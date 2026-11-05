-- Catálogo inicial de accesorios para tienda de celulares.
-- Compatible con SQLite 3. Las tablas de precios guardan historial; no se
-- inventan importes ni moneda porque deben definirse según mercado/proveedor.

PRAGMA foreign_keys = ON;

CREATE TABLE IF NOT EXISTS categorias (
    id INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS productos (
    id INTEGER PRIMARY KEY,
    categoria_id INTEGER NOT NULL,
    nombre TEXT NOT NULL,
    modelo TEXT NOT NULL,
    material TEXT,
    compatibilidad TEXT NOT NULL DEFAULT 'Universal / especificar modelo al vender',
    descripcion TEXT,
    sku TEXT UNIQUE,
    activo INTEGER NOT NULL DEFAULT 1 CHECK (activo IN (0, 1)),
    FOREIGN KEY (categoria_id) REFERENCES categorias(id)
);

CREATE TABLE IF NOT EXISTS precios (
    id INTEGER PRIMARY KEY,
    producto_id INTEGER NOT NULL,
    precio NUMERIC NOT NULL CHECK (precio >= 0),
    moneda TEXT NOT NULL CHECK (length(moneda) = 3),
    proveedor TEXT,
    fecha_registro TEXT NOT NULL DEFAULT (date('now')),
    notas TEXT,
    FOREIGN KEY (producto_id) REFERENCES productos(id)
);

CREATE INDEX IF NOT EXISTS idx_productos_categoria ON productos(categoria_id);
CREATE INDEX IF NOT EXISTS idx_precios_producto_fecha ON precios(producto_id, fecha_registro DESC);

INSERT OR IGNORE INTO categorias (id, nombre) VALUES
    (1, 'Fundas, cases y forros'),
    (2, 'Protectores de pantalla'),
    (3, 'Accesorios de protección'),
    (4, 'Carga y energía'),
    (5, 'Audio y conectividad'),
    (6, 'Complementos y soportes');

INSERT OR IGNORE INTO productos (id, categoria_id, nombre, modelo, material, compatibilidad, descripcion, sku) VALUES
    (1, 1, 'Funda transparente', 'Case transparente con bordes reforzados', 'TPU flexible', 'Especificar marca y modelo del celular', 'Protección diaria y laterales antiimpacto', 'FUN-TPU-001'),
    (2, 1, 'Funda de silicona', 'Forro de silicona lisa', 'Silicona', 'Especificar marca y modelo del celular', 'Interior suave; varios colores', 'FUN-SIL-001'),
    (3, 1, 'Funda de uso rudo', 'Case rugged antigolpes', 'TPU + policarbonato', 'Especificar marca y modelo del celular', 'Esquinas reforzadas y soporte integrado', 'FUN-RUG-001'),
    (4, 1, 'Funda tipo cartera', 'Case folio con ranuras', 'Cuero sintético', 'Especificar marca y modelo del celular', 'Cubierta frontal y espacio para tarjetas', 'FUN-CAR-001'),
    (5, 1, 'Funda rígida', 'Case slim', 'Policarbonato', 'Especificar marca y modelo del celular', 'Diseño delgado con acabado mate', 'FUN-RIG-001'),
    (6, 1, 'Funda con anillo', 'Case con anillo giratorio', 'TPU + metal', 'Especificar marca y modelo del celular', 'Anillo trasero para agarre o soporte', 'FUN-ANI-001'),
    (7, 2, 'Vidrio templado', 'Protector de pantalla 9H', 'Vidrio templado', 'Especificar marca y modelo del celular', 'Cobertura estándar; validar dimensiones', 'PAN-VT-001'),
    (8, 2, 'Vidrio templado de cobertura completa', 'Full cover 9H', 'Vidrio templado', 'Especificar marca y modelo del celular', 'Bordes curvos o negros según modelo', 'PAN-VTC-001'),
    (9, 2, 'Mica de hidrogel', 'Hidrogel transparente', 'Película de hidrogel', 'Especificar marca y modelo del celular', 'Flexible; se adapta a pantallas curvas', 'PAN-HID-001'),
    (10, 2, 'Mica de hidrogel mate', 'Hidrogel antirreflejante', 'Película de hidrogel', 'Especificar marca y modelo del celular', 'Acabado mate y menor reflejo', 'PAN-HIM-001'),
    (11, 2, 'Protector de privacidad', 'Vidrio privacidad 9H', 'Vidrio templado', 'Especificar marca y modelo del celular', 'Reduce la visibilidad lateral de la pantalla', 'PAN-PRI-001'),
    (12, 2, 'Protector para cámara', 'Lente individual o conjunto', 'Vidrio templado', 'Especificar marca y modelo del celular', 'Protección para lentes traseros', 'PAN-CAM-001'),
    (13, 3, 'Protector de puertos', 'Tapones antipolvo', 'Silicona', 'Universal; verificar tipo de puerto', 'Juego de tapones para puertos y conectores', 'PRO-PUE-001'),
    (14, 3, 'Bolsa impermeable para celular', 'Funda estanca con cierre', 'PVC', 'Universal; confirmar dimensiones', 'Protección contra salpicaduras y polvo', 'PRO-IMP-001'),
    (15, 3, 'Correa para celular', 'Cordón ajustable', 'Nylon / poliéster', 'Universal; compatible con funda con anclaje', 'Correa de mano o cuello', 'PRO-COR-001'),
    (16, 4, 'Cargador de pared USB-C', 'Adaptador de carga rápida 20 W', 'Plástico y componentes electrónicos', 'USB-C; verificar protocolo y dispositivo', 'Adaptador de pared; cable se vende por separado', 'ENE-CAR-020'),
    (17, 4, 'Cargador de pared USB-C', 'Adaptador de carga rápida 30 W', 'Plástico y componentes electrónicos', 'USB-C; verificar protocolo y dispositivo', 'Adaptador de pared de mayor potencia', 'ENE-CAR-030'),
    (18, 4, 'Cable USB-C a USB-C', 'Cable de carga y datos 1 m', 'PVC trenzado', 'USB-C a USB-C', 'Revisar potencia máxima y compatibilidad', 'ENE-CAB-CC1'),
    (19, 4, 'Cable USB-A a USB-C', 'Cable de carga y datos 1 m', 'PVC', 'USB-A a USB-C', 'Carga y transferencia de datos', 'ENE-CAB-AC1'),
    (20, 4, 'Cable USB-C a Lightning', 'Cable de carga y datos 1 m', 'PVC', 'Dispositivos con conector Lightning', 'Verificar certificación y compatibilidad', 'ENE-CAB-CL1'),
    (21, 4, 'Batería externa', 'Power bank 10 000 mAh', 'Plástico y celdas de litio', 'USB-A / USB-C; según versión', 'Capacidad y potencia a confirmar con proveedor', 'ENE-PWB-10K'),
    (22, 4, 'Cargador inalámbrico', 'Base Qi 15 W', 'Plástico', 'Dispositivos compatibles con carga Qi', 'La potencia efectiva depende del dispositivo', 'ENE-QI-015'),
    (23, 4, 'Cargador para automóvil', 'Adaptador dual USB', 'Plástico y componentes electrónicos', 'Toma de 12 V; USB-A / USB-C', 'Potencia depende de la versión', 'ENE-AUT-001'),
    (24, 5, 'Audífonos inalámbricos', 'TWS Bluetooth', 'Plástico', 'Bluetooth; confirmar versión y estuche', 'Audífonos intrauditivos con estuche de carga', 'AUD-TWS-001'),
    (25, 5, 'Audífonos con cable', 'In-ear con micrófono', 'Plástico', 'Conector 3.5 mm o USB-C; elegir variante', 'Micrófono y control integrado según modelo', 'AUD-CAB-001'),
    (26, 5, 'Audífonos de diadema', 'Bluetooth over-ear', 'Plástico y almohadillas sintéticas', 'Bluetooth y/o entrada auxiliar', 'Diadema ajustable; autonomía según fabricante', 'AUD-DIA-001'),
    (27, 5, 'Bocina portátil', 'Altavoz Bluetooth compacto', 'Plástico / tela', 'Bluetooth; verificar potencia y resistencia', 'Batería recargable', 'AUD-BOC-001'),
    (28, 5, 'Adaptador de audio', 'USB-C a 3.5 mm', 'Plástico y componentes electrónicos', 'USB-C; verificar compatibilidad con el equipo', 'Permite conectar audífonos con plug 3.5 mm', 'CON-AUD-001'),
    (29, 5, 'Receptor Bluetooth para automóvil', 'Bluetooth a auxiliar 3.5 mm', 'Plástico', 'Entrada auxiliar 3.5 mm', 'Añade conectividad Bluetooth a equipos compatibles', 'CON-BTA-001'),
    (30, 6, 'Soporte de escritorio', 'Base ajustable para celular', 'Plástico / aluminio', 'Universal; verificar tamaño del dispositivo', 'Ángulo ajustable para escritorio', 'SOP-ESC-001'),
    (31, 6, 'Soporte para automóvil', 'Montaje para rejilla de ventilación', 'Plástico y metal', 'Universal; verificar dimensiones del celular', 'Sujeción para tablero o ventilación según variante', 'SOP-AUT-001'),
    (32, 6, 'Tripié flexible', 'Mini trípode para celular', 'ABS y metal', 'Universal; requiere pinza compatible', 'Patas flexibles y cabezal ajustable', 'SOP-TRI-001'),
    (33, 6, 'Pinza para celular', 'Sujetador ajustable para tripié', 'Plástico', 'Universal; revisar ancho admitido', 'Adaptador de montaje con rosca estándar', 'SOP-PIN-001'),
    (34, 6, 'Anillo de agarre', 'Soporte adhesivo trasero', 'Metal / plástico', 'Universal; verificar uso con carga inalámbrica', 'Mejora el agarre y funciona como soporte', 'SOP-ANI-001');
