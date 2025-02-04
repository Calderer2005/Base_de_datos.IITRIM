CREATE DATABASE prueba;

CREATE TABLE departamento
(
    cod_depto VARCHAR2(20) PRIMARY KEY,
    nombre VARCHAR2(50)
);

CREATE TABLE centro
(
    cod_centro VARCHAR2(20) PRIMARY KEY,
    nombre VARCHAR2(50) NOT NULL,
    telefono NUMBER(9) NOT NULL,
    direcc VARCHAR(100) NOT NULL
);

CREATE TABLE profesor
(
    RFC VARCHAR2(18) PRIMARY KEY,
    nombre VARCHAR2(50) NOT NULL,
    direcc VARCHAR2(100),
    tlf NUMBER(9) NOT NULL,
    cod_depto VARCHAR2(20) NOT NULL,
    cod_centro VARCHAR2(20) NOT NULL,
    
    CONSTRAINT fk_departamento FOREIGN KEY (cod_depto) REFERENCES departamento(cod_depto),
    CONSTRAINT fk_centro FOREIGN KEY (cod_centro) REFERENCES centro(cod_centro)
);

CREATE TABLE publico
(
    cod_centro VARCHAR2(20) PRIMARY KEY,
    cod_junta VARCHAR(20) NOT NULL,
    
    CONSTRAINT fk_publico FOREIGN KEY (cod_centro) REFERENCES centro(cod_centro)
);

CREATE TABLE privado
(
    cod_centro VARCHAR2(20) PRIMARY KEY,
    cuota NUMBER(5,2) NOT NULL,
    
    CONSTRAINT fk_privado FOREIGN KEY (cod_centro) REFERENCES centro(cod_centro)
);

CREATE TABLE modulo
(
    codigo VARCHAR2(20) PRIMARY KEY,
    nombre VARCHAR2(50) NOT NULL,
    horas_semana NUMBER(2) NOT NULL
);

CREATE TABLE alumno
(
    control VARCHAR2(20) PRIMARY KEY,
    nombre VARCHAR2(20) NOT NULL,
    apellidos VARCHAR2(40) NOT NULL,
    control_del VARCHAR2(20) NOT NULL,
    
    CONSTRAINT fk_delegado FOREIGN KEY (control_del) REFERENCES alumno(control)
);

CREATE TABLE matriculado
(
    modulo VARCHAR2(20) NOT NULL,
    alumno VARCHAR2(20) NOT NULL,
    
    CONSTRAINT pk_matriculado PRIMARY KEY (modulo, alumno),
    CONSTRAINT fk_matriculado_modulo FOREIGN KEY (modulo) REFERENCES modulo(codigo),
    CONSTRAINT fk_matriculado_alumno FOREIGN KEY (alumno) REFERENCES alumno(control)
);

CREATE TABLE imparte
(
    profesor VARCHAR2(18) NOT NULL,
    modulo VARCHAR2(20) NOT NULL,
    horas NUMBER(2),
    
    CONSTRAINT pk_imparte PRIMARY KEY (profesor, modulo),
    CONSTRAINT fk_imparte_profesor FOREIGN KEY (profesor) REFERENCES profesor(RFC),
    CONSTRAINT fk_imparte_modulo FOREIGN KEY (modulo) REFERENCES modulo(codigo)
);

DROP TABLE imparte;
DROP TABLE matriculado;
DROP TABLE alumno;
DROP TABLE modulo;
DROP TABLE privado;
DROP TABLE publico;
DROP TABLE profesor;
DROP TABLE centro;
DROP TABLE departamento;






CREATE TABLE departamento
(
    cod_depto NUMBER(3) PRIMARY KEY,
    nombre VARCHAR2(50) NOT NULL
);

CREATE TABLE trabajador
(
    DNI VARCHAR2(9) PRIMARY KEY,
    nombre VARCHAR2(50) NOT NULL,
    direccion VARCHAR2(100) NOT NULL,
    cod_depto NUMBER(3) NOT NULL,
    
    CONSTRAINT fk_cod_depto FOREIGN KEY (cod_depto) REFERENCES departamento(cod_depto)
);

CREATE TABLE familiar
(
    DNI VARCHAR2(9),
    nombre VARCHAR2(50),
    parentesco VARCHAR2(5) CHECK (parentesco IN ('hijo', 'padre')),
    
    CONSTRAINT pk_familiar PRIMARY KEY (DNI, nombre),
    CONSTRAINT fk_DNI FOREIGN KEY (DNI) REFERENCES trabajador(DNI)
);

CREATE TABLE proyecto
(
    nombre_proyecto VARCHAR2(50) PRIMARY KEY,
    presupuesto NUMBER(7) DEFAULT (5000),
    cod_depto NUMBER(3),
    
    CONSTRAINT fk_cod_depto_proy FOREIGN KEY (cod_depto) REFERENCES departamento(cod_depto)
);

CREATE TABLE trabaja
(
    DNI VARCHAR2(9),
    nombre_proyecto VARCHAR2(50),
    n_horas NUMBER(4) DEFAULT NULL CHECK (n_horas >= 50),
    
    CONSTRAINT pk_trabajador_trabaja PRIMARY KEY (DNI, nombre_proyecto),
    CONSTRAINT fk_DNI_trabajador FOREIGN KEY (DNI) REFERENCES trabajador(DNI),
    CONSTRAINT fk_nombre_proyecto FOREIGN KEY (nombre_proyecto) REFERENCES proyecto(nombre_proyecto)
);

DROP TABLE trabaja;
DROP TABLE proyecto;
DROP TABLE familiar;
DROP TABLE trabajador;
DROP TABLE departamento;





CREATE TABLE estacion
(
    ID_estacion NUMBER(5) PRIMARY KEY,
    horario VARCHAR2(5) NOT NULL,
    direccion VARCHAR2(50) NOT NULL
);

CREATE TABLE linea
(
    nombre VARCHAR2(50) PRIMARY KEY,
    inicio NUMBER(5) NOT NULL,
    fin NUMBER(5) NOT NULL,
    
    CONSTRAINT fk_inicio_linea FOREIGN KEY (inicio) REFERENCES estacion(ID_estacion),
    CONSTRAINT fk_fin_linea FOREIGN KEY (fin) REFERENCES estacion(ID_estacion)
);

CREATE TABLE acceso
(
    ID_estacion NUMBER(5),
    num_acceso NUMBER(2),
    discapacitados VARCHAR2(1) NOT NULL CHECK (discapacitados IN ('S','N')),
    
    CONSTRAINT pk_acceso PRIMARY KEY (ID_estacion, num_acceso),
    CONSTRAINT fk_acceso_ID_estacion FOREIGN KEY (ID_estacion) REFERENCES estacion(ID_estacion)
);

CREATE TABLE cochera
(
    ID_cochera NUMBER(5) PRIMARY KEY,
    metros NUMBER(4,2) NOT NULL CHECK (metros > 100),
    estacion NUMBER(5) NOT NULL,
    
    CONSTRAINT fk_estacion_cochera FOREIGN KEY (estacion) REFERENCES estacion(ID_estacion)
);

CREATE TABLE tren
(
    ID_tren NUMBER(5) PRIMARY KEY,
    vagones NUMBER(1) NOT NULL CHECK (vagones >= 1 AND vagones <= 3),
    linea VARCHAR2(50) NOT NULL,
    cochera NUMBER(5) NOT NULL,
    
    CONSTRAINT fk_linea_tren FOREIGN KEY (linea) REFERENCES linea(nombre),
    CONSTRAINT fk_cochera_tren FOREIGN KEY (cochera) REFERENCES cochera(ID_cochera)
);

CREATE TABLE recorridos
(
    linea VARCHAR2(50),
    estacion NUMBER(5),
    orden NUMBER(2),
    
    CONSTRAINT pk_recorridos PRIMARY KEY (linea, estacion),
    CONSTRAINT fk_linea_recorridos FOREIGN KEY (linea) REFERENCES linea(nombre),
    CONSTRAINT fk_estacion_recorridos FOREIGN KEY (estacion) REFERENCES estacion(ID_estacion)
);






CREATE TABLE equipo
(
    nombre VARCHAR2(30) PRIMARY KEY,
    ciudad VARCHAR2(20) NOT NULL
);

CREATE TABLE jugador
(
    DNI VARCHAR2(9) PRIMARY KEY,
    nombre VARCHAR2(50) NOT NULL,
    dorsal NUMBER(2) NOT NULL CHECK (dorsal >= 1 AND dorsal <= 30),
    equipo VARCHAR2(30) NOT NULL,
    
    CONSTRAINT fk_equipo_jugador FOREIGN KEY (equipo) REFERENCES equipo(nombre)
);

CREATE TABLE partido
(
    ID_partido NUMBER(5) PRIMARY KEY,
    fecha DATE NOT NULL,
    resultado VARCHAR2(5) DEFAULT NULL
);

CREATE TABLE juega
(
    DNI VARCHAR2(9),
    partido NUMBER(5),
    posicion VARCHAR2(1) NOT NULL CHECK (posicion IN ('D', 'F', 'P', 'S')),
    
    CONSTRAINT pk_juega PRIMARY KEY (DNI, partido),
    CONSTRAINT fk_DNI_juega FOREIGN KEY (DNI) REFERENCES jugador(DNI),
    CONSTRAINT fk_partido_juega FOREIGN KEY (partido) REFERENCES partido(ID_partido)
);

CREATE TABLE rivales
(
    ID_partido NUMBER(5),
    local VARCHAR2(30),
    visitante VARCHAR2(30),
    
    CONSTRAINT pk_rivales PRIMARY KEY (ID_partido, local, visitante),
    CONSTRAINT fk_ID_partido_rivales FOREIGN KEY (ID_partido) REFERENCES partido(ID_partido),
    CONSTRAINT fk_local_rivales FOREIGN KEY (local) REFERENCES equipo(nombre),
    CONSTRAINT fk_visitante_rivales FOREIGN KEY (visitante) REFERENCES equipo(nombre)
);

DROP TABLE rivales;
DROP TABLE juega;
DROP TABLE partido;
DROP TABLE jugador;
DROP TABLE equipo;





CREATE TABLE clientes
(
    dni VARCHAR2(9) PRIMARY KEY,
    nombre VARCHAR2(50) UNIQUE NOT NULL,
    fecha_nac DATE NOT NULL,
    direccion VARCHAR2(100) NOT NULL,
    sexo VARCHAR2(1) NOT NULL CHECK (sexo IN ('H', 'M'))
);

CREATE TABLE productos
(
    cod_prod NUMBER(5) PRIMARY KEY,
    nombre VARCHAR2(50) UNIQUE NOT NULL,
    precio NUMBER(7,2), 
    tipo VARCHAR2(20) NOT NULL,
    stock NUMBER(4) NOT NULL
);

CREATE TABLE compras
(
    cliente VARCHAR2(9),
    producto NUMBER(5),
    fecha DATE,
    cantidad NUMBER(4) NOT NULL,
    
    CONSTRAINT pk_compras PRIMARY KEY (cliente, producto, fecha),
    CONSTRAINT fk_compras_cliente FOREIGN KEY (cliente) REFERENCES clientes(dni),
    CONSTRAINT fk_compras_producto FOREIGN KEY (producto) REFERENCES productos(cod_prod)
);

CREATE TABLE tiendas
(
    cod_tienda VARCHAR2(2) PRIMARY KEY,
    metros NUMBER(4) NOT NULL
);

CREATE TABLE trabajadores
(
    codigo NUMBER(5) PRIMARY KEY,
    nombre VARCHAR2(50) NOT NULL,
    categoria VARCHAR2(20) NOT NULL,
    area VARCHAR2(20) NOT NULL,
    tienda VARCHAR2(2),
    
    CONSTRAINT fk_tienda_trabajadores FOREIGN KEY (tienda) REFERENCES tiendas(cod_tienda)
);

CREATE TABLE ofertas
(
    cod_of VARCHAR2(2) PRIMARY KEY,
    tienda VARCHAR2(2),
    producto NUMBER(5),
    trabajador NUMBER(5),
    tipo VARCHAR2(20) NOT NULL,
    inicio DATE NOT NULL,
    fin DATE NOT NULL,
    
    CONSTRAINT fk_tienda_ofertas FOREIGN KEY (tienda) REFERENCES tiendas(cod_tienda),
    CONSTRAINT fk_producto_ofertas FOREIGN KEY (producto) REFERENCES productos(cod_prod),
    CONSTRAINT fk_trabajador_ofertas FOREIGN KEY (trabajador) REFERENCES trabajadores(codigo)
);

ALTER TABLE clientes
    ADD telefono NUMBER(9) NOT NULL CHECK (telefono >= 600000000);
    
ALTER TABLE clientes
    DROP COLUMN telefono;
    
ALTER TABLE trabajadores
    ADD telefono NUMBER(9) NOT NULL CHECK (telefono >= 600000000);
    
ALTER TABLE productos
    DROP COLUMN stock;
    
ALTER TABLE productos
    MODIFY precio DEFAULT (0);
    
ALTER TABLE tiendas ADD
(
    nombre VARCHAR2(20),
    localizacion VARCHAR2(50)
);

ALTER TABLE productos
    ADD stock NUMBER(4) NOT NULL CHECK (stock >= 0);
    
ALTER TABLE productos
    MODIFY precio CHECK (precio >= 0 AND precio <= 10);
    
ALTER TABLE productos
    MODIFY precio NULL;

DROP TABLE clientes CASCADE CONSTRAINTS;
DROP TABLE ofertas CASCADE CONSTRAINTS;
DROP TABLE productos CASCADE CONSTRAINTS;
DROP TABLE tiendas CASCADE CONSTRAINTS;
DROP TABLE trabajadores CASCADE CONSTRAINTS;
DROP TABLE compras CASCADE CONSTRAINTS;

DELETE FROM PRODUCTOS;

INSERT INTO clientes (dni, nombre, fecha_nac, direccion, sexo) VALUES ('11111111Z', 'Lucía', '12/05/2002', 'Granada', 'M');
INSERT INTO clientes (dni, nombre, fecha_nac, direccion, sexo) VALUES ('22222222B', 'Mónica', '18/12/2008', 'Jaén', 'M');
INSERT INTO clientes (dni, nombre, fecha_nac, direccion, sexo) VALUES ('12345678C', 'Luis', '03/01/2005', 'Granada', 'H');
INSERT INTO clientes (dni, nombre, fecha_nac, direccion, sexo) VALUES ('33333333R', 'César', '12/09/2008', 'Granada', 'H');
INSERT INTO clientes (dni, nombre, fecha_nac, direccion, sexo) VALUES ('55555555T', 'Roberto', '12/11/2002', 'Málaga', 'H');

INSERT INTO productos VALUES (1, 'Lápiz negro', 0.75, '1', 100);
INSERT INTO productos VALUES (2, 'Bolígrafo azul', NULL, '1', 85);
INSERT INTO productos VALUES (3, 'Libreta A4', 1.75, '2', 60);
INSERT INTO productos VALUES (4, 'Cuaderno rubio', 3.25, '2', 50);
INSERT INTO productos VALUES (5, 'Corrector', NULL, '3', 86);
INSERT INTO productos VALUES (6, 'Goma borrar', 0.35, '3', 150);

INSERT INTO compras VALUES ('11111111Z', 1, '25/10/2023', 2);
INSERT INTO compras VALUES ('12345678C', 1, '26/10/2023', 1);
INSERT INTO compras VALUES ('11111111Z', 2, '25/10/2023', 4);
INSERT INTO compras VALUES ('55555555T', 2, '26/10/2023', 3);
INSERT INTO compras VALUES ('11111111Z', 3, '26/10/2023', 1);
INSERT INTO compras VALUES ('12345678C', 4, '26/10/2023', 1);
INSERT INTO compras VALUES ('33333333R', 2, '25/10/2023', 6);
INSERT INTO compras VALUES ('11111111Z', 1, '30/10/2023', 5);
INSERT INTO compras VALUES ('12345678C', 3, '02/11/2023', 2);
INSERT INTO compras VALUES ('12345678C', 4, '30/10/2023', 1);
INSERT INTO compras VALUES ('33333333R', 1, '25/10/2023', 4);
INSERT INTO compras VALUES ('55555555T', 2, '30/10/2023', 3);
INSERT INTO compras VALUES ('55555555T', 3, '30/10/2023', 1);
INSERT INTO compras VALUES ('55555555T', 3, '02/11/2023', 2);
INSERT INTO compras VALUES ('12345678C', 4, '02/11/2023', 2);
INSERT INTO compras VALUES ('22222222B', 2, '02/11/2023', 20);

DELETE FROM compras;
DELETE FROM clientes WHERE direccion='Málaga';
DELETE FROM productos WHERE precio<1;
DELETE FROM clientes WHERE sexo='H';
DELETE FROM clientes;
DELETE FROM productos;
DELETE FROM compras WHERE cantidad<3;

UPDATE productos
SET precio=precio+0.25,
stock=150
WHERE nombre='Bolígrafo azul';

UPDATE clientes
SET direccion='Málaga'
WHERE nombre='Mónica';

UPDATE productos
SET precio=precio+0.25;

UPDATE compras
SET cantidad=cantidad+1
WHERE producto=2;

UPDATE productos
SET precio=1.25
WHERE tipo = 1 OR tipo = 2;

SELECT dni,nombre FROM clientes;
SELECT direccion FROM clientes;
SELECT * FROM clientes;
SELECT nombre FROM clientes WHERE direccion='Granada';
SELECT nombre FROM clientes WHERE sexo='M';
SELECT nombre, dni FROM clientes WHERE direccion!='Granada';
SELECT * FROM clientes WHERE nombre='Lucía';

SELECT nombre FROM productos;
SELECT precio FROM productos;
SELECT cod_prod, precio FROM productos;
SELECT precio FROM productos WHERE tipo=2;
SELECT * FROM productos WHERE cod_prod=4;
SELECT * FROM productos WHERE precio>0.75;
SELECT nombre FROM productos WHERE precio>=0.75 AND precio<=1.25;

SELECT cliente FROM compras;
SELECT cliente FROM compras WHERE producto = 3;
SELECT cliente FROM compras WHERE cantidad > 3 AND producto = 1;
SELECT cliente, producto FROM compras WHERE cantidad > 3;

SELECT DISTINCT direccion FROM clientes WHERE direccion IS NOT NULL ORDER BY direccion DESC;




CREATE TABLE duenios
(
    dni_duenio VARCHAR2(9) PRIMARY KEY,
    nombre_duenio VARCHAR2(50)
);

CREATE TABLE perros
(
    numero_perro NUMBER(4) PRIMARY KEY,
    nombre_perro VARCHAR2(20),
    dni_duenio VARCHAR2(9),
    
    CONSTRAINT fk_dni_duenio FOREIGN KEY (dni_duenio) REFERENCES duenios(dni_duenio)
); 

INSERT INTO duenios VALUES ('11111111S', 'Rocio');
INSERT INTO duenios VALUES ('33333333E', 'Paloma');
INSERT INTO duenios VALUES ('66666666B', 'Victor');

INSERT INTO perros VALUES (1, 'Ali', '11111111S');
INSERT INTO perros VALUES (2, 'Buda', '33333333E');
INSERT INTO perros VALUES (3, 'Pico', '11111111S');
INSERT INTO perros VALUES (4, 'Rufo', '66666666B');

SELECT d.nombre_duenio, p.nombre_perro FROM duenios d, perros p WHERE d.dni_duenio = p.dni_duenio ORDER BY d.nombre_duenio;

SELECT * FROM compras, productos WHERE producto = cod_prod;

SELECT compras.*, productos.nombre FROM compras, productos WHERE cod_prod = producto;

SELECT compras.*, clientes.nombre FROM compras, clientes WHERE clientes.DNI = compras.cliente;

SELECT clientes.nombre FROM compras, clientes WHERE cantidad>4 AND producto=2 AND compras.cliente=clientes.DNI;

SELECT DISTINCT productos.nombre FROM compras, productos WHERE compras.cantidad<3 AND producto=cod_prod;

SELECT DISTINCT productos.* FROM compras, productos, clientes WHERE compras.cliente=clientes.DNI AND clientes.nombre='Roberto' AND productos.cod_prod=compras.producto;

DROP TABLE trabajadores CASCADE CONSTRAINTS;
DROP TABLE tiendas CASCADE CONSTRAINTS;
DROP TABLE ofertas CASCADE CONSTRAINTS;

INSERT INTO tiendas values ('T1', 500);
INSERT INTO tiendas values ('T2', 800);
INSERT INTO tiendas values ('T3', 250);

INSERT INTO trabajadores VALUES (18, 'Pedro', 'Encargado', 'Cajas', 'T1');
INSERT INTO trabajadores VALUES (21, 'Elena', 'Encargado', 'Reposición', 'T1');
INSERT INTO trabajadores VALUES (35, 'Manuel', 'Suplente', 'Reposición', 'T3');
INSERT INTO trabajadores VALUES (20, 'Antonia', 'Suplente', 'Reposición', 'T2');

INSERT INTO ofertas VALUES ('O1', 'T1', 2, 18, '1', '01/09/24', '01/10/24');
INSERT INTO ofertas VALUES ('O2', 'T2', 6, 21, '1', '01/10/24', '01/11/24');
INSERT INTO ofertas VALUES ('O3', 'T3', 6, 35, '2', '01/07/24', '01/08/24');
INSERT INTO ofertas VALUES ('O4', 'T3', 3, 35, '3', '01/10/24', '01/12/24');
INSERT INTO ofertas VALUES ('O5', 'T1', 1, 18, '2', '01/10/24', '01/12/24');
INSERT INTO ofertas VALUES ('O6', 'T2', 5, 20, '1', '01/10/24', '01/12/24');
INSERT INTO ofertas VALUES ('O7', 'T2', 1, NULL, '1', '01/10/24', '01/12/24');
INSERT INTO ofertas VALUES ('O8', 'T1', 4, NULL, '2', '04/10/24', '01/12/24');
INSERT INTO ofertas VALUES ('O9', 'T1', 4, NULL, '2', '01/04/24', '01/12/24');


SELECT productos.nombre FROM productos, ofertas WHERE ofertas.producto=productos.cod_prod AND ofertas.tienda='T3';
SELECT ofertas.cod_of FROM ofertas, productos WHERE ofertas.producto=productos.cod_prod AND productos.nombre='Bolígrafo azul';
SELECT ofertas.cod_of FROM ofertas, productos WHERE ofertas.producto=productos.cod_prod AND productos.nombre='Goma borrar';
SELECT tiendas.metros FROM tiendas, ofertas, productos WHERE ofertas.producto=productos.cod_prod AND productos.nombre='Lápiz negro' AND tiendas.cod_tienda=ofertas.tienda;
SELECT trabajadores.nombre, trabajadores.categoria FROM trabajadores WHERE trabajadores.tienda='T1';
SELECT ofertas.* FROM ofertas, trabajadores WHERE trabajadores.nombre='Elena' AND ofertas.tienda=trabajadores.tienda;


SELECT productos.nombre FROM ofertas, productos WHERE ofertas.producto=productos.cod_prod AND ofertas.inicio='01/09/24';
SELECT productos.nombre FROM productos, ofertas, tiendas WHERE ofertas.tienda=tiendas.cod_tienda AND metros>500 AND cod_prod=ofertas.producto;
SELECT DISTINCT productos.nombre FROM productos, clientes, compras WHERE cod_prod=compras.producto AND direccion='Granada' AND cliente=DNI;
SELECT direccion FROM clientes, compras, productos WHERE DNI=compras.cliente AND compras.producto=cod_prod AND cantidad>7;


SELECT clientes.nombre, compras.* FROM clientes, compras WHERE direccion='Granada' AND compras.cliente=DNI ORDER BY clientes.nombre ASC;
SELECT clientes.direccion FROM clientes, compras, productos WHERE DNI=compras.cliente AND compras.producto=cod_prod AND productos.nombre='Bolígrafo azul' AND cantidad>7;
SELECT cod_tienda FROM tiendas, ofertas, productos WHERE cod_tienda=ofertas.tienda AND ofertas.producto=cod_prod AND precio IS NULL;
SELECT productos.nombre, precio FROM productos, ofertas WHERE ofertas.producto=cod_prod AND ofertas.tipo='2';


SELECT clientes.* FROM compras, clientes, productos WHERE DNI=compras.cliente AND compras.producto=cod_prod AND productos.nombre='Bolígrafo azul' ORDER BY fecha_nac;
SELECT clientes.nombre FROM clientes, compras, productos WHERE DNI=compras.cliente AND compras.producto=cod_prod AND precio IS NOT NULL;
SELECT clientes.nombre, ROUND(productos.precio*compras.cantidad*1.21, 2) FROM clientes, productos, compras WHERE DNI=compras.cliente AND compras.producto=cod_prod AND direccion='Málaga';

SELECT ofertas.*, productos.nombre, trabajadores.nombre FROM ofertas, tiendas, trabajadores, productos WHERE cod_prod=ofertas.producto AND ofertas.tienda=cod_tienda AND ofertas.trabajador=codigo AND trabajadores.tienda=cod_tienda AND metros>500;
SELECT DISTINCT direccion FROM clientes, compras, productos WHERE DNI=compras.cliente AND compras.producto=cod_prod AND precio IS NOT NULL;
SELECT productos.nombre, precio FROM productos, ofertas WHERE cod_prod=ofertas.producto AND ofertas.trabajador IS NULL;
SELECT productos.nombre FROM productos, ofertas WHERE cod_prod=ofertas.producto AND (inicio='01/04/24' OR inicio='01/06/24');




