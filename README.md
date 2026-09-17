# Diseño y Evaluación de un Control Plane Multi-Cluster con GitOps y Disaster Recovery

Eres un arquitecto senior encargado de diseñar un control plane que gestione 12 clusters Kubernetes distribuidos en 4 regiones de AWS. Utilizarás ArgoCD para GitOps, Crossplane para provisionar infraestructura declarativa, y una lógica custom de failover. Debes diseñar la topología de replicación de estado entre clusters, justificar la elección de herramientas, el modelo de RBAC federado, la estrategia de secrets, y la coreografía del disaster recovery.

## Informacion General

| Campo | Valor |
|-------|-------|
| **Tema** | TEST-CT |
| **Nivel** | master-l2 |
| **Tipo** | theoretical |
| **Tiempo estimado** | 8 horas |

## Fases del Reto

### Fase 0: Configuración del Proyecto

**Objetivo:** Obtener el proyecto base funcional enviando el Código Base a un asistente de IA, que lo analizará, corregirá errores y generará un ZIP listo para usar.

**Tiempo estimado:** 15-30 minutos

**Instrucciones:**

- Asegúrate de tener instalado para ejecutar el proyecto: Node.js 18+, npm, VS Code o similar.
- Copia todo el contenido del campo **Código Base** de este reto — incluyendo el texto de instrucciones que aparece al inicio.
- Abre un asistente de IA (Claude en claude.ai, ChatGPT o Gemini — se recomienda Claude), pega el contenido copiado en el chat y envíalo.
- El asistente analizará los archivos, corregirá errores y generará un archivo ZIP descargable. Descárgalo y extráelo en la carpeta donde quieras trabajar.
- Ejecuta `npm install && npm run build` (o `npm start`). Si no hay errores, estás listo.

**Entregable:** El proyecto compila/arranca sin errores.

<details>
<summary>Pistas de conocimiento</summary>

- Copia el Código Base completo incluyendo el texto de instrucciones al inicio — esas instrucciones le indican al asistente exactamente qué hacer con los archivos.
- Si el asistente no genera el ZIP automáticamente al terminar el análisis, escríbele: "genera el ZIP ahora".
- Si el proyecto tiene errores al arrancar, comparte el mensaje de error con el mismo asistente para que lo corrija.

</details>

### Fase 1: Exploración y Requisitos

**Objetivo:** Identificar y documentar los requisitos del sistema y las restricciones del dominio.

**Tiempo estimado:** 2 horas

**Instrucciones:**

- Enumera los componentes clave del sistema y sus responsabilidades.
- Identifica las restricciones y ambigüedades del dominio.
- Describe las operaciones críticas y sus umbrales numéricos.

**Entregable:** Documento de requisitos y restricciones del sistema.

<details>
<summary>Pistas de conocimiento</summary>

- Considera la latencia aceptable entre regiones y la disponibilidad requerida.
- Piensa en los posibles puntos de falla y cómo afectan las operaciones.

</details>

### Fase 2: Elección de Herramientas y Justificación

**Objetivo:** Evaluar y justificar la elección de herramientas para el control plane.

**Tiempo estimado:** 3 horas

**Instrucciones:**

- Compara ArgoCD, Flux y Rancher Fleet. Justifica tu elección.
- Describe el modelo de RBAC federado y su implementación.
- Detalla la estrategia de secrets con Vault y external-secrets.

**Entregable:** Documento comparativo y justificación de herramientas.

<details>
<summary>Pistas de conocimiento</summary>

- Considera la escalabilidad, la facilidad de uso y la integración con otros componentes.
- Piensa en los trade-offs entre consistencia y disponibilidad.

</details>

### Fase 3: Diseño de la Topología de Replicación

**Objetivo:** Diseñar la topología de replicación de estado entre clusters.

**Tiempo estimado:** 3 horas

**Instrucciones:**

- Propón una topología de replicación que garantice la consistencia y la disponibilidad.
- Detalla cómo se manejarán los conflictos y el split-brain durante los failovers.
- Describe la estrategia de disaster recovery y cómo se evitará el split-brain.

**Entregable:** Documento de diseño de la topología de replicación.

<details>
<summary>Pistas de conocimiento</summary>

- Considera la latencia entre regiones y cómo afecta la replicación.
- Piensa en los mecanismos para detectar y resolver conflictos.

</details>

## Dimensiones Evaluadas

- **queEs**: ¿Qué es un control plane multi-cluster y cuáles son sus componentes clave?
- **paraQueSirve**: ¿Para qué sirve la replicación de estado entre clusters y cómo afecta la disponibilidad del sistema?
- **comoSeUsa**: ¿Cómo se usa ArgoCD para gestionar la sincronización de los clusters y cómo se compara con otras herramientas?
- **erroresComunes**: ¿Cuáles son los errores comunes en la replicación de estado y cómo se pueden evitar?
- **queDecisionesImplica**: ¿Qué decisiones implica el diseño de un control plane multi-cluster con GitOps y disaster recovery?

## Criterios de Evaluacion

- Identificación y documentación de los requisitos y restricciones del sistema.
- Comparativa y justificación de la elección de herramientas.
- Diseño de la topología de replicación de estado entre clusters.
- Estrategia de disaster recovery y evitación del split-brain.

## Como trabajar con un asistente de IA

Hay dos caminos, elegi uno:

- **AGENTS.md** (recomendado) — instrucciones nativas del repo. Abri esta carpeta con tu agente local (Claude Code, Cursor, Codex, Copilot, Gemini) y las carga solo. Sabe que archivos faltan y con que comando se verifica, y completa el scaffold escribiendo en disco.
- **PROMPT_MEJORA.md** — para copiar y pegar en un chat (claude.ai, ChatGPT). Devuelve un ZIP con el proyecto. Sirve si no tenes un agente en el IDE.

Ninguno de los dos resuelve las fases del reto: eso es tu trabajo.

## Verificacion

El proyecto esta listo para trabajar cuando este comando corre sin errores:

```bash
el comando de build o arranque canonico del stack elegido
```

---

*Reto generado automaticamente por Challenge Generator - Pragma*
