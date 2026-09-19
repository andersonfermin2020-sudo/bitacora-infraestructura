#!/bin/bash

# =======================================================================================
# 			SISTEMA DE AUDITORIA DE DIRECTORIOS
# =======================================================================================

# --- Script para analizar un directorio elegido por el usuario y generar un reporte ---

# Usuario ejecutando el script
if [[ "$(id -u)" -ne 0 ]]; then
	echo "[ADVERTENCIA] El usuario ejecutando el script no es el administrador (root)"
	echo
fi
usuario=$(id -un)

# Verificar existencia de comandos a utilizar
comandos=(stat du df find sort tail awk)
for i in "${comandos[@]}"
do
	if ! type "$i" &>/dev/null; then
		echo "[ERROR] $i no esta instalado en el sistema"
		echo "Proceda a instalarlo para continuar con el programa."
		exit 1
	fi
done

# Ruta donde se guardaran los reportes
ruta_registro="$HOME/auditoria_directorio"
mkdir -p "$ruta_registro"

# Pedir al usuario el directorio a analizar
read -rp "Ingrese el directorio a analizar (Especifique ruta completa): " directorio
echo 

# Verificar existencia
if [[ ! -d "$directorio" ]]; then
	echo "[ERROR] No se encontro el directorio '$directorio'"
	echo "Verifique la ruta y vuelva a intentar."
	exit 1
fi

# Analisis del directorio
total_archivos=$(find "$directorio" -maxdepth 1 -type f 2>/dev/null | wc -l)
total_directorios=$(find "$directorio" -maxdepth 1 -mindepth 1 -type d 2>/dev/null | wc -l)
total_enlaces=$(find "$directorio" -maxdepth 1 -type l 2>/dev/null | wc -l)
archivo_mayor=$(find "$directorio" -type f -printf '%s %p\n' 2>/dev/null | sort -n | tail -1)

# Espacio donde esta el directorio
espacio=$(du -sh "$directorio" 2>/dev/null | cut -f1)
espacio_particion=$(df -h "$directorio" 2>/dev/null | awk 'NR==2 {print $4}')

# Mostrar informacion del directorio 
echo "=============================================="
echo "	  INFORMACION DEL DIRECTORIO	"
echo "=============================================="
stat -c "Nombre:		%n
Tipo:		%F
Tamano:		%s bytes
Permisos:	%a
Propietario:	%U
Grupo:		%G
Inodo:		%i
Hard links:	%h
" "$directorio"

# Mostrar analisis del directorio
echo "=============================================="
echo "	   ANALISIS DEL DIRECTORIO	"
echo "=============================================="
echo "Total de archivos: $total_archivos"
echo "Total de directorios: $total_directorios"
echo "Total de enlaces: $total_enlaces"
echo "Archivo mas grande en bytes en todo el arbol: $archivo_mayor"
echo

# Mostrar espacio del directorio
echo "=============================================="
echo "	   ESPACIO DEL DIRECTORIO"
echo "=============================================="
echo "Espacio ocupado: $espacio"
echo "Espacio libre de su particion: $espacio_particion"
echo
# Guardar reporte
fecha_nombre=$(date '+%Y-%m-%d')
nombre_archivo="auditoria_$fecha_nombre.log"
ruta_completa="$ruta_registro/$nombre_archivo"
if [[ ! -e "$ruta_completa" ]]; then
	touch "$ruta_completa"
fi

fecha_log=$(date '+%Y-%m-%d %H:%M:%S')
{
	echo "[$fecha_log] Script iniciado por: $usuario"
	echo "[$fecha_log] Directorio analizado: $directorio"
	echo "[$fecha_log] Archivos regulares: $total_archivos"
	echo "[$fecha_log] Subdirectorios: $total_directorios"
	echo "[$fecha_log] Symlinks: $total_enlaces"	
	echo "[$fecha_log] Archivo mas grande en todo el arbol: $archivo_mayor"
	echo "[$fecha_log] Espacio ocupado: $espacio"
	echo "[$fecha_log] Espacio libre en particion: $espacio_particion"
	echo "[$fecha_log] Auditoria completada"
} >> "$ruta_completa"

echo "==============================================="
echo "	   REPORTE GENERADO"
echo "==============================================="
echo "Reporte generado con exito el dia $fecha_nombre"
echo "Ruta: $ruta_completa"
echo

# Mostrar ultimas 10 lineas del reporte del dia
echo "ULTIMAS 10 LINEAS DEL REPORTE:"
echo
tail -10 "$ruta_completa"
exit 0
