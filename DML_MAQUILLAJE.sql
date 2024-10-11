
INSERT INTO Categoria (nombre) VALUES 
('cosméticos'),
('cuidado de la piel'),
('perfumes'),
('accesorios');

-- Inserciones tabla Categoria

INSERT INTO Producto (nombre, descripcion, precio, stock, id_categoria) VALUES 
('Labial Mate', 'Labial de larga duración', 12.99, 50, 1),
('Base Líquida', 'Base de maquillaje para piel grasa', 18.50, 30, 1), 
('Crema Hidratante', 'Crema para piel seca', 25.00, 20, 2), 
('Perfume Floral', 'Perfume con aroma floral', 45.00, 15, 3), 
('Collar de Plata', 'Collar con diseño minimalista', 60.00, 10, 4); 

-- Inserciones tabla Producto

INSERT INTO Cosmetico (id_producto, tipo, tono_color, fecha_expiracion) VALUES 
(1, 'labial', 'rojo', '2025-06-30'),
(2, 'base', 'beige', '2024-12-31');

-- Inserciones tabla Cosmetico

INSERT INTO Cuidado_Piel (id_producto, tipo_piel, componentes_principales, fecha_expiracion) VALUES 
(3, 'seca', 'ácido hialurónico, aloe vera', '2025-12-31');

-- Inserciones tabla Cuidado Piel

INSERT INTO Perfume (id_producto, tipo_aroma, tamaño) VALUES 
(4, 'floral', '100 ml');

-- Inserciones tabla Perfume

INSERT INTO Accesorio (id_producto, material) VALUES 
(5, 'plata');

-- Inserciones tabla Accesorio

INSERT INTO Cliente (nombre_completo, email, direccion, telefono) VALUES 
('Juan Perez', 'juan.perez@mail.com', 'Av. Central 33', '555-1234567'),
('Maria Gomez', 'maria.gomez@mail.com', 'Calle Flores 45', '555-9876543');

-- inserciones tabla clientes

INSERT INTO Empleado (nombre_completo, puesto, fecha_contratacion, area) VALUES 
('Laura Martinez', 'Vendedor', '2022-03-15', 'ventas'),
('Carlos Lopez', 'Administrador', '2020-10-01', 'administración');

-- inserciones tabla Empleados

INSERT INTO Venta (fecha, id_cliente, id_empleado) VALUES 
('2024-10-01', 1, 1), 
('2024-10-02', 2, 1);

-- inserciones tabla ventas

INSERT INTO Detalle_Venta (id_venta, id_producto, cantidad) VALUES 
(1, 1, 2), 
(1, 4, 6), 
(2, 3, 5), 
(2, 2, 7); 

-- inserciones tabla intermedia de detalle de venta

INSERT INTO Proveedor (nombre_empresa, nombre_contacto, telefono, direccion) VALUES 
('Cosmetic Corp', 'Andrea Torres', '555-4441234', 'Calle Comercio 789'),
('Perfume Distrib', 'Luis Hernandez', '555-3335678', 'Av. Perfumes 101');

-- insercion tabla proveedores

INSERT INTO Orden_Compra (id_proveedor, fecha_orden) VALUES 
(1, '2024-09-15'),
(2, '2024-09-20'); 

-- insercion tabla intermedia de  ordenes de compra

INSERT INTO Detalle_Orden_Compra (id_orden_compra, id_producto, cantidad) VALUES 
(1, 1, 20), 
(1, 2, 15), 
(2, 4, 13); 

-- insercion tabla intermedia de  detalles de orden de compra
