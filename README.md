
# Tienda de maquillaje💄💄

## Descripcion📖
Estamos encargados de diseñar y modelar la base de datos para una tienda de maquillaje que vende productos como cosméticos, cuidado de la piel, perfumes, y accesorios. 
La base de datos debe permitir almacenar información sobre productos, clientes, ventas, empleados y proveedores junto con sus demas tablas subseuentes.


## Características Principales Base de Datos👨🏻‍💻
 1. **Productos**:
    - Cada producto tendrá un identificador único, nombre, descripción, categoría (cosméticos, cuidado de la piel, perfumes, accesorios), precio y stock disponible.
    - Los productos de cosméticos incluirán campos adicionales como el tipo (labial, base, sombra, etc.), tono/color, y fecha de expiración.
    - Los productos de cuidado de la piel tendrán información sobre tipo de piel (seca, grasa, mixta), componentes principales y fecha de expiración.
    - Los perfumes y accesorios también tendrán características específicas (tipo de aroma, tamaño, material, etc.).

2. **Clientes**:
    - Cada cliente debe ser registrado con un identificador único, nombre completo, correo electrónico, dirección y número de teléfono.

3. **Ventas**:
    - Cada venta realizada debe ser registrada con un número único, la fecha de la venta, el cliente que realizó la compra, los productos adquiridos y la cantidad de cada uno.
    - Además, se debe registrar el empleado que atendió la venta.

4. **Empleados**:
    - Los empleados tendrán un identificador único, nombre completo, puesto de trabajo, fecha de contratación, y pueden estar asignados a diferentes áreas (venta, bodega, administración).

5. **Proveedores**:
    - Cada proveedor debe tener un identificador único, nombre de la empresa, nombre del contacto, teléfono y dirección.
    - Se debe llevar un registro de las órdenes de compra realizadas a los proveedores, con los productos solicitados, la fecha de la orden, y la cantidad de productos recibidos.

# Funciones y procedimientos almacenados de acuerdo a las consultas solicitadas 👨🏻‍💻
-- FUNCIONES Y PROCEDIMIENTOS
-- 1 Listar todos los productos de cosméticos de un tipo específico (por ejemplo, "labial").

DELIMITER // 
CREATE PROCEDURE ListarCosmeticoPorTipo(IN TipoCosmetico VARCHAR(50))
BEGIN
    SELECT p.nombre AS NombreProducto
    FROM Producto p
    JOIN Cosmetico c ON p.id_producto = c.id_producto
    WHERE c.tipo = TipoCosmetico;
END//
DELIMITER ;
CALL ListarCosmeticoPorTipo('labial');

-- 2 Obtener todos los productos en una categoría (cosméticos, cuidado de la piel, perfumes, accesorios) cuyo stock sea inferior a un valor dado

DELIMITER $$
CREATE PROCEDURE ProductosStockBajoPorCategoria(IN categoriaID INT, IN stockMinimo INT)
BEGIN
    SELECT p.nombre AS NombreProducto, 
           p.stock AS Stock, 
           c.nombre AS Categoria
    FROM Producto p
    JOIN Categoria c ON p.id_categoria = c.id_categoria
    WHERE p.id_categoria = categoriaID
      AND p.stock < stockMinimo;
END$$
DELIMITER ;

CALL ProductosStockBajoPorCategoria(2, 50);

-- 3. Procedimiento: Mostrar todas las ventas realizadas por un cliente específico en un rango de fechas
DELIMITER $$
CREATE PROCEDURE VentasPorClienteRangoFechas(
    IN clienteID INT, 
    IN fechaInicio DATE, 
    IN fechaFin DATE
)
BEGIN
    SELECT v.id_venta, 
           v.fecha, 
           c.nombre_completo AS Cliente, 
           e.nombre_completo AS Empleado, 
           dv.id_producto, 
           p.nombre AS NombreProducto, 
           dv.cantidad
    FROM Venta v
    JOIN Cliente c ON v.id_cliente = c.id_cliente
    JOIN Empleado e ON v.id_empleado = e.id_empleado
    JOIN Detalle_Venta dv ON v.id_venta = dv.id_venta
    JOIN Producto p ON dv.id_producto = p.id_producto
    WHERE v.id_cliente = clienteID
      AND v.fecha BETWEEN fechaInicio AND fechaFin;
END$$
DELIMITER ;
CALL VentasPorClienteRangoFechas(2, '2024-01-01', '2024-12-31');

-- 4. Función: Calcular el total de ventas realizadas por un empleado en un mes dado
DELIMITER $$
CREATE FUNCTION TotalVentasPorEmpleadoMes(
    empleadoID INT,
    anio INT,
    mes INT
) 
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE totalVentas DECIMAL(10, 2);
    -- Sumar las ventas del empleado en el mes y año dados
    SELECT SUM(dv.cantidad * p.precio) INTO totalVentas
    FROM Venta v
    INNER JOIN Detalle_Venta dv ON v.id_venta = dv.id_venta
    INNER JOIN Producto p ON dv.id_producto = p.id_producto
    WHERE v.id_empleado = empleadoID 
      AND YEAR(v.fecha) = anio 
      AND MONTH(v.fecha) = mes;

    RETURN COALESCE(totalVentas, 0);  -- Retornar 0 si no hay ventas
END $$
DELIMITER ;
SELECT TotalVentasPorEmpleadoMes(1, 2024, 10) AS total_ventas_octubre;

-- 5. Procedimiento: Listar los productos más vendidos en un período determinado
DELIMITER $$
CREATE PROCEDURE ProductosMasVendidos(IN fechaInicio DATE, IN fechaFin DATE)
BEGIN
    SELECT p.nombre, SUM(dv.cantidad) AS total_vendido
    FROM Detalle_Venta dv
    INNER JOIN Producto p ON dv.id_producto = p.id_producto
    INNER JOIN Venta v ON dv.id_venta = v.id_venta
    WHERE v.fecha BETWEEN fechaInicio AND fechaFin
    GROUP BY p.id_producto
    ORDER BY total_vendido DESC;
END $$
DELIMITER ;
CALL ProductosMasVendidos('2024-10-01', '2024-10-31'); 


-- 6. Función: Consultar el stock disponible de un producto por su nombre o identificador
DELIMITER $$
CREATE FUNCTION StockDisponibleProducto(productoID INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE stockDisponible INT;
    SELECT stock INTO stockDisponible FROM Producto WHERE id_producto = productoID;
    RETURN stockDisponible;
END $$
DELIMITER ;
SELECT StockDisponibleProducto(1) AS stock_producto;

-- 7. Procedimiento: Mostrar las órdenes de compra realizadas a un proveedor específico en el último año
DELIMITER $$
CREATE PROCEDURE OrdenesProveedorUltimoAno(IN proveedorID INT)
BEGIN
    SELECT COUNT(*) AS cantidad_ordenes 
    FROM Orden_Compra 
    WHERE id_proveedor = proveedorID AND YEAR(fecha_orden) = YEAR(CURDATE());
END $$
DELIMITER ;
CALL OrdenesProveedorUltimoAno(1);

-- 8. Procedimiento: Listar los empleados que han trabajado más de un año en la tienda

DELIMITER $$
CREATE PROCEDURE EmpleadosmasDeUnAno()
BEGIN
    SELECT nombre_completo, fecha_contratacion 
    FROM Empleado 
    WHERE DATEDIFF(CURDATE(), fecha_contratacion) > 365;
END $$
DELIMITER ;

CALL EmpleadosmasDeUnAno();


-- 9. Función: Obtener la cantidad total de productos vendidos en un día específico

DELIMITER $$
CREATE FUNCTION TotalProductosVendidosEnDia(fechaVenta DATE)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE totalProductosVendidos INT;

    SELECT COALESCE(SUM(dv.cantidad), 0) INTO totalProductosVendidos
    FROM Detalle_Venta dv
    INNER JOIN Venta v ON dv.id_venta = v.id_venta
    WHERE v.fecha = fechaVenta;

    RETURN totalProductosVendidos;
END $$
DELIMITER ;


SELECT TotalProductosVendidosEnDia('2024-10-01') AS total_productos_vendidos;



-- 10. Función: Consultar las ventas de un producto específico (por nombre o ID) y cuántas unidades se vendieron
DELIMITER $$
CREATE FUNCTION VentasDeProducto(productoID INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE totalUnidadesVendidas INT DEFAULT 0; 
    SELECT COALESCE(SUM(dv.cantidad), 0) INTO totalUnidadesVendidas
    FROM Detalle_Venta dv
    INNER JOIN Venta v ON dv.id_venta = v.id_venta  
    WHERE dv.id_producto = productoID;
    RETURN totalUnidadesVendidas;
END $$
DELIMITER ;

SELECT VentasDeProducto(1) AS unidades_vendidas;


# Diagrama E-R 📋
Diagramado de la Base de Datos ⬇️⬇️
![alt text](DER.png)


# Lenguaje

Base de datos en MySQL ![MySQL](https://img.shields.io/badge/mysql-4479A1.svg?style=for-the-badge&logo=mysql&logoColor=white)

# Uso

> [!important]
> Abrir el repositorio y descargar su contenido
> descomprimir el zip 
> Ingresa al programa MySQL Workbench y abre los scripts que se encuentran dentro de la carpeta del repositorio previamente descomprimida
> listo ya se ecuentra dentro de la DB.

# Desarolladores 

Laura Carrillo - Tecnologa en Desarrollo de Sistemas Informaticos
| @cordilauoficial |  ![Instagram](https://img.shields.io/badge/Instagram-%23E4405F.svg?style=for-the-badge&logo=Instagram&logoColor=white)

Felipe Velandia - Camper
| @velandia____ | ![Instagram](https://img.shields.io/badge/Instagram-%23E4405F.svg?style=for-the-badge&logo=Instagram&logoColor=white)
