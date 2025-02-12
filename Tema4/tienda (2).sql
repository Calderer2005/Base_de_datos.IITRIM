CREATE TABLE cliente
(
    dni VARCHAR2(9) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    fecha_nac DATE NOT NULL,
    direccion VARCHAR2(100),
    sexo VARCHAR2(1) CHECK (sexo IN ('H', 'M'))
);

CREATE TABLE producto
(
    cod NUMBER(5) PRIMARY KEY,
    nombre VARCHAR2(50) UNIQUE NOT NULL,
    stock NUMBER(6) NOT NULL CHECK (stock >= 0),
    precio NUMBER(4, 2) NOT NULL,
    tipo VARCHAR2(20) NOT NULL
);

CREATE TABLE compra
(
    cliente VARCHAR2(9),
    producto NUMBER(5),
    fecha DATE,
    cantidad NUMBER(3) NOT NULL,
    
    CONSTRAINT pk_comp PRIMARY KEY (cliente, producto, fecha),
    CONSTRAINT fk_comp_cli FOREIGN KEY (cliente) REFERENCES cliente(DNI),
    CONSTRAINT fk_comp_prod FOREIGN KEY (producto) REFERENCES producto(cod)
);

CREATE TABLE tienda
(
    cod NUMBER(5) PRIMARY KEY,
    metros NUMBER(4) NOT NULL
);

CREATE TABLE trabajador
(
    cod NUMBER(5) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    categoria VARCHAR(20) NOT NULL,
    area VARCHAR2(20) NOT NULL,
    tienda NUMBER(5),
    
    CONSTRAINT fk_trab_tien FOREIGN KEY (tienda) REFERENCES tienda(cod)
);

CREATE TABLE oferta
(
    cod NUMBER(5) PRIMARY KEY,
    tienda NUMBER(5),
    producto NUMBER(5),
    trabajador NUMBER(5),
    tipo VARCHAR2(20) NOT NULL,
    inicio DATE NOT NULL,
    fin DATE NOT NULL,
    
    CONSTRAINT fk_of_tien FOREIGN KEY (tienda) REFERENCES tienda(cod),
    CONSTRAINT fk_of_prod FOREIGN KEY (producto) REFERENCES producto(cod),
    CONSTRAINT fk_of_trab FOREIGN KEY (trabajador) REFERENCES trabajador(cod)
);

//DROP TABLE cliente CASCADE CONSTRAINTS;

ALTER TABLE compra
ADD CONSTRAINT fk_comp_cli FOREIGN KEY (cliente) REFERENCES cliente(DNI);

ALTER TABLE cliente
ADD tlf NUMBER(9);

ALTER TABLE trabajador
ADD tlf NUMBER(9);

ALTER TABLE producto
DROP COLUMN stock;

ALTER TABLE cliente
MODIFY tlf CHECK (tlf >= 600000000);

ALTER TABLE trabajador
MODIFY tlf CHECK (tlf >= 600000000);

ALTER TABLE producto
MODIFY precio DEFAULT 0;

ALTER TABLE tienda ADD
(
    nombre VARCHAR2(50) NOT NULL,
    localizacion VARCHAR2(100)
);

ALTER TABLE producto
MODIFY precio CHECK (precio >= 0 AND precio <= 10);

ALTER TABLE producto
ADD stock NUMBER(6);

ALTER TABLE producto
MODIFY stock CHECK (stock >= 0);

INSERT INTO cliente VALUES ('11111111F', 'ERICA', '01/01/00', 'GRANADA', 'M', NULL);
INSERT INTO cliente VALUES ('22222222F', 'PEPE', '01/01/00', 'GRANADA', 'H', 611111123);
INSERT INTO cliente VALUES ('33333333H', 'Manolo','15/02/03','MELILLA','H',NULL );

INSERT INTO cliente (dni, nombre, fecha_nac, direccion, sexo) VALUES 
('11111111Z', 'Lucía', '12/05/2002', 'Granada', 'M');
INSERT INTO cliente (dni, nombre, fecha_nac, direccion, sexo) VALUES 
('22222222B', 'Mónica', '18/12/2008', 'Jaén', 'M');
INSERT INTO cliente (dni, nombre, fecha_nac, direccion, sexo) VALUES 
('12345678C', 'Luis', '18/02/2008', 'Granada', 'H');
INSERT INTO cliente (dni, nombre, fecha_nac, direccion, sexo) VALUES 
('33333333R', 'César', '08/09/2003', 'Granada', 'H');
INSERT INTO cliente (dni, nombre, fecha_nac, direccion, sexo) VALUES 
('55555555T', 'Roberto', '24/11/2008', 'Málaga', 'H');


ALTER TABLE producto
MODIFY tipo NUMBER(2,0);

ALTER TABLE producto
MODIFY precio NULL;

INSERT INTO producto (cod, nombre, stock, precio, tipo) VALUES
(1, 'Lápiz negro', 100, 0.75, 1);
INSERT INTO producto (cod, nombre, stock, precio, tipo) VALUES
(2, 'Bolígrafo azul', 85, 1.25, 1);
INSERT INTO producto (cod, nombre, stock, precio, tipo) VALUES
(3, 'Libreta A4', 60, 1.75, 2);
INSERT INTO producto (cod, nombre, stock, precio, tipo) VALUES
(4, 'Cuaderno rubio', 50, 3.25, 2);
INSERT INTO producto (cod, nombre, stock, precio, tipo) VALUES
(5, 'Corrector', 86, 0.75, 3);
INSERT INTO producto (cod, nombre, stock, precio, tipo) VALUES
(6, 'Goma borrar', 150, 0.35, 3);

INSERT INTO compra (cliente, producto, fecha, cantidad) VALUES
('11111111Z', 1, '25/10/2023', 2);
INSERT INTO compra (cliente, producto, fecha, cantidad) VALUES
('12345678C', 1, '26/10/2023', 1);
INSERT INTO compra (cliente, producto, fecha, cantidad) VALUES
('11111111Z', 2, '25/10/2023', 4);
INSERT INTO compra (cliente, producto, fecha, cantidad) VALUES
('55555555T', 2, '26/10/2023', 3);
INSERT INTO compra (cliente, producto, fecha, cantidad) VALUES
('11111111Z', 3, '26/10/2023', 1);
INSERT INTO compra (cliente, producto, fecha, cantidad) VALUES
('12345678C', 4, '26/10/2023', 1);
INSERT INTO compra (cliente, producto, fecha, cantidad) VALUES
('33333333R', 2, '25/10/2023', 6);
INSERT INTO compra (cliente, producto, fecha, cantidad) VALUES
('11111111Z', 1, '30/10/2023', 5);
INSERT INTO compra (cliente, producto, fecha, cantidad) VALUES
('12345678C', 3, '02/11/2023', 2);
INSERT INTO compra (cliente, producto, fecha, cantidad) VALUES
('12345678C', 4, '30/10/2023', 1);
INSERT INTO compra (cliente, producto, fecha, cantidad) VALUES
('33333333R', 1, '25/10/2023', 4);
INSERT INTO compra (cliente, producto, fecha, cantidad) VALUES
('55555555T', 2, '30/10/2023', 3);
INSERT INTO compra (cliente, producto, fecha, cantidad) VALUES
('55555555T', 3, '30/10/2023', 1);
INSERT INTO compra (cliente, producto, fecha, cantidad) VALUES
('55555555T', 3, '02/11/2023', 2);
INSERT INTO compra (cliente, producto, fecha, cantidad) VALUES
('12345678C', 4, '02/11/2023', 2);


DELETE FROM compra;
DELETE FROM cliente WHERE direccion='Málaga';
DELETE FROM producto WHERE precio<1;
DELETE FROM cliente WHERE sexo='H';
DELETE FROM cliente;
DELETE FROM producto;

DELETE FROM compra WHERE cantidad<3;

UPDATE cliente
SET fecha_nac='11/05/2002'
WHERE dni='11111111Z';

UPDATE producto
SET precio=1.25,
stock = 150
WHERE nombre='Bolígrafo azul';

UPDATE cliente
SET direccion='Málaga'
WHERE nombre='Mónica';

UPDATE producto
SET precio = precio + 0.25;

UPDATE compra
SET cantidad = cantidad + 1
WHERE producto=2;

UPDATE producto
SET precio = 1.25
WHERE tipo=1 OR tipo=2;

UPDATE cliente SET nombre='césar' WHERE nombre='César';

SELECT dni, nombre FROM cliente;

SELECT direccion FROM cliente;

SELECT * FROM compra;

UPDATE cliente SET direccion='Granada' WHERE direccion='GRANADA';

SELECT dni, nombre FROM cliente WHERE direccion='Granada' ORDER BY nombre ASC;

SELECT nombre FROM cliente WHERE sexo='M';

SELECT dni, nombre FROM cliente WHERE NOT direccion='Granada';

SELECT * FROM cliente WHERE nombre='Lucía';

SELECT precio FROM producto WHERE tipo=2;

SELECT * FROM producto WHERE cod=4;

SELECT * FROM producto WHERE precio >= 0.75 AND precio <= 1.25;

SELECT DISTINCT cliente FROM compra;

SELECT cliente FROM compra WHERE producto=3;

SELECT cliente FROM compra WHERE producto=1 AND cantidad>3; 

SELECT DISTINCT cliente,producto FROM compra WHERE cantidad>3;

SELECT nombre, precio*1.21 FROM producto;

SELECT nombre FROM producto WHERE precio IS NOT NULL;

SELECT DISTINCT direccion FROM cliente WHERE direccion IS NOT NULL;

SELECT direccion,nombre FROM cliente ORDER BY direccion DESC, nombre ASC;

CREATE TABLE duenios
(
    DNI VARCHAR2(9) PRIMARY KEY,
    nom VARCHAR2(50)
);

CREATE TABLE perros
(
    num NUMBER(4) PRIMARY KEY,
    nom VARCHAR2(20),
    DNI_due VARCHAR2(9),
    
    CONSTRAINT fk_perr_due FOREIGN KEY (DNI_due) REFERENCES duenios(DNI)
);

INSERT INTO duenios VALUES ('11111111S', 'Rocio');
INSERT INTO duenios VALUES ('33333333E', 'Paloma');
INSERT INTO duenios VALUES ('66666666B', 'Victor');

INSERT INTO perros VALUES (1, 'Ali', '11111111S');
INSERT INTO perros VALUES (2, 'Buda', '33333333E');
INSERT INTO perros VALUES (3, 'Pico', '11111111S');
INSERT INTO perros VALUES (4, 'Rufo', '66666666B');

SELECT * FROM duenios d, perros p WHERE DNI=DNI_due ORDER BY d.nom;


SELECT compra.*, producto.nombre FROM compra, producto WHERE cod=producto;

SELECT compra.*, cliente.nombre FROM compra, cliente WHERE dni=cliente;

SELECT cliente.nombre FROM cliente, compra WHERE cantidad>4 AND producto=2 AND dni=cliente;

SELECT DISTINCT producto.nombre FROM compra, producto WHERE cantidad<3 AND cod=producto;

SELECT DISTINCT producto.* FROM compra, producto, cliente 
WHERE compra.cliente=cliente.dni AND compra.producto=producto.cod AND cliente.nombre='Lucía';

DROP TABLE trabajador CASCADE CONSTRAINTS;
DROP TABLE tienda CASCADE CONSTRAINTS;
DROP TABLE oferta CASCADE CONSTRAINTS;

INSERT INTO trabajador VALUES(18, 'Pedro', 'Encargado', 'Cajas', 1);
INSERT INTO trabajador VALUES(21, 'Elena', 'Encargado', 'Reposición', 1);
INSERT INTO trabajador VALUES(35, 'Manuel', 'Suplente', 'Reposición', 1);

INSERT INTO tienda VALUES(1, 500);
INSERT INTO tienda VALUES(2, 800);
INSERT INTO tienda VALUES(3, 250);

INSERT INTO oferta VALUES(1, 1, 2, 18, 1, '01/09/2024', '01/10/2024');
INSERT INTO oferta VALUES(2, 2, 6, NULL, 1, '01/10/2024', '01/11/2024');
INSERT INTO oferta VALUES(3, 3, 6, 35, 2, '01/07/2024', '01/08/2024');
INSERT INTO oferta VALUES(4, 3, 3, 35, 3, '01/10/2024', '01/12/2024');

SELECT producto.nombre FROM oferta, producto 
WHERE oferta.producto=producto.cod AND oferta.tienda=3;

SELECT oferta.cod FROM oferta, producto 
WHERE producto.nombre='Goma borrar' AND oferta.producto=producto.cod;

SELECT metros FROM tienda, producto, oferta 
WHERE producto.cod=oferta.producto AND tienda.cod=oferta.tienda 
AND producto.nombre='Goma borrar';

SELECT nombre, categoria FROM trabajador WHERE tienda=1;

SELECT oferta.* FROM oferta, trabajador 
WHERE oferta.tienda=trabajador.tienda AND trabajador.nombre='Elena';

SELECT producto.nombre FROM producto, oferta 
WHERE producto.cod=oferta.producto 
AND inicio <= '01/09/2024' AND fin >= '30/09/2024';

SELECT producto.nombre FROM producto, tienda, oferta
WHERE producto.cod=oferta.producto AND tienda.cod=oferta.tienda
AND tienda.metros>500;

SELECT DISTINCT producto.nombre FROM producto, compra, cliente
WHERE producto.cod=compra.producto AND cliente.dni=compra.cliente
AND direccion='Granada';

SELECT direccion FROM cliente, compra, producto
WHERE producto.cod=compra.producto AND cliente.dni=compra.cliente
AND cantidad>=7;

SELECT compra.cliente, compra.producto, cliente.direccion, SUM(compra.cantidad)
FROM cliente, compra 
WHERE compra.cliente=cliente.dni 
GROUP BY compra.cliente,compra.producto,cliente.direccion;

SELECT nombre, compra.*
FROM cliente,compra
WHERE dni=cliente AND direccion='Granada'
ORDER BY nombre;

SELECT DISTINCT tienda.*
FROM tienda, oferta, producto
WHERE tienda.cod=oferta.tienda AND oferta.producto=producto.cod 
AND precio IS NULL;

SELECT nombre, precio
FROM producto, oferta
WHERE producto.cod=oferta.producto AND oferta.tipo=2;

SELECT DISTINCT cliente.*
FROM cliente, producto, compra
WHERE dni=compra.cliente AND producto.cod=compra.producto AND producto.nombre='Bolígrafo azul'
ORDER BY fecha_nac ASC;

SELECT DISTINCT cliente.nombre
FROM cliente, producto, compra
WHERE dni=compra.cliente AND producto.cod=compra.producto AND precio IS NOT NULL;

SELECT cliente.nombre, ROUND(precio*cantidad*1.21, 2)
FROM cliente, producto, compra
WHERE compra.cliente=dni AND producto.cod=compra.producto AND direccion='Málaga';

SELECT oferta.cod, oferta.tienda, producto.nombre, trabajador.nombre, oferta.tipo, inicio, fin
FROM oferta, trabajador, tienda, producto 
WHERE producto.cod=oferta.producto AND trabajador.cod=oferta.trabajador 
AND tienda.cod=oferta.tienda AND metros>=500;

select cli.nombre, sum(c.cantidad*p.precio) FROM cliente cli, producto p, compra c
where cli.dni=cliente
group by cli.nombre;

select cli.nombre, sum(c.cantidad*p.precio) FROM cliente cli, producto p, compra c
where cli.dni=c.cliente and p.cod=c.producto
group by cli.nombre
having sum(c.cantidad*p.precio)>=5;

select producto from compra
group by producto
having avg(cantidad)>3;

select direccion from cliente
group by direccion 
having count(dni)>2;

select p.nombre from compra c, producto p
where c.producto=p.cod
group by p.nombre
having sum(cantidad)>10;

select cliente from compra c, producto p
where c.producto=p.cod
group by cliente 
having avg(cantidad*precio)>3;

select producto from oferta
group by producto
having count(cod)>1;

select tienda from oferta
group by tienda
having count (distinct  producto)>1;
--Subconsultas:
--1
SELECT * FROM cliente WHERE direccion = (SELECT direccion FROM cliente WHERE nombre='César');
--2
SELECT * FROM cliente WHERE fecha_nac = (SELECT fecha_nac FROM cliente WHERE nombre='Luis');
--3
SELECT * FROM cliente WHERE direccion = (SELECT direccion FROM cliente WHERE nombre='Lucía');
--4
SELECT * FROM cliente WHERE fecha_nac < (SELECT fecha_nac FROM cliente WHERE nombre='Lucía');
--5
SELECT * FROM compra c, producto p WHERE c.producto=p.cod and p.nombre
(SELECT dni FROM cliente WHERE nombre='Lucía'));
--OPERADOR
SELECT * FROM cliente WHERE dni NOT IN (SELECT DISTINCT cliente FROM compra);
--2
SELECT nombre,categoria FROM trabajador WHERE tienda IN (SELECT tienda FROM oferta o,producto p WHERE o.producto=p.cod AND p.nombre='Boligrafo azul');

SELECT nombre, fecha_nac FROM clientes FROM 

SELECT nombre FROM trabajador 
WHERE tienda = ANY (
                    SELECT tienda FROM trabajador 
                        WHERE nombre IN ('Pedro','Manuel'));
                        
SELECT * FROM cliente
WHERE fecha_nac <= ALL (
                        SELECT fecha_nac FROM cliente);
                    
SELECT nombre from cliente, compra
WHERE dni=cliente AND ( cliente, producto ) IN (SELECT cliente,producto FROM compra 
                            GROUP BY cliente, producto HAVING SUM(cantidad) < 2);

SELECT nombre FROM cliente 
WHERE nombre != ALL (SELECT nombre from cliente, compra
                        WHERE dni = cliente AND (cliente , producto) IN (SELECT cliente, producto
                            group by cliente,producto having sum (cantidad) < sum 2))
    AND dni = ANY (SELECT DISTINCT cliente FROM compra);
    
SELECT nombre FROM cliente
WHERE  dni != ALL (SELECT  cliente FROM compra
                    WHERE producto = ANY (
                        SELECT cod FROM producto
                            WHERE nombre != 'Bolígrafo azul'))
    AND dni = ANY (SELECT DISTINCT cliente FROM compra);


SELECT cod FROM tienda 
WHERE metros >= ALL (
                    SELECT metros FROM tienda);

-- MANIPULACIÓN DE RESULTADOS: UNION , INTERSECT , MINUS
SELECT cliente FROM cliente cli JOIN compra c JOIN producto p ON c.producto=p.cod
WHERE p.nombre='Lápiz negro';

INTERSECT

SELECT cliente FROM compra c JOIN producto p ON c.producto=p.cod
WHERE p.nombre='Boligrafo azul';

