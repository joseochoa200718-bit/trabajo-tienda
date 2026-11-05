# Catálogo y base de datos de precios

Base inicial en SQLite para organizar productos y registrar sus precios en una moneda y fecha determinadas.

## Contenido

- `catalogo_precios.sql`: crea las tablas `categorias`, `productos` y `precios`, e incluye un catálogo inicial de modelos/tipos de accesorios.
- Los precios no se precargan porque no se indicó país, moneda ni lista de proveedores. Añade cada precio en `precios`; así puedes conservar cambios históricos sin sobrescribir los anteriores.

## Cómo usarlo

Con SQLite instalado, crea la base de datos ejecutando:

```bash
sqlite3 tienda.db < catalogo_precios.sql
```

Para consultar el catálogo con el precio más reciente registrado por producto:

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

Para agregar un precio, sustituye `1` por el ID del producto y completa precio, moneda y proveedor (si aplica):

```sql
INSERT INTO precios (producto_id, precio, moneda, proveedor, fecha_registro)
VALUES (1, 199.00, 'MXN', 'Proveedor', date('now'));
```

Los precios son ejemplos de formato, no cotizaciones; registra los importes reales de tu mercado y proveedor.
