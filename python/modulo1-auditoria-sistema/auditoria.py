# MODULO 1: INTERACCION CON EL SISTEMA OPERATIVO (os, sys, subprocess)

# ===== Script para practicar automatizacion en python

# Modulos 
import os, sys, subprocess
from datetime import datetime

# Verificar un solo argumento
if len(sys.argv) != 2:
    print("[ERROR] Se espera un solo argumento (una ruta existente)")
    print("Ejecucion finalizada.")
    sys.exit(1)

# Verificar existencia de la ruta
if not os.path.exists(sys.argv[1]):
    print("[ERROR] El argumento ingresado debe ser una ruta existente")
    print("Ejecucion finalizada")
    sys.exit(1)

# Funcion para ejecutar comandos externos
def ejecutar_comandos(comando: list | str, shell=False) -> str:
    try:
        ejecucion = subprocess.run(
            comando,
            shell=shell,
            capture_output=True,
            text=True,
            check=True
        )
        resultado = ejecucion.stdout
    except FileNotFoundError:
        resultado = "[ERROR] El comando especificado no existe o no se encontro"
    except subprocess.CalledProcessError as e:
        resultado = f"[ERROR] {e.stderr}"

    return resultado.strip()

# Funcion para detallar contenido de la ruta
def contenido_ruta():
    print(f"\n[DIRECTORIO AUDITADO: '{sys.argv[1]}']")

    contenido = os.listdir(sys.argv[1])
    archivos = 0
    directorios = 0

    for fichero in contenido:
        if os.path.isfile(os.path.join(sys.argv[1], fichero)):
            archivos += 1
        if os.path.isdir(os.path.join(sys.argv[1], fichero)):
            directorios += 1
    
    print(f"Archivos: {archivos}")
    print(f"Directorios: {directorios}")

    print("\n--- Detalle de archivos ---")
    for i in contenido:
        if os.path.isdir(os.path.join(sys.argv[1], i)):
            continue
        ruta_completa = os.path.join(sys.argv[1], i)
        tamanio = os.path.getsize(ruta_completa)
        print(f"{i:<40} {tamanio:>15} bytes")
    print("\n")

# Armar reporte
print("="*60)
print("                 AUDITORIA DEL SISTEMA")
print(f"                  {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
print("="*60)

print("\n[SISTEMA]")
print(f"Hostname: {ejecutar_comandos(['hostname'])}")
print(f"Usuario: {ejecutar_comandos(['whoami'])}")
print(f"IP: {ejecutar_comandos(['hostname', '-I'])}")

print("\n[RECURSOS]")
print("--- Disco ---")
print(ejecutar_comandos(['df', '-h']))
print("\n--- Memoria ---")
print(ejecutar_comandos(['free', '-h']))
print("\n--- Top 3 procesos ---")
print(ejecutar_comandos('ps aux --sort=-%cpu | head -4', shell=True))

contenido_ruta()

print("="*60)
print("                 AUDITORIA COMPLETADA")
print("="*60)
sys.exit(0)