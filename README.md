# 🏗️ Bitácora de Infraestructura

Registro de mi camino de aprendizaje en infraestructura TI — Redes, Linux,
automatización, Contenedores y bases de datos — mientras curso Ingeniería en Informática
(7mo semestre) en Venezuela.

## 🎯 Enfoque

Formación amplia en infraestructura: administración Linux, redes (CCNA),
automatización con Python/Bash, control de versiones, Docker y bases de datos.
Objetivo: estar listo para pasantías o primer empleo en infraestructura TI
(redes, sistemas Linux y automatización) en ~1 año.

Cada tema se documenta con un README y capturas como evidencia de la práctica.

## 📂 Contenido

| Área | Qué hay aquí |
|---|---|
| [`python/`](./python) | Scripts de automatización: auditoría de sistema (módulo 1) e inventario de servidores con `argparse` y JSON (módulo 2) |
| [`bash/`](./bash) | Script de auditoría de directorios con reportes diarios |
| [`linux/`](./linux) | Administración de Ubuntu Server: hora y NTP, diagnóstico de red, nombre y zona horaria, transferencia de archivos y llaves SSH |
| [`git-github/`](./git-github) | Notas y práctica de flujo de trabajo Git avanzado |
| [`sql/`](./sql) | Diseño de una base de datos agrícola propia (DER, modelo relacional y esquema) y consultas complejas |
| [`networking/`](./networking) | Laboratorios de redes en Packet Tracer y GNS3: ACL, NAT, DHCP, Syslog y diagnóstico |
| [`docker/`](./docker) | Próximamente |
| [`bitacora/`](./bitacora) | Avance mensual: [agosto](./bitacora/2026-08.md), [septiembre](./bitacora/2026-09.md) y [octubre](./bitacora/2026-10.md) de 2026 |

## 🐧 Linux Server

Prácticas sobre Ubuntu Server 26.04 LTS en VirtualBox.

| Práctica | Qué se trabaja |
|---|---|
| [`gestion-tiempo-servidor`](./linux/gestion-tiempo-servidor) | Reloj de hardware (RTC) vs. reloj del sistema, sincronización NTP con Chrony |
| [`redes-diagnostico`](./linux/redes-diagnostico) | `ip`, `ping`, `ss` y `tracepath` para diagnosticar la red por capas |
| [`hostname-zona-horaria`](./linux/hostname-zona-horaria) | Nombre del servidor (`hostnamectl`) y zona horaria (`timedatectl`), UTC vs. zona local |
| [`transferencia-archivos-ssh`](./linux/transferencia-archivos-ssh) | Transferencia con Bitvise, `scp` y `rsync` |
| [`llaves-ssh`](./linux/llaves-ssh) | Autenticación por llaves: `ssh-keygen`, `ssh-copy-id` |

## 🌐 Laboratorios de redes

| Laboratorio | Herramienta | Qué se trabaja |
|---|---|---|
| [`acl-estandar`](./networking/acl-estandar) | Packet Tracer | ACL estándar en una topología de malla parcial con RIPv2 |
| [`acl-extendida`](./networking/acl-extendida) | Packet Tracer | ACL extendidas, aislamiento entre departamentos y SSH |
| [`acl-ipv6`](./networking/acl-ipv6) | Packet Tracer | ACL IPv6 con RIPng |
| [`NAT`](./networking/NAT) | Packet Tracer | Los cuatro tipos de NAT en un ISP con seis empresas |
| [`DHCP`](./networking/DHCP) | GNS3 | Servidor DHCP centralizado con relay (`ip helper-address`) |
| [`Syslog`](./networking/Syslog) | GNS3 | Servidor `rsyslog`, RIPv2 y NTP |
| [`recuperacion-passwords`](./networking/recuperacion-passwords) | Documentación | Recuperación de contraseñas en equipos Cisco (ROMMON, `config-register`) |
| [`traceroute_debug`](./networking/traceroute_debug) | GNS3 | `traceroute`, `debug`, CPU y `terminal monitor` por SSH |

## 🛠️ Herramientas

Cisco Packet Tracer · GNS3 · VirtualBox · Ubuntu Server · Debian · Python · Bash · SQL · Git y GitHub

## 🌐 Otros proyectos

Proyecto grande de redes (10 sedes, IPv6, RIPv2, InterVLAN):
[ccna-redven-network-lab →](https://github.com/andersonfermin2020-sudo/ccna-redven-network-lab)

## 📫 Contacto

andersonfermin2020@gmail.com
