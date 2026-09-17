# Diseño de la Topología de Replicación de Estado

## Introducción

El diseño de replicación de estado entre clusters constituye uno de los componentes más críticos del control plane multi-cluster. Este documento detalla la arquitectura de replicación seleccionada, los mecanismos de sincronización implementados, las estrategias de resolución de conflictos, y el manejo de escenarios de split-brain que pueden surgir durante la operación distribuida.

## Modelo de Replicación

### Arquitectura General

El sistema implementa un modelo de replicación asíncrona con un cluster primario y múltiples clusters standby. Esta arquitectura optimiza para disponibilidad y tolerancia a fallos regionales, aceptando consistencia eventual como el compromiso necesario para lograr estos objetivos.

El cluster primario en us-east-1 actúa como fuente autoritativa de estado. Los clusters standby en us-east-2, us-west-1 y us-west-2 mantienen copias del estado que se actualizan periódicamente. La replicación fluye unidireccionalmente desde primario hacia standby, simplificando la resolución de conflictos y eliminando la necesidad de coordinación bidireccional.

### Estado Replicado

El estado que se replica entre clusters incluye las definiciones de aplicaciones gestionadas por ArgoCD, las configuraciones de infraestructura aprovisionadas por Crossplane, las políticas de RBAC federado, y los recursos de Custom Resource Definitions necesarios para la operación del control plane.

Los datos de aplicación transaccional no se replican a nivel de control plane. Cada aplicación es responsable de gestionar su propia replicación de datos según sus requisitos de consistencia. El control plane solo replica metadatos de gestión y configuración.

### Mecanismo de Sincronización

La sincronización utiliza ArgoCD como mecanismo primario de replicación. El repositorio Git actúa como fuente de verdad, y ArgoCD en cada cluster reconcile el estado deseado con el estado actual. Este patrón proporciona las siguientes garantías:

La atomicidad de operaciones se logra mediante commits atómicos en Git. Cada cambio de configuración se representa como un commit que actualiza los manifests relevantes. La replicación es eventual porque depende del intervalo de sync de ArgoCD.

La consistencia se garantiza por la naturaleza determinista de la reconciliación. Given el mismo estado desired en Git, ArgoCD converge al mismo estado actual en todos los clusters. Las divergencias se corrigen automáticamente en el siguiente ciclo de reconciliación.

### Flujo de Replicación

El flujo de replicación comienza cuando un operador/conf operator confirma cambios en el repositorio Git. El commit incluye los manifests actualizados para aplicaciones, configuraciones de infraestructura, o políticas de acceso. Un webhook notifica a ArgoCD en el cluster primario sobre el cambio.

ArgoCD en el primario reconcile los cambios y actualiza los recursos en el cluster local. Una vez que el primario alcanza el estado deseado, el cambio está disponible para replicación a los standby. El mecanismo de replicación secundaria depende de la topología de red:

Para replicación intra-región (us-east-1 a us-east-2), la latencia baja permite sincronización frecuente con intervalo de 30 segundos. Para replicación cross-región (us-east-1 a us-west), el intervalo se extiende a 60 segundos para tolerar latencias mayores y evitar saturación de red.

## Manejo de Conflictos

### Tipos de Conflictos

Los conflictos en el contexto de replicación asíncrona se clasifican en dos categorías principales. Los conflictos de actualización occuren cuando múltiples fuentes intentan modificar el mismo recurso simultáneamente. Los conflictos de eliminación occuren cuando un recurso se elimina en una ubicación mientras se modifica en otra.

En el modelo de replicación unidireccional del primario a standby, los conflictos de actualización son improbables porque todas las modificaciones se originan en el primario. Sin embargo, pueden surgir conflictos si un operador modifica manualmente recursos en un cluster standby, creando divergencia con el estado esperado.

### Política de Resolución: Primary-Wins

La política de primary-wins establece que el estado del cluster primario siempre prevalece sobre el estado de los clusters standby. Cuando se detecta divergencia, los recursos en standby se actualizan para reflejar el estado del primario.

Esta política se implementa mediante el mecanismo de self-heal de ArgoCD. Cada cluster tiene configurado self-heal enabled, lo que significa que cualquier desviación del estado desired se corrige automáticamente. Un operador que modifica manualmente un recurso en un standby descubrirá que sus cambios se revierten en el siguiente ciclo de reconciliación.

### Detección de Conflictos

La detección de conflictos utiliza múltiples indicadores. El estado de sync de ArgoCD muestra si los recursos están synchronized, out-of-sync, o unknown. Un estado out-of-sync sostenido indica divergencia que requiere investigación.

El health check del sistema detecta clusters que no están respondiendo a sincronización. Si un cluster standby no puede alcanzar el primario, las métricas de滞后 (lag) se incrementan y se generan alertas. El operador puede investigar la causa raíz y tomar acciones correctivas.

### Resolución Manual

Para conflictos que no pueden resolverse automáticamente, el sistema proporciona herramientas de diagnóstico. El comando argocd app diff muestra las diferencias entre el estado desired y actual. El historial de eventos registra todas las operaciones de sincronización con timestamps y resultados.

En casos extremos, el operador puede utilizar el comando argocd app sync con la opción force para forzar la aplicación del estado desired, sobrescribiendo cualquier modificación local. Esta operación debe usarse con precaución ya que puede causar pérdida de cambios manuales.

## Escenarios de Split-Brain

### Definición de Split-Brain

El escenario de split-brain ocurre cuando la comunicación entre el primario y los standby se interrumpe, y los standby no pueden determinar cuál es el primario válido. En este escenario, múltiples clusters pueden intentar funcionar como primario, causando divergencia de estado y potencial corrupción de datos.

### Prevención de Split-Brain

El diseño del sistema previene split-brain mediante varias capas de protección. La replicación unidireccional desde primario a standby elimina la posibilidad de que los standby generen conflictos de escritura. Los standby solo pueden leer y aplicar estado, nunca generarlo.

El mecanismo de failover requiere intervención manual para cambiar el rol de primario. El sistema no promote automáticamente un standby a primario porque carece de información completa sobre el estado del primario actual. Esta decisión de diseño evita promote espontáneo que podría causar split-brain.

### Detección de Condiciones de Split-Brain

El health monitor verifica continuamente la conectividad entre clusters. Si la conectividad se pierde, se genera una alerta immediately. El operador recibe notificación sobre la pérdida de comunicación y puede investigar el cause.

Los indicadores de split-brain incluyen: múltiples clusters reportando como primario, divergeces de estado entre clusters que deberían estar sincronizados, y errores de replicación sostenidos. Estos indicadores se monitorean mediante alertas automatizadas.

### Recuperación de Split-Brain

La recuperación de un escenario de split-brain sigue un proceso estructurado. Primero, se restaura la conectividad entre clusters si es posible. Luego, se determina cuál cluster tiene el estado más reciente y completo. Finalmente, se reconfigura el sistema para usar ese cluster como primario y se resincroniza el resto.

Si la conectividad no puede restaurarse, el operador debe decidir manualmente cuál cluster promover a primario. Esta decisión considera el estado de las aplicaciones en cada cluster y los datos potencialmente perdidos en cada ubicación.

## Configuración de Replicación

### Parámetros de Sincronización

La configuración de sincronización define intervalos y comportamientos que afectan la consistencia y el rendimiento. El intervalo de sincronización de ArgoCD se configura en 30 segundos para el primario y 60 segundos para clusters cross-región.

El timeout de operación define cuánto tiempo ArgoCD espera por la completación de operaciones antes de marcarlas como fallidas. El valor recomendado es 3 minutos para operaciones de despliegue de aplicaciones y 5 minutos para aprovisionamiento de infraestructura.

### Retry y Tolerancia a Fallos

Las operaciones de sincronización que fallan se reintentan automáticamente según la configuración de retry. El número máximo de reintentos es 3, con backoff exponencial entre intentos. Después de agotar los reintentos, la operación se marca como fallida y se genera una alerta.

El sistema tolera fallos transitorios de red sin cambiar su comportamiento. Los fallos sostenidos que superan el umbral de timeout generan alertas pero no triggers de failover automático, ya que el failover requiere evaluación manual.

### Monitoreo de Replicación

El monitoreo de replicación captura métricas clave que permiten evaluar la salud del sistema. Las métricas recopiladas incluyen: lag de replicación (diferencia de tiempo entre commit y aplicación), tasa de errores de sincronización, y latencia de round-trip entre clusters.

Los dashboards de monitoreo visualizan el estado de cada cluster y la salud de replicación. Las alertas se configuran para notificar cuando el lag supera umbrales definidos o cuando se detectan errores de sincronización.

## Disaster Recovery y Replicación

### Activación de Standby

Cuando el cluster primario falla y no puede recuperarse en un tiempo razonable, el sistema activa un cluster standby como nuevo primario. Este proceso incluye varios pasos que deben ejecutarse en orden.

Primero, se verifica el estado de cada standby potencial. El standby seleccionado debe tener el estado más reciente y estar completamente synchronized con el último estado conocido del primario. Si múltiples standby tienen estados similares, se selecciona el de menor latency de red.

Segundo, se actualiza la configuración de DNS para apuntar al nuevo primario. Esta actualización puede tomar tiempo en propagarse, dependiendo de la configuración de TTL. Las aplicaciones que cachean conexiones deben ser reiniciadas o reconfiguradas.

Tercero, se reconfigura ArgoCD en el nuevo primario para gestionar todos los clusters. Los standby ahora reconocen al nuevo primario como su fuente de estado. La replicación se reanuda desde el nuevo primario hacia los standby restantes.

### Sincronización Post-Failover

Después de promover un standby a primario, es necesario sincronizar cualquier estado que divergió durante el failover. Si el primario anterior recoverable, sus recursos deben evaluarse para detectar cambios que occurred durante el período de indisponibilidad.

Los recursos creados en el nuevo primario durante el failover se replican hacia los standby. Los recursos que existían en el primario anterior pero no fueron replicados se pierden a menos que puedan recuperarse del primario anterior.

## Consideraciones de Rendimiento

### Latencia de Replicación

La latencia de replicación depende de múltiples factores: el tamaño del estado a sincronizar, la capacidad de red entre regiones, y la carga de los clusters. En condiciones normales, la latencia intra-región es menor a 30 segundos, mientras que la latencia cross-región puede alcanzar 60-90 segundos.

Para minimizar la latencia, el sistema utiliza compresión de datos durante transferencia y sincronización incremental. Solo los recursos modificados se transfieren, no el estado completo. Los recursos grandes se sincronizan en background sin bloquear la reconciliación de recursos pequeños.

### Impacto en Recursos

La replicación consume recursos de red y compute en los clusters. El tráfico de replicación compite con el tráfico de aplicaciones por ancho de banda. En regiones con capacidad limitada, la replicación puede degradar el rendimiento de las aplicaciones.

Para mitigar este impacto, la replicación cross-región se programa durante períodos de baja actividad cuando es posible. El throttle de sincronización limita la tasa de operaciones para evitar saturación de la red o de los API servers.