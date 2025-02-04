CREATE TABLE clientes
(
    DNI VARCHAR2(9) PRIMARY KEY,
    nombre VARCHAR2(50) NOT NULL,
    fecha_nac DATE NOT NULL,
    direccion VARCHAR2(100),
    sexo VARCHAR2(1) CHECK (sexo IN ('H', 'M'))
);

CREATE TABLE productos
(
    cod_prod NUMERIC(5) PRIMARY KEY,
    nombre VARCHAR2(50) UNIQUE NOT NULL,
    stock NUMERIC(6) NOT NULL,
    precio NUMERIC(4,2) NOT NULL,
    tipo VARCHAR2(20)
);

CREATE TABLE compras
(
    cliente VARCHAR2(9),
    producto NUMERIC(5),
    fecha DATE,
    cantidad NUMERIC(3) NOT NULL,
    
    CONSTRAINT pk_compras PRIMARY KEY (cliente, producto, fecha),
    CONSTRAINT fk_compras_clientes FOREIGN KEY (cliente) REFERENCES clientes(DNI),
    CONSTRAINT fk_compras_producto FOREIGN KEY (producto) REFERENCES productos(cod_prod)
);

CREATE TABLE tienda
(
    cod_tienda NUMERIC(2) PRIMARY KEY,
    metros NUMERIC(4,2) NOT NULL
);

CREATE TABLE trabajadores
(
    cod_trab NUMERIC(3) PRIMARY KEY,
    nombre VARCHAR2(50) NOT NULL,
    categoria VARCHAR2(20) NOT NULL,
    area VARCHAR2(20) NOT NULL,
    tienda NUMERIC(2),
    
    CONSTRAINT fk_trabajadores_tienda FOREIGN KEY (tienda) REFERENCES tienda(cod_tienda)
);

CREATE TABLE oferta
(
    cod_of NUMERIC(2) PRIMARY KEY,
    tienda NUMERIC(2),
    producto NUMERIC(5),
    trabajador NUMERIC(3),
    tipo VARCHAR2(20) NOT NULL,
    inicio DATE NOT NULL,
    fin DATE NOT NULL,
    
    CONSTRAINT fk_oferta_tienda FOREIGN KEY (tienda) REFERENCES tienda(cod_tienda),
    CONSTRAINT fk_oferta_producto FOREIGN KEY (producto) REFERENCES productos(cod_prod),
    CONSTRAINT fk_oferta_trabajador FOREIGN KEY (trabajador) REFERENCES trabajadores(cod_trab)
);

ALTER TABLE clientes ADD
(
    telefono NUMERIC(9) CHECK (telefono>=600000000)
);

ALTER TABLE trabajadores ADD
(
    telefono NUMERIC(9) CHECK (telefono>=600000000)
);

ALTER TABLE productos
    DROP COLUMN stock

ALTER TABLE productos
    ADD stock NUMERIC(4) CHECK (stock>=0);
    
ALTER TABLE tienda ADD
(
    nombre VARCHAR2(20),
    localizacion VARCHAR2(20)
);

ALTER TABLE productos MODIFY
(
    precio DEFAULT(0) CHECK (precio>=0 AND precio<=10) NULL
);

ALTER TABLE clientes
    DROP COLUMN telefono

INSERT INTO clientes VALUES ('11111111Z','Lucia','12/05/2002','Granada','M');
INSERT INTO clientes VALUES ('22222222B','Monica','18/12/2008','Jaen','M');
INSERT INTO clientes VALUES ('12345678C','Luis','03/01/2005','Granada','H');
INSERT INTO clientes VALUES ('33333333R','Cesar','08/09/2003','Granada','H');
INSERT INTO clientes VALUES ('55555555T','Roberto','24/11/2008','Malaga','H');

INSERT INTO productos VALUES (1,'Lapiz negro',0.75,'1',100);
INSERT INTO productos VALUES (2,'Boligrafo azul',0.5,'1',85);
INSERT INTO productos VALUES (3,'LibretaA4',1.75,'2',60);
INSERT INTO productos VALUES (4,'Cuaderno rubio',3.25,'2',50);
INSERT INTO productos VALUES (5,'Corrector',0.5,'3',86);
INSERT INTO productos VALUES (6,'Goma borrar',0.35,'3',150);

INSERT INTO compras VALUES ('11111111Z',1,'25/10/2023',2);
INSERT INTO compras VALUES ('12345678C',1,'26/10/2023',1);
INSERT INTO compras VALUES ('11111111Z',2,'25/10/2023',4);
INSERT INTO compras VALUES ('55555555T',2,'26/10/2023',3);
INSERT INTO compras VALUES ('11111111Z',3,'26/10/2023',1);
INSERT INTO compras VALUES ('12345678C',4,'26/10/2023',1);
INSERT INTO compras VALUES ('33333333R',2,'25/10/2023',6);
INSERT INTO compras VALUES ('11111111Z',1,'30/10/2023',5);
INSERT INTO compras VALUES ('12345678C',3,'02/11/2023',2);
INSERT INTO compras VALUES ('12345678C',4,'30/10/2023',1);
INSERT INTO compras VALUES ('33333333R',1,'25/10/2023',4);
INSERT INTO compras VALUES ('55555555T',2,'30/10/2023',3);
INSERT INTO compras VALUES ('55555555T',3,'30/10/2023',1);
INSERT INTO compras VALUES ('55555555T',3,'02/11/2023',2);
INSERT INTO compras VALUES ('12345678C',4,'02/11/2023',2);

DELETE FROM compras;
DELETE FROM clientes WHERE direccion='Malaga';
DELETE FROM productos WHERE precio<1;
DELETE FROM clientes WHERE sexo='H';
DELETE FROM clientes;
DELETE FROM productos;

DELETE FROM compras WHERE cantidad<3;

UPDATE clientes
SET direccion='Malaga'
WHERE nombre = 'Monica';

SELECT nombre FROM clientes WHERE sexo = 'M';

SELECT nombre FROM clientes WHERE direccion != 'Granada';

SELECT * FROM clientes WHERE nombre = 'Lucia';

SELECT nombre FROM productos WHERE precio < 1 AND precio > 0;

SELECT cliente FROM compras WHERE producto=1 AND cantidad>3;

SELECT cliente, producto FROM compras WHERE cantidad>3;

SELECT DISTINCT direccion FROM clientes;


SELECT compras.*, clientes.nombre FROM clientes, compras WHERE clientes.DNI = compras.cliente;

SELECT clientes.nombre FROM clientes, compras WHERE clientes.DNI = compras.cliente AND compras.cantidad>4 AND compras.producto=2;

SELECT DISTINCT productos.nombre FROM productos, compras WHERE compras.producto=productos.cod_prod AND compras.cantidad<3;

SELECT DISTINCT productos.* FROM clientes, productos, compras WHERE clientes.DNI = compras.cliente AND compras.producto=productos.cod_prod AND clientes.nombre='Roberto';


INSERT INTO trabajadores VALUES (18,'Pedro','Encargado','Cajas',1);
INSERT INTO trabajadores VALUES (21,'Elena','Encargado','Reposicion',1);
INSERT INTO trabajadores VALUES (35,'Manuel','Suplente','Reposicion',3);

INSERT INTO tienda (cod_tienda, metros) VALUES (1, 500);
INSERT INTO tienda (cod_tienda, metros) VALUES (2, 800);
INSERT INTO tienda (cod_tienda, metros) VALUES (3, 250);

ALTER TABLE tienda modify metros NUMBER(6,2);

INSERT INTO oferta VALUES (1,1,2,18,'1','01/09/24','01/10/24');
INSERT INTO oferta VALUES (2,2,6,null,'1','01/10/24','01/11/24');
INSERT INTO oferta VALUES (3,3,6,35,'2','01/07/24','01/08/24');
INSERT INTO oferta VALUES (4,3,3,35,'3','01/10/24','01/12/24');


SELECT productos.nombre FROM productos, oferta WHERE productos.cod_prod=oferta.producto AND oferta.tienda=3;

SELECT oferta.cod_of FROM productos, oferta WHERE productos.cod_prod=oferta.producto AND productos.nombre='Boligrafo azul';

SELECT oferta.* FROM oferta, tienda, trabajadores WHERE oferta.tienda=tienda.cod_tienda AND trabajadores.tienda=tienda.cod_tienda AND trabajadores.nombre='Elena';

SELECT tienda.metros FROM tienda, oferta, productos WHERE oferta.tienda=tienda.cod_tienda AND productos.cod_prod=oferta.producto AND productos.nombre='Lapiz negro';

SELECT trabajadores.nombre, trabajadores.categoria FROM trabajadores, tienda WHERE trabajadores.tienda=tienda.cod_tienda AND tienda.cod_tienda=1;


SELECT productos.nombre FROM productos, oferta WHERE oferta.producto=productos.cod_prod AND inicio<'30/09/24' AND fin>'01/09/24';

SELECT productos.nombre FROM productos, oferta, tienda WHERE oferta.producto=productos.cod_prod AND oferta.tienda=tienda.cod_tienda AND tienda.metros>500;

SELECT DISTINCT productos.nombre FROM productos, clientes, compras WHERE productos.cod_prod=compras.producto AND compras.cliente=clientes.dni AND clientes.direccion='Granada';

SELECT DISTINCT clientes.direccion FROM productos, clientes, compras WHERE productos.cod_prod=compras.producto AND compras.cliente=clientes.dni AND compras.cantidad>7 AND productos.nombre='Boligrafo azul';

SELECT clientes.nombre, compras.* FROM clientes, compras WHERE clientes.dni=compras.cliente AND direccion='Granada' ORDER BY clientes.nombre;

SELECT productos.nombre, productos.precio FROM productos, oferta WHERE productos.cod_prod=oferta.producto AND oferta.tipo=2;

SELECT DISTINCT clientes.* FROM clientes, compras, productos WHERE productos.cod_prod=compras.producto AND compras.cliente=clientes.dni AND productos.nombre='Boligrafo azul' ORDER BY clientes.fecha_nac;

SELECT productos.precio*cantidad*1.21 FROM clientes, compras, productos WHERE productos.cod_prod=compras.producto AND compras.cliente=clientes.dni AND clientes.direccion='Malaga';

SELECT oferta.tienda, productos.nombre, trabajadores.nombre, oferta.tipo, oferta.inicio, oferta.fin FROM oferta, productos, trabajadores, tienda WHERE oferta.tienda=tienda.cod_tienda AND oferta.producto=productos.cod_prod AND oferta.trabajador=trabajadores.cod_trab AND metros>=500;

SELECT productos.nombre, productos.precio FROM oferta, productos WHERE oferta.producto=productos.cod_prod AND oferta.trabajador IS NULL;

SELECT productos.nombre FROM oferta, productos WHERE oferta.producto=productos.cod_prod AND (inicio='01/04/24' OR inicio='01/06/24');