# 🔧 Git & GitHub — Flujo de trabajo

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
