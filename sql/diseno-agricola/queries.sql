-- queries.sql — Consultas sobre el esquema agrícola propio
-- Probadas primero en SQLite, migradas a PostgreSQL

-- Cultivos con mayor requerimiento de agua, ordenados por tiempo de cosecha
SELECT * FROM Cultivo
WHERE Requerimiento_Agua = 'Alto'
ORDER BY Tiempo_Cosecha DESC;

-- Siembras marcadas como pérdida y qué cultivo tenían
SELECT s.ID_Siembra, s.ID_Terreno, s.ID_Cultivo, c.Nombre
FROM Siembra s
INNER JOIN Cultivo c ON c.ID_Cultivo = s.ID_Cultivo
WHERE s.Estado = 'perdida';

-- Clientes por tipo (minorista vs mayorista)
SELECT Tipo, COUNT(*) AS Cantidad
FROM Cliente
GROUP BY Tipo;

-- Total cosechado por cultivo
SELECT c.Nombre, SUM(co.Cantidad_Obtenida) AS Total_Kg_Cosechados
FROM Cultivo c
INNER JOIN Siembra s ON c.ID_Cultivo = s.ID_Cultivo
INNER JOIN Cosecha co ON co.ID_Siembra = s.ID_Siembra
GROUP BY c.Nombre
ORDER BY Total_Kg_Cosechados DESC;

-- Insumos que nunca se han aplicado (quedan en inventario sin uso)
SELECT i.Nombre
FROM Insumo i
LEFT JOIN Aplicacion_Insumo a ON i.ID_Insumo = a.ID_Insumo
WHERE a.ID_Aplicacion IS NULL;

-- Siembras con área sembrada por encima del promedio general
SELECT * FROM Siembra
WHERE Area_Sembrada > (SELECT ROUND(AVG(Area_Sembrada), 2) FROM Siembra);

-- Cantidad de siembras por terreno
SELECT t.ID_Terreno, t.Ubicacion, COUNT(s.ID_Siembra) AS Cantidad_Siembra
FROM Terreno t
LEFT JOIN Siembra s ON s.ID_Terreno = t.ID_Terreno
GROUP BY t.ID_Terreno;

-- Clientes con más de una compra pagada y cuánto han gastado en total
SELECT c.Nombre, c.Apellido, SUM(v.Monto_Total) AS Monto_Total_Ventas
FROM Cliente c
INNER JOIN Venta v ON c.ID_Cliente = v.ID_Cliente
WHERE v.Estado = 'pagada'
GROUP BY c.ID_Cliente
HAVING COUNT(v.ID_Venta) > 1;

-- Para cada cultivo, la siembra con mayor área sembrada (subconsulta correlacionada)
SELECT c.Nombre, s.ID_Siembra, s.Area_Sembrada AS Area_Sembrada_Maxima
FROM Cultivo c
INNER JOIN Siembra s ON s.ID_Cultivo = c.ID_Cultivo
WHERE s.Area_Sembrada = (
    SELECT MAX(s2.Area_Sembrada) FROM Siembra s2
    WHERE s2.ID_Cultivo = c.ID_Cultivo
);

-- Insumos cuyo uso total supera el promedio de uso entre todos los insumos aplicados
SELECT ipr.ID_Insumo, ipr.Nombre, ipr.Tipo, ipr.Unidad_Medida, ipr.Costo_Unitario
FROM Insumo ipr
INNER JOIN Aplicacion_Insumo apr ON apr.ID_Insumo = ipr.ID_Insumo
GROUP BY ipr.ID_Insumo
HAVING SUM(apr.Cantidad_Utilizada) > (
    SELECT AVG(Cantidad_Total_Utilizada) FROM (
        SELECT i.ID_Insumo, i.Nombre, SUM(a.Cantidad_Utilizada) AS Cantidad_Total_Utilizada
        FROM Insumo i
        INNER JOIN Aplicacion_Insumo a ON i.ID_Insumo = a.ID_Insumo
        GROUP BY i.ID_Insumo
    ) AS Totales
);

-- Ingreso neto por siembra: dinero generado en ventas menos gasto en insumos
SELECT d.ID_Siembra, d.Cultivo_Sembrado, d.Dinero_Obtenido - g.Gasto_Total AS Ingreso
FROM (
    (SELECT s.ID_Siembra, cu.Nombre AS Cultivo_Sembrado, COALESCE(SUM(dv.Subtotal), 0) AS Dinero_Obtenido
     FROM Siembra s
     INNER JOIN Cultivo cu ON cu.ID_Cultivo = s.ID_Cultivo
     INNER JOIN Cosecha c ON s.ID_Siembra = c.ID_Siembra
     LEFT JOIN Detalle_Venta dv ON dv.ID_Cosecha = c.ID_Cosecha
     GROUP BY s.ID_Siembra, cu.Nombre) d

    INNER JOIN

    (SELECT s.ID_Siembra, COALESCE(SUM(a.Cantidad_Utilizada * i.Costo_Unitario), 0) AS Gasto_Total
     FROM Siembra s
     LEFT JOIN Aplicacion_Insumo a ON a.ID_Siembra = s.ID_Siembra
     LEFT JOIN Insumo i ON i.ID_Insumo = a.ID_Insumo
     GROUP BY s.ID_Siembra) g ON d.ID_Siembra = g.ID_Siembra
)
ORDER BY Ingreso DESC;