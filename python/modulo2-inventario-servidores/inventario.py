# MODULO 2: ARCHIVOS Y CONFIGURACIONES

# --- SCRIPT PARA CREAR EL INVENTARIO DE SERVIDORES A ADMINISTRAR

# ================================================================

import os, subprocess, sys, json

# Crear el archivo 'inventario.json' con estructura inicial si no existe
carpeta = os.path.join(os.environ.get("HOME"), "python_infra")
os.makedirs(carpeta, exist_ok=True)
ruta = os.path.join(carpeta, "inventario.json")
if not os.path.exists(ruta):
    estructura_inicial = {
        "servidores": []
    }

    with open(ruta, "w", encoding="utf-8") as archivo:
        json.dump(estructura_inicial, archivo, indent=4)

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
        resultado = "[ERROR] No se pudo acceder al valor"
    except subprocess.CalledProcessError:
        resultado = "[ERROR] No se pudo acceder al valor"

    return resultado.strip()

# Verificar que el servidor no este registrado en el inventario
with open(ruta, "r", encoding="utf-8") as archivo:
    inventario_servidores = json.load(archivo)

nombre_entrada = ejecutar_comandos(["hostname"])

for servidor in inventario_servidores["servidores"]:
    if servidor['nombre'] == nombre_entrada:
        print("[INFO] Este servidor ya se encuentra registrado en el inventario")
        print("[INFO] Si desea actualizar sus datos ejecute 'gestionar_inventario.py'")
        sys.exit(0)

# Puertos que realmente estan escuchando 
comando = r"ss -tlnp | awk 'NR>1 {print $4}' | grep -oP ':\K\d+'"
try:
    resultado = subprocess.run(
        comando,
        shell=True,
        capture_output=True,
        text=True,
        check=True
    )
    puertos = sorted(list(set(int(p) for p in resultado.stdout.splitlines() if p.strip())))

except FileNotFoundError:
    puertos = []
except subprocess.CalledProcessError:
    puertos = []

# Agregar entrada al inventario
ip_entrada = ejecutar_comandos("hostname -I | awk '{print $1}'", shell=True)
sistema_entrada = ejecutar_comandos(["uname", "-o"])
fecha_entrada = ejecutar_comandos("date '+%Y-%m-%d %H:%M:%S'", shell=True)

entrada = {
    "nombre": nombre_entrada,
    "ip": ip_entrada,
    "sistema_operativo": sistema_entrada,
    "puertos_abiertos": puertos,
    "activo": True,
    "fecha_registro": fecha_entrada
}

inventario_servidores["servidores"].append(entrada)
total_servidores = len(inventario_servidores["servidores"])

with open(ruta, 'w', encoding="utf-8") as archivo:
    json.dump(inventario_servidores, archivo, indent=4)

if not puertos:
    print("[ADVERTENCIA] No se pudo identificar los puertos abiertos del servidor\n")

print(f"Total de servidores registrados: {total_servidores}")

sys.exit(0)