DROP TABLE clientes CASCADE CONSTRAINT;

//Modificar tabla

ALTER TABLE compras
ADD CONSTRAINT fk_compra_cliente FOREIGN KEY (cliente) REFERENCES clientes(dni);

ALTER TABLE clientes
ADD telefono NUMBER(9);

ALTER TABLE trabajadores
ADD telefono NUMBER(9);

ALTER TABLE productos
DROP COLUMN stock;

ALTER TABLE clientes
MODIFY telefono CHECK (telefono >= 600000000);

ALTER TABLE trabajadores
MODIFY telefono CHECK (telefono >= 600000000);

ALTER TABLE productos
MODIFY precio DEFAULT 0;

ALTER TABLE productos
ADD stock NUMBER(6) NOT NULL;

ALTER TABLE productos MODIFY
(
    stock CHECK (stock >= 0),
    precio CHECK (precio >=0 AND precio <= 10)
);

ALTER TABLE tiendas ADD
(
    nombre VARCHAR(30),
    localizacion VARCHAR2(20)
);

CREATE TABLE clientes
(
    dni VARCHAR(9) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    fecha_nac DATE NOT NULL,
    direccion VARCHAR2(100),
    sexo VARCHAR2(1) CHECK (sexo IN('H', 'M'))
);

//Poner info

INSERT INTO clientes (dni, nombre, fecha_nac, direccion, sexo) VALUES ('11111111Z', 'Lucia', '12/05/2002', 'Granada', 'M');
INSERT INTO clientes (dni, nombre, fecha_nac, direccion, sexo) VALUES ('22222222B', 'Monica', '18/12/2008', 'Jaén', 'M');
INSERT INTO clientes (dni, nombre, fecha_nac, direccion, sexo) VALUES ('12345678C', 'Luis', '03/01/2005', 'Granada', 'H');
INSERT INTO clientes (dni, nombre, fecha_nac, direccion, sexo) VALUES ('33333333R', 'Cesar', '08/09/2003', 'Granada', 'H');
INSERT INTO clientes (dni, nombre, fecha_nac, direccion, sexo) VALUES ('55555555T', 'Roberto', '24/11/2008', 'Malaga', 'H');

CREATE TABLE productos
(
    cod_prod NUMBER(5) PRIMARY KEY,
    nombre VARCHAR(50) UNIQUE NOT NULL,
    stock NUMBER(6) NOT NULL,
    precio NUMBER(4,2) NOT NULL,
    tipo VARCHAR2(20) NOT NULL
);

//Poner info

INSERT INTO productos VALUES (1, 'Lápiz negro', 100, 0.75, '1');
INSERT INTO productos VALUES (2, 'Bolígrafo azul', 85, 0, '1');
INSERT INTO productos VALUES (3, 'Libreta A4', 60, 1.75, '2');
INSERT INTO productos VALUES (4, 'Cuaderno rubio', 50, 3.25, '2');
INSERT INTO productos VALUES (5, 'Corrector', 86, 0, '3');
INSERT INTO productos VALUES (6, 'Goma borrar', 150, 0.35, '3');

CREATE TABLE compras
(
    cliente VARCHAR(9),
    producto NUMBER(5),
    fecha DATE,
    cantidad VARCHAR2(3) NOT NULL,
    
    CONSTRAINT pk_compras PRIMARY KEY (cliente, producto, fecha),
    CONSTRAINT fk_compra_cliente FOREIGN KEY (cliente) REFERENCES clientes(dni),
    CONSTRAINT fk_compra_producto FOREIGN KEY (producto) REFERENCES productos (cod_prod)
);

//Poner info

INSERT INTO compras VALUES ('11111111Z', 1, '25/10/2023', '2');
INSERT INTO compras VALUES ('12345678C', 1, '26/10/2023', '1');
INSERT INTO compras VALUES ('11111111Z', 2, '25/10/2023', '4');
INSERT INTO compras VALUES ('55555555T', 2, '26/10/2023', '3');
INSERT INTO compras VALUES ('11111111Z', 3, '26/10/2023', '1');
INSERT INTO compras VALUES ('12345678C', 4, '26/10/2023', '1');
INSERT INTO compras VALUES ('33333333R', 2, '25/10/2023', '6');
INSERT INTO compras VALUES ('11111111Z', 1, '30/10/2023', '5');
INSERT INTO compras VALUES ('12345678C', 3, '02/11/2023', '2');
INSERT INTO compras VALUES ('12345678C', 4, '30/10/2023', '1');
INSERT INTO compras VALUES ('33333333R', 1, '25/10/2023', '4');
INSERT INTO compras VALUES ('55555555T', 2, '30/10/2023', '3');
INSERT INTO compras VALUES ('55555555T', 3, '30/10/2023', '1');
INSERT INTO compras VALUES ('55555555T', 3, '02/11/2023', '2');
INSERT INTO compras VALUES ('12345678C', 4, '02/11/2023', '2');

//Borrar datos

DELETE FROM compras;
DELETE FROM clientes WHERE direccion='Malaga';
DELETE FROM productos WHERE precio<1;
DELETE FROM clientes WHERE sexo='H';
DELETE FROM clientes;
DELETE FROM productos;

DELETE FROM compras WHERE cantidad<3;

//Update filas

UPDATE clientes
SET direccion='Málaga'
WHERE nombre='Monica';

UPDATE productos 
SET precio=precio+0.25;

UPDATE compras 
SET cantidad=cantidad+1
WHERE producto=2;

UPDATE productos 
SET precio=1.25
WHERE tipo=1 OR tipo=2;

//Consultas

SELECT nombre, dni FROM clientes;
SELECT direccion FROM clientes;
SELECT dni, nombre, fecha_nac, direccion, sexo FROM clientes;
SELECT * FROM clientes;
SELECT nombre FROM clientes WHERE direccion='Granada';
SELECT nombre FROM clientes WHERE sexo='M';
SELECT nombre, dni FROM clientes WHERE direccion!='Granada';
SELECT * FROM clientes WHERE nombre='Lucia';
SELECT nombre FROM productos;
SELECT precio FROM productos;
SELECT cod_prod, precio FROM productos;
SELECT precio FROM productos WHERE tipo=2;
SELECT * FROM productos WHERE cod_prod=4;
SELECT * FROM productos WHERE precio>0.75;
SELECT nombre FROM productos WHERE precio >=0.75 AND precio <= 1.25;
SELECT cliente FROM compras;
SELECT cliente FROM compras WHERE producto=3;
SELECT cliente FROM compras WHERE cantidad >3 AND producto=1;
SELECT cliente, producto FROM compras WHERE cantidad >3;

SELECT compras.*, clientes.nombre FROM compras, clientes WHERE dni=cliente;
SELECT clientes.nombre FROM compras, clientes WHERE producto=2 AND cantidad >4 AND dni=cliente;
SELECT DISTINCT productos.nombre FROM compras, productos WHERE cantidad <3 AND cod_prod=producto;
SELECT DISTINCT productos.* FROM compras, productos, clientes 
WHERE compras.cliente=clientes.dni AND compras.producto=productos.cod_prod AND clientes.nombre='Lucia';

CREATE TABLE tiendas
(
    cod_tienda NUMBER(5) PRIMARY KEY,
    metros NUMBER(4) NOT NULL
);

INSERT INTO tiendas VALUES (1, 500);
INSERT INTO tiendas VALUES (2, 800);
INSERT INTO tiendas VALUES (3, 250);

CREATE TABLE trabajadores
(
    codigo NUMBER(5) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    categoria VARCHAR2(20) NOT NULL,
    area VARCHAR2(20) NOT NULL,
    tienda NUMBER(5),
    
    CONSTRAINT fk_trabajador_tienda FOREIGN KEY (tienda) REFERENCES tiendas (cod_tienda)
);

INSERT INTO trabajadores VALUES (18, 'Pedro', 'Encargado', 'Cajas', 1);
INSERT INTO trabajadores VALUES (21, 'Elena', 'Encargado', 'Reposicion', 1);
INSERT INTO trabajadores VALUES (35, 'Manuel', 'Suplente', 'Reposicion', 3);

CREATE TABLE ofertas
(
    cod_of VARCHAR(3) PRIMARY KEY,
    tienda NUMBER(5),
    producto NUMBER(5),
    trabajador NUMBER(5),
    tipo_of NUMBER(1),
    inicio VARCHAR(20),
    fin VARCHAR(20),
    
    CONSTRAINT fk_ofertas_tienda FOREIGN KEY (tienda) REFERENCES tiendas(cod_tienda),
    CONSTRAINT fk_ofertas_trabajador FOREIGN KEY (trabajador) REFERENCES trabajadores(codigo),
    CONSTRAINT fk_ofertas_producto FOREIGN KEY (producto) REFERENCES productos(cod_prod)
);

INSERT INTO ofertas VALUES ('O1', 1, 2, 18, 1, 'Septiembre', 'Octubre');
INSERT INTO ofertas (cod_of, tienda, producto, tipo_of, inicio, fin) VALUES ('O2', 2, 6, 1, 'Octubre', 'Noviembre');
INSERT INTO ofertas VALUES ('O3', 3, 6, 35, 2, 'Julio', 'Agosto');
INSERT INTO ofertas VALUES ('O4', 3, 3, 35, 3, 'Octubre', 'Diciembre');

ALTER TABLE ofertas ADD CONSTRAINT fk_ofertas_producto FOREIGN KEY (producto) REFERENCES productos(cod_prod);
ALTER TABLE ofertas MODIFY producto NUMBER(5);

//Consultas

SELECT producto.nombre FROM ofertas, producto
WHERE oferta.producto=producto.cod_prod AND oferta.tienda='T3';
SELECT ofertas.cod_of, productos.nombre FROM ofertas, productos
WHERE productos.nombre='Bolígrafo azul' AND ofertas.producto=productos.cod_prod;
SELECT metros FROM tienda, producto, oferta
WHERE producto.cod_prod=ofertas.producto AND tienda.cod_tienda=ofertas.tienda;
SELECT nombre, categoría FROM trabajadores WHERE tienda=1;
SELECT oferta.* FROM ofertas, tiendas, trabajadores WHERE ofertas.tienda=tiendas.cod_tienda AND trabajadores.tienda

SELECT productos.nombre FROM productos, ofertas
WHERE productos.cod_prod=ofertas.producto AND ofertas.inicio='Septiembre';
SELECT productos.nombre FROM productos, tiendas, ofertas
WHERE productos.cod_prod=ofertas.producto AND tiendas.cod_tienda=ofertas.tienda AND tiendas.metros>500;
SELECT DISTINCT productos.nombre FROM productos, compras, clientes
WHERE productos.cod_prod=compras.producto AND clientes.dni=compras.cliente AND direccion='Granada';
SELECT direccion FROM clientes, compras, productos
WHERE productos.cod_prod=compras.producto AND clientes.dni=compras.cliente AND cantidad>=7;

SELECT clientes.nombre, compras.* FROM clientes, compras
WHERE clientes.dni=compras.cliente AND direccion='Granada' ORDER BY clientes.nombre ASC;
SELECT direccion FROM clientes, productos, compras
WHERE productos.nombre='Bolígrafo azul' AND compras.cantidad=8;
SELECT tiendas.* FROM tiendas, ofertas, productos
WHERE tiendas.cod_tienda=ofertas.tienda AND productos.cod_prod=ofertas.producto AND productos.precio=0;
//el de arriba se cambia por productos.precio IS NULL si está null
SELECT productos.nombre, productos.precio FROM productos, ofertas
WHERE ofertas.producto=productos.cod_prod AND ofertas.tipo_of=2;

SELECT clientes.* FROM clientes, compras, productos
WHERE productos.nombre='Bolígrafo azul' AND compras.producto=productos.cod_prod AND compras.cliente=clientes.dni ORDER BY clientes.fecha_nac ASC;
SELECT DISTINCT clientes.nombre FROM clientes, compras, productos
WHERE clientes.dni=compras.cliente AND productos.cod_prod=compras.producto AND productos.precio IS NOT NULL;
SELECT clientes.nombre, ROUND (precio*cantidad*1.21, 2) FROM clientes, productos, compras
WHERE compras.cliente=clientes.dni AND productos.cod_prod=compras.producto AND direccion='Malaga';

SELECT ofertas.cod_of, ofertas.tienda, productos.nombre, trabajadores.nombre, ofertas.tipo_of FROM ofertas, trabajadores, tiendas, productos
WHERE productos.cod_prod=ofertas.producto AND trabajadores.codigo=ofertas.trabajador AND tiendas.cod_tienda=ofertas.tienda AND tiendas.metros>=500;