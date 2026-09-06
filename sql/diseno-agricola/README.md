# 🌱 Diseño de Base de Datos — Sistema de Gestión Agrícola

Modelo propio de base de datos relacional para un negocio agrícola real 
(terrenos, siembras, insumos, cosechas y ventas)

## 📐 Proceso de diseño

1. **Diagrama Entidad-Relación (conceptual)** → identificación de entidades 
   y relaciones del negocio, sin pensar aún en implementación
2. **Diagrama Relacional** → traducción a tablas, claves primarias/foráneas, 
   resolución de relaciones N:M
3. **`schema.sql`** → DDL ejecutable en PostgreSQL 17

| Archivo | Contenido |
|---|---|
| [`der.png`](./der.png) | Diagrama conceptual (entidades y relaciones) |
| [`diagrama-relacional.png`](./diagrama-relacional.png) | Tablas con PK/FK definidas |
| [`schema.sql`](./schema.sql) | DDL completo, probado en PostgreSQL |
| [`seed.sql`](./seed.sql) | Datos de prueba (variados: distintos estados, fechas, tipos de cliente) |
| [`queries.sql`](./queries.sql) | Consultas complejas: JOINs, subconsultas correlacionadas, agregaciones anidadas |

## 🧠 Decisiones de diseño

- **`Siembra`** es una entidad intermedia entre `Terreno` y `Cultivo` — 
  permite registrar datos propios de cada ciclo (fecha, método, área) sin 
  mezclarlos con las propiedades fijas del terreno o el cultivo.
- **`Detalle_Venta`** (Cosecha↔Venta) usa clave primaria compuesta 
  (`ID_Cosecha`, `ID_Venta`) — el mismo par no se repite, igual que en 
  `Order Details` de Northwind.
- **`Aplicacion_Insumo`** (Siembra↔Insumo) usa un ID propio en vez de clave 
  compuesta — a diferencia del caso anterior, el mismo insumo puede 
  aplicarse a la misma siembra en fechas distintas, así que es un registro 
  de eventos repetibles, no una asociación única.
- Motor: **PostgreSQL** — tipos estrictos (`NUMERIC` para cantidades y 
  dinero, `CHECK` para estados válidos, `REFERENCES` con integridad 
  referencial activa por defecto).

## 🔍 Próximo

Consultas complejas sobre este esquema, agregadas de forma progresiva.
