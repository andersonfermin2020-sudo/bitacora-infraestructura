-- seed.sql — Datos de prueba para el sistema de gestión agrícola
-- Ejecutar después de schema.sql

-- ========== TERRENO ==========
INSERT INTO terreno (id_terreno, area, ubicacion, tipo_tierra, estado) VALUES
(1, 2.5, 'Sector El Tigre, Guárico', 'Franco-arcillosa', 'activo'),
(2, 1.8, 'Parcela Norte, Guárico', 'Arenosa', 'activo'),
(3, 3.0, 'Sector Los Pinos, Guárico', 'Franco-limosa', 'en_preparacion'),
(4, 0.5, 'Galpón de gallinas, Guárico', 'N/A', 'activo'),
(5, 1.2, 'Parcela Sur, Guárico', 'Franca', 'inactivo');

-- ========== CULTIVO ==========
INSERT INTO cultivo (id_cultivo, nombre, tipo, variedad, tiempo_cosecha, temperatura_min, temperatura_max, requerimiento_agua) VALUES
(1, 'Tomate', 'Hortaliza', 'Río Grande', 80, 18, 30, 'Medio'),
(2, 'Pimentón', 'Hortaliza', 'California Wonder', 90, 18, 28, 'Medio'),
(3, 'Lechuga', 'Hortaliza', 'Great Lakes', 60, 15, 24, 'Alto'),
(4, 'Maíz', 'Cereal', 'Blanco criollo', 110, 20, 32, 'Medio'),
(5, 'Cilantro', 'Hierba aromática', 'Criollo', 45, 15, 27, 'Bajo'),
(6, 'Gallina Ponedora', 'Avícola', 'Isa Brown', 1, 18, 26, 'N/A');

-- ========== SIEMBRA ==========
INSERT INTO siembra (id_siembra, id_terreno, id_cultivo, fecha_siembra, fecha_cosecha, area_sembrada, cantidad_semillas, metodo, estado, observaciones) VALUES
(1, 1, 1, '2026-03-10', '2026-05-30', 1.0, 500,  'Trasplante', 'cosechada', NULL),
(2, 1, 3, '2026-06-05', '2026-08-04', 0.5, 1000, 'Directa',    'cosechada', NULL),
(3, 2, 2, '2026-04-01', NULL,         0.8, 400,  'Trasplante', 'en_curso',  NULL),
(4, 2, 5, '2026-07-01', '2026-08-15', 0.3, 200,  'Directa',    'cosechada', NULL),
(5, 3, 4, '2026-02-15', NULL,         2.0, 1500, 'Directa',    'perdida',   'Plaga de gusano cogollero, pérdida total'),
(6, 4, 6, '2025-11-01', NULL,         NULL, 150, 'Ciclo de postura', 'en_curso', '150 aves ponedoras en producción'),
(7, 5, 1, '2026-01-10', '2026-03-25', 1.2, 600,  'Trasplante', 'cosechada', NULL),
(8, 1, 1, '2026-06-15', NULL,         1.0, 500,  'Trasplante', 'en_curso',  'Segunda siembra de tomate en Terreno 1'),
(9, 3, 4, '2026-05-01', NULL,         2.0, 1500, 'Directa',    'en_curso',  'Resiembra tras pérdida de Siembra 5');

-- ========== INSUMO ==========
INSERT INTO insumo (id_insumo, nombre, tipo, unidad_medida, estado, costo_unitario, cantidad_disponible, fecha_adquisicion, fecha_vencimiento) VALUES
(1, 'Fertilizante NPK 15-15-15',      'Fertilizante', 'kg',    'disponible', 3.50, 200, '2026-01-05', '2027-01-05'),
(2, 'Insecticida Cipermetrina',       'Pesticida',    'litro', 'disponible', 12.00, 30, '2026-02-10', '2027-02-10'),
(3, 'Semilla de Tomate Río Grande',   'Semilla',      'sobre', 'disponible', 1.50, 100, '2026-01-01', '2028-01-01'),
(4, 'Alimento Balanceado Ponedoras',  'Alimento',     'kg',    'disponible', 0.80, 500, '2026-08-01', '2026-12-01'),
(5, 'Vacuna Newcastle',               'Sanitario',    'dosis', 'disponible', 0.50, 200, '2026-01-15', '2027-01-15'),
(6, 'Fungicida Cobre',                'Pesticida',    'kg',    'agotado',    8.00, 0,   '2025-11-01', '2026-11-01'),
(7, 'Cal Agrícola',                   'Enmienda',     'kg',    'disponible', 0.30, 300, '2026-02-01', '2028-02-01'),
(8, 'Fertilizante Foliar Orgánico',   'Fertilizante', 'litro', 'disponible', 5.00, 40,  '2026-03-01', '2026-09-01');

-- ========== APLICACION_INSUMO ==========
INSERT INTO aplicacion_insumo (id_aplicacion, id_siembra, id_insumo, fecha_aplicacion, metodo_aplicacion, cantidad_utilizada, dosis, unidad_medida) VALUES
(1,  1, 1, '2026-03-15', 'Al suelo',  20,  2,   'kg/parcela'),
(2,  1, 2, '2026-04-01', 'Foliar',    5,   0.5, 'litro/parcela'),
(3,  1, 1, '2026-04-20', 'Al suelo',  15,  1.5, 'kg/parcela'),
(4,  2, 7, '2026-06-10', 'Al suelo',  10,  1,   'kg/parcela'),
(5,  3, 1, '2026-04-10', 'Al suelo',  18,  2,   'kg/parcela'),
(6,  3, 6, '2026-04-25', 'Foliar',    3,   0.3, 'kg/parcela'),
(7,  4, 7, '2026-07-05', 'Al suelo',  5,   0.5, 'kg/parcela'),
(8,  5, 2, '2026-03-01', 'Foliar',    8,   0.8, 'litro/parcela'),
(9,  6, 4, '2026-08-05', 'Comedero',  250, 25,  'kg/semana'),
(10, 6, 5, '2026-08-10', 'Inyección', 150, 1,   'dosis/ave'),
(11, 7, 1, '2026-01-20', 'Al suelo',  22,  2,   'kg/parcela'),
(12, 8, 8, '2026-06-20', 'Foliar',    4,   0.4, 'litro/parcela'),
(13, 9, 1, '2026-05-10', 'Al suelo',  25,  2.5, 'kg/parcela');

-- ========== COSECHA ==========
INSERT INTO cosecha (id_cosecha, id_siembra, cantidad_obtenida, calidad, unidad_medida, fecha_cosecha, cantidad_disponible, perdida) VALUES
(1,  1, 450, 'Primera', 'kg',     '2026-05-30', 100, 20),
(2,  2, 300, 'Primera', 'kg',     '2026-08-04', 50,  10),
(3,  4, 60,  'Primera', 'kg',     '2026-08-15', 10,  2),
(4,  7, 520, 'Primera', 'kg',     '2026-03-25', 0,   30),
(5,  6, 140, 'Primera', 'docena', '2026-08-20', 20,  5),
(6,  6, 138, 'Primera', 'docena', '2026-08-27', 18,  6),
(7,  6, 142, 'Primera', 'docena', '2026-09-03', 142, 3),
(8,  1, 30,  'Segunda', 'kg',     '2026-06-05', 0,   5),
(9,  7, 40,  'Segunda', 'kg',     '2026-04-02', 0,   8),
(10, 2, 25,  'Segunda', 'kg',     '2026-08-10', 0,   3);

-- ========== CLIENTE ==========
INSERT INTO cliente (id_cliente, cedula, nombre, apellido, fecha_registro, tipo, telefono, correo, direccion) VALUES
(1, 'V-12345678',   'María', 'Gómez',                      '2026-01-10', 'Minorista', '0414-1234567', 'maria.gomez@example.com',    'Calle Principal, San Juan de los Morros'),
(2, 'V-23456789',   'Carlos','Pérez',                      '2026-02-05', 'Mayorista', '0424-2345678', 'carlos.perez@example.com',   'Av. Bolívar, Calabozo'),
(3, 'V-34567890',   'Ana',   'Rodríguez',                  '2026-01-20', 'Minorista', '0412-3456789', 'ana.rodriguez@example.com',  'Sector La Puerta, Guárico'),
(4, 'J-40012345-6', 'Mercado','Central Guárico C.A.',      '2026-03-01', 'Mayorista', '0246-4567890', 'compras@mercadocentral.com', 'Zona Industrial, San Juan de los Morros'),
(5, 'V-45678901',   'Luis',  'Martínez',                   '2026-04-12', 'Minorista', '0416-5678901', 'luis.martinez@example.com',  'Sector Brisas del Guárico'),
(6, 'V-56789012',   'Rosa',  'Hernández',                  '2026-05-20', 'Minorista', '0414-6789012', 'rosa.hernandez@example.com', 'Calle Miranda, Valle de la Pascua'),
(7, 'V-67890123',   'Jorge', 'Torres',                     '2026-06-30', 'Mayorista', '0424-7890123', 'jorge.torres@example.com',   'Av. Libertador, Zaraza');

-- ========== VENTA ==========
INSERT INTO venta (id_venta, id_cliente, fecha_venta, metodo_pago, estado, monto_total) VALUES
(1,  1, '2026-06-01', 'Efectivo',     'pagada',    120.00),
(2,  2, '2026-06-02', 'Transferencia','pagada',    240.00),
(3,  3, '2026-08-05', 'Efectivo',     'pagada',    225.00),
(4,  4, '2026-08-16', 'Transferencia','pagada',    150.00),
(5,  5, '2026-03-26', 'Efectivo',     'pagada',    330.00),
(6,  1, '2026-04-01', 'Efectivo',     'pagada',    242.00),
(7,  6, '2026-08-21', 'Efectivo',     'pagada',    60.00),
(8,  7, '2026-08-28', 'Transferencia','pendiente', 50.40),
(9,  3, '2026-06-06', 'Efectivo',     'pagada',    24.00),
(10, 1, '2026-08-11', 'Efectivo',     'cancelada', 17.50);

-- ========== DETALLE_VENTA ==========
INSERT INTO detalle_venta (id_cosecha, id_venta, precio_unitario, cantidad_vendida, subtotal) VALUES
(1, 1,  1.20, 100, 120.00),
(1, 2,  1.00, 200, 200.00),
(9, 2,  1.00, 40,  40.00),
(2, 3,  0.90, 250, 225.00),
(3, 4,  2.50, 60,  150.00),
(4, 5,  1.10, 300, 330.00),
(4, 6,  1.10, 220, 242.00),
(5, 7,  3.00, 20,  60.00),
(6, 8,  2.80, 18,  50.40),
(8, 9,  0.80, 30,  24.00),
(10, 10, 0.70, 25, 17.50);

-- ========== Sincronizar secuencias (importante) ==========
-- Como insertamos IDs manualmente, hay que avanzar el contador interno de cada
-- SERIAL para que el próximo INSERT sin ID explícito no choque con estos.
SELECT setval('terreno_id_terreno_seq', (SELECT MAX(id_terreno) FROM terreno));
SELECT setval('cultivo_id_cultivo_seq', (SELECT MAX(id_cultivo) FROM cultivo));
SELECT setval('siembra_id_siembra_seq', (SELECT MAX(id_siembra) FROM siembra));
SELECT setval('insumo_id_insumo_seq', (SELECT MAX(id_insumo) FROM insumo));
SELECT setval('aplicacion_insumo_id_aplicacion_seq', (SELECT MAX(id_aplicacion) FROM aplicacion_insumo));
SELECT setval('cosecha_id_cosecha_seq', (SELECT MAX(id_cosecha) FROM cosecha));
SELECT setval('cliente_id_cliente_seq', (SELECT MAX(id_cliente) FROM cliente));
SELECT setval('venta_id_venta_seq', (SELECT MAX(id_venta) FROM venta));
