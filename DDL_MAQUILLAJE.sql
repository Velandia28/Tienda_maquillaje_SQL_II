CREATE DATABASE TIENDA_YASURI_YAMILE;
USE TIENDA_YASURI_YAMILE;
-- CREACION  Y USO DE LA BASE DE DATOS DE TIENDA_YASURI_YAMILE

CREATE TABLE Categoria (
    id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL
);
-- CREACION TABLA CATEGORIA

CREATE TABLE Producto (
    id_producto INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(100) NOT NULL,
    precio DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL,
    id_categoria INT NOT NULL,
    FOREIGN KEY (id_categoria) REFERENCES Categoria(id_categoria)
);
-- CREACION DE TABLA PRODUCTO 

CREATE TABLE Cosmetico (
    id_cosmetico INT PRIMARY KEY AUTO_INCREMENT,
    id_producto INT NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    tono_color VARCHAR(50) NOT NULL,
    fecha_expiracion DATE NOT NULL,
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);
-- CREACION DE  TABLA ESPECIFICA PARA COSMETICOS

CREATE TABLE Cuidado_Piel (
    id_cuidado_piel INT PRIMARY KEY AUTO_INCREMENT,
    id_producto INT NOT NULL,
    tipo_piel VARCHAR(50) NOT NULL,
    componentes_principales VARCHAR(100) NOT NULL,
    fecha_expiracion DATE NOT NULL,
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);
-- CREACION DE  TABLA ESPECIFICA PARA CUIDADO DE LA PIEL

CREATE TABLE Perfume (
    id_perfume INT PRIMARY KEY AUTO_INCREMENT,
    id_producto INT NOT NULL,
    tipo_aroma VARCHAR(50) NOT NULL,
    tamaño VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);
-- CREACION DE  TABLA ESPECIFICA PARA PERFUMES

CREATE TABLE Accesorio (
    id_accesorio INT PRIMARY KEY AUTO_INCREMENT,
    id_producto INT NOT NULL,
    material VARCHAR(50) NOT  NULL,
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);
-- CREACION DE  TABLA ESPECIFICA PARA ACCESORIOS

CREATE TABLE Cliente (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nombre_completo VARCHAR(150) NOT NULL,
    email VARCHAR(100) NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    telefono VARCHAR(20) NOT NULL
);
-- CREACION DE TABLA CLIENTE 

CREATE TABLE Empleado (
    id_empleado INT PRIMARY KEY AUTO_INCREMENT,
    nombre_completo VARCHAR(150) NOT NULL,
    puesto VARCHAR(100) NOT NULL,
    fecha_contratacion DATE NOT NULL,
    area VARCHAR(50) NOT NULL
);
-- CREACION DE TABLA EMPLEADO 

CREATE TABLE Venta (
    id_venta INT PRIMARY KEY AUTO_INCREMENT,
    fecha DATE NOT NULL,
    id_cliente INT NOT NULL,
    id_empleado INT NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
    FOREIGN KEY (id_empleado) REFERENCES Empleado(id_empleado)
);
-- CREACION DE TABLA VENTA
 
CREATE TABLE Detalle_Venta (
    id_detalle_venta INT PRIMARY KEY AUTO_INCREMENT,
    id_venta INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    FOREIGN KEY (id_venta) REFERENCES Venta(id_venta),
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);
-- CREACION DE LA TABLA INTERMEDIA DE DETALLES DE LA VENTA

CREATE TABLE Proveedor (
    id_proveedor INT PRIMARY KEY AUTO_INCREMENT,
    nombre_empresa VARCHAR(100) NOT NULL,
    nombre_contacto VARCHAR(100) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    direccion VARCHAR(100) NOT NULL
);
-- CREACION DE TABLA PROVEEDOR 

CREATE TABLE Orden_Compra (
    id_orden_compra INT PRIMARY KEY AUTO_INCREMENT,
    id_proveedor INT NOT NULL,
    fecha_orden DATE NOT NULL,
    FOREIGN KEY (id_proveedor) REFERENCES Proveedor(id_proveedor)
);
-- CREACION  DE LA TABLA INTERMEDIA DE ORDEN DE COMPRA

CREATE TABLE Detalle_Orden_Compra (
    id_detalle_orden_compra INT PRIMARY KEY AUTO_INCREMENT,
    id_orden_compra INT NOT NULL, 
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    FOREIGN KEY (id_orden_compra) REFERENCES Orden_Compra(id_orden_compra),
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);
-- CREACION  DE LA TABLA INTERMEDIA DE DETALLES DE ORDEN DE COMPRA