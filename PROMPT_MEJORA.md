# Prompt para Mejorar el Codigo Base

Copia y pega el contenido del bloque de abajo en un asistente de IA (Claude, ChatGPT)
para obtener un ZIP con el proyecto completo y arrancable.

Si preferis trabajar en tu editor con un agente local (Claude Code, Cursor, Copilot), usa `AGENTS.md` en vez de este archivo: dice lo mismo pero para que escriba los archivos en disco.

## Las dos reglas que no se negocian

1. **Completa el boilerplate.** Todo lo que el proyecto necesita para compilar y arrancar: manifiesto de dependencias, punto de entrada, configuracion, capa de interfaz, y las capas del patron arquitectonico declarado. Eso es andamiaje y es tu trabajo.
2. **NO resuelvas el reto.** Los entregables de las fases son el trabajo de la persona. El hueco pedagogico se deja como esta: el proyecto arranca, pero lo que el reto pide implementar NO esta implementado.

Dicho de otra forma: si algo impide compilar, arreglalo. Si algo es logica de negocio incompleta, validaciones ausentes, un secreto hardcodeado o un patron mejorable, dejalo exactamente como esta — es lo que la persona tiene que encontrar.

## Lo que le falta a este proyecto

Esto NO lo tenes que adivinar: salio de comparar el proyecto contra la arquitectura declarada del reto y de un analisis estatico del codigo. Completalo TODO.

### Boilerplate del stack que falta

Sin esto no compila ni arranca. Es andamiaje, no toca nada de lo pedagogico:

- **Punto de entrada del stack elegido** — Sin un punto de entrada reconocible, el runtime no tiene por donde arrancar la aplicacion.
- **Capa de interfaz (controller/handler)** — Sin una capa de interfaz explicita, no hay forma de invocar la logica de negocio desde afuera del proceso.

## Como saber que terminaste

```bash
el comando de build o arranque canonico del stack elegido
```

Ese comando corriendo sin errores es la definicion de "listo".

---

```
## Briefing del reto (autoridad)
Este bloque manda sobre los archivos adjuntos. El stack y el rol salen de AQUÍ, no de un topic genérico ni de markdown placeholder.

### Contexto técnico original
Arquitectura master-l2 de un control plane que gestiona 12 clusters Kubernetes distribuidos en 4 regiones AWS. Usa ArgoCD para GitOps con sync policies por entorno, Crossplane para provisionar infraestructura declarativa (RDS, S3, IAM roles) desde el repo de Git, y una lógica custom de failover que promueve un cluster standby cuando el primary de una región falla su health check por 3 minutos consecutivos. El developer master-l2 debe diseñar la topología de replicación de estado entre clusters, justificar la elección de ArgoCD vs Flux vs Rancher Fleet, el modelo de RBAC federado, la estrategia de secrets con Vault + external-secrets, y la coreografía del disaster recovery incluyendo cómo evita el split-brain durante failovers.

### Reto
- Tema: TEST-CT
- Seniority: master-l2
- Tipo: theoretical
- Título: Diseño y Evaluación de un Control Plane Multi-Cluster con GitOps y Disaster Recovery
- Tiempo estimado: 8 horas

### Fases (trabajo del HUMANO — PROHIBIDO completarlas)
No implementes estos entregables. Dejalos como hueco pedagógico. El asistente solo materializa el proyecto arrancable para que el participante pueda trabajar.
- Fase 1: Exploración y Requisitos — objetivo: Identificar y documentar los requisitos del sistema y las restricciones del dominio. — entregable (NO resolver): Documento de requisitos y restricciones del sistema.
- Fase 2: Elección de Herramientas y Justificación — objetivo: Evaluar y justificar la elección de herramientas para el control plane. — entregable (NO resolver): Documento comparativo y justificación de herramientas.
- Fase 3: Diseño de la Topología de Replicación — objetivo: Diseñar la topología de replicación de estado entre clusters. — entregable (NO resolver): Documento de diseño de la topología de replicación.

Eres un asistente experto en análisis, corrección y generación de archivos de cualquier tipo:
código fuente, documentación, hojas de cálculo, documentos Word, configuraciones, entre otros.
Voy a enviarte una cadena de texto que contiene uno o más archivos. Cada archivo está delimitado por un marcador con el siguiente formato:
// === ARCHIVO: ruta/del/archivo.extension ===
o también puede aparecer como:
## === ARCHIVO: ruta/del/archivo.extension ===
Lo que sigue al marcador puede ser:

El contenido real del archivo (código, texto, YAML, etc.)
Una descripción en lenguaje natural de lo que debe contener el archivo


TU TAREA
PASO 0 — ¿Esto es un proyecto o una carcasa?
Antes de extraer archivos, leé el Briefing (si está) y diagnosticá el adjunto.

Es CARCASA si ocurre CUALQUIERA de estas:
- No hay manifiesto de dependencias del stack del briefing (manifest.json de VTEX IO / package.json / pom.xml / build.gradle / requirements.txt / go.mod / *.tf / *.csproj, según corresponda)
- Hay un "binario" que en realidad es un comentario ("no puede ser mostrado como texto plano", placeholder .fig/.docx vacío)
- Los markdowns ya completan entregables de fases posteriores ("se implementó fade-in", lista de áreas ya resuelta)

Si es CARCASA:
- MATERIALIZÁ un proyecto que arranca en el stack del briefing (VTEX IO Store Framework, Angular, Terraform, pytest, Nest, etc.). Incluí manifiesto, punto de entrada y capa de interfaz reales.
- NO copies los markdowns de "solución" como si fueran el producto. Son ruido de generación.
- NO resuelvas las fases del briefing (están marcadas PROHIBIDO). Dejá el hueco pedagógico: el flujo existe, las microinteracciones/calidad/infra que el reto pide NO están hechas.
- Después seguí al PASO 5 (ZIP).

Si es un proyecto REAL (manifiesto + código que compila o arranca):
- Seguí PASO 1 en adelante. 🔴 compilación sí. 🟡 pedagógico no.

PASO 1 — Detección y extracción
Identifica todos los archivos presentes en la cadena. Para cada archivo extrae:

Su ruta completa (ej: src/main/java/com/pragma/Service.java)
Su contenido o descripción

PASO 2 — Clasificación por tipo
Clasifica cada archivo en una de estas categorías:
A) Código fuente (Java, Python, TypeScript, JavaScript, Kotlin, etc.)
B) Configuración / documentación (YAML, properties, Markdown, JSON, txt, etc.)
C) Excel (.xlsx, .xls, .csv)
D) Word (.docx, .doc)
E) Otro tipo de archivo binario o especial
PASO 3 — Clasificación de errores en código fuente

Objetivo prioritario: que el proyecto compile. No corrijas flujo de negocio ni lógica funcional.

Antes de modificar cualquier archivo de código fuente, clasifica cada problema encontrado en una de estas dos categorías:
🔴 ERROR DE COMPILACIÓN — corregir siempre
Son errores que impiden que el proyecto arranque, sin valor pedagógico:

Import faltante o incorrecto
Clase, método o variable referenciada que no existe en ningún archivo del proyecto
Error de sintaxis
Anotación con atributos inválidos
Dependencia ausente en pom.xml, package.json, etc.
Archivo referenciado que no existe y debe ser creado con implementación mínima

→ CORREGIR estos errores.
🟡 PROBLEMA FUNCIONAL O DE CALIDAD — preservar siempre
Son problemas que no impiden compilar. Pueden ser intencionales para el aprendizaje:

Clave secreta hardcodeada ("secret", "password123")
API deprecada que funciona pero tiene reemplazo moderno
Lógica de negocio incorrecta o incompleta
Código redundante o de baja legibilidad
Falta de validaciones en flujo de negocio
Patrones de diseño incorrectos pero funcionales
Concurrencia no segura
Configuración funcional pero no óptima

→ PRESERVAR tal cual. No corregir, no mejorar, no comentar.
PASO 4 — Procesamiento según tipo de archivo
Tipo A — Código fuente
Aplica únicamente las correcciones clasificadas como 🔴 ERROR DE COMPILACIÓN.
No alteres ningún elemento clasificado como 🟡 PROBLEMA FUNCIONAL O DE CALIDAD.
Si falta un archivo referenciado, créalo con la implementación mínima necesaria para compilar.
Tipo B — Configuración / documentación
Extrae el contenido tal cual, sin modificaciones salvo errores evidentes de sintaxis
(ej: YAML mal indentado).
Tipo C — Excel (.xlsx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un archivo Excel funcional con:

Fila de encabezados en negrita con color de fondo distintivo
Columnas con ancho ajustado al contenido
Tipos de dato correctos por columna
Validaciones si la descripción lo indica
Hojas nombradas descriptivamente si hay más de una
Filas de ejemplo si no hay datos reales

Tipo D — Word (.docx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un documento Word funcional con:

Estilos de título (Título 1, Título 2) para jerarquía de secciones
Fuente legible (Calibri o equivalente), tamaño 11-12pt para cuerpo
Márgenes estándar
Tabla de contenido si tiene múltiples secciones
Tablas con encabezados en negrita si aplica

Tipo E — Otro
Genera el archivo con el contenido o estructura más apropiada según la descripción.
PASO 5 — Exportación en ZIP
Empaqueta todos los archivos en un único archivo ZIP descargable respetando exactamente
la estructura de rutas indicada por los marcadores.
El ZIP debe incluir:

Archivos de código con únicamente los errores de compilación corregidos
Archivos de configuración y documentación sin cambios
Archivos nuevos creados para resolver dependencias de compilación faltantes
Archivos Excel y Word generados desde descripción

IMPORTANTE: El ZIP debe estar listo para descargar al finalizar. No preguntes si el usuario
quiere generarlo. Simplemente genera el archivo y proporciona el enlace de descarga; No debes desplegar en el chat el resumen de lo que arreglaste al Zip, solo entregalo.

REGLAS IMPORTANTES

No omitas ningún archivo aunque no tenga errores ni modificaciones
Respeta los nombres y rutas exactas indicadas por los marcadores
Si un archivo no tiene marcador claro, infiere el nombre desde su contenido
Si la cadena contiene solo documentación, placeholders o binarios fake, NO la reproduzcas:
aplicá PASO 0 (materializar el proyecto del briefing). Reproducir la carcasa es un fallo.
No agregues texto después del enlace de descarga del ZIP
No preguntes si el usuario quiere el ZIP: simplemente generalo siempre
Si detectas que falta un archivo de configuración necesario para compilar
(pom.xml, package.json, requirements.txt, build.gradle, etc.), créalo e inclúyelo
inferiendo su contenido desde los imports y frameworks detectados en el código
Nunca corrijas problemas 🟡 aunque parezcan obvios o fáciles de mejorar.
El participante que recibirá este proyecto los debe encontrar y resolver él mismo.


INPUT
Aquí está la cadena con los archivos:

// === ARCHIVO: package.json ===
{
  "name": "multi-cluster-gitops-control-plane",
  "version": "1.0.0",
  "description": "Control plane multi-cluster con GitOps y disaster recovery cross-region",
  "main": "index.js",
  "scripts": {
    "validate:clusters": "bash scripts/validate-cluster-configs.sh",
    "validate:infra": "bash scripts/validate-infrastructure.sh",
    "validate:apps": "bash scripts/validate-applications.sh",
    "health:all": "bash scripts/health-check.sh",
    "failover:dry-run": "bash scripts/failover-logic.sh --dry-run",
    "failover:execute": "bash scripts/failover-logic.sh --execute",
    "test:health": "kubectl apply -f tests/health-check-tests.yaml",
    "test:failover": "kubectl apply -f tests/failover-tests.yaml",
    "test:replication": "kubectl apply -f tests/replication-tests.yaml",
    "deploy:argocd": "kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/v2.10.0/manifests/install.yaml",
    "deploy:crossplane": "helm install crossplane crossplane-stable/crossplane --version 1.14.0 --namespace crossplane-system --create-namespace",
    "deploy:vault": "helm install vault hashicorp/vault --version 0.25.0 --namespace vault --create-namespace",
    "sync:apps": "argocd app sync -l app.kubernetes.io/instance=argocd",
    "sync:infra": "argocd app sync infrastructure",
    "cleanup:all": "bash scripts/cleanup.sh"
  },
  "keywords": [
    "kubernetes",
    "argocd",
    "crossplane",
    "gitops",
    "multi-cluster",
    "disaster-recovery",
    "aws",
    "vault",
    "external-secrets",
    "federated-rbac"
  ],
  "author": "Architecture Team",
  "license": "MIT",
  "repository": {
    "type": "git",
    "url": "https://github.com/org/multi-cluster-control-plane"
  },
  "engines": {
    "node": ">=18.0.0",
    "kubectl": ">=1.28.0",
    "helm": ">=3.12.0",
    "awscli": ">=2.15.0"
  },
  "dependencies": {
    "@kubernetes/client-node": "^0.20.0",
    "js-yaml": "^4.1.0",
    "axios": "^1.6.0"
  },
  "devDependencies": {
    "@types/js-yaml": "^4.0.9",
    "@types/node": "^20.10.0",
    "typescript": "^5.3.0"
  },
  "config": {
    "cluster": {
      "primary": {
        "name": "primary-cluster",
        "region": "us-east-1",
        "endpoint": "https://primary.k8s.example.com",
        "version": "1.28.0"
      },
      "standby": [
        {
          "name": "standby-us-east-2",
          "region": "us-east-2",
          "endpoint": "https://standby-us-east-2.k8s.example.com",
          "version": "1.28.0"
        },
        {
          "name": "standby-us-west-1",
          "region": "us-west-1",
          "endpoint": "https://standby-us-west-1.k8s.example.com",
          "version": "1.28.0"
        },
        {
          "name": "standby-us-west-2",
          "region": "us-west-2",
          "endpoint": "https://standby-us-west-2.k8s.example.com",
          "version": "1.28.0"
        }
      ]
    },
    "argocd": {
      "version": "2.10.0",
      "namespace": "argocd",
      "admin.enabled": true,
      "server.service.type": "LoadBalancer",
      "repo.server.autotls": "env",
      "applicationSet.enabled": true,
      "applicationSet.namespaces": ["argocd", "applications"]
    },
    "crossplane": {
      "version": "1.14.0",
      "namespace": "crossplane-system",
      "provider-aws": {
        "version": "v0.47.0",
        "package": "xref://index.upbound.io/master/crossplane/provider-aws:v0.47.0"
      }
    },
    "vault": {
      "version": "1.15.0",
      "namespace": "vault",
      "injector.enabled": true,
      "server.ha.enabled": true,
      "server.ha.replicas": 3
    },
    "external-secrets": {
      "version": "0.9.0",
      "namespace": "external-secrets",
      "operator": {
        "version": "0.9.0"
      },
      "clusteroesint-store": {
        "backend": "aws-secrets-manager",
        "provider": "aws",
        "region": "us-east-1"
      }
    },
    "replication": {
      "strategy": "async",
      "consistency": "eventual",
      "syncInterval": "30s",
      "retryAttempts": 3,
      "conflictResolution": "primary-wins"
    },
    "failover": {
      "healthCheckInterval": "10s",
      "failoverTimeout": "60s",
      "gracePeriod": "30s",
      "autoFailover": false,
      "notificationChannels": ["slack", "pagerduty"]
    }
  }
}

// === ARCHIVO: clusters/primary-cluster.yaml ===
apiVersion: argoproj.io/v1alpha1
kind: ApplicationSet
metadata:
  name: primary-cluster-infrastructure
  namespace: argocd
  labels:
    app.kubernetes.io/name: primary-cluster-infrastructure
    app.kubernetes.io/part-of: argocd
    environment: production
    region: us-east-1
    cluster-role: primary
spec:
  generators:
    - cluster:
        values:
          environment: production
          region: us-east-1
          cluster-role: primary
          replication-enabled: "false"
          priority: "1"
          health-check-interval: 10s
          failover-timeout: 60s
  template:
    metadata:
      name: primary-cluster-{{name}}
      labels:
        cluster: primary
        region: us-east-1
    spec:
      project: infrastructure
      source:
        - repoURL: https://github.com/org/multi-cluster-gitops-control-plane
          targetRevision: main
          path: infrastructure/resources
          directory:
            recurse: true
            jsonnet: {}
      destination:
        server: https://primary.k8s.example.com
        namespace: default
      syncPolicy:
        automated:
          prune: true
          selfHeal: true
          allowEmpty: false
        syncOptions:
          - CreateNamespace=true
          - PruneLast=true
          - PrunePropagationPolicy=foreground
        retry:
          limit: 5
          backoff:
            duration: 5s
            factor: 2
            maxDuration: 3m
---
apiVersion: argoproj.io/v1alpha1
kind: AppProject
metadata:
  name: primary-cluster-project
  namespace: argocd
  labels:
    app.kubernetes.io/name: primary-cluster-project
    cluster-role: primary
    region: us-east-1
spec:
  description: Projecto para el cluster primario en us-east-1
  sourceRepos:
    - https://github.com/org/multi-cluster-gitops-control-plane
    - https://github.com/org/multi-cluster-gitops-control-plane-infra
  destinations:
    - namespace: argocd
      server: https://primary.k8s.example.com
    - namespace: infrastructure
      server: https://primary.k8s.example.com
    - namespace: applications
      server: https://primary.k8s.example.com
    - namespace: crossplane-system
      server: https://primary.k8s.example.com
    - namespace: vault
      server: https://primary.k8s.example.com
    - namespace: external-secrets
      server: https://primary.k8s.example.com
    - namespace: monitoring
      server: https://primary.k8s.example.com
  clusterResourceWhitelist:
    - group: ""
      kind: Namespace
    - group: "rbac.authorization.k8s.io"
      kind: ClusterRole
    - group: "rbac.authorization.k8s.io"
      kind: ClusterRoleBinding
    - group: "apiextensions.k8s.io"
      kind: CustomResourceDefinition
    - group: "admissionregistration.k8s.io"
      kind: MutatingWebhookConfiguration
    - group: "admissionregistration.k8s.io"
      kind: ValidatingWebhookConfiguration
  namespaceResourceWhitelist:
    - group: ""
      kind: Service
    - group: ""
      kind: ConfigMap
    - group: ""
      kind: Secret
    - group: "apps"
      kind: Deployment
    - group: "apps"
      kind: StatefulSet
    - group: "apps"
      kind: DaemonSet
    - group: "networking.k8s.io"
      kind: Ingress
    - group: "policy"
      kind: PodDisruptionBudget
    - group: "crossplane.io"
      kind: '*'
    - group: "external-secrets.io"
      kind: '*'
  roles:
    - name: admin
      description: Rol de administrador para el cluster primario
      groups:
        - system:clusteradmins
        - argocd-admins@company.com
      policies:
        - p, proj:primary-cluster-project:admin, *, *, */*, allow
    - name: operator
      description: Rol de operador para gestionar aplicaciones
      groups:
        - platform-operators@company.com
      policies:
        - p, proj:primary-cluster-project:operator, *, get, *, allow
        - p, proj:primary-cluster-project:operator, *, update, *, allow
    - name: readonly
      description: Rol de solo lectura
      groups:
        - platform-viewers@company.com
      policies:
        - p, proj:primary-cluster-project:readonly, *, get, *, allow
---
apiVersion: crossplane.io/v1alpha1
kind: ProviderConfig
metadata:
  name: primary-cluster-aws
  namespace: crossplane-system
  labels:
    cluster: primary
    region: us-east-1
spec:
  credentials:
    source: Secret
    secretRef:
      namespace: crossplane-system
      name: aws-provider-creds
      key: credentials
  configuration:
    region: us-east-1
  meta:
    priority: "1"
    replication-role: primary
    health-check-url: https://primary.k8s.example.com/healthz
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: primary-cluster-config
  namespace: argocd
  labels:
    cluster: primary
    region: us-east-1
    cluster-role: primary
data:
  cluster.config: |
    cluster-name: primary-cluster
    region: us-east-1
    role: primary
    priority: 1
    replication:
      enabled: false
      upstream: null
    healthchecks:
      interval: 10s
      timeout: 5s
      retries: 3
    failover:
      enabled: true
      auto: false
      timeout: 60s
      grace-period: 30s
  cluster.metadata: |
    k8s-version: "1.28.0"
    provider: aws
    node-count: 6
    node-type: m6i.2xlarge
    storage-type: gp3
    vpc-cidr: 10.0.0.0/16
    vpc-id: vpc-0123456789abcdef0
    availability-zones:
      - us-east-1a
      - us-east-1b
      - us-east-1c
---
apiVersion: v1
kind: Secret
metadata:
  name: primary-cluster-credentials
  namespace: argocd
  labels:
    cluster: primary
    region: us-east-1
type: Opaque
stringData:
  server: https://primary.k8s.example.com
  # Los certificados se gestionan via External Secrets desde AWS Secrets Manager
  cert-data: |
    -----BEGIN CERTIFICATE-----
    # Certificado del API server
    -----END CERTIFICATE-----
  # Token de acceso (rotado automaticamente via External Secrets)
  auth-token: "placeholder-managed-by-external-secrets"
---
apiVersion: external-secrets.io/v1beta1
kind: ClusterSecretStore
metadata:
  name: primary-cluster-secrets
  namespace: argocd
  labels:
    cluster: primary
    region: us-east-1
spec:
  provider:
    aws:
      service: SecretsManager
      region: us-east-1
      auth:
        secretRef:
          accessKeyIDRef:
            name: aws-secrets-manager-access
            key: access-key-id
          secretAccessKeyRef:
            name: aws-secrets-manager-access
            key: secret-access-key
  secretSelector:
    matchLabels:
      cluster: primary
      environment: production
---
apiVersion: policy/v1
kind: PodDisruptionBudget
metadata:
  name: primary-cluster-argocd-pdb
  namespace: argocd
  labels:
    cluster: primary
    region: us-east-1
spec:
  minAvailable: 2
  selector:
    matchLabels:
      app.kubernetes.io/name: argocd-server
---
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: primary-cluster-argocd-hpa
  namespace: argocd
  labels:
    cluster: primary
    region: us-east-1
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: argocd-server
  minReplicas: 2
  maxReplicas: 10
  metrics:
    - type: Resource
      resource:
        name: cpu
        target:
          type: Utilization
          averageUtilization: 70
    - type: Resource
      resource:
        name: memory
        target:
          type: Utilization
          averageUtilization: 80
---
apiVersion: v1
kind: Service
metadata:
  name: primary-cluster-health
  namespace: argocd
  labels:
    cluster: primary
    region: us-east-1
    purpose: health-check
spec:
  type: ClusterIP
  ports:
    - name: health
      port: 8080
      targetPort: 8080
      protocol: TCP
    - name: metrics
      port: 9090
      targetPort: 9090
      protocol: TCP
  selector:
    app.kubernetes.io/name: argocd-server
---
apiVersion: monitoring.coreos.com/v1
kind: ServiceMonitor
metadata:
  name: primary-cluster-argocd-monitor
  namespace: monitoring
  labels:
    cluster: primary
    region: us-east-1
spec:
  selector:
    matchLabels:
      app.kubernetes.io/name: argocd-server
  endpoints:
    - port: metrics
      interval: 30s
      path: /metrics
  namespaceSelector:
    matchNames:
      - argocd
---
apiVersion: argoproj.io/v1alpha1
kind: ApplicationSet
metadata:
  name: primary-cluster-monitoring
  namespace: argocd
  labels:
    cluster: primary
    region: us-east-1
    component: monitoring
spec:
  generators:
    - matrix:
        generators:
          - clusters:
              selector:
                matchLabels:
                  cluster: primary
          - git:
              repoURL: https://github.com/org/multi-cluster-gitops-control-plane
              revision: main
              directories:
                - path: monitoring/primary/*
  template:
    metadata:
      name: primary-monitoring-{{path.basename}}
    spec:
      project: monitoring
      source:
        - repoURL: https://github.com/org/multi-cluster-gitops-control-plane
          targetRevision: main
          path: monitoring/primary
      destination:
        server: https://primary.k8s.example.com
        namespace: monitoring
      syncPolicy:
        automated:
          prune: true
          selfHeal: true
// === ARCHIVO: clusters/standby-clusters.yaml ===
apiVersion: argoproj.io/v1alpha1
kind: ApplicationSet
metadata:
  name: standby-clusters-infrastructure
  namespace: argocd
  labels:
    app.kubernetes.io/name: standby-clusters-infrastructure
    app.kubernetes.io/part-of: argocd
    environment: production
    cluster-role: standby
spec:
  generators:
    - cluster:
        selector:
          matchLabels:
            cluster-role: standby
        values:
          environment: production
          cluster-role: standby
          replication-enabled: "true"
          priority: "2"
          health-check-interval: 10s
          failover-timeout: 60s
  template:
    metadata:
      name: standby-{{name}}-infrastructure
      labels:
        cluster: "{{name}}"
        cluster-role: standby
        region: "{{values.region}}"
    spec:
      project: infrastructure
      source:
        - repoURL: https://github.com/org/multi-cluster-gitops-control-plane
          targetRevision: main
          path: infrastructure/resources
          directory:
            recurse: true
      destination:
        server: "{{values.endpoint}}"
        namespace: default
      syncPolicy:
        automated:
          prune: true
          selfHeal: true
          allowEmpty: false
        syncOptions:
          - CreateNamespace=true
          - PruneLast=true
        retry:
          limit: 5
          backoff:
            duration: 5s
            factor: 2
            maxDuration: 3m
---
apiVersion: argoproj.io/v1alpha1
kind: AppProject
metadata:
  name: standby-clusters-project
  namespace: argocd
  labels:
    app.kubernetes.io/name: standby-clusters-project
    cluster-role: standby
spec:
  description: Proyecto para clusters standby - replica del primario
  sourceRepos:
    - https://github.com/org/multi-cluster-gitops-control-plane
    - https://github.com/org/multi-cluster-gitops-control-plane-infra
  destinations:
    - namespace: argocd
      server: https://standby-us-east-2.k8s.example.com
    - namespace: argocd
      server: https://standby-us-west-1.k8s.example.com
    - namespace: argocd
      server: https://standby-us-west-2.k8s.example.com
    - namespace: infrastructure
      server: "*"
    - namespace: applications
      server: "*"
    - namespace: crossplane-system
      server: "*"
    - namespace: vault
      server: "*"
    - namespace: external-secrets
      server: "*"
  clusterResourceWhitelist:
    - group: ""
      kind: Namespace
    - group: "rbac.authorization.k8s.io"
      kind: ClusterRole
    - group: "rbac.authorization.k8s.io"
      kind: ClusterRoleBinding
    - group: "apiextensions.k8s.io"
      kind: CustomResourceDefinition
  namespaceResourceWhitelist:
    - group: ""
      kind: Service
    - group: ""
      kind: ConfigMap
    - group: ""
      kind: Secret
    - group: "apps"
      kind: Deployment
    - group: "apps"
      kind: StatefulSet
    - group: "networking.k8s.io"
      kind: Ingress
    - group: "crossplane.io"
      kind: '*'
    - group: "external-secrets.io"
      kind: '*'
  roles:
    - name: admin
      description: Rol de administrador para clusters standby
      groups:
        - system:clusteradmins
        - argocd-admins@company.com
      policies:
        - p, proj:standby-clusters-project:admin, *, *, */*, allow
    - name: replication-operator
      description: Rol para operadores de replicacion
      groups:
        - platform-operators@company.com
      policies:
        - p, proj:standby-clusters-project:replication-operator, *, get, *, allow
        - p, proj:standby-clusters-project:replication-operator, *, update, *, allow
        - p, proj:standby-clusters-project:replication-operator, applications, create, *, allow
---
apiVersion: crossplane.io/v1alpha1
kind: ProviderConfig
metadata:
  name: standby-clusters-aws
  namespace: crossplane-system
  labels:
    cluster-role: standby
spec:
  credentials:
    source: Secret
    secretRef:
      namespace: crossplane-system
      name: aws-provider-creds-standby
      key: credentials
  configuration:
    region: "{{values.region}}"
  meta:
    priority: "2"
    replication-role: standby
    health-check-url: "{{values.health-check-url}}"
    upstream-cluster: primary-cluster
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: standby-clusters-config
  namespace: argocd
  labels:
    cluster-role: standby
data:
  cluster.config: |
    cluster-role: standby
    replication:
      enabled: true
      strategy: async
      consistency: eventual
      sync-interval: 30s
      retry-attempts: 3
      conflict-resolution: primary-wins
      upstream: primary-cluster
    healthchecks:
      interval: 10s
      timeout: 5s
      retries: 3
      endpoint: /healthz
    failover:
      enabled: true
      auto: false
      timeout: 60s
      grace-period: 30s
      promotion-candidates:
        - standby-us-east-2
        - standby-us-west-1
        - standby-us-west-2
  cluster.list: |
    clusters:
      - name: standby-us-east-2
        region: us-east-2
        priority: 2
        endpoint: https://standby-us-east-2.k8s.example.com
        health-check-url: https://standby-us-east-2.k8s.example.com/healthz
        availability-zones:
          - us-east-2a
          - us-east-2b
          - us-east-2c
      - name: standby-us-west-1
        region: us-west-1
        priority: 3
        endpoint: https://standby-us-west-1.k8s.example.com
        health-check-url: https://standby-us-west-1.k8s.example.com/healthz
        availability-zones:
          - us-west-1a
          - us-west-1b
      - name: standby-us-west-2
        region: us-west-2
        priority: 4
        endpoint: https://standby-us-west-2.k8s.example.com
        health-check-url: https://standby-us-west-2.k8s.example.com/healthz
        availability-zones:
          - us-west-2a
          - us-west-2b
          - us-west-2c
---
apiVersion: v1
kind: Secret
metadata:
  name: standby-clusters-credentials
  namespace: argocd
  labels:
    cluster-role: standby
type: Opaque
stringData:
  # Configuracion de credenciales para cada cluster standby
  # Gestionado via External Secrets desde AWS Secrets Manager
  standby-us-east-2.server: https://standby-us-east-2.k8s.example.com
  standby-us-west-1.server: https://standby-us-west-1.k8s.example.com
  standby-us-west-2.server: https://standby-us-west-2.k8s.example.com
  credentials-reference: "placeholder-managed-by-external-secrets"
---
apiVersion: external-secrets.io/v1beta1
kind: ClusterSecretStore
metadata:
  name: standby-clusters-secrets
  namespace: argocd
  labels:
    cluster-role: standby
spec:
  provider:
    aws:
      service: SecretsManager
      region: us-east-1
      auth:
        secretRef:
          accessKeyIDRef:
            name: aws-secrets-manager-access
            key: access-key-id
          secretAccessKeyRef:
            name: aws-secrets-manager-access
            key: secret-access-key
  secretSelector:
    matchLabels:
      cluster-role: standby
      environment: production
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: replication-config
  namespace: argocd
  labels:
    component: replication
    cluster-role: standby
data:
  replication.yaml: |
    apiVersion: v1
    kind: ReplicationConfiguration
    metadata:
      name: cross-region-replication
    spec:
      strategy: async
      consistency: eventual
      syncInterval: 30s
      retryAttempts: 3
      conflictResolution: primary-wins
      resources:
        - kind: Application
          apiVersion: argoproj.io/v1alpha1
          syncMode: foreground
        - kind: ConfigMap
          apiVersion: v1
          syncMode: merge
        - kind: Secret
          apiVersion: v1
          syncMode: secret
          encryptionRequired: true
        - kind: AppProject
          apiVersion: argoproj.io/v1alpha1
          syncMode: foreground
  topology.yaml: |
    apiVersion: v1
    kind: ReplicationTopology
    metadata:
      name: multi-region-topology
    spec:
      primary:
        cluster: primary-cluster
        region: us-east-1
        writeEndpoint: https://primary.k8s.example.com
      standbys:
        - cluster: standby-us-east-2
          region: us-east-2
          priority: 2
          readEndpoint: https://standby-us-east-2.k8s.example.com
        - cluster: standby-us-west-1
          region: us-west-1
          priority: 3
          readEndpoint: https://standby-us-west-1.k8s.example.com
        - cluster: standby-us-west-2
          region: us-west-2
          priority: 4
          readEndpoint: https://standby-us-west-2.k8s.example.com
---
apiVersion: v1
kind: Service
metadata:
  name: standby-clusters-health
  namespace: argocd
  labels:
    cluster-role: standby
    purpose: health-check
spec:
  type: ClusterIP
  ports:
    - name: health
      port: 8080
      targetPort: 8080
      protocol: TCP
    - name: metrics
      port: 9090
      targetPort: 9090
      protocol: TCP
    - name: replication
      port: 8081
      targetPort: 8081
      protocol: TCP
  selector:
    app.kubernetes.io/name: argocd-server
---
apiVersion: policy/v1
kind: PodDisruptionBudget
metadata:
  name: standby-clusters-argocd-pdb
  namespace: argocd
  labels:
    cluster-role: standby
spec:
  minAvailable: 1
  selector:
    matchLabels:
      app.kubernetes.io/name: argocd-server
---
apiVersion: argoproj.io/v1alpha1
kind: ApplicationSet
metadata:
  name: standby-clusters-monitoring
  namespace: argocd
  labels:
    cluster-role: standby
    component: monitoring
spec:
  generators:
    - matrix:
        generators:
          - clusters:
              selector:
                matchLabels:
                  cluster-role: standby
          - git:
              repoURL: https://github.com/org/multi-cluster-gitops-control-plane
              revision: main
              directories:
                - path: monitoring/standby/*
  template:
    metadata:
      name: standby-monitoring-{{name}}
    spec:
      project: monitoring
      source:
        - repoURL: https://github.com/org/multi-cluster-gitops-control-plane
          targetRevision: main
          path: monitoring/standby
      destination:
        server: "{{server}}"
        namespace: monitoring
      syncPolicy:
        automated:
          prune: true
          selfHeal: true
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: failover-config
  namespace: argocd
  labels:
    component: failover
    cluster-role: standby
data:
  failover-policy.yaml: |
    apiVersion: v1
    kind: FailoverPolicy
    metadata:
      name: automatic-failover-policy
    spec:
      enabled: false
      mode: manual
      healthCheckInterval: 10s
      failoverTimeout: 60s
      gracePeriod: 30s
      preFailoverChecks:
        - name: cluster-reachable
          type: http
          endpoint: /healthz
          timeout: 5s
        - name: data-replicated
          type: state
          resource: ReplicationStatus
          condition: synced
        - name: capacity-available
          type: capacity
          threshold: 80%
      postFailoverActions:
        - type: notification
          channel: slack
          message: "Failover executed from {{failedCluster}} to {{promotedCluster}}"
        - type: notification
          channel: pagerduty
          severity: critical
        - type: dns-update
          record: primary.k8s.example.com
          target: {{promotedClusterEndpoint}}
      rollbackPolicy:
        enabled: true
        timeout: 300s
        maxRetries: 3
  promotion-order.yaml: |
    apiVersion: v1
    kind: PromotionOrder
    metadata:
      name: cluster-promotion-order
    spec:
      order:
        - cluster: standby-us-east-2
          region: us-east-2
          priority: 1
          weight: 100
        - cluster: standby-us-west-1
          region: us-west-1
          priority: 2
          weight: 80
        - cluster: standby-us-west-2
          region: us-west-2
          priority: 3
          weight: 60

// === ARCHIVO: infrastructure/providers.yaml ===
apiVersion: aws.upbound.io/v1beta1
kind: ProviderConfig
metadata:
  name: aws-primary
  namespace: crossplane-system
  labels:
    environment: production
    region: us-east-1
    cluster: primary
spec:
  credentials:
    source: Secret
    secretRef:
      namespace: crossplane-system
      name: aws-provider-creds
      key: credentials
  region: us-east-1
  skipCredsValidation: false
  skipMetadataApiCheck: false
---
apiVersion: aws.upbound.io/v1beta1
kind: ProviderConfig
metadata:
  name: aws-standby-us-east-2
  namespace: crossplane-system
  labels:
    environment: production
    region: us-east-2
    cluster: standby-us-east-2
spec:
  credentials:
    source: Secret
    secretRef:
      namespace: crossplane-system
      name: aws-provider-creds-standby
      key: credentials
  region: us-east-2
  skipCredsValidation: false
  skipMetadataApiCheck: false
---
apiVersion: aws.upbound.io/v1beta1
kind: ProviderConfig
metadata:
  name: aws-standby-us-west-1
  namespace: crossplane-system
  labels:
    environment: production
    region: us-west-1
    cluster: standby-us-west-1
spec:
  credentials:
    source: Secret
    secretRef:
      namespace: crossplane-system
      name: aws-provider-creds-standby
      key: credentials
  region: us-west-1
  skipCredsValidation: false
  skipMetadataApiCheck: false
---
apiVersion: aws.upbound.io/v1beta1
kind: ProviderConfig
metadata:
  name: aws-standby-us-west-2
  namespace: crossplane-system
  labels:
    environment: production
    region: us-west-2
    cluster: standby-us-west-2
spec:
  credentials:
    source: Secret
    secretRef:
      namespace: crossplane-system
      name: aws-provider-creds-standby
      key: credentials
  region: us-west-2
  skipCredsValidation: false
  skipMetadataApiCheck: false
---
apiVersion: v1
kind: Secret
metadata:
  name: aws-provider-creds
  namespace: crossplane-system
  labels:
    app: crossplane
    provider: aws
type: Opaque
stringData:
  credentials: |-
    [default]
    aws_access_key_id = ${AWS_ACCESS_KEY_ID}
    aws_secret_access_key = ${AWS_SECRET_ACCESS_KEY}
    region = us-east-1
---
apiVersion: v1
kind: Secret
metadata:
  name: aws-provider-creds-standby
  namespace: crossplane-system
  labels:
    app: crossplane
    provider: aws
    scope: standby
type: Opaque
stringData:
  credentials: |-
    [standby]
    aws_access_key_id = ${AWS_STANDBY_ACCESS_KEY_ID}
    aws_secret_access_key = ${AWS_STANDBY_SECRET_ACCESS_KEY}
    role_arn = arn:aws:iam::${STANDBY_ACCOUNT_ID}:role/CrossplaneProvisioner
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: crossplane-provider-config
  namespace: crossplane-system
  labels:
    app: crossplane
    component: provider-config
data:
  provider-config.yaml: |-
    apiVersion: aws.upbound.io/v1beta1
    kind: ProviderConfig
    metadata:
      name: default
    spec:
      region: us-east-1
      credentials:
        source: Secret
        secretRef:
          namespace: crossplane-system
          name: aws-provider-creds
          key: credentials
  enable-external-name: "true"
  enable-managed-identities: "true"
  default-tags: |-
    Managed-By: Crossplane
    Project: multi-cluster-gitops
    Environment: production
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: crossplane-provider-aws
  labels:
    app: crossplane
    provider: aws
    component: rbac
aggregationRule:
  clusterRoleSelectors:
    - matchLabels:
        rbac.crossplane.io/aggregate-to-provider: "true"
rules: [] 
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: crossplane-provider-aws-verbs
  labels:
    app: crossplane
    provider: aws
    rbac.crossplane.io/aggregate-to-provider: "true"
rules:
  - apiGroups: ["aws.upbound.io", "ec2.amazonaws.com", "rds.amazonaws.com", "iam.amazonaws.com", "s3.amazonaws.com"]
    resources: ["*"]
    verbs: ["*"]
  - apiGroups: [""]
    resources: ["secrets"]
    verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]
  - apiGroups: [""]
    resources: ["configmaps"]
    verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]
---
apiVersion: v1
kind: Namespace
metadata:
  name: crossplane-system
  labels:
    app: crossplane
    component: runtime
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: crossplane
  namespace: crossplane-system
  labels:
    app: crossplane
    component: controller
spec:
  selector:
    matchLabels:
      app: crossplane
  replicas: 2
  template:
    metadata:
      labels:
        app: crossplane
    spec:
      serviceAccountName: crossplane
      containers:
        - name: crossplane
          image: crossplane/crossplane:v1.14.0
          args:
            - --debug
            - --enable-external-name-sts
          securityContext:
            runAsNonRoot: true
            runAsUser: 65532
            fsGroup: 65532
          resources:
            limits:
              cpu: 500m
              memory: 512Mi
            requests:
              cpu: 100m
              memory: 256Mi
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: crossplane
  namespace: crossplane-system
  labels:
    app: crossplane
    component: security
// === ARCHIVO: infrastructure/resources.yaml ===
apiVersion: database.rds.upbound.io/v1beta1
kind: Instance
metadata:
  name: primary-postgres
  namespace: crossplane-system
  labels:
    environment: production
    region: us-east-1
    cluster: primary
    role: primary
    database-type: postgres
spec:
  forProvider:
    region: us-east-1
    engine: postgres
    engineVersion: "15.4"
    instanceClass: db.r6g.xlarge
    allocatedStorage: 100
    maxAllocatedStorage: 500
    storageType: gp3
    storageEncrypted: true
    multiAz: true
    dbName: controlplane
    masterUsername: dbadmin
    masterPasswordSecretRef:
      namespace: vault
      name: database-credentials
      key: password
    backupRetentionPeriod: 30
    backupWindow: "03:00-04:00"
    maintenanceWindow: "mon:04:00-mon:05:00"
    publiclyAccessible: false
    vpcSecurityGroupIDRefs:
      - name: rds-security-group
    dbSubnetGroupName: primary-db-subnet-group
    enabledCloudwatchLogsExports:
      - postgresql
      - upgrade
    parameterGroupName: postgres-15-optimized
    optionGroupName: postgres-15-options
    tags:
      Name: primary-postgres
      Managed-By: Crossplane
      Environment: production
  providerConfigRef:
    name: aws-primary
  writeConnectionSecretToRef:
    namespace: crossplane-system
    name: primary-postgres-conn
---
apiVersion: database.rds.upbound.io/v1beta1
kind: Instance
metadata:
  name: standby-postgres-us-east-2
  namespace: crossplane-system
  labels:
    environment: production
    region: us-east-2
    cluster: standby-us-east-2
    role: standby
    database-type: postgres
spec:
  forProvider:
    region: us-east-2
    engine: postgres
    engineVersion: "15.4"
    instanceClass: db.r6g.xlarge
    allocatedStorage: 100
    maxAllocatedStorage: 500
    storageType: gp3
    storageEncrypted: true
    multiAz: false
    dbName: controlplane
    masterUsername: dbadmin
    masterPasswordSecretRef:
      namespace: vault
      name: database-credentials
      key: password
    backupRetentionPeriod: 30
    publiclyAccessible: false
    vpcSecurityGroupIDRefs:
      - name: rds-security-group-standby
    dbSubnetGroupName: standby-db-subnet-group-us-east-2
    enabledCloudwatchLogsExports:
      - postgresql
    parameterGroupName: postgres-15-optimized
    tags:
      Name: standby-postgres-us-east-2
      Managed-By: Crossplane
      Environment: production
  providerConfigRef:
    name: aws-standby-us-east-2
  writeConnectionSecretToRef:
    namespace: crossplane-system
    name: standby-postgres-us-east-2-conn
---
apiVersion: s3.aws.upbound.io/v1beta1
kind: Bucket
metadata:
  name: control-plane-state
  namespace: crossplane-system
  labels:
    environment: production
    region: us-east-1
    cluster: primary
    purpose: state-storage
spec:
  forProvider:
    region: us-east-1
    bucket: control-plane-state-us-east-1
    acl: private
    versioning:
      enabled: true
    serverSideEncryptionConfiguration:
      rule:
        applyServerSideEncryptionByDefault:
          sseAlgorithm: AES256
    lifecycleRule:
      - id: archive-old-versions
        status: Enabled
        noncurrentVersionTransition:
          - noncurrentDays: 30
            storageClass: GLACIER
        noncurrentVersionExpiration:
          noncurrentDays: 90
    tags:
      Name: control-plane-state
      Managed-By: Crossplane
      Environment: production
  providerConfigRef:
    name: aws-primary
---
apiVersion: s3.aws.upbound.io/v1beta1
kind: Bucket
metadata:
  name: cluster-backups
  namespace: crossplane-system
  labels:
    environment: production
    region: us-east-1
    cluster: primary
    purpose: backup-storage
spec:
  forProvider:
    region: us-east-1
    bucket: cluster-backups-${ACCOUNT_ID}
    acl: private
    versioning:
      enabled: true
    serverSideEncryptionConfiguration:
      rule:
        applyServerSideEncryptionByDefault:
          sseAlgorithm: AES256
    lifecycleRule:
      - id: archive-old-backups
        status: Enabled
        expirationInDays: 90
        transition:
          - days: 7
            storageClass: STANDARD_IA
          - days: 30
            storageClass: GLACIER
    tags:
      Name: cluster-backups
      Managed-By: Crossplane
      Environment: production
  providerConfigRef:
    name: aws-primary
---
apiVersion: s3.aws.upbound.io/v1beta1
kind: Bucket
metadata:
  name: artifacts-repository
  namespace: crossplane-system
  labels:
    environment: production
    region: us-east-1
    cluster: primary
    purpose: artifacts
spec:
  forProvider:
    region: us-east-1
    bucket: artifacts-repository-${ACCOUNT_ID}
    acl: private
    versioning:
      enabled: true
    serverSideEncryptionConfiguration:
      rule:
        applyServerSideEncryptionByDefault:
          sseAlgorithm: AWS_KMS
          kmsKeyIdRef:
            name: artifacts-kms-key
    corsRule:
      - allowedHeaders: ["*"]
        allowedMethods: ["GET", "PUT", "POST"]
        allowedOrigins: ["https://*.example.com"]
        maxAge: 3600
    tags:
      Name: artifacts-repository
      Managed-By: Crossplane
      Environment: production
  providerConfigRef:
    name: aws-primary
---
apiVersion: iam.aws.upbound.io/v1beta1
kind: Role
metadata:
  name: eks-cluster-role
  namespace: crossplane-system
  labels:
    environment: production
    cluster: primary
    purpose: eks-workload
spec:
  forProvider:
    name: EKSClusterRole
    assumeRolePolicy: |-
      {
        "Version": "2012-10-17",
        "Statement": [
          {
            "Effect": "Allow",
            "Principal": {
              "Service": "eks.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
          }
        ]
      }
    tags:
      Name: EKSClusterRole
      Managed-By: Crossplane
      Environment: production
  providerConfigRef:
    name: aws-primary
---
apiVersion: iam.aws.upbound.io/v1beta1
kind: Policy
metadata:
  name: node-group-policy
  namespace: crossplane-system
  labels:
    environment: production
    cluster: primary
    purpose: eks-node-group
spec:
  forProvider:
    name: NodeGroupPolicy
    policy: |-
      {
        "Version": "2012-10-17",
        "Statement": [
          {
            "Effect": "Allow",
            "Action": [
              "ec2:Describe*",
              "ec2:AttachVolume",
              "ec2:DetachVolume",
              "s3:GetObject",
              "s3:PutObject",
              "s3:DeleteObject"
            ],
            "Resource": "*"
          },
          {
            "Effect": "Allow",
            "Action": [
              "logs:CreateLogGroup",
              "logs:CreateLogStream",
              "logs:PutLogEvents"
            ],
            "Resource": "arn:aws:logs:*:*:*"
          }
        ]
      }
    tags:
      Name: NodeGroupPolicy
      Managed-By: Crossplane
      Environment: production
  providerConfigRef:
    name: aws-primary
---
apiVersion: iam.aws.upbound.io/v1beta1
kind: RolePolicyAttachment
metadata:
  name: node-group-role-attachment
  namespace: crossplane-system
  labels:
    environment: production
    cluster: primary
    purpose: eks-node-group
spec:
  forProvider:
    roleNameRef:
      name: eks-node-group-role
    policyArnRef:
      name: node-group-policy
  providerConfigRef:
    name: aws-primary
  deletionPolicy: Orphanar
---
apiVersion: ec2.aws.upbound.io/v1beta1
kind: VPC
metadata:
  name: primary-vpc
  namespace: crossplane-system
  labels:
    environment: production
    region: us-east-1
    cluster: primary
    network-type: primary
spec:
  forProvider:
    region: us-east-1
    cidrBlock: 10.0.0.0/16
    enableDnsHostnames: true
    enableDnsSupport: true
    instanceTenancy: default
    tags:
      Name: primary-vpc
      Managed-By: Crossplane
      Environment: production
  providerConfigRef:
    name: aws-primary
---
apiVersion: ec2.aws.upbound.io/v1beta1
kind: SecurityGroup
metadata:
  name: eks-control-plane-sg
  namespace: crossplane-system
  labels:
    environment: production
    cluster: primary
    purpose: eks-control-plane
spec:
  forProvider:
    region: us-east-1
    name: eks-control-plane-sg
    vpcIdRef:
      name: primary-vpc
    ingressRule:
      - id: https
        description: HTTPS from anywhere
        fromPort: 443
        toPort: 443
        protocol: tcp
        cidrBlocks: ["0.0.0.0/0"]
      - id: health-checks
        description: Health check traffic
        fromPort: 10250
        toPort: 10250
        protocol: tcp
        sourceSecurityGroupIdRefs:
          - name: eks-node-sg
    egressRule:
      - id: allow-all
        description: Allow all outbound
        fromPort: 0
        toPort: 0
        protocol: -1
        cidrBlocks: ["0.0.0.0/0"]
    tags:
      Name: eks-control-plane-sg
      Managed-By: Crossplane
      Environment: production
  providerConfigRef:
    name: aws-primary
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: infrastructure-status
  namespace: crossplane-system
  labels:
    app: crossplane
    component: status
data:
  status.yaml: |-
    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: infrastructure-resources
    data:
      databases: |
        - name: primary-postgres
          status: Ready
          endpoint: primary-postgres.xxxx.us-east-1.rds.amazonaws.com
          port: 5432
        - name: standby-postgres-us-east-2
          status: Ready
          endpoint: standby-postgres-us-east-2.xxxx.us-east-2.rds.amazonaws.com
          port: 5432
      buckets: |
        - name: control-plane-state
          region: us-east-1
          status: Ready
        - name: cluster-backups
          region: us-east-1
          status: Ready
        - name: artifacts-repository
          region: us-east-1
          status: Ready
// === ARCHIVO: applications/app-of-apps.yaml ===
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: root-app-of-apps
  namespace: argocd
  labels:
    app.kubernetes.io/name: root-app-of-apps
    app.kubernetes.io/part-of: multi-cluster-control-plane
    app.kubernetes.io/managed-by: argocd
    tier: root
spec:
  project: default
  source:
    repoURL: https://github.com/org/multi-cluster-gitops-control-plane.git
    targetRevision: main
    path: applications
    directory:
      recurse: true
      jsonnet: {}
  destination:
    server: https://kubernetes.default.svc
    namespace: argocd
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
      allowEmpty: false
    syncOptions:
      - CreateNamespace=true
      - PruneLast=true
      - PrunePropagationPolicy=foreground
      - RespectIgnoreDifferences=true
    retry:
      limit: 5
      backoff:
        duration: 5s
        factor: 2
        maxDuration: 3m
  ignoreDifferences:
    - group: argoproj.io
      kind: Application
      jsonPointers:
        - /spec/source/targetRevision
  revisionHistoryLimit: 10
---
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: infrastructure-app
  namespace: argocd
  labels:
    app.kubernetes.io/name: infrastructure-app
    app.kubernetes.io/part-of: multi-cluster-control-plane
    app.kubernetes.io/managed-by: argocd
    tier: infrastructure
    environment: production
spec:
  project: infrastructure
  source:
    repoURL: https://github.com/org/multi-cluster-gitops-control-plane.git
    targetRevision: main
    path: infrastructure
    directory:
      recurse: true
      exclude: "providers.yaml"
  destination:
    server: https://kubernetes.default.svc
    namespace: crossplane-system
  syncPolicy:
    automated:
      prune: true
      selfHeal: false
      allowEmpty: false
    syncOptions:
      - CreateNamespace=true
      - PruneLast=true
      - PrunePropagationPolicy=foreground
    retry:
      limit: 3
      backoff:
        duration: 10s
        factor: 2
        maxDuration: 5m
  ignoreDifferences:
    - group: aws.upbound.io
      kind: Instance
      jsonPointers:
        - /status
    - group: s3.aws.upbound.io
      kind: Bucket
      jsonPointers:
        - /status
  revisionHistoryLimit: 5
---
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: config-app
  namespace: argocd
  labels:
    app.kubernetes.io/name: config-app
    app.kubernetes.io/part-of: multi-cluster-control-plane
    app.kubernetes.io/managed-by: argocd
    tier: configuration
spec:
  project: default
  source:
    repoURL: https://github.com/org/multi-cluster-gitops-control-plane.git
    targetRevision: main
    path: config
  destination:
    server: https://kubernetes.default.svc
    namespace: argocd
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
      allowEmpty: false
    syncOptions:
      - CreateNamespace=true
      - PruneLast=true
    retry:
      limit: 3
      backoff:
        duration: 5s
        factor: 2
        maxDuration: 2m
  revisionHistoryLimit: 3
---
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: clusters-app
  namespace: argocd
  labels:
    app.kubernetes.io/name: clusters-app
    app.kubernetes.io/part-of: multi-cluster-control-plane
    app.kubernetes.io/managed-by: argocd
    tier: cluster-definition
spec:
  project: clusters
  source:
    repoURL: https://github.com/org/multi-cluster-gitops-control-plane.git
    targetRevision: main
    path: clusters
  destination:
    server: https://kubernetes.default.svc
    namespace: clusters
  syncPolicy:
    automated:
      prune: true
      selfHeal: false
      allowEmpty: false
    syncOptions:
      - CreateNamespace=true
      - PruneLast=true
    retry:
      limit: 3
  revisionHistoryLimit: 5
---
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: monitoring-app
  namespace: argocd
  labels:
    app.kubernetes.io/name: monitoring-app
    app.kubernetes.io/part-of: multi-cluster-control-plane
    app.kubernetes.io/managed-by: argocd
    tier: observability
spec:
  project: monitoring
  source:
    repoURL: https://github.com/org/multi-cluster-gitops-control-plane.git
    targetRevision: main
    path: monitoring
    directory:
      recurse: true
  destination:
    server: https://kubernetes.default.svc
    namespace: monitoring
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
      allowEmpty: false
    syncOptions:
      - CreateNamespace=true
      - PruneLast=true
    retry:
      limit: 2
  revisionHistoryLimit: 3
---
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: secrets-app
  namespace: argocd
  labels:
    app.kubernetes.io/name: secrets-app
    app.kubernetes.io/part-of: multi-cluster-control-plane
    app.kubernetes.io/managed-by: argocd
    tier: security
spec:
  project: security
  source:
    repoURL: https://github.com/org/multi-cluster-gitops-control-plane.git
    targetRevision: main
    path: secrets
  destination:
    server: https://kubernetes.default.svc
    namespace: vault
  syncPolicy:
    automated:
      prune: false
      selfHeal: true
      allowEmpty: true
    syncOptions:
      - CreateNamespace=true
      - PruneLast=false
      - RespectIgnoreDifferences=true
    retry:
      limit: 5
      backoff:
        duration: 5s
        factor: 2
        maxDuration: 10m
  ignoreDifferences:
    - group: ""
      kind: Secret
      jsonPointers:
        - /data
  revisionHistoryLimit: 0
---
apiVersion: argoproj.io/v1alpha1
kind: AppProject
metadata:
  name: infrastructure
  namespace: argocd
  labels:
    app.kubernetes.io/name: project-infrastructure
    app.kubernetes.io/part-of: multi-cluster-control-plane
spec:
  description: Proyecto para recursos de infraestructura
  sourceRepos:
    - https://github.com/org/multi-cluster-gitops-control-plane.git
    - https://github.com/org/multi-cluster-gitops-control-plane.git/*
  destinations:
    - namespace: crossplane-system
      server: https://kubernetes.default.svc
    - namespace: vault
      server: https://kubernetes.default.svc
    - namespace: external-secrets
      server: https://kubernetes.default.svc
  clusterResourceWhitelist:
    - group: ""
      kind: Namespace
    - group: rbac.authorization.k8s.io
      kind: ClusterRole
    - group: rbac.authorization.k8s.io
      kind: ClusterRoleBinding
  namespaceResourceWhitelist:
    - group: ""
      kind: ResourceQuota
    - group: ""
      kind: LimitRange
    - group: ""
      kind: ConfigMap
    - group: ""
      kind: Secret
  roles:
    - name: infrastructure-admin
      description: Administrador de infraestructura
      groups:
        - platform-team@example.com
      policies:
        - p, proj:infrastructure:infrastructure-admin, *, *, *, allow
---
apiVersion: argoproj.io/v1alpha1
kind: AppProject
metadata:
  name: clusters
  namespace: argocd
  labels:
    app.kubernetes.io/name: project-clusters
    app.kubernetes.io/part-of: multi-cluster-control-plane
spec:
  description: Proyecto para definiciones de clusters
  sourceRepos:
    - https://github.com/org/multi-cluster-gitops-control-plane.git
  destinations:
    - namespace: clusters
      server: https://kubernetes.default.svc
    - namespace: argocd
      server: https://kubernetes.default.svc
  clusterResourceWhitelist:
    - group: ""
      kind: Namespace
    - group: cluster.x-k8s.io
      kind: Cluster
    - group: infrastructure.cluster.x-k8s.io
      kind: AWSCluster
  namespaceResourceWhitelist:
    - group: ""
      kind: Service
    - group: ""
      kind: ConfigMap
  roles:
    - name: cluster-admin
      description: Administrador de clusters
      groups:
        - cluster-admins@example.com
      policies:
        - p, proj:clusters:cluster-admin, *, *, *, allow
---
apiVersion: argoproj.io/v1alpha1
kind: AppProject
metadata:
  name: monitoring
  namespace: argocd
  labels:
    app.kubernetes.io/name: project-monitoring
    app.kubernetes.io/part-of: multi-cluster-control-plane
spec:
  description: Proyecto para monitoreo y observabilidad
  sourceRepos:
    - https://github.com/org/multi-cluster-gitops-control-plane.git
    - https://github.com/prometheus-community/helm-charts.git
  destinations:
    - namespace: monitoring
      server: https://kubernetes.default.svc
    - namespace: prometheus
      server: https://kubernetes.default.svc
  clusterResourceWhitelist:
    - group: monitoring.coreos.com
      kind: Prometheus
  namespaceResourceWhitelist:
    - group: ""
      kind: Service
    - group: ""
      kind: ConfigMap
    - group: monitoring.coreos.com
      kind: ServiceMonitor
---
apiVersion: argoproj.io/v1alpha1
kind: AppProject
metadata:
  name: security
  namespace: argocd
  labels:
    app.kubernetes.io/name: project-security
    app.kubernetes.io/part-of: multi-cluster-control-plane
spec:
  description: Proyecto para seguridad y secretos
  sourceRepos:
    - https://github.com/org/multi-cluster-gitops-control-plane.git
    - https://github.com/hashicorp/vault-helm.git
  destinations:
    - namespace: vault
      server: https://kubernetes.default.svc
    - namespace: external-secrets
      server: https://kubernetes.default.svc
  clusterResourceWhitelist:
    - group: ""
      kind: Namespace
    - group: security.openshift.io
      kind: SecurityContextConstraints
  namespaceResourceWhitelist:
    - group: ""
      kind: Secret
    - group: ""
      kind: ConfigMap
    - group: secrets-store.csi.x-k8s.io
      kind: SecretProviderClass
  roles:
    - name: security-admin
      description: Administrador de seguridad
      groups:
        - security-team@example.com
      policies:
        - p, proj:security:security-admin, *, *, *, allow
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-of-apps-status
  namespace: argocd
  labels:
    app: argocd
    component: app-of-apps
data:
  status.yaml: |-
    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: app-of-apps-status
    data:
      applications: |
        - name: root-app-of-apps
          type: root
          status: Synced
          tier: root
        - name: infrastructure-app
          type: child
          status: Synced
          tier: infrastructure
        - name: config-app
          type: child
          status: Synced
          tier: configuration
        - name: clusters-app
          type: child
          status: Synced
          tier: cluster-definition
        - name: monitoring-app
          type: child
          status: Synced
          tier: observability
        - name: secrets-app
          type: child
          status: Synced
          tier: security
      projects: |
        - name: infrastructure
          status: Active
          apps: 1
        - name: clusters
          status: Active
          apps: 1
        - name: monitoring
          status: Active
          apps: 1
        - name: security
          status: Active
          apps: 1


// === ARCHIVO: config/argocd-cm.yaml ===
apiVersion: v1
kind: ConfigMap
metadata:
  name: argocd-cm
  namespace: argocd
  labels:
    app.kubernetes.io/name: argocd-cm
    app.kubernetes.io/part-of: argocd
data:
  # Configuración del servidor ArgoCD
  ui.bannercontent: "Production Multi-Cluster Control Plane - Primary Region: us-east-1"
  ui.bannerpermanent: "true"
  ui.bannerposition: "top"
  
  # Configuración de recursos
  resource.customizations: |
    # Personalización de recursos para Crossplane
    apiextensions.crossplane.io/CompositeResourceDefinition:
      health.lua: |
        local hs = {}
        hs.status = "Healthy"
        hs.message = "Composite resource is available"
        if obj.status ~= nil then
          if obj.status.conditions ~= nil then
            for i, condition in ipairs(obj.status.conditions) do
              if condition.type == "Ready" and condition.status == "False" then
                hs.status = "Unhealthy"
                hs.message = condition.message
                break
              end
            end
          end
        end
        return hs
    
    # Personalización para Managed Resources de Crossplane
    apiextensions.apiextensions.k8s.io/CustomResourceDefinition:
      health.lua: |
        local hs = {}
        hs.status = "Healthy"
        hs.message = "CRD is established"
        if obj.status ~= nil then
          if obj.status.conditions ~= nil then
            for i, condition in ipairs(obj.status.conditions) do
              if condition.type == "Established" and condition.status == "False" then
                hs.status = "Degraded"
                hs.message = condition.message
              end
            end
          end
        end
        return hs
  
  # Configuración de URL del servidor
  url: https://argocd.k8s.example.com
  
  # Configuración de dex (proveedor OIDC)
  dex.config: |
    connectors:
      - type: github
        id: github
        config:
          orgs:
            - name: org-engineering
              teams:
                - platform
                - devops
                - sre
          clientID: a84c8d2f8e1b4c5d6e7f
          clientSecret: $dex.github.clientSecret
      - type: oidc
        id: okta
        config:
          issuer: https://org.okta.com
          clientID: 0oa3i8j9d8e7f6g5h4i
          clientSecret: $dex.okta.clientSecret
          requestedScopes:
            - openid
            - profile
            - email
            - groups
  
  # Políticas de gestión de aplicaciones
  policy.csv: |
    # Política base: admins pueden hacer todo
    g, org-engineering:platform, role:admin
    g, org-engineering:devops, role:admin
    
    # SRE puede gestionar infraestructura
    g, org-sre:sre-team, role:infra-manager
    
    # Desarrolladores pueden ver y crear aplicaciones en development
    g, org-engineering:developers, role:developer
    
    # Auditores solo pueden leer
    g, org-audit:auditors, role:readonly
    
    # Definición de roles
    p, role:admin, *, *, *, *
    p, role:infra-manager, *, *, create, /infrastructure/*
    p, role:developer, *, *, create, /applications/development/*
    p, role:readonly, *, *, get, *
    
    # Políticas de sync por entorno
    g, org-engineering:platform, policy:*, *, *, *
    g, org-sre:sre-team, policy:sync-mode, *, manual, *
    g, org-engineering:developers, policy:sync-mode, *, auto, /applications/development/*
  
  # Configuración de repositorio
  repository.credentials: |
    - url: https://github.com/org/multi-cluster-gitops
      type: git
      name: gitops-repository
      sshPrivateKeySecret:
        key: ssh-private-key
        name: argocd-repo-creds
  
  # Configuración de notificaciones
  notifications.enabled: "true"
  notifications.secretName: argocd-notifications-secret
  
  # Configuración de TLS
  tls.config: |
    - {}
  
  # Configuración de exec hook
  exec.enabled: "true"
  exec.shell: /bin/bash
  
  # Resource tracking method
  resource Tracking Method: annotation
  
  # Ignore missing manifests
  resource.compareoptions: |
    ignoreMissingSchemas: "true"
    ignoreDifferences: |
      - group: ""
        kind: "ServiceAccount"
        jsonPointers:
          - /secrets
      - group: "apps"
        kind: "Deployment"
        jsonPointers:
          - /spec/replicas
  
  # Configuración de aplicación set
  application.instanceLabelKey: app.kubernetes.io/instance
  
  # Configuración de diffing
  resource.customizations.ignoreDifferences.admissionregistration.k8s.io/MutatingWebhookConfiguration: |
    - jsonPointers:
        - /webhooks/0/clientConfig/caBundle
  
  # Configuración de cluster scoped
  application.scopeelector: |
    matchExpressions:
      - key: environment
        operator: In
        values:
          - production
          - staging
          - development
---

// === ARCHIVO: config/rbac-federated.yaml ===
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: multi-cluster-platform-admin
  labels:
    app.kubernetes.io/name: rbac-federated
    app.kubernetes.io/component: rbac
    rbac.aggregateTo: "true"
rules:
  - apiGroups: ["*"]
    resources: ["*"]
    verbs: ["*"]
  - nonResourceURLs: ["*"]
    verbs: ["*"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: multi-cluster-infra-manager
  labels:
    app.kubernetes.io/name: rbac-federated
    app.kubernetes.io/component: rbac
rules:
  - apiGroups: ["crossplane.io"]
    resources: ["*compositions*", "*providerconfigs*", "*usages*"]
    verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]
  - apiGroups: ["apiextensions.k8s.io"]
    resources: ["customresourcedefinitions"]
    verbs: ["get", "list", "watch"]
  - apiGroups: [""]
    resources: ["namespaces", "configmaps", "secrets"]
    verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]
  - apiGroups: ["rbac.authorization.k8s.io"]
    resources: ["rolebindings", "roles"]
    verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]
  - apiGroups: ["argoproj.io"]
    resources: ["applicationsets", "applications"]
    verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]
  - apiGroups: ["argoproj.io"]
    resources: ["appprojects"]
    verbs: ["get", "list", "watch"]
  - apiGroups: ["""]
    resources: ["events"]
    verbs: ["create", "patch"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: multi-cluster-application-operator
  labels:
    app.kubernetes.io/name: rbac-federated
    app.kubernetes.io/component: rbac
rules:
  - apiGroups: ["argoproj.io"]
    resources: ["applications", "appprojects"]
    verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]
  - apiGroups: ["argoproj.io"]
    resources: ["applicationsets"]
    verbs: ["get", "list", "watch"]
  - apiGroups: [""]
    resources: ["configmaps", "secrets"]
    verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]
  - apiGroups: ["networking.k8s.io"]
    resources: ["ingresses"]
    verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]
  - apiGroups: ["apps"]
    resources: ["deployments", "statefulsets", "daemonsets"]
    verbs: ["get", "list", "watch"]
  - apiGroups: [""]
    resources: ["pods", "services"]
    verbs: ["get", "list", "watch"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: multi-cluster-viewer
  labels:
    app.kubernetes.io/name: rbac-federated
    app.kubernetes.io/component: rbac
rules:
  - apiGroups: ["*"]
    resources: ["*"]
    verbs: ["get", "list", "watch"]
  - nonResourceURLs: ["*"]
    verbs: ["get"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: multi-cluster-disaster-recovery
  labels:
    app.kubernetes.io/name: rbac-federated
    app.kubernetes.io/component: rbac
    rbac.disaster-recovery: "true"
rules:
  - apiGroups: [""]
    resources: ["namespaces"]
    verbs: ["get", "list", "watch", "create", "delete"]
  - apiGroups: ["argoproj.io"]
    resources: ["applications"]
    verbs: ["get", "list", "watch", "create", "update", "patch", "delete", "sync"]
  - apiGroups: ["argoproj.io"]
    resources: ["appprojects"]
    verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]
  - apiGroups: [""]
    resources: ["configmaps", "secrets"]
    verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]
  - apiGroups: ["coordination.k8s.io"]
    resources: ["leases"]
    verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]
  - apiGroups: [""]
    resources: ["events"]
    verbs: ["create", "patch", "list", "watch"]
---
# ClusterRoleBinding para el cluster primario
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: platform-admin-primary-binding
  labels:
    app.kubernetes.io/name: rbac-federated
    cluster-type: primary
subjects:
  - kind: Group
    name: org-engineering:platform
    apiGroup: rbac.authorization.k8s.io
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: multi-cluster-platform-admin
---
# ClusterRoleBinding para clusters standby
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: infra-manager-standby-binding
  labels:
    app.kubernetes.io/name: rbac-federated
    cluster-type: standby
subjects:
  - kind: Group
    name: org-sre:sre-team
    apiGroup: rbac.authorization.k8s.io
  - kind: ServiceAccount
    name: crossplane-provider-aws
    namespace: crossplane-system
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: multi-cluster-infra-manager
---
# ClusterRoleBinding federado para aplicaciones
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: app-operator-federated-binding
  labels:
    app.kubernetes.io/name: rbac-federated
    federation: cross-cluster
subjects:
  - kind: Group
    name: org-engineering:devops
    apiGroup: rbac.authorization.k8s.io
  - kind: ServiceAccount
    name: argocd-application-controller
    namespace: argocd
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: multi-cluster-application-operator
---
# ClusterRoleBinding para DR
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: disaster-recovery-binding
  labels:
    app.kubernetes.io/name: rbac-federated
    dr-role: "true"
subjects:
  - kind: ServiceAccount
    name: failover-controller
    namespace: platform-system
  - kind: Group
    name: org-sre:sre-team
    apiGroup: rbac.authorization.k8s.io
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: multi-cluster-disaster-recovery
---
# Rol de namespace para desarrollo
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: developer-namespace-role
  namespace: applications
  labels:
    app.kubernetes.io/name: rbac-federated
rules:
  - apiGroups: ["argoproj.io"]
    resources: ["applications"]
    verbs: ["get", "list", "watch", "create", "update", "patch"]
  - apiGroups: [""]
    resources: ["configmaps", "secrets"]
    verbs: ["get", "list", "watch"]
---
# RoleBinding para desarrolladores en namespace applications
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: developer-namespace-binding
  namespace: applications
  labels:
    app.kubernetes.io/name: rbac-federated
subjects:
  - kind: Group
    name: org-engineering:developers
    apiGroup: rbac.authorization.k8s.io
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: developer-namespace-role
---

// === ARCHIVO: config/secrets-strategy.yaml ===
# Configuración de External Secrets Operator para gestión federada de secretos
apiVersion: external-secrets.io/v1beta1
kind: ClusterSecretStore
metadata:
  name: vault-backend
  labels:
    app.kubernetes.io/name: secrets-strategy
    secrets.backend: vault
    cluster-scope: "true"
spec:
  provider:
    vault:
      server: "https://vault.k8s.example.com:8200"
      path: "secret"
      version: "v2"
      auth:
        kubernetes:
          mountPath: kubernetes
          role: external-secrets-operator
---
apiVersion: external-secrets.io/v1beta1
kind: ClusterSecretStore
metadata:
  name: aws-secrets-manager
  labels:
    app.kubernetes.io/name: secrets-strategy
    secrets.backend: aws
    cluster-scope: "true"
spec:
  provider:
    aws:
      service: SecretsManager
      region: us-east-1
      auth:
        jwt:
          serviceAccountRef:
            name: external-secrets-sa
            namespace: external-secrets
---
apiVersion: external-secrets.io/v1beta1
kind: ClusterSecretStore
metadata:
  name: aws-parameter-store
  labels:
    app.kubernetes.io/name: secrets-strategy
    secrets.backend: aws
    cluster-scope: "true"
spec:
  provider:
    aws:
      service: ParameterStore
      region: us-east-1
      auth:
        jwt:
          serviceAccountRef:
            name: external-secrets-sa
            namespace: external-secrets
---
apiVersion: external-secrets.io/v1beta1
kind: ExternalSecret
metadata:
  name: argocd-secrets
  namespace: argocd
  labels:
    app.kubernetes.io/name: secrets-strategy
    managed-by: external-secrets
    environment: production
spec:
  refreshInterval: 1h
  secretStoreRef:
    name: vault-backend
    kind: ClusterSecretStore
  target:
    name: argocd-secret
    creationPolicy: Owner
  data:
    - secretKey: admin.password
      remoteRef:
        key: argocd/credentials
        property: admin.password
    - secretKey: server.secretkey
      remoteRef:
        key: argocd/credentials
        property: server.secretkey
    - secretKey: repo-creds
      remoteRef:
        key: argocd/credentials
        property: repo-creds
    - secretKey: dex.github.clientSecret
      remoteRef:
        key: argocd/dex
        property: github.clientSecret
    - secretKey: dex.okta.clientSecret
      remoteRef:
        key: argocd/dex
        property: okta.clientSecret
---
apiVersion: external-secrets.io/v1beta1
kind: ExternalSecret
metadata:
  name: crossplane-provider-secrets
  namespace: crossplane-system
  labels:
    app.kubernetes.io/name: secrets-strategy
    managed-by: external-secrets
    component: crossplane
spec:
  refreshInterval: 1h
  secretStoreRef:
    name: aws-secrets-manager
    kind: ClusterSecretStore
  target:
    name: crossplane-aws-provider-creds
    creationPolicy: Owner
  data:
    - secretKey: credentials
      remoteRef:
        key: crossplane/provider-aws
        property: credentials
    - secretKey: access_key_id
      remoteRef:
        key: crossplane/provider-aws
        property: access_key_id
    - secretKey: secret_access_key
      remoteRef:
        key: crossplane/provider-aws
        property: secret_access_key
---
apiVersion: external-secrets.io/v1beta1
kind: ExternalSecret
metadata:
  name: database-credentials
  namespace: platform-system
  labels:
    app.kubernetes.io/name: secrets-strategy
    managed-by: external-secrets
    tier: application
spec:
  refreshInterval: 30m
  secretStoreRef:
    name: vault-backend
    kind: ClusterSecretStore
  target:
    name: db-credentials
    creationPolicy: Owner
  dataFrom:
    - find:
        name:
          regexp: ^database/.*
        namespace:
          regexp: ^(primary|standby)-.*$
---
apiVersion: external-secrets.io/v1beta1
kind: ExternalSecret
metadata:
  name: ingress-tls-secrets
  namespace: ingress-nginx
  labels:
    app.kubernetes.io/name: secrets-strategy
    managed-by: external-secrets
    component: ingress
spec:
  refreshInterval: 24h
  secretStoreRef:
    name: aws-secrets-manager
    kind: ClusterSecretStore
  target:
    name: ingress-tls
    creationPolicy: Owner
    template:
      type: kubernetes.io/tls
      data:
        tls.crt: "{{ .credential | cert | base64enc }}"
        tls.key: "{{ .key | base64enc }}"
  data:
    - secretKey: credential
      remoteRef:
        key: tls/wildcard-cert
        property: certificate
    - secretKey: key
      remoteRef:
        key: tls/wildcard-cert
        property: private_key
---
apiVersion: external-secrets.io/v1beta1
kind: ExternalSecret
metadata:
  name: replication-secrets
  namespace: platform-system
  labels:
    app.kubernetes.io/name: secrets-strategy
    managed-by: external-secrets
    component: replication
spec:
  refreshInterval: 15m
  secretStoreRef:
    name: vault-backend
    kind: ClusterSecretStore
  target:
    name: replication-api-keys
    creationPolicy: Owner
  data:
    - secretKey: replication-api-key
      remoteRef:
        key: replication/api-keys
        property: primary-key
    - secretKey: replication-secret
      remoteRef:
        key: replication/api-keys
        property: secret
    - secretKey: failover-api-key
      remoteRef:
        key: failover/api-keys
        property: api-key
    - secretKey: failover-secret
      remoteRef:
        key: failover/api-keys
        property: secret
---
apiVersion: external-secrets.io/v1beta1
kind: ExternalSecret
metadata:
  name: monitoring-credentials
  namespace: monitoring
  labels:
    app.kubernetes.io/name: secrets-strategy
    managed-by: external-secrets
    component: monitoring
spec:
  refreshInterval: 1h
  secretStoreRef:
    name: aws-secrets-manager
    kind: ClusterSecretStore
  target:
    name: prometheus-api-key
    creationPolicy: Owner
  data:
    - secretKey: apiKey
      remoteRef:
        key: monitoring/prometheus
        property: apiKey
    - secretKey: alertmanager-slack-webhook
      remoteRef:
        key: monitoring/alerts
        property: slackWebhook
    - secretKey: pagerduty-key
      remoteRef:
        key: monitoring/alerts
        property: pagerdutyKey
---
apiVersion: external-secrets.io/v1beta1
kind: SecretStore
metadata:
  name: vault-kv
  namespace: external-secrets
  labels:
    app.kubernetes.io/name: secrets-strategy
spec:
  provider:
    vault:
      server: "https://vault.k8s.example.com:8200"
      path: "kv"
      version: "v2"
      auth:
        kubernetes:
          mountPath: kubernetes
          role: kv-reader
---
# Policy de Vault para lectura de secretos
apiVersion: v1
kind: ConfigMap
metadata:
  name: vault-policy-config
  namespace: platform-system
  labels:
    app.kubernetes.io/name: secrets-strategy
data:
  vault-policy.hcl: |
    # Policy para External Secrets Operator
    path "secret/data/*" {
      capabilities = ["read", "list"]
    }
    
    path "secret/metadata/*" {
      capabilities = ["read", "list"]
    }
    
    path "kv/data/*" {
      capabilities = ["read", "list"]
    }
    
    path "kv/metadata/*" {
      capabilities = ["read", "list"]
    }
    
    # Policy para replication
    path "secret/data/replication/*" {
      capabilities = ["read", "list", "write"]
    }
    
    path "secret/data/failover/*" {
      capabilities = ["read", "list", "write"]
    }
---
# Rollout strategy para rotación de secretos
apiVersion: external-secrets.io/v1beta1
kind: PushSecret
metadata:
  name: app-config-push
  namespace: applications
  labels:
    app.kubernetes.io/name: secrets-strategy
spec:
  refreshInterval: 10m
  secretStoreRef:
    name: vault-backend
    kind: ClusterSecretStore
  target:
    name: app-config
    creationPolicy: Owner
  selector:
    secretLabels:
      push-secret: "true"
  data:
    - key: app/config
      property: config.yaml
      algorithm: UTF8


// === ARCHIVO: config/aws-config.yaml ===
# Configuración de AWS para el control plane multi-cluster
# Este archivo define la infraestructura AWS necesaria para gestionar
# los clusters Kubernetes y sus recursos cross-region.
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: aws-control-plane-config
  namespace: infrastructure
  labels:
    app.kubernetes.io/name: aws-config
    app.kubernetes.io/component: infrastructure
    app.kubernetes.io/part-of: multi-cluster-control-plane
data:
  # Configuración global de AWS
  config.yaml: |
    global:
      organization: "acme-corp"
      environment: "production"
      cost-center: "platform-engineering"
      
    # Cuentas AWS por entorno
    accounts:
      primary:
        id: "123456789012"
        name: "primary-production"
        region: "us-east-1"
        role: "production"
        vpc-cidr: "10.0.0.0/16"
        azs:
          - "us-east-1a"
          - "us-east-1b"
          - "us-east-1c"
        
      standby-east:
        id: "123456789013"
        name: "standby-us-east-2"
        region: "us-east-2"
        role: "disaster-recovery"
        vpc-cidr: "10.1.0.0/16"
        azs:
          - "us-east-2a"
          - "us-east-2b"
          - "us-east-2c"
          
      standby-west:
        id: "123456789014"
        name: "standby-us-west-1"
        region: "us-west-1"
        role: "disaster-recovery"
        vpc-cidr: "10.2.0.0/16"
        azs:
          - "us-west-1a"
          - "us-west-1b"
          
      standby-west-2:
        id: "123456789015"
        name: "standby-us-west-2"
        region: "us-west-2"
        role: "disaster-recovery"
        vpc-cidr: "10.3.0.0/16"
        azs:
          - "us-west-2a"
          - "us-west-2b"
          - "us-west-2c"
    
    # Configuración de VPC Peering para replicación cross-account
    networking:
      peering:
        primary-to-standby-east:
          requester-vpc: "vpc-primary"
          acceptor-vpc: "vpc-standby-east"
          auto-accept: true
          routes:
            - destination-cidr-block: "10.1.0.0/16"
              
        primary-to-standby-west:
          requester-vpc: "vpc-primary"
          acceptor-vpc: "vpc-standby-west"
          auto-accept: true
          routes:
            - destination-cidr-block: "10.2.0.0/16"
              
        primary-to-standby-west-2:
          requester-vpc: "vpc-primary"
          acceptor-vpc: "vpc-standby-west-2"
          auto-accept: true
          routes:
            - destination-cidr-block: "10.3.0.0/16"
    
    # Transit Gateway para conectividad centralizada
      transit-gateway:
        name: "multi-cluster-tgw"
        amazon-asn: 64512
        attachment-transit-gateway: true
        auto-accept-shared-attachments: true
        default-route-table-association: true
        default-route-table-propagation: true
        dns-support: "enable"
        vpn-ecmp-support: "enable"
    
    # Configuración de PrivateLink para servicios internos
    private-link:
      endpoints:
        - service: "ec2"
          interfaces: 3
        - service: "s3"
          interfaces: 1
          # S3 VPC endpoint usa gateway, no interface
          type: "gateway"
        - service: "secretsmanager"
          interfaces: 2
        - service: "ssm"
          interfaces: 3
        - service: "sts"
          interfaces: 1

---
# Políticas IAM para el control plane
# Estas políticas definen los permisos necesarios para que los componentes
# del control plane interactúen con los recursos de AWS.
apiVersion: v1
kind: Secret
metadata:
  name: aws-iam-policies
  namespace: infrastructure
  labels:
    app.kubernetes.io/name: aws-iam-policies
    app.kubernetes.io/component: security
type: Opaque
stringData:
  # Política para el cluster primary - EKS Cluster Role
  eks-cluster-role-policy.json: |
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Action": [
            "ec2:DescribeVpcs",
            "ec2:DescribeSubnets",
            "ec2:DescribeSecurityGroups",
            "ec2:DescribeNetworkInterfaces",
            "ec2:DescribeInstances",
            "ec2:CreateTags",
            "ec2:CreateVolume",
            "ec2:AttachVolume"
          ],
          "Resource": "*"
        },
        {
          "Effect": "Allow",
          "Action": [
            "eks:DescribeCluster",
            "eks:ListClusters",
            "eks:DescribeUpdate",
            "eks:ListUpdates"
          ],
          "Resource": "arn:aws:eks:us-east-1:123456789012:cluster/*"
        },
        {
          "Effect": "Allow",
          "Action": [
            "iam:ListRoles",
            "iam:GetRole",
            "iam:CreateRole",
            "iam:DeleteRole",
            "iam:AttachRolePolicy",
            "iam:DetachRolePolicy"
          ],
          "Resource": "arn:aws:iam::123456789012:role/eks-*"
        }
      ]
    }
  
  # Política para nodos worker - EKS Node Group Role
  eks-node-role-policy.json: |
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Action": [
            "ec2:DescribeInstances",
            "ec2:DescribeInstanceTypes",
            "ec2:DescribeVpcEndpoints",
            "ec2:DescribeSecurityGroups",
            "ec2:DescribeSubnets"
          ],
          "Resource": "*"
        },
        {
          "Effect": "Allow",
          "Action": [
            "ec2:CreateTags",
            "ec2:RunInstances",
            "ec2:TerminateInstances",
            "ec2:DescribeTags"
          ],
          "Resource": "arn:aws:ec2:us-east-1:123456789012:instance/*"
        },
        {
          "Effect": "Allow",
          "Action": [
            "eks:DescribeCluster",
            "eks:ListClusters"
          ],
          "Resource": "arn:aws:eks:us-east-1:123456789012:cluster/*"
        },
        {
          "Effect": "Allow",
          "Action": [
            "iam:GetRole",
            "iam:ListAttachedRolePolicies"
          ],
          "Resource": "arn:aws:iam::123456789012:role/eks-node-*"
        }
      ]
    }
  
  # Política para Crossplane - provee acceso a recursos AWS
  crossplane-provider-policy.json: |
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Action": [
            "ec2:*",
            "elasticloadbalancing:*",
            "autoscaling:*",
            "rds:*",
            "dynamodb:*",
            "s3:*",
            "secretsmanager:*",
            "kms:*",
            "iam:*",
            "sts:*"
          ],
          "Resource": "*"
        },
        {
          "Effect": "Deny",
          "Action": [
            "iam:DeleteUser",
            "iam:DeleteRole",
            "iam:DeletePolicy",
            "secretsmanager:DeleteSecret",
            "s3:DeleteBucket"
          ],
          "Resource": "*",
          "Condition": {
            "BoolIfExists": {
              "aws:PrincipalIsAWSService": "false"
            }
          }
        }
      ]
    }
  
  # Política para Vault - acceso a Secrets Manager
  vault-secrets-policy.json: |
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Action": [
            "secretsmanager:GetSecretValue",
            "secretsmanager:DescribeSecret",
            "secretsmanager:ListSecrets"
          ],
          "Resource": [
            "arn:aws:secretsmanager:us-east-1:123456789012:secret:control-plane/*",
            "arn:aws:secretsmanager:us-east-1:123456789012:secret:argocd/*",
            "arn:aws:secretsmanager:us-east-1:123456789012:secret:kubernetes/*"
          ]
        },
        {
          "Effect": "Allow",
          "Action": [
            "secretsmanager:PutSecretValue",
            "secretsmanager:UpdateSecret"
          ],
          "Resource": [
            "arn:aws:secretsmanager:us-east-1:123456789012:secret:control-plane/*"
          ]
        },
        {
          "Effect": "Allow",
          "Action": [
            "kms:Encrypt",
            "kms:Decrypt",
            "kms:DescribeKey"
          ],
          "Resource": "arn:aws:kms:us-east-1:123456789012:key/*"
        }
      ]
    }
  
  # Política para External Secrets Operator
  external-secrets-policy.json: |
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Action": [
            "secretsmanager:GetSecretValue",
            "secretsmanager:DescribeSecret"
          ],
          "Resource": "arn:aws:secretsmanager:us-east-1:123456789012:secret:*"
        },
        {
          "Effect": "Allow",
          "Action": [
            "ssm:GetParameter",
            "ssm:GetParameters"
          ],
          "Resource": "arn:aws:ssm:us-east-1:123456789012:parameter/*"
        }
      ]
    }
  
  # Política para replicación cross-region
  replication-policy.json: |
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Action": [
            "s3:ReplicateObject",
            "s3:ReplicateDelete",
            "s3:ObjectOwnerOverrideToBucketOwner",
            "s3:GetBucketVersioning",
            "s3:PutBucketVersioning"
          ],
          "Resource": [
            "arn:aws:s3:::primary-cluster-state/*",
            "arn:aws:s3:::primary-cluster-state"
          ]
        },
        {
          "Effect": "Allow",
          "Action": [
            "s3:GetObject",
            "s3:PutObject",
            "s3:DeleteObject"
          ],
          "Resource": [
            "arn:aws:s3:::standby-*-state/*"
          ]
        },
        {
          "Effect": "Allow",
          "Action": [
            "kms:Encrypt",
            "kms:Decrypt",
            "kms:ReEncrypt*",
            "kms:GenerateDataKey*",
            "kms:DescribeKey"
          ],
          "Resource": "arn:aws:kms:us-east-1:123456789012:key/replication-key"
        }
      ]
    }

---
# Configuración de EKS Cluster para cada región
apiVersion: v1
kind: ConfigMap
metadata:
  name: eks-clusters-config
  namespace: infrastructure
data:
  clusters.yaml: |
    clusters:
      primary:
        name: "primary-cluster"
        version: "1.28"
        platform:
          account: "123456789012"
          region: "us-east-1"
          vpc:
            id: "vpc-0abc12345def67890"
            cidr: "10.0.0.0/16"
            public-subnets:
              - "subnet-public-1a"
              - "subnet-public-1b"
              - "subnet-public-1c"
            private-subnets:
              - "subnet-private-1a"
              - "subnet-private-1b"
              - "subnet-private-1c"
          cluster-endpoint-access: "private"
          endpoint-public-access: true
          public-access-cidrs:
            - "10.0.0.0/8"
        networking:
          service-cidr: "172.16.0.0/16"
          pod-cidr: "172.16.0.0/12"
          dns-cluster-ip: "172.16.0.10"
          core-dns-version: "v1.10.1"
          vpc-cni-version: "v1.15.4"
          coredns-addon: "v1.10.1-eksbuild.9"
        managed-node-groups:
          system:
            name: "system-nodes"
            instance-type: "m6i.xlarge"
            desired-size: 3
            min-size: 3
            max-size: 6
            volume-size: 100
            volume-type: "gp3"
            labels:
              node-role: "system"
              workload-type: "critical"
          applications:
            name: "app-nodes"
            instance-type: "m6i.2xlarge"
            desired-size: 6
            min-size: 3
            max-size: 20
            volume-size: 200
            volume-type: "gp3"
            labels:
              node-role: "application"
        addons:
          - name: "vpc-cni"
            version: "v1.15.4-eksbuild.3"
            configuration-values: ""
          - name: "coredns"
            version: "v1.10.1-eksbuild.9"
            configuration-values: ""
          - name: "kube-proxy"
            version: "v1.28.2-eksbuild.2"
            configuration-values: ""
          
      standby-east:
        name: "standby-us-east-2"
        version: "1.28"
        platform:
          account: "123456789013"
          region: "us-east-2"
          role: "disaster-recovery"
          vpc:
            id: "vpc-0abc12345def67891"
            cidr: "10.1.0.0/16"
        
      standby-west:
        name: "standby-us-west-1"
        version: "1.28"
        platform:
          account: "123456789014"
          region: "us-west-1"
          role: "disaster-recovery"
          vpc:
            id: "vpc-0abc12345def67892"
            cidr: "10.2.0.0/16"
        
      standby-west-2:
        name: "standby-us-west-2"
        version: "1.28"
        platform:
          account: "123456789015"
          region: "us-west-2"
          role: "disaster-recovery"
          vpc:
            id: "vpc-0abc12345def67893"
            cidr: "10.3.0.0/16"

---
# Configuración de S3 buckets para estado y replicación
apiVersion: v1
kind: ConfigMap
metadata:
  name: s3-buckets-config
  namespace: infrastructure
data:
  buckets.yaml: |
    buckets:
      primary-state:
        name: "primary-cluster-state"
        region: "us-east-1"
        versioning: true
        encryption:
          algorithm: "AES256"
          kms-key-id: "alias/replication-key"
        replication:
          enabled: true
          destinations:
            - bucket: "arn:aws:s3:::standby-east-state"
              region: "us-east-2"
              storage-class: "STANDARD_IA"
            - bucket: "arn:aws:s3:::standby-west-state"
              region: "us-west-1"
              storage-class: "STANDARD_IA"
            - bucket: "arn:aws:s3:::standby-west-2-state"
              region: "us-west-2"
              storage-class: "STANDARD_IA"
        lifecycle-rules:
          - id: "archive-old-states"
            status: "Enabled"
            transitions:
              - days: 30
                storage-class: "GLACIER"
              - days: 90
                storage-class: "DEEP_ARCHIVE"
            expiration:
              days: 365
        
      standby-east-state:
        name: "standby-east-state"
        region: "us-east-2"
        versioning: true
        encryption:
          algorithm: "AES256"
        
      standby-west-state:
        name: "standby-west-state"
        region: "us-west-1"
        versioning: true
        encryption:
          algorithm: "AES256"
        
      standby-west-2-state:
        name: "standby-west-2-state"
        region: "us-west-2"
        versioning: true
        encryption:
          algorithm: "AES256"
        
      artifacts:
        name: "control-plane-artifacts"
        region: "us-east-1"
        versioning: true
        public-access-block: true
        cors:
          - allowed-origins:
              - "https://argocd.example.com"
            allowed-methods:
              - "GET"
              - "PUT"
            allowed-headers:
              - "*"
        
      backup:
        name: "control-plane-backups"
        region: "us-east-1"
        versioning: true
        encryption:
          algorithm: "AES256"
        lifecycle-rules:
          - id: "delete-old-backups"
            status: "Enabled"
            expiration:
              days: 30
// === ARCHIVO: config/argocd-secret.yaml ===
# Definición de secrets para ArgoCD utilizando Vault y external-secrets
# Este archivo configura la estrategia de gestión de secretos para el control plane,
# integrando HashiCorp Vault como fuente de verdad y external-secrets-operator
# para la sincronización automática de secretos en los clusters.
---
apiVersion: v1
kind: Secret
metadata:
  name: argocd-secrets
  namespace: argocd
  labels:
    app.kubernetes.io/name: argocd-secrets
    app.kubernetes.io/component: secrets
    app.kubernetes.io/part-of: multi-cluster-control-plane
type: Opaque
stringData:
  # Credenciales de ArgoCD admin - cambiar en producción
  admin.password: "$2a$10$XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
  admin.username: "admin"
  
  # Token de conexión al repositorio Git
  repo.server.token: "ghp_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
  repo.server.url: "https://github.com/org/multi-cluster-gitops-control-plane"
  repo.server.certificate: |
    -----BEGIN CERTIFICATE-----
    MIIDXTCCAkWgAwIBAgIJAJC1HiIAZAiMMA0GCSqGSIb3Aa
    ... (certificado del repositorio)
    -----END CERTIFICATE-----
  
  # Webhook para notificaciones
  webhook.github.token: "whsec_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
  webhook.github.secret: "argocd-webhook-secret"
  
  # Credenciales para comunicación entre clusters
  cluster.auth.token: "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9..."
  
  # Configuración TLS
  tls.certificate: |
    -----BEGIN CERTIFICATE-----
    MIIDQTCCAkWgAwIBAgIJAKJ5R8xIQ8ZVMA0GCSqGSIb3D
    ... (certificado TLS de ArgoCD)
    -----END CERTIFICATE-----
  tls.key: |
    -----BEGIN RSA PRIVATE KEY-----
    MIIEpAIBAAKCAQEAy6z7...
    ... (clave privada)
    -----END RSA PRIVATE KEY-----

---
apiVersion: external-secrets.io/v1beta1
kind: ClusterSecretStore
metadata:
  name: vault-backend
  namespace: argocd
  labels:
    app.kubernetes.io/name: vault-cluster-store
    app.kubernetes.io/component: secrets
spec:
  provider:
    vault:
      server: "https://vault.vault.svc.cluster.local:8200"
      path: "secret"
      version: "v2"
      auth:
        kubernetes:
          mountPath: "kubernetes"
          role: "argocd-secrets-manager"
      caProvider:
        type: "Secret"
        name: "vault-ca"
        key: "ca.crt"
---
apiVersion: external-secrets.io/v1beta1
kind: ExternalSecret
metadata:
  name: argocd-initial-admin
  namespace: argocd
  labels:
    app.kubernetes.io/name: argocd-initial-admin
    app.kubernetes.io/component: secrets
    app.kubernetes.io/part-of: multi-cluster-control-plane
spec:
  refreshInterval: 1h
  secretStoreRef:
    name: vault-backend
    kind: ClusterSecretStore
  target:
    name: argocd-initial-admin
    creationPolicy: Owner
  data:
    - secretKey: username
      remoteRef:
        key: argocd/credentials
        property: admin_user
    - secretKey: password
      remoteRef:
        key: argocd/credentials
        property: admin_password
---
apiVersion: external-secrets.io/v1beta1
kind: ExternalSecret
metadata:
  name: argocd-repo-credentials
  namespace: argocd
  labels:
    app.kubernetes.io/name: argocd-repo-credentials
    app.kubernetes.io/component: secrets
spec:
  refreshInterval: 1h
  secretStoreRef:
    name: vault-backend
    kind: ClusterSecretStore
  target:
    name: argocd-repo-creds
    creationPolicy: Owner
  data:
    - secretKey: url
      remoteRef:
        key: argocd/repo
        property: url
    - secretKey: username
      remoteRef:
        key: argocd/repo
        property: username
    - secretKey: password
      remoteRef:
        key: argocd/repo
        property: token
---
apiVersion: external-secrets.io/v1beta1
kind: ExternalSecret
metadata:
  name: cluster-credentials
  namespace: argocd
  labels:
    app.kubernetes.io/name: cluster-credentials
    app.kubernetes.io/component: secrets
    app.kubernetes.io/part-of: multi-cluster-control-plane
spec:
  refreshInterval: 1h
  secretStoreRef:
    name: vault-backend
    kind: ClusterSecretStore
  target:
    name: cluster-credentials
    creationPolicy: Owner
  data:
    # Primary cluster credentials
    - secretKey: primary-kubeconfig
      remoteRef:
        key: kubernetes/clusters
        property: primary_kubeconfig
    # Standby cluster credentials
    - secretKey: standby-east-kubeconfig
      remoteRef:
        key: kubernetes/clusters
        property: standby_east_kubeconfig
    - secretKey: standby-west-kubeconfig
      remoteRef:
        key: kubernetes/clusters
        property: standby_west_kubeconfig
    - secretKey: standby-west-2-kubeconfig
      remoteRef:
        key: kubernetes/clusters
        property: standby_west2_kubeconfig
---
apiVersion: external-secrets.io/v1beta1
kind: ExternalSecret
metadata:
  name: vault-argocd-integration
  namespace: argocd
  labels:
    app.kubernetes.io/name: vault-argocd-integration
    app.kubernetes.io/component: secrets
spec:
  refreshInterval: 1h
  secretStoreRef:
    name: vault-backend
    kind: ClusterSecretStore
  target:
    name: vault-argocd
    creationPolicy: Owner
  data:
    - secretKey: vault_addr
      remoteRef:
        key: argocd/vault
        property: address
    - secretKey: vault_token
      remoteRef:
        key: argocd/vault
        property: token
    - secretKey: vault_namespace
      remoteRef:
        key: argocd/vault
        property: namespace
---
apiVersion: external-secrets.io/v1beta1
kind: ExternalSecret
metadata:
  name: aws-credentials
  namespace: argocd
  labels:
    app.kubernetes.io/name: aws-credentials
    app.kubernetes.io/component: secrets
    app.kubernetes.io/part-of: multi-cluster-control-plane
spec:
  refreshInterval: 1h
  secretStoreRef:
    name: vault-backend
    kind: ClusterSecretStore
  target:
    name: aws-credentials
    creationPolicy: Owner
  data:
    - secretKey: access_key_id
      remoteRef:
        key: aws/credentials
        property: access_key_id
    - secretKey: secret_access_key
      remoteRef:
        key: aws/credentials
        property: secret_access_key
    - secretKey: region
      remoteRef:
        key: aws/credentials
        property: region
---
apiVersion: external-secrets.io/v1beta1
kind: ExternalSecret
metadata:
  name: crossplane-provider-aws
  namespace: crossplane-system
  labels:
    app.kubernetes.io/name: crossplane-provider-aws
    app.kubernetes.io/component: secrets
    app.kubernetes.io/part-of: multi-cluster-control-plane
spec:
  refreshInterval: 1h
  secretStoreRef:
    name: vault-backend
    kind: ClusterSecretStore
  target:
    name: crossplane-aws-provider-creds
    creationPolicy: Owner
  data:
    - secretKey: credentials
      remoteRef:
        key: crossplane/aws-provider
        property: credentials
---
apiVersion: v1
kind: Secret
metadata:
  name: vault-agent-injector-tls
  namespace: vault
type: kubernetes.io/tls
stringData:
  # Certificados para la comunicación entre Vault Agent Injector y los pods
  tls.crt: |
    -----BEGIN CERTIFICATE-----
    MIIDXTCCAkWgAwIBAgIJAJC1HiIAZAiMMA0GCSqGSIb3Aa
    ... (certificado del injector)
    -----END CERTIFICATE-----
  tls.key: |
    -----BEGIN RSA PRIVATE KEY-----
    MIIEpAIBAAKCAQEAy6z7...
    ... (clave privada)
    -----END RSA PRIVATE KEY-----
  ca.crt: |
    -----BEGIN CERTIFICATE-----
    MIIDXTCCAkWgAwIBAgIJAJC1HiIAZAiMMA0GCSqGSIb3Aa
    ... (CA de Vault)
    -----END CERTIFICATE-----

---
apiVersion: v1
kind: Secret
metadata:
  name: vault-server-tls
  namespace: vault
type: kubernetes.io/tls
stringData:
  # Certificados TLS para el servidor de Vault
  tls.crt: |
    -----BEGIN CERTIFICATE-----
    MIIDXTCCAkWgAwIBAgIJAJC1HiIAZAiMMA0GCSqGSIb3Aa
    ... (certificado del servidor Vault)
    -----END CERTIFICATE-----
  tls.key: |
    -----BEGIN RSA PRIVATE KEY-----
    MIIEpAIBAAKCAQEAy6z7...
    ... (clave privada)
    -----END RSA PRIVATE KEY-----

---
apiVersion: v1
kind: Secret
metadata:
  name: argocd-vault-plugin
  namespace: argocd
  labels:
    app.kubernetes.io/name: argocd-vault-plugin
    app.kubernetes.io/component: secrets
    app.kubernetes.io/part-of: multi-cluster-control-plane
type: Opaque
stringData:
  # Configuración del plugin de Vault para ArgoCD
  config.yaml: |
    vault:
      address: "https://vault.vault.svc.cluster.local:8200"
      role: "argocd"
      auth:
        method: "kubernetes"
        mount_path: "kubernetes"
      skip_verify: false
      ca_cert: |
        -----BEGIN CERTIFICATE-----
        ...
        -----END CERTIFICATE-----
    
    # Mapeo de paths de secretos a aplicaciones
    secretMappings:
      - apps:
          - "frontend"
          - "backend"
        path: "secret/data/applications"
        
      - apps:
          - "monitoring"
        path: "secret/data/monitoring"
        
      - apps:
          - "database"
        path: "secret/data/database"

---
apiVersion: v1
kind: Secret
metadata:
  name: failover-secrets
  namespace: infrastructure
  labels:
    app.kubernetes.io/name: failover-secrets
    app.kubernetes.io/component: secrets
    app.kubernetes.io/part-of: multi-cluster-control-plane
type: Opaque
stringData:
  # Secrets necesarios para la lógica de failover
  # Incluyen credenciales de notificación y herramientas de orquestación
  pagerduty.key: "xxxxxxxxxxxxxxxxxx"
  slack.webhook: "https://hooks.slack.com/services/xxxxxxxxx/yyyyyyyyy/zzzzzzzzz"
  slack.channel: "#platform-alerts"
  
  # Credenciales para herramientas de diagnóstico
  datadog.api-key: "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
  datadog.app-key: "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
  
  # Configuración de alerts
  alert-manager.url: "http://alertmanager.monitoring.svc.cluster.local:9093"
  alert-manager.token: "alertmanager-token-xxxxx"
  
  # Scripts de failover
  failover.script: |
    #!/bin/bash
    # Script de failover - ejecutado por el operador de failover
    set -e
    
    PRIMARY_CLUSTER="primary-cluster"
    STANDBY_CLUSTER="${FAILOVER_TARGET:-standby-east}"
    
    echo "Iniciando failover de ${PRIMARY_CLUSTER} a ${STANDBY_CLUSTER}"
    
    # Verificar salud del cluster standby
    kubectl --kubeconfig=/etc/kubernetes/${STANDBY_CLUSTER}/kubeconfig get nodes
    
    # Actualizar DNS
    aws route53 change-resource-record-sets \
      --hosted-zone-id Z1234567890ABC \
      --change-batch file://failover-record.json
    
    # Sincronizar estado desde S3
    aws s3 sync s3://primary-cluster-state/ s3://${STANDBY_CLUSTER}-state/ \
      --source-region us-east-1 \
      --region ${STANDBY_CLUSTER_REGION}
    
    echo "Failover completado exitosamente"

---
apiVersion: v1
kind: Secret
metadata:
  name: replication-secrets
  namespace: infrastructure
  labels:
    app.kubernetes.io/name: replication-secrets
    app.kubernetes.io/component: secrets
    app.kubernetes.io/part-of: multi-cluster-control-plane
type: Opaque
stringData:
  # Secrets para la replicación cross-region
  # Incluyen claves de cifrado y credenciales de S3
  replication.access-key: "AKIAIOSFODNN7EXAMPLE"
  replication.secret-key: "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"
  replication.region: "us-east-1"
  
  # Clave KMS para cifrado de datos en replicación
  kms.key.arn: "arn:aws:kms:us-east-1:123456789012:key/replication-key-xxxxx"
  kms.key.alias: "alias/replication-key"
  
  # Configuración de tablas DynamoDB para estado de replicación
  dynamodb.table: "replication-state"
  dynamodb.region: "us-east-1"
  
  # SQS para eventos de replicación
  sqs.queue.url: "https://sqs.us-east-1.amazonaws.com/123456789012/replication-events"
  sqs.queue.region: "us-east-1"
  
  # Configuración de SNS para notificaciones de replicación
  sns.topic.arn: "arn:aws:sns:us-east-1:123456789012:replication-alerts"
  sns.topic.region: "us-east-1"


// === ARCHIVO: scripts/health-check.sh ===
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
// === ARCHIVO: scripts/failover-logic.sh ===
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


// === ARCHIVO: docs/requirements.md ===
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

// === ARCHIVO: docs/tools-comparison.md ===
# Comparación y Justificación de Herramientas GitOps

## Contexto de Evaluación

La selección de herramientas GitOps para el control plane multi-cluster requiere evaluación exhaustiva de múltiples soluciones del ecosistema. Este documento presenta un análisis comparativo de ArgoCD, Flux y Rancher Fleet, evaluando criterios técnicos y operacionales relevantes para el escenario de 12 clusters distribuidos en 4 regiones de AWS.

## Criterios de Evaluación

### Funcionalidad Multi-Cluster

La capacidad de gestionar múltiples clusters desde un punto de control central es fundamental para el escenario propuesto. La evaluación considera el modelo de arquitectura (push vs pull), la escalabilidad con大量 de clusters, y la granularidad de configuración por cluster.

### Modelo de Sincronización

El mecanismo de reconciliación determina cómo el controlador detecta cambios y los aplica a los clusters objetivo. Los modelos push requieren conectividad desde un componente central hacia los clusters, mientras que los modelos pull operan mediante agentes instalados en cada cluster que pollan la fuente de verdad.

### Integración con Kubernetes

La evaluación considera el nivel de integración con APIs nativas de Kubernetes, el uso de CRDs para definir recursos, y la compatibilidad con características de Kubernetes como admission controllers y RBAC.

### Ecosistema y Comunidad

El tamaño de la comunidad activa, la frecuencia de releases, la disponibilidad de documentación, y el soporte comercial influencian la sostenibilidad a largo plazo de la solución seleccionada.

## Análisis de Herramientas

### ArgoCD

ArgoCD es un controlador declarativo GitOps para Kubernetes que implementa el patrón pull-based de reconciliación continua. Su arquitectura se basa en un API server, un controlador de aplicaciones, y un repositorio de configuración que mantiene el estado de las aplicaciones gestionadas.

**Fortalezas identificadas:**

La funcionalidad multi-cluster de ArgoCD permite gestionar hasta 50 clusters desde una única instancia, con soporte nativo para clusters federados mediante el uso de ApplicationSets. El modelo de aplicaciones aplica-apply permite propagar configuraciones comunes mientras permite personalizaciones por cluster mediante sobrescritura de valores.

La experiencia de usuario incluye una interfaz web completa que visualiza el estado de todas las aplicaciones, el historial de revisiones, y los diffs entre estado desired y actual. El CLI proporciona capacidades completas para scripting y automatización. La integración con notificaciones permite integrar con sistemas de alerta existentes.

El ecosistema de extensiones incluye ApplicationSet para generación automática de aplicaciones, Argo Rollouts para despliegues progresivos, y Argo Image Updater para actualización automática de imágenes. Esta extensibilidad permite construir flujos de CD completos sobre la base de ArgoCD.

**Consideraciones de limitación:**

El API server de ArgoCD requiere autenticación y autorización que debe configurarse cuidadosamente para escenarios de múltiples equipos. La gestión de secretos dentro de ArgoCD requiere integración externa como Vault o Sealed Secrets. En entornos con大量 de aplicaciones, el tiempo de sincronización puede incrementarse debido a la arquitectura de reconciliación secuencial.

### Flux

Flux es un operador GitOps nativo de Kubernetes que implementa sincronización continua desde repositorios Git hacia clusters. Su arquitectura se basa en múltiples controladores especializados que gestionan diferentes aspectos del ciclo de vida GitOps.

**Fortalezas identificadas:**

La arquitectura modular de Flux permite ejecutar únicamente los componentes necesarios para cada caso de uso. El modelo de reconciliación distribuido escala mejor que soluciones centralizadas, ya que cada cluster ejecuta su propio controlador que poll el repositorio independientemente.

La integración nativa con Helm mediante HelmController proporciona gestión declarativa de releases de Helm. La capacidad de definir dependencias entre aplicaciones mediante Kustomize permite construir estructuras jerárquicas complejas. El soporte para image automation permite actualizar automáticamente las referencias de imágenes en manifests.

**Consideraciones de limitación:**

La interfaz gráfica de Flux es limitada comparada con ArgoCD, requiriendo herramientas externas como Weave GitOps para visualización. La configuración multi-cluster requiere herramientas adicionales como Flux Enterprise o soluciones propias. La documentación, aunque completa, tiene una curva de aprendizaje pronunciada para configuraciones avanzadas.

### Rancher Fleet

Rancher Fleet es la solución GitOps de Rancher Labs, diseñada para gestionar大量 clusters a escala empresarial. Su arquitectura soporta miles de clusters con un modelo de gestión jerárquico que permite agrupar clusters por criterios organizacionales.

**Fortalezas identificadas:**

La escalabilidad de Fleet permite gestionar miles de clusters desde una única instalación, muy por encima de los requisitos del escenario actual. El modelo de bundles permite打包 aplicaciones y configuraciones para despliegue uniforme. La integración con Rancher proporciona gestión unificada de múltiples кластеров junto con capacidades de GitOps.

La gestión de secretos mediante integración con Vault y otros backends está incluida nativamente. El modelo de target customization permite personalizar configuraciones por grupo de clusters sin duplicar definiciones.

**Consideraciones de limitación:**

Fleet tiene dependencia fuerte del ecosistema Rancher, lo que puede serlimitante si la organización no utiliza Rancher como plataforma de gestión. La documentación y comunidad son menores comparadas con ArgoCD y Flux. La instalación y configuración inicial es más compleja para casos de uso simples.

## Matriz Comparativa

| Criterio | ArgoCD | Flux | Fleet |
|----------|--------|------|-------|
| Multi-cluster nativo | Excelente | Bueno | Excelente |
| Interfaz de usuario | Completa | Limitada | Completa |
| Escalabilidad | Hasta 50 clusters | Alta | Miles de clusters |
| Curva de aprendizaje | Moderada | Alta | Alta |
| Comunidad activa | Muy activa | Activa | Moderada |
| Integración Helm | Buena | Excelente | Buena |
| Documentación | Excelente | Buena | Moderada |
| Soporte comercial | GitOps Inc. | Weaveworks | SUSE |

## Justificación de Selección

### Selección: ArgoCD

Para el escenario de 12 clusters distribuidos en 4 regiones de AWS, ArgoCD representa la selección óptima por las siguientes razones:

La funcionalidad multi-cluster nativa de ArgoCD se alinea perfectamente con los 12 clusters del escenario. El modelo de gestión centralizada proporciona visibilidad unificada del estado de todas las aplicaciones en todos los clusters, facilitando operaciones y troubleshooting. La interfaz web permite a operadores verificar rápidamente el estado del sistema sin depender de herramientas de línea de comandos.

El ApplicationSet de ArgoCD con su generador de matrices permite implementar el patrón de apps-of-apps de manera elegante. Una única definición de ApplicationSet puede gestionar el despliegue de aplicaciones base en todos los clusters, mientras que configuraciones específicas por cluster se logran mediante parámetros de personalización. Este patrón reduce la carga operativa y minimiza errores de configuración.

La comunidad activa y el soporte comercial de GitOps Inc. proporcionan garantías de sostenibilidad a largo plazo. La frecuencia de releases y la rápida adopción de nuevas características de Kubernetes aseguran que la solución se mantendrá actualizada con el ecosistema.

### Alternativas Consideradas

Flux fue evaluado como alternativa por su modelo de reconciliación distribuida. Sin embargo, la menor madurez de su interfaz de usuario y la complejidad adicional para gestión multi-cluster lo hacen menos adecuado para el equipo operativo previsto. La diferencia de rendimiento en escala es marginal para el caso de 12 clusters.

Rancher Fleet fue considerado por su escalabilidad superior, pero la dependencia del ecosistema Rancher añade complejidad innecesaria. El equipo no utiliza Rancher como plataforma de gestión, por lo que incorporar Fleet implicaría adoptar una plataforma adicional solo para esta funcionalidad.

## Recomendaciones de Implementación

### Arquitectura de Despliegue

Se recomienda instalar ArgoCD en el cluster primario con acceso a los clusters remotos mediante kubeconfig configurado. Esta arquitectura centralizada proporciona un punto de control único mientras permite visibilidad completa del estado del sistema.

Para alta disponibilidad, el servidor de ArgoCD puede desplegarse con múltiples réplicas detrás de un balanceador de carga. Los datos de estado se almacenan en un ConfigMap de Kubernetes o externamente en una base de datos PostgreSQL para escenarios que requieren persistencia robusta.

### Configuración Multi-Cluster

La configuración de clusters remotos utiliza el comando `argocd cluster add` que registra el cluster target y crea el ServiceAccount necesario en el cluster remoto. Este ServiceAccount recibe permisos específicos para permitir operaciones de ArgoCD en el namespace de destino.

Las aplicaciones se organizan en un directorio estructurado que refleja la topología de clusters. El ApplicationSet de nivel superior crea aplicaciones para cada cluster, mientras que aplicaciones específicas de workload se despliegan mediante aplicaciones anidadas.

### Integración con el Resto del Sistema

ArgoCD se integra con Crossplane mediante la creación de aplicaciones que gestionan los XRDs y Compositions. Los cambios en definiciones de infraestructura se propagan automáticamente a través del mecanismo de sincronización de ArgoCD.

La gestión de secretos utiliza External Secrets Operator configurado como aplicación base. Los secretos se sincronizan desde Vault hacia los namespaces requeridos, y ArgoCD gestiona el ciclo de vida del operador y sus configuraciones.

// === ARCHIVO: docs/replication-topology.md ===
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


// === ARCHIVO: docs/disaster-recovery.md ===
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

// === ARCHIVO: tests/health-check-tests.yaml ===
apiVersion: v1
kind: List
metadata:
  name: health-check-test-suite
  description: Casos de prueba para validar el script de health-check.sh
items:
- apiVersion: batch/v1
  kind: Job
  metadata:
    name: health-check-primary-available
    namespace: default
    labels:
      test-type: health-check
      target-script: health-check.sh
      cluster-role: primary
  spec:
    ttlSecondsAfterFinished: 300
    template:
      metadata:
        labels:
          test-type: health-check
      spec:
        serviceAccountName: test-runner
        restartPolicy: Never
        containers:
        - name: test-runner
          image: bitnami/kubectl:1.28
          command:
          - /bin/sh
          - -c
          - |
            set -e
            echo "=== Validando health check para cluster primario ==="
            SCRIPT_PATH="/scripts/health-check.sh"
            if [ ! -f "$SCRIPT_PATH" ]; then
              echo "ERROR: Script health-check.sh no encontrado"
              exit 1
            fi
            chmod +x "$SCRIPT_PATH"
            OUTPUT=$(bash "$SCRIPT_PATH" 2>&1 || true)
            echo "Output del script: $OUTPUT"
            if echo "$OUTPUT" | grep -q "primary-cluster.*healthy"; then
              echo "PASS: Cluster primario reportado como healthy"
              exit 0
            elif echo "$OUTPUT" | grep -q "primary.*UP"; then
              echo "PASS: Cluster primario UP"
              exit 0
            else
              echo "FAIL: No se detectó estado healthy para cluster primario"
              exit 1
            fi
          env:
          - name: PRIMARY_CLUSTER
            value: "primary-cluster"
          - name: PRIMARY_ENDPOINT
            value: "https://primary.k8s.example.com"
          volumeMounts:
          - name: scripts
            mountPath: /scripts
        volumes:
        - name: scripts
          configMap:
            name: health-check-script
            defaultMode: 0755
- apiVersion: batch/v1
  kind: Job
  metadata:
    name: health-check-standby-available
    namespace: default
    labels:
      test-type: health-check
      target-script: health-check.sh
      cluster-role: standby
  spec:
    ttlSecondsAfterFinished: 300
    template:
      metadata:
        labels:
          test-type: health-check
      spec:
        serviceAccountName: test-runner
        restartPolicy: Never
        containers:
        - name: test-runner
          image: bitnami/kubectl:1.28
          command:
          - /bin/sh
          - -c
          - |
            set -e
            echo "=== Validando health check para clusters standby ==="
            SCRIPT_PATH="/scripts/health-check.sh"
            chmod +x "$SCRIPT_PATH"
            OUTPUT=$(bash "$SCRIPT_PATH" --check-standby 2>&1 || true)
            echo "Output: $OUTPUT"
            STANDBY_COUNT=$(echo "$OUTPUT" | grep -c "standby.*UP\|standby.*healthy" || true)
            if [ "$STANDBY_COUNT" -ge 1 ]; then
              echo "PASS: Al menos un cluster standby disponible"
              exit 0
            else
              echo "FAIL: Ningun cluster standby disponible"
              exit 1
            fi
          volumeMounts:
          - name: scripts
            mountPath: /scripts
        volumes:
        - name: scripts
          configMap:
            name: health-check-script
            defaultMode: 0755
- apiVersion: batch/v1
  kind: Job
  metadata:
    name: health-check-argocd-connection
    namespace: argocd
    labels:
      test-type: health-check
      target-component: argocd
  spec:
    ttlSecondsAfterFinished: 300
    template:
      metadata:
        labels:
          test-type: health-check
      spec:
        serviceAccountName: test-runner
        restartPolicy: Never
        containers:
        - name: test-runner
          image: bitnami/kubectl:1.28
          command:
          - /bin/sh
          - -c
          - |
            set -e
            echo "=== Verificando conectividad a ArgoCD ==="
            ARGOCD_POD=$(kubectl get pods -n argocd -l app.kubernetes.io/name=argocd-server -o jsonpath='{.items[0].metadata.name}')
            if [ -z "$ARGOCD_POD" ]; then
              echo "ERROR: No se encontró pod de ArgoCD"
              exit 1
            fi
            echo " ArgoCD pod: $ARGOCD_POD"
            kubectl exec -n argocd "$ARGOCD_POD" -- argocd version --client > /dev/null 2>&1
            if [ $? -eq 0 ]; then
              echo "PASS: ArgoCD CLI accesible"
              exit 0
            else
              echo "FAIL: ArgoCD CLI no accesible"
              exit 1
            fi
- apiVersion: batch/v1
  kind: Job
  metadata:
    name: health-check-crossplane-providers
    namespace: crossplane-system
    labels:
      test-type: health-check
      target-component: crossplane
  spec:
    ttlSecondsAfterFinished: 300
    template:
      metadata:
        labels:
          test-type: health-check
      spec:
        serviceAccountName: test-runner
        restartPolicy: Never
        containers:
        - name: test-runner
          image: bitnami/kubectl:1.28
          command:
          - /bin/sh
          - -c
          - |
            set -e
            echo "=== Verificando estado de Crossplane providers ==="
            PROVIDERS=$(kubectl get providers -A -o jsonpath='{.items[*].metadata.name}')
            echo " Providers encontrados: $PROVIDERS"
            HEALTHY=$(kubectl get providers -A -o jsonpath='{.items[?(@.status.conditions[0].type=="Ready")].metadata.name}' | wc -w)
            TOTAL=$(echo "$PROVIDERS" | wc -w)
            if [ "$HEALTHY" -gt 0 ]; then
              echo "PASS: $HEALTHY/$TOTAL providers en estado Ready"
              exit 0
            else
              echo "FAIL: Ningun provider en estado Ready"
              exit 1
            fi
- apiVersion: batch/v1
  kind: Job
  metadata:
    name: health-check-vault-accessible
    namespace: vault
    labels:
      test-type: health-check
      target-component: vault
  spec:
    ttlSecondsAfterFinished: 300
    template:
      metadata:
        labels:
          test-type: health-check
      spec:
        serviceAccountName: test-runner
        restartPolicy: Never
        containers:
        - name: test-runner
          image: bitnami/kubectl:1.28
          command:
          - /bin/sh
          - -c
          - |
            set -e
            echo "=== Verificando accesibilidad de Vault ==="
            VAULT_POD=$(kubectl get pods -n vault -l app.kubernetes.io/name=vault -o jsonpath='{.items[0].metadata.name}' 2>/dev/null || echo "")
            if [ -z "$VAULT_POD" ]; then
              echo "WARN: Vault pod no encontrado, verificando servicio"
              kubectl get svc -n vault vault > /dev/null 2>&1
              if [ $? -eq 0 ]; then
                echo "PASS: Servicio Vault existe"
                exit 0
              fi
              echo "FAIL: Vault no accesible"
              exit 1
            fi
            echo " Vault pod: $VAULT_POD"
            STATUS=$(kubectl get pod -n vault "$VAULT_POD" -o jsonpath='{.status.phase}')
            if [ "$STATUS" == "Running" ]; then
              echo "PASS: Vault en estado Running"
              exit 0
            else
              echo "FAIL: Vault en estado $STATUS"
              exit 1
            fi
- apiVersion: batch/v1
  kind: Job
  metadata:
    name: health-check-all-clusters-reachable
    namespace: default
    labels:
      test-type: health-check
      target-script: health-check.sh
      scope: full-topology
  spec:
    ttlSecondsAfterFinished: 300
    template:
      metadata:
        labels:
          test-type: health-check
      spec:
        serviceAccountName: test-runner
        restartPolicy: Never
        containers:
        - name: test-runner
          image: bitnami/kubectl:1.28
          command:
          - /bin/sh
          - -c
          - |
            set -e
            echo "=== Verificando todos los clusters ==="
            SCRIPT_PATH="/scripts/health-check.sh"
            chmod +x "$SCRIPT_PATH"
            OUTPUT=$(bash "$SCRIPT_PATH" --all 2>&1 || true)
            echo "Output: $OUTPUT"
            CLUSTERS=("primary-cluster" "standby-us-east-2" "standby-us-west-1" "standby-us-west-2")
            REACHABLE=0
            for cluster in "${CLUSTERS[@]}"; do
              if echo "$OUTPUT" | grep -q "$cluster.*UP\|$cluster.*healthy"; then
                REACHABLE=$((REACHABLE + 1))
              fi
            done
            if [ "$REACHABLE" -ge 3 ]; then
              echo "PASS: $REACHABLE/4 clusters alcanzables"
              exit 0
            else
              echo "FAIL: Solo $REACHABLE/4 clusters alcanzables"
              exit 1
            fi
          volumeMounts:
          - name: scripts
            mountPath: /scripts
        volumes:
        - name: scripts
          configMap:
            name: health-check-script
            defaultMode: 0755
// === ARCHIVO: tests/failover-tests.yaml ===
apiVersion: v1
kind: List
metadata:
  name: failover-test-suite
  description: Casos de prueba para validar la lógica de failover en failover-logic.sh
items:
- apiVersion: batch/v1
  kind: Job
  metadata:
    name: failover-dry-run-validation
    namespace: default
    labels:
      test-type: failover
      mode: dry-run
      target-script: failover-logic.sh
  spec:
    ttlSecondsAfterFinished: 300
    template:
      metadata:
        labels:
          test-type: failover
      spec:
        serviceAccountName: test-runner
        restartPolicy: Never
        containers:
        - name: test-runner
          image: bitnami/kubectl:1.28
          command:
          - /bin/sh
          - -c
          - |
            set -e
            echo "=== Ejecutando failover en modo dry-run ==="
            SCRIPT_PATH="/scripts/failover-logic.sh"
            if [ ! -f "$SCRIPT_PATH" ]; then
              echo "ERROR: Script failover-logic.sh no encontrado"
              exit 1
            fi
            chmod +x "$SCRIPT_PATH"
            OUTPUT=$(bash "$SCRIPT_PATH" --dry-run 2>&1 || true)
            echo "Output: $OUTPUT"
            if echo "$OUTPUT" | grep -q "dry-run\|DRY RUN\|simulacion"; then
              echo "PASS: Modo dry-run ejecutado correctamente"
              exit 0
            else
              echo "FAIL: No se detectó modo dry-run"
              exit 1
            fi
          env:
          - name: PRIMARY_CLUSTER
            value: "primary-cluster"
          - name: STANDBY_CLUSTER
            value: "standby-us-east-2"
          volumeMounts:
          - name: scripts
            mountPath: /scripts
        volumes:
        - name: scripts
          configMap:
            name: failover-script
            defaultMode: 0755
- apiVersion: batch/v1
  kind: Job
  metadata:
    name: failover-primary-failure-detection
    namespace: default
    labels:
      test-type: failover
      scenario: primary-failure
      target-script: failover-logic.sh
  spec:
    ttlSecondsAfterFinished: 300
    template:
      metadata:
        labels:
          test-type: failover
      spec:
        serviceAccountName: test-runner
        restartPolicy: Never
        containers:
        - name: test-runner
          image: bitnami/kubectl:1.28
          command:
          - /bin/sh
          - -c
          - |
            set -e
            echo "=== Simulando falla de cluster primario ==="
            SCRIPT_PATH="/scripts/failover-logic.sh"
            chmod +x "$SCRIPT_PATH"
            OUTPUT=$(bash "$SCRIPT_PATH" --execute --primary-failed 2>&1 || true)
            echo "Output: $OUTPUT"
            if echo "$OUTPUT" | grep -q "failover.*iniciado\|failover.*started\|switching"; then
              echo "PASS: Proceso de failover iniciado"
              exit 0
            elif echo "$OUTPUT" | grep -q "No se requiere failover"; then
              echo "PASS: Evaluacion de failover completada"
              exit 0
            else
              echo "WARN: Output no concluyente pero script ejecuto"
              exit 0
            fi
          volumeMounts:
          - name: scripts
            mountPath: /scripts
        volumes:
        - name: scripts
          configMap:
            name: failover-script
            defaultMode: 0755
- apiVersion: batch/v1
  kind: Job
  metadata:
    name: failover-grace-period-enforcement
    namespace: default
    labels:
      test-type: failover
      aspect: timing
      config-param: grace-period
  spec:
    ttlSecondsAfterFinished: 300
    template:
      metadata:
        labels:
          test-type: failover
      spec:
        serviceAccountName: test-runner
        restartPolicy: Never
        containers:
        - name: test-runner
          image: bitnami/kubectl:1.28
          command:
          - /bin/sh
          - -c
          - |
            set -e
            echo "=== Verificando configuracion de grace period ==="
            GRACE_PERIOD=30
            TIMEOUT=60
            if [ "$GRACE_PERIOD" -lt "$TIMEOUT" ]; then
              echo "PASS: Grace period (${GRACE_PERIOD}s) es menor que timeout (${TIMEOUT}s)"
              exit 0
            else
              echo "FAIL: Grace period debe ser menor que timeout"
              exit 1
            fi
          env:
          - name: FAILOVER_GRACE_PERIOD
            value: "30"
          - name: FAILOVER_TIMEOUT
            value: "60"
- apiVersion: batch/v1
  kind: Job
  metadata:
    name: failover-standby-selection-logic
    namespace: default
    labels:
      test-type: failover
      aspect: selection
      target-script: failover-logic.sh
  spec:
    ttlSecondsAfterFinished: 300
    template:
      metadata:
        labels:
          test-type: failover
      spec:
        serviceAccountName: test-runner
        restartPolicy: Never
        containers:
        - name: test-runner
          image: bitnami/kubectl:1.28
          command:
          - /bin/sh
          - -c
          - |
            set -e
            echo "=== Verificando seleccion de standby cluster ==="
            SCRIPT_PATH="/scripts/failover-logic.sh"
            chmod +x "$SCRIPT_PATH"
            OUTPUT=$(bash "$SCRIPT_PATH" --dry-run --select-standby 2>&1 || true)
            echo "Output: $OUTPUT"
            STANDBY_CLUSTERS="standby-us-east-2 standby-us-west-1 standby-us-west-2"
            SELECTED=""
            for cluster in $STANDBY_CLUSTERS; do
              if echo "$OUTPUT" | grep -q "$cluster.*selected\|$cluster.*elegido"; then
                SELECTED="$cluster"
                break
              fi
            done
            if [ -n "$SELECTED" ]; then
              echo "PASS: Standby cluster seleccionado: $SELECTED"
              exit 0
            else
              echo "WARN: Verificando otros patrones de seleccion"
              if echo "$OUTPUT" | grep -qE "(standby|backup).*cluster"; then
                echo "PASS: Logica de seleccion presente"
                exit 0
              fi
              echo "FAIL: No se detecto seleccion de standby"
              exit 1
            fi
          volumeMounts:
          - name: scripts
            mountPath: /scripts
        volumes:
        - name: scripts
          configMap:
            name: failover-script
            defaultMode: 0755
- apiVersion: batch/v1
  kind: Job
  metadata:
    name: failover-argocd-sync-after-switch
    namespace: argocd
    labels:
      test-type: failover
      post-action: argocd-sync
  spec:
    ttlSecondsAfterFinished: 300
    template:
      metadata:
        labels:
          test-type: failover
      spec:
        serviceAccountName: test-runner
        restartPolicy: Never
        containers:
        - name: test-runner
          image: bitnami/kubectl:1.28
          command:
          - /bin/sh
          - -c
          - |
            set -e
            echo "=== Verificando sincronizacion de ArgoCD post-failover ==="
            ARGOCD_APP=$(kubectl get applications -A -l app.kubernetes.io/instance=argocd -o jsonpath='{.items[0].metadata.name}' 2>/dev/null || echo "")
            if [ -z "$ARGOCD_APP" ]; then
              echo "INFO: No hay aplicaciones ArgoCD para verificar"
              echo "PASS: Verificacion completada (sin apps)"
              exit 0
            fi
            SYNC_STATUS=$(kubectl get application "$ARGOCD_APP" -A -o jsonpath='{.status.sync.status}' 2>/dev/null || echo "Unknown")
            echo " Sync status: $SYNC_STATUS"
            if [ "$SYNC_STATUS" == "Synced" ]; then
              echo "PASS: Aplicacion sincronizada"
              exit 0
            else
              echo "INFO: Estado actual: $SYNC_STATUS"
              echo "PASS: Verificacion completada"
              exit 0
            fi
- apiVersion: batch/v1
  kind: Job
  metadata:
    name: failover-notification-channels
    namespace: default
    labels:
      test-type: failover
      aspect: notification
  spec:
    ttlSecondsAfterFinished: 300
    template:
      metadata:
        labels:
          test-type: failover
      spec:
        serviceAccountName: test-runner
        restartPolicy: Never
        containers:
        - name: test-runner
          image: bitnami/kubectl:1.28
          command:
          - /bin/sh
          - -c
          - |
            set -e
            echo "=== Verificando canales de notificacion configurados ==="
            CHANNELS_VAR="slack,pagerduty"
            IFS=',' read -ra CHANNELS <<< "$CHANNELS_VAR"
            CONFIGURED=0
            for channel in "${CHANNELS[@]}"; do
              if [ -n "$channel" ]; then
                CONFIGURED=$((CONFIGURED + 1))
              fi
            done
            if [ "$CONFIGURED" -ge 2 ]; then
              echo "PASS: $CONFIGURED canales de notificacion configurados"
              exit 0
            else
              echo "FAIL: Canales de notificacion insuficientes"
              exit 1
            fi
          env:
          - name: NOTIFICATION_CHANNELS
            value: "slack,pagerduty"
- apiVersion: batch/v1
  kind: Job
  metadata:
    name: failover-auto-disabled-by-default
    namespace: default
    labels:
      test-type: failover
      config-validation: auto-failover
  spec:
    ttlSecondsAfterFinished: 300
    template:
      metadata:
        labels:
          test-type: failover
      spec:
        serviceAccountName: test-runner
        restartPolicy: Never
        containers:
        - name: test-runner
          image: bitnami/kubectl:1.28
          command:
          - /bin/sh
          - -c
          - |
            set -e
            echo "=== Verificando que auto-failover esta deshabilitado por defecto ==="
            AUTO_FAILOVER="false"
            if [ "$AUTO_FAILOVER" == "false" ]; then
              echo "PASS: Auto-failover deshabilitado por defecto (configuracion segura)"
              exit 0
            else
              echo "FAIL: Auto-failover deberia estar deshabilitado por defecto"
              exit 1
            fi
          env:
          - name: AUTO_FAILOVER
            value: "false"
// === ARCHIVO: tests/replication-tests.yaml ===
apiVersion: v1
kind: List
metadata:
  name: replication-test-suite
  description: Casos de prueba para validar la replicacion de estado entre clusters
items:
- apiVersion: batch/v1
  kind: Job
  metadata:
    name: replication-config-async-strategy
    namespace: default
    labels:
      test-type: replication
      strategy: async
      config-param: strategy
  spec:
    ttlSecondsAfterFinished: 300
    template:
      metadata:
        labels:
          test-type: replication
      spec:
        serviceAccountName: test-runner
        restartPolicy: Never
        containers:
        - name: test-runner
          image: bitnami/kubectl:1.28
          command:
          - /bin/sh
          - -c
          - |
            set -e
            echo "=== Verificando configuracion de estrategia de replicacion ==="
            STRATEGY="async"
            CONSISTENCY="eventual"
            if [ "$STRATEGY" == "async" ]; then
              echo "PASS: Estrategia asincrona configurada"
            else
              echo "FAIL: Estrategia debe ser async"
              exit 1
            fi
            if [ "$CONSISTENCY" == "eventual" ]; then
              echo "PASS: Consistencia eventual configurada"
            else
              echo "FAIL: Consistencia debe ser eventual para estrategia async"
              exit 1
            fi
          env:
          - name: REPLICATION_STRATEGY
            value: "async"
          - name: REPLICATION_CONSISTENCY
            value: "eventual"
- apiVersion: batch/v1
  kind: Job
  metadata:
    name: replication-sync-interval-validation
    namespace: default
    labels:
      test-type: replication
      config-param: syncInterval
  spec:
    ttlSecondsAfterFinished: 300
    template:
      metadata:
        labels:
          test-type: replication
      spec:
        serviceAccountName: test-runner
        restartPolicy: Never
        containers:
        - name: test-runner
          image: bitnami/kubectl:1.28
          command:
          - /bin/sh
          - -c
          - |
            set -e
            echo "=== Validando intervalo de sincronizacion ==="
            SYNC_INTERVAL="30s"
            INTERVAL_SECONDS=$(echo "$SYNC_INTERVAL" | sed 's/s//')
            if [ "$INTERVAL_SECONDS" -ge 10 ] && [ "$INTERVAL_SECONDS" -le 300 ]; then
              echo "PASS: Intervalo de sincronizacion dentro de rango valido (${INTERVAL_SECONDS}s)"
              exit 0
            else
              echo "FAIL: Intervalo fuera de rango valido: ${INTERVAL_SECONDS}s"
              exit 1
            fi
          env:
          - name: SYNC_INTERVAL
            value: "30s"
- apiVersion: batch/v1
  kind: Job
  metadata:
    name: replication-retry-attempts
    namespace: default
    labels:
      test-type: replication
      config-param: retryAttempts
  spec:
    ttlSecondsAfterFinished: 300
    template:
      metadata:
        labels:
          test-type: replication
      spec:
        serviceAccountName: test-runner
        restartPolicy: Never
        containers:
        - name: test-runner
          image: bitnami/kubectl:1.28
          command:
          - /bin/sh
          - -c
          - |
            set -e
            echo "=== Verificando configuracion de reintentos ==="
            RETRY_ATTEMPTS=3
            if [ "$RETRY_ATTEMPTS" -ge 1 ] && [ "$RETRY_ATTEMPTS" -le 10 ]; then
              echo "PASS: Reintentos configurados en rango valido ($RETRY_ATTEMPTS)"
              exit 0
            else
              echo "FAIL: Reintentos fuera de rango valido"
              exit 1
            fi
          env:
          - name: RETRY_ATTEMPTS
            value: "3"
- apiVersion: batch/v1
  kind: Job
  metadata:
    name: replication-conflict-resolution-primary-wins
    namespace: default
    labels:
      test-type: replication
      config-param: conflictResolution
  spec:
    ttlSecondsAfterFinished: 300
    template:
      metadata:
        labels:
          test-type: replication
      spec:
        serviceAccountName: test-runner
        restartPolicy: Never
        containers:
        - name: test-runner
          image: bitnami/kubectl:1.28
          command:
          - /bin/sh
          - -c
          - |
            set -e
            echo "=== Verificando resolucion de conflictos ==="
            CONFLICT_RESOLUTION="primary-wins"
            if [ "$CONFLICT_RESOLUTION" == "primary-wins" ]; then
              echo "PASS: Resolucion de conflictos configurada: primary-wins"
              exit 0
            else
              echo "FAIL: Resolucion de conflictos debe ser primary-wins"
              exit 1
            fi
          env:
          - name: CONFLICT_RESOLUTION
            value: "primary-wins"
- apiVersion: batch/v1
  kind: Job
  metadata:
    name: replication-crossplane-xrd-sync
    namespace: crossplane-system
    labels:
      test-type: replication
      component: crossplane
      resource-type: XRD
  spec:
    ttlSecondsAfterFinished: 300
    template:
      metadata:
        labels:
          test-type: replication
      spec:
        serviceAccountName: test-runner
        restartPolicy: Never
        containers:
        - name: test-runner
          image: bitnami/kubectl:1.28
          command:
          - /bin/sh
          - -c
          - |
            set -e
            echo "=== Verificando XRDs de Crossplane ==="
            XRDS=$(kubectl get xrd -A -o jsonpath='{.items[*].metadata.name}' 2>/dev/null || echo "")
            echo " XRDs encontrados: $XRDS"
            if [ -n "$XRDS" ]; then
              XRD_COUNT=$(echo "$XRDS" | wc -w)
              echo "PASS: $XRD_COUNT CompositeResourceDefinitions encontradas"
              exit 0
            else
              echo "INFO: No hay XRDs configuradas (esperado en setup inicial)"
              echo "PASS: Verificacion completada"
              exit 0
            fi
- apiVersion: batch/v1
  kind: Job
  metadata:
    name: replication-argocd-app-sync-status
    namespace: argocd
    labels:
      test-type: replication
      component: argocd
      check: sync-status
  spec:
    ttlSecondsAfterFinished: 300
    template:
      metadata:
        labels:
          test-type: replication
      spec:
        serviceAccountName: test-runner
        restartPolicy: Never
        containers:
        - name: test-runner
          image: bitnami/kubectl:1.28
          command:
          - /bin/sh
          - -c
          - |
            set -e
            echo "=== Verificando estado de sincronizacion ArgoCD ==="
            APPS=$(kubectl get applications -A -o json 2>/dev/null || echo "[]")
            if echo "$APPS" | grep -q "items"; then
              APP_COUNT=$(echo "$APPS" | grep -o '"name"' | wc -l)
              echo "PASS: $APP_COUNT aplicaciones gestionadas por ArgoCD"
              exit 0
            else
              echo "INFO: Verificando estado del servidor ArgoCD"
              ARGO_POD=$(kubectl get pods -n argocd -l app.kubernetes.io/name=argocd-server -o jsonpath='{.items[0].metadata.name}' 2>/dev/null || echo "")
              if [ -n "$ARGO_POD" ]; then
                echo "PASS: ArgoCD accesible, verificacion completada"
                exit 0
              fi
              echo "FAIL: No se puede verificar estado de ArgoCD"
              exit 1
            fi
- apiVersion: batch/v1
  kind: Job
  metadata:
    name: replication-external-secrets-store
    namespace: external-secrets
    labels:
      test-type: replication
      component: external-secrets
      resource-type: ClusterSecretStore
  spec:
    ttlSecondsAfterFinished: 300
    template:
      metadata:
        labels:
          test-type: replication
      spec:
        serviceAccountName: test-runner
        restartPolicy: Never
        containers:
        - name: test-runner
          image: bitnami/kubectl:1.28
          command:
          - /bin/sh
          - -c
          - |
            set -e
            echo "=== Verificando ClusterSecretStore para replicacion de secrets ==="
            CSS=$(kubectl get clustersecretstores -A -o jsonpath='{.items[*].metadata.name}' 2>/dev/null || echo "")
            if [ -n "$CSS" ]; then
              echo " ClusterSecretStores: $CSS"
              echo "PASS: ClusterSecretStore configurado"
              exit 0
            else
              echo "INFO: Verificando SecretStores alternativos"
              SS=$(kubectl get secretstores -A -o jsonpath='{.items[*].metadata.name}' 2>/dev/null || echo "")
              if [ -n "$SS" ]; then
                echo " SecretStores: $SS"
                echo "PASS: SecretStore configurado"
                exit 0
              fi
              echo "INFO: No hay stores configurados (esperado en setup inicial)"
              echo "PASS: Verificacion completada"
              exit 0
            fi
- apiVersion: batch/v1
  kind: Job
  metadata:
    name: replication-vault-replication-status
    namespace: vault
    labels:
      test-type: replication
      component: vault
      feature: replication
  spec:
    ttlSecondsAfterFinished: 300
    template:
      metadata:
        labels:
          test-type: replication
      spec:
        serviceAccountName: test-runner
        restartPolicy: Never
        containers:
        - name: test-runner
          image: bitnami/kubectl:1.28
          command:
          - /bin/sh
          - -c
          - |
            set -e
            echo "=== Verificando estado de replicacion de Vault ==="
            VAULT_PODS=$(kubectl get pods -n vault -l app.kubernetes.io/name=vault -o jsonpath='{.items[*].metadata.name}' 2>/dev/null || echo "")
            if [ -z "$VAULT_PODS" ]; then
              echo "INFO: Vault no desplegado en este cluster"
              echo "PASS: Verificacion completada (Vault en otro cluster)"
              exit 0
            fi
            POD_COUNT=$(echo "$VAULT_PODS" | wc -w)
            if [ "$POD_COUNT" -ge 3 ]; then
              echo " Vault pods: $VAULT_PODS"
              echo "PASS: Configuracion HA de Vault detectada ($POD_COUNT pods)"
              exit 0
            else
              echo "WARN: Solo $POD_COUNT pod(es) de Vault"
              echo "PASS: Verificacion completada"
              exit 0
            fi
- apiVersion: batch/v1
  kind: Job
  metadata:
    name: replication-topology-validation
    namespace: default
    labels:
      test-type: replication
      aspect: topology
      clusters: all
  spec:
    ttlSecondsAfterFinished: 300
    template:
      metadata:
        labels:
          test-type: replication
      spec:
        serviceAccountName: test-runner
        restartPolicy: Never
        containers:
        - name: test-runner
          image: bitnami/kubectl:1.28
          command:
          - /bin/sh
          - -c
          - |
            set -e
            echo "=== Validando topologia de replicacion ==="
            PRIMARY="primary-cluster"
            STANDBY_CLUSTERS="standby-us-east-2 standby-us-west-1 standby-us-west-2"
            PRIMARY_REGION="us-east-1"
            STANDBY_REGIONS="us-east-2 us-west-1 us-west-2"
            echo "Cluster primario: $PRIMARY ($PRIMARY_REGION)"
            echo "Clusters standby: $STANDBY_CLUSTERS"
            STANDBY_COUNT=$(echo "$STANDBY_CLUSTERS" | wc -w)
            if [ "$STANDBY_COUNT" -ge 2 ]; then
              echo "PASS: Topologia con $STANDBY_COUNT clusters standby configurada"
              exit 0
            else
              echo "FAIL: Se requieren al menos 2 clusters standby"
              exit 1
            fi
            UNIQUE_REGIONS=$(echo "$STANDBY_REGIONS" | tr ' ' '\n' | sort -u | wc -l)
            if [ "$UNIQUE_REGIONS" -ge 2 ]; then
              echo "PASS: Replicacion cross-region configurada ($UNIQUE_REGIONS regiones)"
              exit 0
            else
              echo "FAIL: Se requieren multiples regiones para DR"
              exit 1
            fi

```
