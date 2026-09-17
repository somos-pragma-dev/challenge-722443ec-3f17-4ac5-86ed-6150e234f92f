# Requisitos y Restricciones del Sistema

## Visión General del Sistema

El presente documento establece los requisitos técnicos y restricciones operacionales para el control plane multi-cluster con capacidades de GitOps y disaster recovery. El sistema debe gestionar 12 clusters Kubernetes distribuidos en 4 regiones de AWS, proporcionando una capa unificada de gestión, orquestación de infraestructura y recuperación ante desastres.

## Requisitos Funcionales

### Gestión Unificada de Clusters

El sistema debe proporcionar una interfaz centralizada para gestionar el ciclo de vida de los 12 clusters. Esta gestión incluye aprovisionamiento, configuración, actualización y monitoreo de cada cluster individual. El control plane debe mantener un registro actualizado del estado de todos los clusters, incluyendo métricas de salud, capacidad y configuración aplicada.

Latopología de clusters contempla un cluster primario ubicado en us-east-1 y tres clusters standby distribuidos en us-east-2, us-west-1 y us-west-2. Esta distribución geográfica proporciona redundancia regional y permite continuidad operativa ante fallos que afecten una región completa. Cada cluster debe mantener comunicación bidireccional con el control plane para reporte de estado y recepción de directivas.

### GitOps con ArgoCD

El sistema debe implementar GitOps como metodología de gestión de configuración. ArgoCD actúa como controlador principal que reconcile continuamente el estado deseado definido en Git con el estado real de cada cluster. Esta implementación requiere que todas las definiciones de aplicaciones, configuraciones de infraestructura y políticas de seguridad residan en repositorios Git versionados.

El patrón de aplicación de apps-of-apps permite gestionar jerárquicamente los recursos. Un ApplicationSet de ArgoCD define el catálogo de aplicaciones que deben desplegarse en cada cluster. Los cambios en este catálogo se propagan automáticamente a todos los clusters objetivo, garantizando consistencia en el despliegue de cargas de trabajo.

### Provisionamiento de Infraestructura con Crossplane

Crossplane debe aprovisionar recursos de AWS de manera declarativa. Los CompositeResourceDefinitions (XRD) definen las abstracciones de infraestructura que los desarrolladores pueden solicitar. Los CompositeResources (XR) representan las solicitudes concretas de recursos que Crossplane transforma en recursos nativos de AWS.

La configuración incluye proveedores para múltiples servicios AWS: RDS para bases de datos relacionales, S3 para almacenamiento de objetos, EKS para clusters Kubernetes adicionales, Route53 para DNS, y IAM para gestión de identidades. Cada proveedor requiere credenciales configuradas en el namespace de crossplane-system.

### Disaster Recovery y Failover

El sistema debe implementar capacidades de disaster recovery que permitan continuidad operativa ante fallos del cluster primario. El proceso de failover incluye detección de indisponibilidad, promoción de un cluster standby, actualización de DNS para dirigir tráfico al nuevo primario, y sincronización del estado más reciente.

La lógica de failover debe ejecutarse de manera determinista, siguiendo pasos predefinidos con validación en cada etapa. El sistema soporta ejecución en modo dry-run para validar la viabilidad del failover sin afectar el entorno actual. Los health checks periódicos determinan la disponibilidad de cada cluster y触发an alertas cuando se detecta degradación.

### Gestión de Secrets

La estrategia de secrets utiliza HashiCorp Vault como sistema centralizado de gestión de credenciales. External Secrets Operator sincroniza los secretos desde Vault hacia los clusters Kubernetes, creando Kubernetes Secrets que las aplicaciones consumen de manera estándar. Esta separación permite rotación de credenciales sin modificar las aplicaciones.

Los ClusterSecretStores definen el backend de Vault para cada cluster, permitiendo acceso a secretos específicos del entorno. Los ExternalSecret resources referencian las claves en Vault y definen el intervalo de sincronización. La arquitectura soporta múltiples backends de secrets para escenarios de multi-tenant.

## Requisitos No Funcionales

### Disponibilidad

El sistema debe alcanzar un objetivo de disponibilidad del 99.95% para el control plane. Esta disponibilidad se logra mediante la distribución geográfica de componentes y la redundancia en puntos críticos. El cluster primario y los standby operan en regiones separadas de AWS, proporcionando aislamiento ante fallos regionales.

El RTO (Recovery Time Objective) máximo es de 5 minutos para failover automático entre clusters de la misma región y 15 minutos para failover cross-región. El RPO (Recovery Point Objective) depende de la frecuencia de replicación de estado, configurada en 30 segundos para datos críticos.

### Consistencia

El modelo de consistencia es eventual para operaciones de replicación de estado entre clusters. Esta decisión arquitectónica permite operación independiente durante períodos de conectividad limitada entre regiones. Los conflictos de escritura se resuelven mediante políticas predefinidas, siendo la política primaria-wins la configuración por defecto.

Las aplicaciones que requieren consistencia fuerte deben implementarla a nivel de aplicación mediante mecanismos de locking o transacciones distribuidas. El control plane no impone consistencia transaccional global, delegando esta responsabilidad a las aplicaciones específicas.

### Rendimiento

La latencia máxima para operaciones de sincronización de ArgoCD es de 60 segundos desde la confirmación de un cambio en Git hasta su aplicación en todos los clusters. El tiempo de aprovisionamiento de infraestructura mediante Crossplane varía según el recurso, con un máximo de 5 minutos para recursos complejos como clusters EKS.

Los health checks se ejecutan cada 10 segundos, con un tiempo de timeout de 5 segundos por verificación. El sistema de alertas notifica dentro de 30 segundos ante la detección de condiciones de fallo.

### Seguridad

El modelo RBAC federado permite gestión centralizada de políticas de acceso que se propagan a todos los clusters. Los ClusterRoles y ClusterRoleBindings se sincronizan mediante ArgoCD, garantizando consistencia en la aplicación de políticas de seguridad.

La comunicación entre componentes utiliza TLS 1.3 para todos los canales. Las credenciales de AWS se gestionan mediante IAM Roles con Service Account Annotations, evitando almacenamiento de credenciales estáticas. Vault almacena secretos sensibles con encryption at-rest.

## Restricciones del Dominio

### Limitaciones de Red

La replicación asíncrona entre regiones enfrenta latencias de red variables. La distancia geográfica entre us-east-1 y us-west-1 introduce latencias de 70-100ms que afectan la sincronización de estado. El diseño debe tolerar estas latencias sin degradar la experiencia del usuario final.

La conectividad entre clusters depende de la infraestructura de AWS Transit Gateway. Fallos en este componente afectan la replicación y el monitoreo. El sistema debe detectar pérdida de conectividad y operar en modo degradado hasta que se restaure la conexión.

### Cuotas y Límites

AWS impone cuotas regionales para recursos como número de EKS clusters por región, límites de API de Route53, y cuotas de IAM. El diseño debe respetar estos límites y proporcionar mecanismos para solicitar incrementos de cuota cuando sea necesario.

ArgoCD tiene límites en el número de aplicaciones y recursos que puede gestionar eficientemente. Para el escenario de 12 clusters con múltiples aplicaciones cada uno, se requiere una estructura de apps-of-apps que agrupe recursos y minimice la carga en el controlador.

### Compatibilidad de Versiones

Los componentes del control plane deben mantener compatibilidad con Kubernetes 1.28. Las versiones de ArgoCD, Crossplane y External Secrets Operator deben ser compatibles con esta versión de Kubernetes y entre sí. Las actualizaciones de componentes deben seguir una secuencia específica para evitar interrupciones.

## Componentes Clave y sus Responsabilidades

| Componente | Responsabilidad | Tipo de Recurso |
|------------|-----------------|-----------------|
| ArgoCD | GitOps controller, sync y reconciliation | Deployment + CRDs |
| Crossplane | Provisionamiento de infraestructura | CRDs + Provider |
| Vault | Almacenamiento de secretos | Deployment HA |
| External Secrets | Sincronización de secretos | Deployment + CRDs |
| Failover Controller | Detección y ejecución de failover | Custom Controller |
| Health Monitor | Verificación de estado de clusters | Custom Controller |

## Operaciones Críticas del Sistema

### Sincronización de Aplicaciones

El flujo de sincronización comienza cuando un desarrollador confirma cambios en el repositorio Git. ArgoCD detecta el cambio mediante webhook o polling periódico. El controlador compara el estado desired con el estado actual en cada cluster. Los recursos desactualizados se aplican mediante el operador de Kubernetes correspondiente.

La sincronización respeta la política de prune y self-heal configurada. Prune elimina recursos que ya no existen en Git, mientras que self-heal corrige desviaciones causadas por cambios directos en el cluster. Estas políticas son configurables por aplicación.

### Aprovisionamiento de Infraestructura

Un desarrollador crea un CompositeResource que solicita recursos de infraestructura. Crossplane reconcilia el XR y genera los recursos compuestos definidos en el Composition. El proveedor de AWS crea los recursos físicos en la cuenta configurada. El estado del XR se actualiza para reflejar el estado de los recursos creados.

La composición define valores por defecto y políticas de validación que aseguran cumplimiento organizacional. Los errores de aprovisionamiento se reportan como condiciones del XR, permitiendo captura y manejo por parte del solicitante.

### Ejecución de Failover

El proceso de failover se inicia manualmente o mediante detección automática de fallo. El controlador de failover verifica la salud del cluster primario mediante múltiples indicadores. Si la verificación falla, se evalúa la elegibilidad de cada cluster standby.

El cluster standby seleccionado undergoes un proceso de promoción que incluye verificación de estado, sincronización de datos restantes, actualización de configuraciones de red, y promoción a rol primario. Los clientes actualizan sus configuraciones de DNS para apuntar al nuevo primario.

## Métricas de Éxito

Las métricas clave para evaluar el sistema incluyen: tiempo medio de detección de fallos (MTTD) menor a 30 segundos, tiempo medio de recuperación (MTTR) menor a 5 minutos para failover intra-región, porcentaje de sincronización exitosa de ArgoCD mayor al 99.9%, y latencia de replicación de estado menor a 60 segundos en condiciones normales de red.