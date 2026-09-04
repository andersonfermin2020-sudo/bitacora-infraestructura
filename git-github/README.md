## 📊 Git & GitHub — Nivel de dominio

### 🟢 Básico
`init` `add` `commit` `status` `log` `diff` — flujo local de control de versiones
`branch` `switch` `merge` — manejo de ramas
`clone` `push` `pull` `fetch` `remote` — colaboración con GitHub
`.gitignore` — control de archivos ignorados

### 🟡 Intermedio
`stash` `cherry-pick` `tag` `reflog` — herramientas de gestión de trabajo
Resolución de conflictos de merge, alias personalizados (`git config alias`)
Pull Requests, Forks, Issues, Labels, Milestones — flujo de colaboración en GitHub
Autenticación con Personal Access Token (PAT)

### 🔴 Avanzado
`rebase` (actualización e interactivo) — reescritura de historial
`bisect` — debugging por búsqueda binaria sobre commits
`hooks` (`pre-commit`, `commit-msg`, `pre-push`) — automatización de eventos
`submodules` — repositorios anidados
GitFlow vs. GitHub Flow — diseño de flujos de trabajo en equipo


# 🔧 Flujo de trabajo

## Sistema San Rafael (proyecto propio, repo privado)
Sistema de gestión hospitalaria simulado (Python, POO, persistencia JSON) 
desarrollado cuando exploraba backend, antes de enfocarme en infraestructura. 
El código no está pulido a mi nivel actual, pero el flujo de Git sí refleja 
buenas prácticas:

- Una rama `feature/` por módulo (RRHH, clínica, farmacia/facturación, 
  reportes, administración)
- Tags semánticos por hito: `v0.1.0` → `v1.0.0` (release final con suite 
  de tests)
- Commits siguiendo Conventional Commits (`feat:`, `fix:`, `refactor:`, 
  `test:`, `docs:`)
- Integración por fast-forward, uso de `commit --amend` para corregir 
  sin ensuciar el historial

Historial completo: [`sistema-san-rafael-log.txt`](./sistema-san-rafael-log.txt)
