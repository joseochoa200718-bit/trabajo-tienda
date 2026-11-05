# Catálogo y base de datos de precios

Este repositorio contiene una base inicial en SQLite para organizar productos y registrar sus precios en una moneda y fecha determinadas, además de una presentación visual de los modelos.

## Presentación visual

Abre [`index.html`](index.html) en un navegador para ver el catálogo por categorías, con tarjetas de producto, modelo, material o tipo y compatibilidad. Los precios aparecen como **“Por registrar”** porque no se indicó país, moneda ni lista de proveedores; no se inventaron cotizaciones.

## Base de datos

- `catalogo_precios.sql`: crea las tablas `categorias`, `productos` y `precios`, e incluye un catálogo inicial de modelos/tipos de accesorios.
- La tabla `precios` conserva el historial: registra un nuevo precio cuando cambie en lugar de reemplazar el anterior.

### Crear la base de datos

Con SQLite instalado, ejecuta:

```bash
sqlite3 tienda.db < catalogo_precios.sql
```

### Consultar el catálogo con el precio más reciente

```sql
SELECT c.nombre AS categoria, p.nombre AS producto, p.modelo,
       pr.precio, pr.moneda, pr.fecha_registro
FROM productos p
JOIN categorias c ON c.id = p.categoria_id
LEFT JOIN precios pr ON pr.id = (
    SELECT id FROM precios
    WHERE producto_id = p.id
    ORDER BY fecha_registro DESC, id DESC
    LIMIT 1
)
ORDER BY c.nombre, p.nombre;
```

### Registrar un precio

Sustituye `1` por el ID real del producto e indica precio, moneda y proveedor cuando aplique:

```sql
INSERT INTO precios (producto_id, precio, moneda, proveedor, fecha_registro)
VALUES (1, 199.00, 'MXN', 'Proveedor', date('now'));
```

El importe es solo un ejemplo de formato, no una cotización. Registra el valor real del mercado y proveedor local.
