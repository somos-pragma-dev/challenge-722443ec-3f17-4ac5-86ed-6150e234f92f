# Estrategia de Disaster Recovery y Coreografía del Failover

## Visión General del Sistema

El control plane multi-cluster gestiona 12 clusters Kubernetes distribuidos en 4 regiones de AWS, utilizando ArgoCD para GitOps y Crossplane para infraestructura declarativa. La estrategia de disaster recovery debe garantizar la continuidad operativa ante fallos regionales, corrupciones de datos o desastres naturales que afecten a la infraestructura primaria.

## Objetivos de Recovery

El sistema persigue un RTO (Recovery Time Objective) menor a 5 minutos y un RPO (Recovery Point Objective) menor a 1 minuto para los componentes críticos del control plane. Los clusters de standby están configurados en regiones geográfica y geológicamente separadas para maximizar la probabilidad de supervivencia ante desastres a gran escala.

## Topología de Failover

El cluster primario localizado en us-east-1 actúa como fuente autoritativa de estado. Los clusters de standby en us-east-2, us-west-1 y us-west-2 reciben replicación continua del estado de ArgoCD Applications, configuraciones de Crossplane y secretos de Vault. La replicación utiliza un modelo asíncrono con consistencia eventual, donde cada cluster de standby mantiene una copia casi en tiempo real del estado del primario.

### Selección de Nuevo Primario

Cuando el cluster primario falla, el proceso de failover selecciona automáticamente el cluster de standby con menor latencia de replicación y mayor distancia geográfica del incidente. Esta selección se basa en métricas de salud recopiladas por el health-check cada 10 segundos, considerando el estado de los nodos, la conectividad de red y el lag de replicación.

## Coreografía del Failover

### Fase 1: Detección y Validación

El script de health-check monitorea continuamente la salud del cluster primario mediante llamadas a la API de Kubernetes y verificaciones de conectividad de red. Cuando detecta que el cluster primario no responde durante 3 ciclos consecutivos (30 segundos), inicia el proceso de failover. Esta validación previene falsos positivos causados por problemas transitorios de red.

### Fase 2: Confirmación de Consistencia

Antes de promover un cluster de standby, el sistema verifica que el lag de replicación sea menor al umbral configurado (30 segundos). Si el lag excede este valor, el sistema espera hasta que la replicación complete o agota los intentos de retry (3 intentos con backoff exponencial). Esta verificación es crítica para evitar el split-brain, donde dos clusters podrían considerarse primarios simultáneamente.

### Fase 3: Bloqueo del Primario Antiguo

Una vez confirmado que el standby está actualizado, el sistema ejecuta operaciones atómicas para evitar split-brain. Primero, marca el cluster primario antiguo como no elegible para tráfico mediante un ConfigMap de bloqueo que ArgoCD consulta antes de sincronizar. Segundo, actualiza el registro DNS mediante External-DNS para apuntar al nuevo cluster primario. Tercero, reconfigura el ClusterRoleBinding federado para otorgar permisos administrativos al nuevo primario en todos los clusters.

### Fase 4: Promoción del Standby

El cluster de standby seleccionado promociona su rol de standby a primario mediante la actualización de etiquetas de cluster en el ConfigMap de coordinación. ArgoCD detecta este cambio y comienza a sincronizar aplicaciones desde el nuevo primario. Los secretos de Vault se reconfiguran para reconocer el nuevo cluster como primario, habilitando la escritura.

### Fase 5: Reconfiguración de Réplicas

Tras la promoción, los otros clusters de standby reconfiguran su origen de replicación para apontar al nuevo primario. Crossplane actualiza sus ProviderConfigs para usar las credenciales del nuevo cluster primario. External-Secrets Operator reconecta sus stores al nuevo ClusterSecretStore.

## Prevención de Split-Brain

### Mecanismos de Bloqueo

El sistema implementa un bloqueo distribuido utilizando un ConfigMap en un cluster de coordinación externo (etcd) o mediante el operador de bloqueo de Vault. Este bloqueo tiene un TTL de 60 segundos y se renueva automáticamente cada 15 segundos mientras el proceso de failover está activo. Si el proceso de failover falla o se interrumpe, el bloqueo expira y permite nuevos intentos.

### Validación de Cuórum

Antes de ejecutar cualquier operación de escritura en el nuevo primario, el sistema verifica que al menos 2 de los 3 clusters de standby confirmen recepción del último estado conocido. Esta validación de cuórum garantiza que no hay divergencia de estado entre los clusters.

### Sincronización Forzada

Tras un failover exitoso, el sistema ejecuta una sincronización forzada de todas las aplicaciones ArgoCD en el nuevo primario para garantizar consistencia. Esta sincronización compara el estado declarado en Git con el estado real de cada cluster y reconcilia las diferencias.

## Rollback y Recuperación

### Recuperación del Primario Antiguo

Una vez que el cluster primario original se recupera, el sistema no lo promuebe automáticamente a primario. En su lugar, el equipo de operaciones debe ejecutar una verificación manual de consistencia y aprobar la reintegración como standby. Este proceso incluye validación de datos, verificación de no regresiones y pruebas de integración.

### Procedimiento de Rollback

Si durante el failover se detecta inconsistencia de datos, el sistema aborta la operación y notifica al equipo de operaciones. El rollback implica restaurar el ConfigMap de coordinación al estado anterior y revertir los cambios de DNS. Los clusters de standby mantienen su rol hasta intervención manual.

## Notificaciones y Alertas

El sistema envía notificaciones a Slack y PagerDuty en cada fase del failover: inicio de detección, confirmación de consistencia, promoción de standby, completitud de failover y cualquier error o bloqueo. Estas notificaciones incluyen el cluster afectado, la hora de inicio, las acciones tomadas y los próximos pasos recomendados.

## Consideraciones de Seguridad

Durante el failover, los secretos de Vault se replican cifrados mediante el transit backend de Vault. Las credenciales de AWS para Crossplane se rotan automáticamente cada 24 horas y se almacenan en Secrets Manager con replicación cross-region. El RBAC federado utiliza ClusterRoleBindings con impersonation para garantizar el principio de mínimo privilegio.

## Métricas de Monitoreo

Las métricas clave incluyen: tiempo de detección de fallo (métricas de health-check), tiempo de promoción de standby (scripts de failover), lag de replicación (métricas de Vault), consistencia de estado (comparaciones de ArgoCD app diff) y disponibilidad del sistema (SLO tracking).