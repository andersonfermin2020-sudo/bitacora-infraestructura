-- schema.sql — Sistema de gestión agrícola
-- Diseño propio basado en emprendimiento agrícola real

CREATE TABLE Terreno (
    ID_Terreno    SERIAL PRIMARY KEY,
    Area          NUMERIC(10,2) NOT NULL,
    Ubicacion     VARCHAR(255),
    Tipo_Tierra   VARCHAR(50),
    Estado        VARCHAR(20) CHECK (Estado IN ('activo', 'inactivo', 'en_preparacion'))
);

CREATE TABLE Cultivo (
    ID_Cultivo          SERIAL PRIMARY KEY,
    Nombre              VARCHAR(100) NOT NULL,
    Tipo                VARCHAR(50),
    Variedad            VARCHAR(100),
    Tiempo_Cosecha      INTEGER,           -- días estimados
    Temperatura_Min     NUMERIC(4,1),
    Temperatura_Max     NUMERIC(4,1),
    Requerimiento_Agua  VARCHAR(50)
);

CREATE TABLE Siembra (
    ID_Siembra       SERIAL PRIMARY KEY,
    ID_Terreno       INTEGER NOT NULL REFERENCES Terreno(ID_Terreno),
    ID_Cultivo       INTEGER NOT NULL REFERENCES Cultivo(ID_Cultivo),
    Fecha_Siembra    DATE NOT NULL,
    Fecha_Cosecha    DATE,
    Area_Sembrada    NUMERIC(10,2),
    Cantidad_Semillas INTEGER,
    Metodo           VARCHAR(50),
    Estado           VARCHAR(20) CHECK (Estado IN ('en_curso', 'cosechada', 'perdida')),
    Observaciones    TEXT
);

CREATE TABLE Insumo (
    ID_Insumo           SERIAL PRIMARY KEY,
    Nombre              VARCHAR(100) NOT NULL,
    Tipo                VARCHAR(50),
    Unidad_Medida       VARCHAR(20),
    Estado              VARCHAR(20) CHECK (Estado IN ('disponible', 'agotado', 'vencido')),
    Costo_Unitario      NUMERIC(10,2),
    Cantidad_Disponible NUMERIC(10,2),
    Fecha_Adquisicion   DATE,
    Fecha_Vencimiento   DATE
);

CREATE TABLE Aplicacion_Insumo (
    ID_Aplicacion      SERIAL PRIMARY KEY,
    ID_Siembra         INTEGER NOT NULL REFERENCES Siembra(ID_Siembra),
    ID_Insumo          INTEGER NOT NULL REFERENCES Insumo(ID_Insumo),
    Fecha_Aplicacion   DATE NOT NULL,
    Metodo_Aplicacion  VARCHAR(50),
    Cantidad_Utilizada NUMERIC(10,2) NOT NULL,
    Dosis              NUMERIC(10,2),
    Unidad_Medida      VARCHAR(20)
);

CREATE TABLE Cosecha (
    ID_Cosecha          SERIAL PRIMARY KEY,
    ID_Siembra          INTEGER NOT NULL REFERENCES Siembra(ID_Siembra),
    Cantidad_Obtenida   NUMERIC(10,2) NOT NULL,
    Calidad             VARCHAR(20),
    Unidad_Medida       VARCHAR(20),
    Fecha_Cosecha       DATE NOT NULL,
    Cantidad_Disponible NUMERIC(10,2),
    Perdida             NUMERIC(10,2)
);

CREATE TABLE Cliente (
    ID_Cliente     SERIAL PRIMARY KEY,
    Cedula         VARCHAR(20) UNIQUE NOT NULL,
    Nombre         VARCHAR(50) NOT NULL,
    Apellido       VARCHAR(50) NOT NULL,
    Fecha_Registro DATE DEFAULT CURRENT_DATE,
    Tipo           VARCHAR(20),
    Telefono       VARCHAR(20),
    Correo         VARCHAR(100),
    Direccion      TEXT
);

CREATE TABLE Venta (
    ID_Venta     SERIAL PRIMARY KEY,
    ID_Cliente   INTEGER NOT NULL REFERENCES Cliente(ID_Cliente),
    Fecha_Venta  DATE NOT NULL DEFAULT CURRENT_DATE,
    Metodo_Pago  VARCHAR(30),
    Estado       VARCHAR(20) CHECK (Estado IN ('pendiente', 'pagada', 'cancelada')),
    Monto_Total  NUMERIC(10,2)
);

CREATE TABLE Detalle_Venta (
    ID_Cosecha       INTEGER NOT NULL REFERENCES Cosecha(ID_Cosecha),
    ID_Venta         INTEGER NOT NULL REFERENCES Venta(ID_Venta),
    Precio_Unitario  NUMERIC(10,2) NOT NULL,
    Cantidad_Vendida NUMERIC(10,2) NOT NULL,
    Subtotal         NUMERIC(10,2),
    PRIMARY KEY (ID_Cosecha, ID_Venta)
);
