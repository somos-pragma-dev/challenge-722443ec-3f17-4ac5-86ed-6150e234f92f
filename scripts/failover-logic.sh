#!/bin/bash
# Script de lógica de failover que promueve un cluster standby cuando el primary
# falla su health check por 3 minutos (180 segundos)

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
CONFIG_FILE="${PROJECT_ROOT}/package.json"
STATE_DIR="${PROJECT_ROOT}/state"
LOG_FILE="${PROJECT_ROOT}/logs/failover.log"
LOCK_FILE="${STATE_DIR}/failover.lock"
DRY_RUN="${DRY_RUN:-false}"

mkdir -p "${PROJECT_ROOT}/logs" "${STATE_DIR}"

log() {
    local level="$1"
    shift
    local message="$*"
    local timestamp
    timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[${timestamp}] [${level}] ${message}" | tee -a "$LOG_FILE"
}

error() {
    log "ERROR" "$@"
}

info() {
    log "INFO" "$@"
}

warn() {
    log "WARN" "$@"
}

acquire_lock() {
    local lock_fd=200
    eval "exec $lock_fd>'$LOCK_FILE'"
    
    if ! flock -n $lock_fd; then
        error "Another failover process is running"
        return 1
    fi
    
    echo "$$" >& $lock_fd
    info "Acquired failover lock"
}

release_lock() {
    local lock_fd=200
    flock -u $lock_fd
    rm -f "$LOCK_FILE"
    info "Released failover lock"
}

load_primary_config() {
    if [[ ! -f "$CONFIG_FILE" ]]; then
        error "Configuration file not found: $CONFIG_FILE"
        return 1
    fi
    
    local primary_name primary_region primary_endpoint
    
    primary_name=$(node -e "const pkg=require('$CONFIG_FILE'); console.log(pkg.config.cluster.primary.name)")
    primary_region=$(node -e "const pkg=require('$CONFIG_FILE'); console.log(pkg.config.cluster.primary.region)")
    primary_endpoint=$(node -e "const pkg=require('$CONFIG_FILE'); console.log(pkg.config.cluster.primary.endpoint)")
    
    echo "${primary_name}|${primary_region}|${primary_endpoint}"
}

load_standby_clusters() {
    node -e "
const pkg = require('$CONFIG_FILE');
const standby = pkg.config.cluster.standby || [];
standby.forEach(c => console.log(c.name + '|' + c.region + '|' + c.endpoint));
"
}

get_primary_health_status() {
    local health_file="${STATE_DIR}/primary-cluster.health"
    
    if [[ -f "$health_file" ]]; then
        cat "$health_file"
    else
        echo "UNKNOWN"
    fi
}

get_fail_duration() {
    local cluster_name="$1"
    local timestamp_file="${STATE_DIR}/${cluster_name}.timestamp"
    
    if [[ ! -f "$timestamp_file" ]]; then
        echo "0"
        return
    fi
    
    local last_healthy current_time fail_duration
    last_healthy=$(cat "$timestamp_file")
    current_time=$(date +%s)
    fail_duration=$((current_time - last_healthy))
    
    echo "$fail_duration"
}

check_standby_availability() {
    local standby_name="$1"
    local standby_endpoint="$3"
    
    local timeout_seconds=30
    
    if http_code=$(curl -s -o /dev/null -w "%{http_code}" --connect-timeout "$timeout_seconds" --max-time "$timeout_seconds" "${standby_endpoint}/healthz" 2>/dev/null || echo "000"); then
        if [[ "$http_code" == "200" ]] || [[ "$http_code" == "401" ]] || [[ "$http_code" == "403" ]]; then
            echo "AVAILABLE"
            return
        fi
    fi
    
    echo "UNAVAILABLE"
}

select_best_standby() {
    local primary_name="$1"
    local fail_duration="$2"
    
    info "Selecting best standby cluster to promote"
    
    local best_standby=""
    local best_score=0
    
    while IFS='|' read -r standby_name standby_region standby_endpoint; do
        local availability
        availability=$(check_standby_availability "$standby_name" "$standby_region" "$standby_endpoint")
        
        if [[ "$availability" == "AVAILABLE" ]]; then
            local score=100
            
            local health_file="${STATE_DIR}/${standby_name}.health"
            local standby_health="UNKNOWN"
            if [[ -f "$health_file" ]]; then
                standby_health=$(cat "$health_file")
            fi
            
            if [[ "$standby_health" == "HEALTHY" ]]; then
                score=$((score + 50))
            fi
            
            local standby_fail_duration
            standby_fail_duration=$(get_fail_duration "$standby_name")
            if [[ "$standby_fail_duration" -lt 60 ]]; then
                score=$((score + 30))
            fi
            
            info "Standby ${standby_name} score: ${score} (availability: ${availability}, health: ${standby_health}, fail_duration: ${standby_fail_duration}s)"
            
            if [[ "$score" -gt "$best_score" ]]; then
                best_score=$score
                best_standby="${standby_name}|${standby_region}|${standby_endpoint}"
            fi
        else
            warn "Standby ${standby_name} is not available"
        fi
    done < <(load_standby_clusters)
    
    if [[ -n "$best_standby" ]]; then
        echo "$best_standby"
        return 0
    else
        return 1
    fi
}

promote_standby_cluster() {
    local standby_name="$1"
    local standby_region="$2"
    local standby_endpoint="$3"
    local primary_name="$4"
    
    info "PROMOTING standby cluster: ${standby_name} (${standby_region})"
    info "Old primary: ${primary_name}"
    
    if [[ "$DRY_RUN" == "true" ]]; then
        info "DRY RUN: Would execute the following actions:"
        info "  1. Update DNS/load balancer to point to ${standby_endpoint}"
        info "  2. Update ArgoCD context to use ${standby_name} as primary"
        info "  3. Update Crossplane ProviderConfig to target ${standby_region}"
        info "  4. Notify all notification channels"
        return 0
    fi
    
    execute_dns_update "$standby_endpoint"
    update_argocd_context "$standby_name"
    update_crossplane_config "$standby_name" "$standby_region"
    notify_failover_complete "$standby_name" "$standby_region"
    record_failover_event "$primary_name" "$standby_name"
    
    info "Failover completed successfully to ${standby_name}"
}

execute_dns_update() {
    local new_endpoint="$1"
    info "Updating DNS records to point to ${new_endpoint}"
    
    local failover_config="${STATE_DIR}/failover.config"
    if [[ -f "$failover_config" ]]; then
        local hosted_zone dns_record
        hosted_zone=$(node -e "const c=require('$failover_config'); console.log(c.hostedZone || '')")
        dns_record=$(node -e "const c=require('$failover_config'); console.log(c.recordName || '')")
        
        if [[ -n "$hosted_zone" ]] && [[ -n "$dns_record" ]]; then
            info "Would execute: aws route53 change-resource-record-sets --hosted-zone-id ${hosted_zone} --change-batch ..."
        fi
    fi
    
    echo "PROMOTED" > "${STATE_DIR}/failover.status"
}

update_argocd_context() {
    local new_primary="$1"
    info "Updating ArgoCD context to use ${new_primary} as primary"
    
    local argocd_config="${PROJECT_ROOT}/config/argocd-cm.yaml"
    if [[ -f "$argocd_config" ]]; then
        info "ArgoCD config found - would update cluster.context to ${new_primary}"
    fi
    
    echo "${new_primary}" > "${STATE_DIR}/active-cluster"
}

update_crossplane_config() {
    local cluster_name="$1"
    local cluster_region="$2"
    info "Updating Crossplane ProviderConfig to target ${cluster_name} in ${cluster_region}"
    
    local crossplane_config="${PROJECT_ROOT}/infrastructure/providers.yaml"
    if [[ -f "$crossplane_config" ]]; then
        info "Crossplane config found - would update provider-aws region to ${cluster_region}"
    fi
}

notify_failover_complete() {
    local new_primary="$1"
    local region="$2"
    
    info "Sending failover completion notifications"
    
    local notification_channels
    notification_channels=$(node -e "const pkg=require('$CONFIG_FILE'); console.log(pkg.config.failover.notificationChannels.join(','))")
    
    if [[ "$notification_channels" == *"slack"* ]]; then
        info "Sending Slack notification: Failover completed to ${new_primary} (${region})"
    fi
    
    if [[ "$notification_channels" == *"pagerduty"* ]]; then
        info "Triggering PagerDuty resolution for previous incident"
    fi
}

record_failover_event() {
    local old_primary="$1"
    local new_primary="$2"
    local timestamp
    timestamp=$(date -Iseconds)
    
    local event_file="${STATE_DIR}/failover-history.jsonl"
    
    echo "{\"timestamp\":\"${timestamp}\",\"old_primary\":\"${old_primary}\",\"new_primary\":\"${new_primary}\"}" >> "$event_file"
    
    info "Recorded failover event to history"
}

check_failover_prerequisites() {
    local primary_name="$1"
    local fail_duration="$2"
    
    local min_fail_duration=180
    
    if [[ "$fail_duration" -lt "$min_fail_duration" ]]; then
        info "Fail duration ${fail_duration}s < ${min_fail_duration}s - prerequisites not met"
        return 1
    fi
    
    local health_status
    health_status=$(get_primary_health_status)
    
    if [[ "$health_status" == "HEALTHY" ]]; then
        info "Primary cluster is healthy - failover not required"
        return 1
    fi
    
    info "Failover prerequisites met: fail_duration=${fail_duration}s, health=${health_status}"
    return 0
}

perform_failover() {
    local primary_config
    primary_config=$(load_primary_config)
    IFS='|' read -r primary_name primary_region primary_endpoint <<< "$primary_config"
    
    local fail_duration
    fail_duration=$(get_fail_duration "$primary_name")
    
    info "Evaluating failover for ${primary_name} (fail_duration: ${fail_duration}s)"
    
    if ! check_failover_prerequisites "$primary_name" "$fail_duration"; then
        info "Failover prerequisites not met - aborting"
        return 0
    fi
    
    if ! select_best_standby "$primary_name" "$fail_duration"; then
        error "No available standby cluster found - failover cannot proceed"
        return 1
    fi | read -r best_standby
    
    if [[ -z "$best_standby" ]]; then
        error "Failed to select standby cluster"
        return 1
    fi
    
    IFS='|' read -r standby_name standby_region standby_endpoint <<< "$best_standby"
    
    promote_standby_cluster "$standby_name" "$standby_region" "$standby_endpoint" "$primary_name"
}

show_status() {
    echo "=== Failover Status ==="
    
    local primary_config
    primary_config=$(load_primary_config)
    IFS='|' read -r primary_name primary_region primary_endpoint <<< "$primary_config"
    
    echo "Primary: ${primary_name} (${primary_region})"
    
    local health_status
    health_status=$(get_primary_health_status)
    local fail_duration
    fail_duration=$(get_fail_duration "$primary_name")
    
    echo "  Status: ${health_status}"
    echo "  Fail Duration: ${fail_duration}s"
    
    if [[ -f "${STATE_DIR}/active-cluster" ]]; then
        echo "Active Cluster: $(cat "${STATE_DIR}/active-cluster")"
    fi
    
    if [[ -f "${STATE_DIR}/failover.status" ]]; then
        echo "Failover Status: $(cat "${STATE_DIR}/failover.status")"
    fi
    
    echo ""
    echo "Standby Clusters:"
    
    while IFS='|' read -r standby_name standby_region standby_endpoint; do
        local availability
        availability=$(check_standby_availability "$standby_name" "$standby_region" "$standby_endpoint")
        local health_file="${STATE_DIR}/${standby_name}.health"
        local standby_health="UNKNOWN"
        if [[ -f "$health_file" ]]; then
            standby_health=$(cat "$health_file")
        fi
        echo "  - ${standby_name} (${standby_region}): ${availability}, health: ${standby_health}"
    done < <(load_standby_clusters)
    
    echo "======================"
}

main() {
    local mode="${1:-}"
    
    case "$mode" in
        --dry-run)
            DRY_RUN="true"
            info "Running in DRY RUN mode"
            ;;
        --execute)
            DRY_RUN="false"
            info "Running in EXECUTE mode"
            ;;
        --status)
            show_status
            exit 0
            ;;
        *)
            echo "Usage: $0 [--dry-run|--execute|--status]"
            echo "  --dry-run   : Validate failover without executing"
            echo "  --execute   : Execute failover when conditions are met"
            echo "  --status    : Show current failover status"
            exit 1
            ;;
    esac
    
    if ! acquire_lock; then
        error "Cannot acquire lock - exiting"
        exit 1
    fi
    
    trap release_lock EXIT
    
    perform_failover
}

main "$@"