# Auditoría de Sistema

Script en Python que genera un reporte de auditoría de un servidor: 
información del sistema, uso de disco y memoria, procesos con mayor 
consumo de CPU, y un inventario del contenido de un directorio dado — 
parte del Módulo 1 (Interacción con el Sistema Operativo: `os`, `sys`, 
`subprocess`).

## Script

[`auditoria.py`](./auditoria.py)

## Qué hace

- Valida que se reciba exactamente un argumento (una ruta existente) 
  antes de continuar
- Ejecuta comandos externos del sistema (`hostname`, `whoami`, `df`, 
  `free`, `ps`) y captura su salida de forma segura vía `subprocess`
- Reporta hostname, usuario y dirección IP
- Muestra uso de disco (`df -h`) y memoria (`free -h`)
- Lista los 3 procesos con mayor consumo de CPU (`ps aux --sort=-%cpu`)
- Detalla el contenido del directorio recibido como argumento: total de 
  archivos y subdirectorios, más el tamaño individual de cada archivo

## Técnicas demostradas

| Técnica | Dónde |
|---|---|
| Validación de argumentos de línea de comandos (`sys.argv`) | Inicio del script |
| Ejecución de comandos externos con `subprocess.run` | `ejecutar_comandos()` |
| Manejo diferenciado de excepciones (`FileNotFoundError` vs `CalledProcessError`) | `ejecutar_comandos()` |
| Combinación de comandos externos (`shell=True`) con pipes | `ps aux --sort=-%cpu \| head -4` |
| Recorrido de directorios y metadata de archivos | `os.listdir`, `os.path.isfile`, `os.path.getsize` |
| Formato de salida alineado | `contenido_ruta()` |

## Uso

```bash
python3 auditoria.py <ruta_a_analizar>
```
