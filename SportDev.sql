DROP DATABASE IF EXISTS sport_development;
 
CREATE DATABASE sport_development;
 
USE sport_development;
 
-- Tablas
 
CREATE TABLE tb_clientes (
    id_cliente INT PRIMARY KEY NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    dui VARCHAR(10) NOT NULL,
    correo VARCHAR(100) NOT NULL,
    telefono VARCHAR(15) NOT NULL,
    nacimiento DATE NOT NULL DEFAULT (CURRENT_DATE()),
    direccion VARCHAR(255) NOT NULL,
    clave_cliente VARCHAR(100) NOT NULL,
    estado_cliente BOOLEAN NOT NULL
);
 
 CREATE TABLE tb_favoritos (
    id_favoritos INT PRIMARY KEY NOT NULL,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE tb_colores (
    id_colores INT PRIMARY KEY NOT NULL,
    nombre VARCHAR(50) NOT NULL
);

 
CREATE TABLE tb_pedidos (
    id_pedido INT PRIMARY KEY NOT NULL,
    id_cliente INT,
    estado_pedido BOOL NOT NULL,
    fecha_pedido DATE NOT NULL DEFAULT (CURRENT_TIME()),
    direccion VARCHAR(255) NOT NULL
);
 
CREATE TABLE tb_detalles_pedidos (
    id_detalle INT PRIMARY KEY NOT NULL,
    id_detalle_producto INT,
    cantidad_producto INT NOT NULL CHECK (cantidad_producto >= 0),
    precio_producto NUMERIC(6,2) NOT NULL CHECK (precio_producto >= 0)
);
 
CREATE TABLE tb_valoraciones (
    id_valoracion INT PRIMARY KEY NOT NULL,
    calificacion_producto ENUM ('1', '2', '3', '4', '5') NOT NULL,
    comentario_producto VARCHAR(255) NOT NULL,
    fecha_valoracion DATE NOT NULL DEFAULT (CURRENT_TIME()),
    estado_comentario BOOLEAN NOT NULL
);
 
CREATE TABLE tb_tallas (
    id_talla INT PRIMARY KEY NOT NULL,
    nombre VARCHAR(5) NOT NULL
);
 
CREATE TABLE tb_detalles_productos (
    id_detalle_producto INT PRIMARY KEY NOT NULL,
    id_producto INT,
    existencias INT NOT NULL CHECK(existencias >= 0),
    id_talla INT
);
 
CREATE TABLE tb_productos (
    id_producto INT PRIMARY KEY NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(250) NOT NULL,
    precio DECIMAL(6,2) NOT NULL CHECK (precio >= 0),
    estado_producto BOOLEAN NOT NULL,
    id_admin INT,
    id_marca INT,
    id_deporte INT,
    id_genero INT,
    id_categoria INT
);
 
CREATE TABLE tb_administradores (
    id_admin INT PRIMARY KEY NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    usuario VARCHAR(50) NOT NULL,
    clave VARCHAR(50) NOT NULL,
    correo VARCHAR(50) NOT NULL,
    cargo ENUM('Administrador','Empleado')
);
CREATE TABLE tb_marcas (
    id_marca INT PRIMARY KEY NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    imagen VARCHAR(255) NOT NULL
);
 
CREATE TABLE tb_deportes (
    id_deporte INT PRIMARY KEY NOT NULL,
    nombre VARCHAR(50) NOT NULL
);
 
CREATE TABLE tb_generos (
    id_genero INT PRIMARY KEY NOT NULL,
    nombre VARCHAR(50) NOT NULL
);
 
CREATE TABLE tb_imagenes (
    id_imagen INT PRIMARY KEY NOT NULL,
    nombre_imagen VARCHAR(25) NOT NULL,
    id_producto INT
);
 
CREATE TABLE tb_categorias (
    id_categoria INT PRIMARY KEY NOT NULL,
    nombre VARCHAR(50) NOT NULL
);



-- Claves foráneas
 
SELECT * FROM tb_detalles_pedidos;
SELECT * FROM tb_detalles_productos;
 
ALTER TABLE tb_pedidos ADD CONSTRAINT fk_id_cliente_pedidos FOREIGN KEY (id_cliente) REFERENCES tb_clientes(id_cliente);

ALTER TABLE tb_detalles_pedidos ADD CONSTRAINT fk_id_detalle_producto_detalles_pedidos FOREIGN KEY (id_detalle_producto) REFERENCES tb_productos (id_producto);

ALTER TABLE tb_valoraciones ADD CONSTRAINT fk_id_detalle_pedido_valoraciones FOREIGN KEY (id_valoracion) REFERENCES tb_detalles_pedidos(id_detalle);

ALTER TABLE tb_detalles_productos ADD CONSTRAINT fk_id_producto_detalles_productos FOREIGN KEY (id_producto) REFERENCES tb_productos(id_producto);
ALTER TABLE tb_detalles_productos ADD CONSTRAINT fk_id_talla_detalles_productos FOREIGN KEY (id_talla) REFERENCES tb_tallas(id_talla);

ALTER TABLE tb_productos ADD CONSTRAINT fk_id_admin_productos FOREIGN KEY (id_admin) REFERENCES tb_administradores(id_admin);
ALTER TABLE tb_productos ADD CONSTRAINT fk_id_marca_productos FOREIGN KEY (id_marca) REFERENCES tb_marcas(id_marca);
ALTER TABLE tb_productos ADD CONSTRAINT fk_id_deporte_productos FOREIGN KEY (id_deporte) REFERENCES tb_deportes(id_deporte);
ALTER TABLE tb_productos ADD CONSTRAINT fk_id_genero_productos FOREIGN KEY (id_genero) REFERENCES tb_generos(id_genero);
ALTER TABLE tb_productos ADD CONSTRAINT fk_id_categoria_productos FOREIGN KEY (id_categoria) REFERENCES tb_categorias(id_categoria);

ALTER TABLE tb_imagenes ADD CONSTRAINT fk_id_producto_imagenes FOREIGN KEY (id_producto) REFERENCES tb_productos(id_producto);
 
 
-- Claves unicas
 
ALTER TABLE tb_clientes ADD CONSTRAINT uni_dui_clientes UNIQUE(dui);
 
ALTER TABLE tb_clientes ADD CONSTRAINT uni_correo_clientes UNIQUE(correo);
 
ALTER TABLE tb_administradores ADD CONSTRAINT uni_usuario_administradores UNIQUE(usuario);
 
ALTER TABLE tb_administradores ADD CONSTRAINT uni_correo_administradores UNIQUE(correo);
 

-- TRIGGGERS
DELIMITER //
CREATE TRIGGER before_insert_tb_pedidos
BEFORE INSERT ON tb_pedidos
FOR EACH ROW
SET NEW.fecha_pedido = CURRENT_DATE();
//
DELIMITER ;

 
-- PROCEDIMIENTOS ALMACENADOS
DELIMITER //
CREATE PROCEDURE insertar_marcas (IN id INT, IN nom_marca VARCHAR (150))
BEGIN
INSERT INTO tb_marcas (id_marca, nombre) VALUES (id, nom_marca);
END
// DELIMITER ;
CALL insertar_marcas (100, 'Reebok');
SELECT * FROM tb_marcas;
 
DELIMITER //
CREATE PROCEDURE actualizar_marcas (IN id INT, IN nom_marca VARCHAR (150))
BEGIN
UPDATE tb_marcas
SET nombre = nom_marca WHERE id_marca = id;
END
// DELIMITER ;
 
CALL actualizar_marcas (100, 'Channel');
SELECT * FROM tb_marcas;
 
-- FUNCIONES
DELIMITER //
CREATE FUNCTION calcular_precio_total(pedido_id INT) RETURNS DECIMAL(8,2) 
DETERMINISTIC 
READS SQL DATA
BEGIN 
    DECLARE total DECIMAL(8,2); 
    SELECT SUM(dp.cantidad_producto * dp.precio_producto) INTO total 
    FROM tb_detalles_pedidos dp 
    WHERE dp.id_detalle = pedido_id; 
    RETURN total; 
END;

//

DELIMITER ;
 
-- Inserts
INSERT INTO tb_clientes VALUES 
(1, 'Dennis', 'Gonzalez', '11111111', 'correo1@gmail.com', '1111-1111', '2000-01-01','Calle Principal 1', 'contraseña1', true),
(2, 'Jose', 'Catillo', '22222222', 'correo2@gmail.com', '2222-2222', '2001-02-02', 'Calle Secundaria 2', 'contraseña2', true),
(3, 'Cesar', 'Martínez', '33333333', 'correo3@gmail.com', '3333-3333', '2002-03-03', 'Avenida Principal 3', 'contraseña3', true),
(4, 'Daniel', 'Rodríguez', '44444444', 'correo4@gmail.com', '4444-4444', '2003-04-04', 'Calle A 4', 'contraseña4', true),
(5, 'Sagas', 'López', '55555555', 'correo5@gmail.com', '5555-5555', '2004-05-05', 'Calle B 5', 'contraseña5', true),
(6, 'Rocio', 'Flores', '66666666', 'correo6@gmail.com', '6666-6666', '2005-06-06', 'Calle C 6', 'contraseña6', true),
(7, 'Jhonny', 'Pérez', '77777777', 'correo7@gmail.com', '7777-7777', '2006-07-07', 'Calle D 7', 'contraseña7', true),
(8, 'Franco', 'Gómez', '88888888', 'correo8@gmail.com', '8888-8888', '2007-08-08', 'Avenida Principal 8', 'contraseña8', true),
(9, 'Bryan', 'Ramírez', '99999999', 'correo9@gmail.com', '9999-9999', '2008-09-09', 'Calle Secundaria 9', 'contraseña9', true),
(10, 'Carranza', 'Castro', '10101010', 'correo10@gmail.com', '1010-1010', '2009-10-10', 'Calle E 10', 'contraseña10', true),
(11, 'Wilfredo', 'Molina', '11111112', 'correo11@gmail.com', '1112-1112', '2010-11-11', 'Calle Principal 11', 'contraseña11', true),
(12, 'Anderson', 'Serrano', '11111113', 'correo12@gmail.com', '1113-1113', '2011-12-12', 'Calle Secundaria 12', 'contraseña12', true),
(13, 'Francisco', 'Castillo', '11111114', 'correo13@gmail.com', '1114-1114', '2012-01-13', 'Avenida Principal 13', 'contraseña13', true),
(14, 'Ricardo', 'Flores', '11111115', 'correo14@gmail.com', '1115-1115', '2013-02-14', 'Calle A 14', 'contraseña14', true),
(15, 'Karla', 'Hernández', '11111116', 'correo15@gmail.com', '1116-1116', '2014-03-15', 'Calle B 15', 'contraseña15', true),
(16, 'José', 'Gómez', '11111117', 'correo16@gmail.com', '1117-1117', '2015-04-16', 'Calle C 16', 'contraseña16', true),
(17, 'Vanessa', 'Molina', '11111118', 'correo17@gmail.com', '1118-1118', '2016-05-17', 'Calle D 17', 'contraseña17', true),
(18, 'Carlos', 'Martínez', '11111119', 'correo18@gmail.com', '1119-1119', '2017-06-18', 'Avenida Principal 18', 'contraseña18', true),
(19, 'Gabriela', 'Serrano', '11111120', 'correo19@gmail.com', '1120-1120', '2018-07-19', 'Calle Secundaria 19', 'contraseña19', true),
(20, 'Alejandro', 'Castillo', '11111121', 'correo20@gmail.com', '1121-1121', '2019-08-20', 'Calle E 20', 'contraseña20', true),
(21, 'Claudia', 'López', '11111122', 'correo21@gmail.com', '1122-1122', '2019-08-20', 'Calle Principal 21', 'contraseña21', true),
(22, 'Francisco', 'Flores', '11111123', 'correo22@gmail.com', '1123-1123', '2019-08-20', 'Calle Secundaria 22', 'contraseña22', true),
(23, 'Lenny', 'Electra', '11111124', 'correo23@gmail.com', '1124-1124', '2019-08-20', 'Avenida Principal 23', 'contraseña23', true),
(24, 'Raul', 'González', '11111125', 'correo24@gmail.com', '1125-1125', '2019-08-20', 'Calle A 24', 'contraseña24', true),
(25, 'Claudia', 'Lars', '11111126', 'correo25@gmail.com', '1126-1126', '2019-08-20', 'Calle B 25', 'contraseña25', true);
 
 
INSERT INTO tb_administradores VALUES 
(1, 'Natael', 'Cano', 'Gerente', '12345', 'correo789@gmail.com', 'Administrador'),
(2, 'Jesus', 'Ortiz', 'Supervisor', '12345', 'correo3545@gmail.com', 'Empleado'),
(3, 'Gabito', 'Ballesteros', 'Asistente', '12345', 'correo2455@gmail.com', 'Empleado');

 
INSERT INTO tb_marcas VALUES 
(1, 'Nike'),
(2, 'Adidas'),
(3, 'Puma'),
(4, 'Under Armour'),
(5, 'New Balance');
 
INSERT INTO tb_deportes VALUES 
(1, 'Correr'),
(2, 'Baloncesto'),
(3, 'Fútbol'),
(4, 'Tenis'),
(5, 'Ciclismo');
 
INSERT INTO tb_generos VALUES 
(1, 'Hombres'),
(2, 'Mujeres'),
(3, 'Unisex');
 
INSERT INTO tb_categorias VALUES 
(1, 'Calzado'),
(2, 'Accesorios'),
(3, 'Ropa');

INSERT INTO tb_productos VALUES 
(1, 'Zapatos para correr', 'Zapatos cómodos para correr', 89.99, true, 1, 1, 1, 1, 1),
(2, 'Baloncesto', 'Tamaño y peso oficial', 29.99, true, 1, 2, 2, 2, 2),
(3, 'Camiseta de algodón', 'Camiseta casual de algodón', 19.99, true, 2, 1, 3, 1, 1),
(4, 'Pantalones deportivos', 'Pantalones deportivos cómodos', 39.99, true, 2, 2, 1, 2, 2),
(5, 'Gorra de béisbol', 'Gorra de béisbol ajustable', 14.99, true, 3, 1, 2, 2, 1),
(6, 'Calcetines deportivos', 'Calcetines transpirables para deportes', 9.99, true, 3, 2, 3, 1, 3),
(7, 'Balón de fútbol', 'Balón de fútbol tamaño oficial', 24.99, true, 1, 1, 1, 2, 2),
(8, 'Chaqueta impermeable', 'Chaqueta impermeable para actividades al aire libre', 49.99, true, 3, 2, 2, 1, 1),
(9, 'Raqueta de tenis', 'Raqueta de tenis profesional', 89.99, true, 2, 1, 3, 2, 2),
(10, 'Gafas de ciclismo', 'Gafas deportivas para ciclismo', 34.99, true, 1, 2, 1, 1, 3),
(11, 'Mallas de entrenamiento', 'Mallas elásticas para entrenamiento', 29.99, true, 1, 3, 2, 2, 1),
(12, 'Sudadera con capucha', 'Sudadera cómoda con capucha', 39.99, true, 1, 1, 3, 1, 2),
(13, 'Bolso de deporte', 'Bolso espacioso para artículos deportivos', 19.99, true, 2, 2, 1, 2, 3),
(14, 'Guantes de portero', 'Guantes profesionales para portero', 49.99, true, 2, 1, 2, 1, 1),
(15, 'Pelota de golf', 'Pelota de golf de alta calidad', 14.99, true, 3, 2, 3, 2, 2),
(16, 'Reloj deportivo', 'Reloj resistente al agua para actividades deportivas', 79.99, true, 3, 1, 1, 1, 3),
(17, 'Cuerda para saltar', 'Cuerda ajustable para entrenamiento cardiovascular', 9.99, true, 1, 2, 2, 2, 1),
(18, 'Casco para ciclismo', 'Casco ligero y seguro para ciclistas', 39.99, true, 2, 1, 3, 1, 2),
(19, 'Botella de agua deportiva', 'Botella de agua con diseño ergonómico', 7.99, true, 2, 2, 1, 2, 3),
(20, 'Cinta de correr plegable', 'Cinta de correr para entrenamiento en casa', 299.99, true, 3, 1, 2, 1, 1),
(21, 'Bicicleta estática', 'Bicicleta estática para ejercicio en interiores', 199.99, true, 1, 3, 3, 2, 2),
(22, 'Mochila de senderismo', 'Mochila resistente para senderismo', 59.99, true, 1, 1, 1, 1, 3),
(23, 'Gorro de natación', 'Gorro de natación cómodo y duradero', 12.99, true, 2, 2, 2, 2, 1),
(24, 'Bolsa de golf', 'Bolsa de golf con múltiples compartimentos', 79.99, true, 2, 1, 3, 1, 2),
(25, 'Colchoneta de yoga', 'Colchoneta antideslizante para yoga', 24.99, true, 3, 2, 1, 2, 3);

 
INSERT INTO tb_imagenes VALUES 
(1, 'zapato1.jpg', 1),
(2, 'balon1.jpg', 2),
(3, 'camiseta1.jpg', 3),
(4, 'pantalon1.jpg', 4),
(5, 'gorra1.jpg', 5),
(6, 'calcetines1.jpg', 6),
(7, 'balon2.jpg', 7),
(8, 'chaqueta1.jpg', 8),
(9, 'raqueta1.jpg', 9),
(10, 'gafas1.jpg', 10),
(11, 'mallas1.jpg', 11),
(12, 'sudadera1.jpg', 12),
(13, 'bolso1.jpg', 13),
(14, 'guantes1.jpg', 14),
(15, 'pelota1.jpg', 15),
(16, 'reloj1.jpg', 16),
(17, 'cuerda1.jpg', 17),
(18, 'casco1.jpg', 18),
(19, 'botella1.jpg', 19),
(20, 'cinta1.jpg', 20),
(21, 'bicicleta1.jpg', 21),
(22, 'mochila1.jpg', 22),
(23, 'gorro1.jpg', 23),
(24, 'bolsa1.jpg', 24),
(25, 'colchoneta1.jpg', 25);
 
INSERT INTO tb_pedidos VALUES 
(1, 1, true, '2024-03-06', 'Calle A 123'),
(2, 2, false, '2024-03-05', 'Calle B 456'),
(3, 3, true, '2024-03-04', 'Calle C 789'),
(4, 4, false, '2024-03-03', 'Calle D 012'),
(5, 5, true, '2024-03-02', 'Calle E 345'),
(6, 6, false, '2024-03-01', 'Calle F 678'),
(7, 7, true, '2024-02-29', 'Calle G 901'),
(8, 8, false, '2024-02-28', 'Calle H 234'),
(9, 9, true, '2024-02-27', 'Calle I 567'),
(10, 10, false, '2024-02-26', 'Calle J 890'),
(11, 11, true, '2024-02-25', 'Calle K 123'),
(12, 12, false, '2024-02-24', 'Calle L 456'),
(13, 13, true, '2024-02-23', 'Calle M 789'),
(14, 14, false, '2024-02-22', 'Calle N 012'),
(15, 15, true, '2024-02-21', 'Calle O 345'),
(16, 16, false, '2024-02-20', 'Calle P 678'),
(17, 17, true, '2024-02-19', 'Calle Q 901'),
(18, 18, false, '2024-02-18', 'Calle R 234'),
(19, 19, true, '2024-02-17', 'Calle S 567'),
(20, 20, false, '2024-02-16', 'Calle T 890'),
(21, 21, true, '2024-02-15', 'Calle U 123'),
(22, 22, false, '2024-02-14', 'Calle V 456'),
(23, 23, true, '2024-02-13', 'Calle W 789'),
(24, 24, false, '2024-02-12', 'Calle X 012'),
(25, 25, true, '2024-02-11', 'Calle Y 345');
 
INSERT INTO tb_detalles_pedidos VALUES
(1, 1, 2, 50.00),
(2, 2, 1, 30.00),
(3, 3, 3, 20.00),
(4, 4, 1, 40.00),
(5, 5, 2, 25.00),
(6, 6, 4, 35.00),
(7, 7, 2, 15.00),
(8, 8, 1, 28.00),
(9, 9, 3, 22.50),
(10, 10, 1, 18.00),
(11, 11, 2, 42.00),
(12, 12, 5, 30.00),
(13, 13, 1, 20.50),
(14, 14, 3, 27.00),
(15, 15, 2, 23.75),
(16, 16, 4, 31.20),
(17, 17, 1, 19.99),
(18, 18, 3, 25.50),
(19, 19, 2, 37.80),
(20, 20, 1, 22.00),
(21, 21, 2, 40.00),
(22, 22, 4, 18.50),
(23, 23, 1, 33.75),
(24, 24, 3, 26.80),
(25, 25, 2, 21.00);

 
INSERT INTO tb_valoraciones VALUES 
(1, 4, '¡Gran producto!', '2024-03-04', true),
(2, 5, 'Calidad excelente', '2024-03-03', true),
(3, 3, 'Buen producto', '2024-03-02', true),
(4, 5, '¡Me encanta!', '2024-03-01', true),
(5, 2, 'No está mal', '2024-02-29', true),
(6, 4, 'Muy satisfecho con la compra', '2024-02-28', true),
(7, 3, 'Buena relación calidad-precio', '2024-02-27', true),
(8, 5, '¡Recomendado!', '2024-02-26', true),
(9, 4, 'Excelente servicio al cliente', '2024-02-25', true),
(10, 2, 'Producto recibido en buen estado', '2024-02-24', true),
(11, 5, '¡Increíble calidad!', '2024-02-23', true),
(12, 3, 'Cumple con mis expectativas', '2024-02-22', true),
(13, 4, 'Envío rápido', '2024-02-21', true),
(14, 5, 'Mejor de lo esperado', '2024-02-20', true),
(15, 3, 'Buena atención al cliente', '2024-02-19', true),
(16, 4, 'Lo volvería a comprar', '2024-02-18', true),
(17, 5, '¡Fantástico!', '2024-02-17', true),
(18, 3, 'Satisfecho con la compra', '2024-02-16', true),
(19, 4, 'Buena variedad de productos', '2024-02-15', true),
(20, 5, 'Envío seguro y rápido', '2024-02-14', true),
(21, 3, 'Producto de calidad', '2024-02-13', true),
(22, 4, 'Muy recomendable', '2024-02-12', true),
(23, 5, 'Perfecto para mis necesidades', '2024-02-11', true),
(24, 3, 'Buen servicio postventa', '2024-02-10', true),
(25, 4, 'Precio justo', '2024-02-09', true);
 
INSERT INTO tb_tallas VALUES 
(1, 'S'),
(2, 'M'),
(3, 'L'),
(4, 'XL'),
(5, 'XXL');

INSERT INTO tb_detalles_productos VALUES
(1, 1, 10, 1),
(2, 2, 15, 2),
(3, 3, 20, 3),
(4, 4, 25, 4),
(5, 5, 10, 5),
(6, 6, 18, 1),
(7, 7, 30, 2),
(8, 8, 22, 3),
(9, 9, 27, 4),
(10, 10, 14, 5),
(11, 11, 20, 1),
(12, 12, 32, 2),
(13, 13, 15, 3),
(14, 14, 28, 4),
(15, 15, 19, 5),
(16, 16, 24, 1),
(17, 17, 36, 2),
(18, 18, 16, 3),
(19, 19, 29, 4),
(20, 20, 21, 5),
(21, 21, 25, 1),
(22, 22, 12, 2),
(23, 23, 33, 3),
(24, 24, 17, 4),
(25, 25, 8, 1);


SELECT * FROM tb_clientes;

SELECT * FROM tb_pedidos;

SELECT * FROM tb_detalles_pedidos;

SELECT * FROM tb_valoraciones;

SELECT * FROM tb_tallas;

SELECT * FROM tb_detalles_productos;

SELECT * FROM tb_productos;

SELECT * FROM tb_administradores;

SELECT * FROM tb_marcas;

SELECT * FROM tb_deportes;

SELECT * FROM tb_generos;

SELECT * FROM tb_imagenes;

SELECT * FROM tb_categorias;

 
