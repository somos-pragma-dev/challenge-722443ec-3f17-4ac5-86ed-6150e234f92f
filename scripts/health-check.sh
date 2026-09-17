#!/bin/bash
# Health check script para monitorear disponibilidad de clusters primarios
# Verifica el estado de salud de los clusters definidos en la configuración

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
CONFIG_FILE="${PROJECT_ROOT}/package.json"
HEALTH_CHECK_INTERVAL="${HEALTH_CHECK_INTERVAL:-10}"
TIMEOUT_SECONDS="${TIMEOUT_SECONDS:-30}"
LOG_FILE="${PROJECT_ROOT}/logs/health-check.log"
STATE_DIR="${PROJECT_ROOT}/state"

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

load_cluster_config() {
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

check_cluster_health() {
    local cluster_name="$1"
    local cluster_region="$2"
    local cluster_endpoint="$3"
    
    info "Checking health for cluster: ${cluster_name} (${cluster_region})"
    
    local health_state="${STATE_DIR}/${cluster_name}.health"
    local previous_state
    previous_state=$(cat "$health_state" 2>/dev/null || echo "UNKNOWN")
    
    local health_status="HEALTHY"
    local http_code
    
    if http_code=$(curl -s -o /dev/null -w "%{http_code}" --connect-timeout "$TIMEOUT_SECONDS" --max-time "$TIMEOUT_SECONDS" "${cluster_endpoint}/healthz" 2>/dev/null || echo "000"); then
        if [[ "$http_code" == "200" ]]; then
            health_status="HEALTHY"
            info "Cluster ${cluster_name} is HEALTHY (HTTP ${http_code})"
        elif [[ "$http_code" == "401" ]] || [[ "$http_code" == "403" ]]; then
            health_status="HEALTHY"
            info "Cluster ${cluster_name} is HEALTHY (authenticated, HTTP ${http_code})"
        else
            health_status="UNHEALTHY"
            warn "Cluster ${cluster_name} returned HTTP ${http_code}"
        fi
    else
        health_status="UNREACHABLE"
        warn "Cluster ${cluster_name} is UNREACHABLE (connection failed)"
    fi
    
    echo "$health_status" > "$health_state"
    
    if [[ "$previous_state" != "$health_status" ]]; then
        info "State change detected for ${cluster_name}: ${previous_state} -> ${health_status}"
        update_cluster_timestamp "$cluster_name" "$health_status"
    fi
    
    echo "$health_status"
}

update_cluster_timestamp() {
    local cluster_name="$1"
    local health_status="$2"
    local timestamp_file="${STATE_DIR}/${cluster_name}.timestamp"
    
    if [[ "$health_status" == "HEALTHY" ]]; then
        date +%s > "$timestamp_file"
    fi
}

get_cluster_fail_duration() {
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

check_all_standby_clusters() {
    local standby_list
    standby_list=$(node -e "const pkg=require('$CONFIG_FILE'); console.log(JSON.stringify(pkg.config.cluster.standby || []))")
    
    if [[ "$standby_list" == "[]" ]]; then
        warn "No standby clusters configured"
        return
    fi
    
    echo "$standby_list" | node -e "
const stdin = require('fs').readFileSync(0, 'utf-8');
const standby = JSON.parse(stdin);
standby.forEach(c => console.log(c.name + '|' + c.region + '|' + c.endpoint));
"
}

run_health_checks() {
    info "Starting health check cycle"
    
    local primary_config
    primary_config=$(load_cluster_config)
    IFS='|' read -r primary_name primary_region primary_endpoint <<< "$primary_config"
    
    local primary_health
    primary_health=$(check_cluster_health "$primary_name" "$primary_region" "$primary_endpoint")
    
    local primary_fail_duration=0
    if [[ "$primary_health" != "HEALTHY" ]]; then
        primary_fail_duration=$(get_cluster_fail_duration "$primary_name")
    fi
    
    echo "=== Health Check Summary ==="
    echo "Primary Cluster: ${primary_name}"
    echo "  Status: ${primary_health}"
    echo "  Fail Duration: ${primary_fail_duration}s"
    
    echo ""
    echo "Standby Clusters:"
    
    while IFS='|' read -r standby_name standby_region standby_endpoint; do
        local standby_health
        standby_health=$(check_cluster_health "$standby_name" "$standby_region" "$standby_endpoint")
        echo "  - ${standby_name} (${standby_region}): ${standby_health}"
    done < <(check_all_standby_clusters)
    
    echo "=============================="
    
    if [[ "$primary_health" != "HEALTHY" ]] && [[ "$primary_fail_duration" -ge 180 ]]; then
        warn "Primary cluster unhealthy for ${primary_fail_duration}s (>= 3 minutes) - FAILOVER TRIGGER CONDITION MET"
        return 1
    fi
    
    info "Health check cycle completed"
    return 0
}

continuous_monitoring() {
    info "Starting continuous health monitoring (interval: ${HEALTH_CHECK_INTERVAL}s)"
    
    while true; do
        run_health_checks
        local result=$?
        
        if [[ "$result" -ne 0 ]]; then
            warn "Health check failed - triggering alert mechanism"
            notify_failover_condition
        fi
        
        sleep "$HEALTH_CHECK_INTERVAL"
    done
}

notify_failover_condition() {
    local notification_channels
    notification_channels=$(node -e "const pkg=require('$CONFIG_FILE'); console.log(pkg.config.failover.notificationChannels.join(','))")
    
    warn "Notifying channels: ${notification_channels}"
    
    echo "FAILOVER_TRIGGER" > "${STATE_DIR}/failover.trigger"
    
    if [[ "$notification_channels" == *"slack"* ]]; then
        info "Slack notification would be sent here"
    fi
    
    if [[ "$notification_channels" == *"pagerduty"* ]]; then
        info "PagerDuty alert would be triggered here"
    fi
}

main() {
    local mode="${1:-once}"
    
    case "$mode" in
        --continuous|-c)
            continuous_monitoring
            ;;
        --once|-o)
            run_health_checks
            ;;
        *)
            run_health_checks
            ;;
    esac
}

main "$@"