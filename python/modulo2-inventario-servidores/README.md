# Inventario de Servidores

Dos scripts en Python para crear y gestionar un inventario de servidores 
persistido en JSON — parte del Módulo 2 (Archivos y Configuraciones): 
manipulación de archivos de texto y JSON desde Python.

## Scripts

- [`inventario.py`](./inventario.py) — registra el servidor actual en el 
  inventario, detectando datos reales del sistema (hostname, IP, SO, 
  puertos realmente en escucha vía `ss`).
- [`gestionar_inventario.py`](./gestionar_inventario.py) — CLI con 
  subcomandos para consultar y modificar el inventario ya creado.

## `inventario.py` — qué hace

- Crea `~/python_infra/inventario.json` con estructura inicial si no existe
- Evita duplicados: si el servidor ya está registrado (mismo hostname), 
  avisa y no vuelve a agregarlo
- Detecta puertos realmente abiertos con `ss -tlnp`, no una lista fija — 
  usa `awk` + `grep -oP` para extraer solo los números de puerto de la 
  columna de dirección local, deduplicados con `set()`
- Registra hostname, IP, sistema operativo y fecha vía `subprocess`

## `gestionar_inventario.py` — subcomandos

| Comando | Qué hace |
|---|---|
| `listar` | Tabla resumen de todos los servidores registrados |
| `ver <nombre>` | Detalle completo de un servidor específico |
| `desactivar <nombre>` | Marca un servidor como inactivo |
| `agregar-puerto <nombre> <puerto>` | Agrega un puerto (validado 1–65535) a un servidor, manteniendo la lista ordenada |

## Técnicas demostradas

| Técnica | Dónde |
|---|---|
| Persistencia en JSON (lectura/escritura) | Ambos scripts |
| `argparse` con subcomandos | `gestionar_inventario.py` |
| Clase personalizada heredando de `ArgumentParser` para mensajes de error propios | `MiBuscador` |
| `subprocess` para obtener datos reales del sistema | `inventario.py` |
| Manejo de excepciones (`JSONDecodeError`, `FileNotFoundError`, `CalledProcessError`) | Ambos scripts |
| Prevención de duplicados antes de escribir | `inventario.py` |
| Validación de rango de entrada | `agregar-puerto` |
| Códigos de salida consistentes (`exit(0)` éxito, `exit(1)` error/no-op) | `gestionar_inventario.py` |

## Uso

```bash
# Registrar este servidor en el inventario
python3 inventario.py

# Ver todos los servidores
python3 gestionar_inventario.py listar

# Ver el detalle de uno
python3 gestionar_inventario.py ver <nombre>

# Desactivar un servidor
python3 gestionar_inventario.py desactivar <nombre>

# Agregar un puerto
python3 gestionar_inventario.py agregar-puerto <nombre> <puerto>
```
