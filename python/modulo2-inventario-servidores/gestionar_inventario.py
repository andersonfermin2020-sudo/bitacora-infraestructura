# MODULO 2: ARCHIVOS Y CONFIGURACIONES

# --- SCRIPT PARA CONSULTAR Y MODIFICAR EL INVENTARIO DE SERVIDORES

# ==================================================================

import os, sys, argparse, json

# Verificar existencia del archivo 'inventario.py'
carpeta = os.path.join(os.environ.get("HOME"), "python_infra")
ruta = os.path.join(carpeta, "inventario.json")
if not os.path.exists(ruta):
    print("[ERROR] El archivo 'inventario.json' no esta creado en el sistema")
    print("[INFO] Ejecute el script 'inventario.py' para inicializar el inventario")
    sys.exit(0)

# Personalizar mensaje de error por si el usuario ejecuta mal el programa
class MiBuscador(argparse.ArgumentParser):
    def error(self, mensaje):
        print("\n[ERROR] Estas usando mal el programa")
        print("[INFO] Para mas informacion ejecuta: python3 gestionar_inventario.py -h\n")
        sys.exit(1)

# Funcion para abrir y leer el archivo json
def abrir_archivo():
    try:
        with open(ruta, 'r', encoding='utf-8') as archivo:
            return json.load(archivo)
    except json.JSONDecodeError:
        print("[ERROR] El archivo 'inventario.json' esta vacio o tiene un formato JSON invalido.")
        sys.exit(1)

# Funcion para abrir y guardar datos en el archivo json
def guardar_archivo(datos):
    with open(ruta, 'w', encoding='utf-8') as archivo:
        json.dump(datos, archivo, indent=4)

# Definir el parser raiz
parser = MiBuscador(description="Gestion de Inventario")

# Contenedor de comandos
subparser = parser.add_subparsers(dest="subcomando", help="Opciones disponibles")

# Subcomandos disponibles
parser_listar = subparser.add_parser("listar", help="Muestra tabla simple de los datos de los servidores")
parser_ver = subparser.add_parser("ver", help="Muestra todos los datos de un servidor especifico")
parser_desactivar = subparser.add_parser("desactivar", help="Cambia el estado a inactivo de un servidor especifico")
parser_puerto = subparser.add_parser("agregar-puerto", help="Agrega un puerto a un servidor especifico")

# Argumentos de subcomandos
parser_ver.add_argument('nombre_ver', type=str, help="Nombre del servidor para ver sus datos")
parser_desactivar.add_argument('nombre_des', type=str, help="Nombre del servidor a desactivar")
parser_puerto.add_argument('nombre_puerto',type=str, help="Nombre del servidor para agregarle un puerto")
parser_puerto.add_argument('puerto', type=int, help="Puerto a agregar al servidor (ej. 8080)")

# Objeto args
args = parser.parse_args()

# Si no se pasaron argumentos
if not args.subcomando:
    print("[ERROR] No se paso ningun subcomando (ejecutar 'python3 gestionar_inventario.py -h' para mas informacion)")
    sys.exit(1)

# Listar servidores
if args.subcomando == "listar":
    datos_servidores = abrir_archivo()

    if not datos_servidores['servidores']:
        print("[INFO] Actualmente no hay ningun servidor registrado")
        sys.exit(1)

    print(f"{'Nombre':<20} {'IP':<18} {'Activo':<8}")
    print("=" * 48)

    for servidor in datos_servidores['servidores']:
        estado = "Si" if servidor['activo'] else "No"

        print(f"{servidor['nombre']:<20} {servidor['ip']:<18} {estado:<8}")
    sys.exit(0)

# Ver detalles de un servidor
if args.subcomando == "ver":

    # Si no se pasa el nombre la clase 'MiBuscador' lanzara el error
    buscar_nombre = args.nombre_ver

    datos_servidores = abrir_archivo()

    datos_mostrar = None
    for servidor in datos_servidores['servidores']:
        if servidor['nombre'] == buscar_nombre:
            datos_mostrar = servidor
            break

    if datos_mostrar is None:
        print(f"[INFO] No se encontro ningun servidor con el nombre '{buscar_nombre}'")
        sys.exit(1)
    
    if not datos_mostrar.get('puertos_abiertos'):
        puertos_abiertos = "Sin puertos abiertos"
    else:
        puertos_abiertos = ", ".join([str(p) for p in datos_mostrar.get('puertos_abiertos')])
    estado = "Si" if datos_mostrar['activo'] else "No"
    
    print(f"DATOS DEL SERVIDOR '{buscar_nombre}':\n")
    print(f"Nombre: {datos_mostrar.get('nombre')}")
    print(f"IP: {datos_mostrar.get('ip')}")
    print(f"Sistema Operativo: {datos_mostrar.get('sistema_operativo')}")
    print(f"Puertos Abiertos: {puertos_abiertos}")
    print(f"Activo: {estado}")
    print(f"Fecha registro: {datos_mostrar.get('fecha_registro')}")
    sys.exit(0)

# Marcar un servidor como inactivo
if args.subcomando == "desactivar":

    # Si no se pasa el nombre la clase 'MiBuscador' lanzara el error
    buscar_nombre = args.nombre_des

    datos_servidores = abrir_archivo()

    encontrado = False
    for servidor in datos_servidores['servidores']:
        if servidor['nombre'] == buscar_nombre:
            encontrado = True
            if not servidor['activo']:
                print(f"[INFO] El servidor '{buscar_nombre}' ya se encontraba desactivado")
                sys.exit(1)
            else:
                servidor['activo'] = False
                break

    if not encontrado:
        print(f"[INFO] No se encontro ningun servidor con el nombre '{buscar_nombre}'")
        sys.exit(1)

    guardar_archivo(datos_servidores)
    print(f"[INFO] Se desactivo con exito el servidor {buscar_nombre}")
    sys.exit(0)

# Agregar un puerto a un servidor
if args.subcomando == "agregar-puerto":

    # Si no se pasa el nombre ni el puerto la clase 'MiBuscador' lanzara el error
    buscar_nombre = args.nombre_puerto
    puerto_agregar = args.puerto
    
    if not (1 <= puerto_agregar <= 65535):
            print(f"[ERROR] El puerto {puerto_agregar} no es valido (debe estar entre 1 y 65535)")
            sys.exit(1)

    datos_servidores = abrir_archivo()

    encontrado = False
    for servidor in datos_servidores['servidores']:
        if servidor['nombre'] == buscar_nombre:
            encontrado = True
            if puerto_agregar in servidor['puertos_abiertos']:
                print(f"[INFO] El puerto '{puerto_agregar}' ya se encontraba abierto en el servidor '{buscar_nombre}'")
                sys.exit(1)
            else:
                servidor['puertos_abiertos'].append(puerto_agregar)
                servidor['puertos_abiertos'].sort()
                break

    if not encontrado:
        print(f"[INFO] No se encontro ningun servidor con el nombre '{buscar_nombre}'")
        sys.exit(1)

    guardar_archivo(datos_servidores)
    print(f"[INFO] Se agrego con exito el puerto '{puerto_agregar}' al servidor '{buscar_nombre}'")
    sys.exit(0)
