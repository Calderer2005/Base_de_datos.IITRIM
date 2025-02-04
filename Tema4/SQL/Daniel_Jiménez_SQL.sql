CREATE TABLE Estrella 
(
    Nombre VARCHAR2(50) PRIMARY KEY,
    Dirección VARCHAR2(100) NOT NULL UNIQUE,
    Sexo VARCHAR2(1) CHECK (Sexo IN ('H', 'M')),
    Fecha_Nacimiento Date 
);

CREATE TABLE Estudio
(
  Nombre VARCHAR2(50) PRIMARY KEY,
  Dirección VARCHAR2(100) NOT NULL UNIQUE
);

CREATE TABLE Película
(
    Titulo VARCHAR2(50),
    Anio NUMBER(4,0), CHECK (anio > 1900),
    Duración NUMERIC(3,0),
    Nombre_Estudio VARCHAR2(50),
    
    CONSTRAINT pk_peli PRIMARY KEY(Titulo, anio),
    CONSTRAINT fk_nom_estu FOREIGN KEY(Nombre_Estudio) REFERENCES Estudio(nombre)
);

CREATE TABLE Protagoniza
(
    Titulo_Pelicula VARCHAR2(30),
    Anio_Pelicula NUMBER(4,0),
    Nombre_Estrella VARCHAR2(50),
    
    CONSTRAINT pk_protago PRIMARY KEY(Titulo_Pelicula,Anio_Pelicula,Nombre_Estrella),
    CONSTRAINT fk_prota_peli FOREIGN KEY(Titulo_Pelicula,Anio_Pelicula) REFERENCES Pelicula(Titulo, Anio),
    CONSTRAINT fk_prota_estre FOREIGN KEY(Nombre_Estrella) REFERENCES Estrella(Nombre)
);

CREATE TABLE Persona 
(
    Nombre VARCHAR2(50) PRIMARY KEY,
    Calle VARCHAR2(40) NOT NULL,
    Ciudad VARCHAR(20) NOT NULL
);

CREATE TABLE Trabaja
(
    Nombre_Persona VARCHAR(50) PRIMARY KEY,
    Nombre_Compania VARCHAR(100) NOT NULL,
    Salario NUMBER(4,0) DEFAULT (1000.00),
    
    CONSTRAINT fk_traba_perso FOREIGN KEY (Nombre_Persona) REFERENCES Persona(Nombre),
    CONSTRAINT fk_tra_comp FOREIGN KEY (Nombre_Compania) REFERENCES Compania(Nombre_Compa)
);

CREATE TABLE Compania
(
    Nombre_Compania VARCHAR2(100) PRIMARY KEY,
    Ciudad VARCHAR2(20) NOT NULL
);

CREATE TABLE Dirige
(
    Nombre_Persona VARCHAR2(50),
    Nombre_Director VARCHAR(50),
    
    CONSTRAINT pk_diri PRIMARY KEY (Nombre_persona, Nombre_Director),
    CONSTRAINT fk_trabajador FOREIGN KEY (Nombre_Persona) REFERENCES Persona(Nombre),
    CONSTRAINT fk_director FOREIGN KEY (Nombre_Director) REFERENCES Persona(Nombre)
):

CREATE TABLE Profesor
(
    rfc VARCHAR2(50) PRIMARY KEY,
    nombre VARCHAR2(50),
    direccion VARCHAR2(40) NOT NULL UNIQUE,
    telefono NUMBER(9,0),
    cod_depto VARCHAR2(20) NOT NULL UNIQUE,
    cod_centro VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE Alumno 
(
    control VARCHAR2(50) PRIMARY KEY,
    nombre VARCHAR2(50),
    direccion VARCHAR2(40)NOT FULL UNIQUE,
    control_del VARCHAR(
);

CREATE TABLE Departamento
(
    cod_depto NUMBER(3,0) PRIMARY KEY,
    nombre VARCHAR2(50) NOT NULL
);
CREATE TABLE Familiar 
(
    dni VARCHAR(9),
    nombre VARCHAR2(50),
    parentesco VARCHAR2(5) CHECK(parentesco IN ('hijo', 'padre')),
    
    CONSTRAINT pk_familiar PRIMARY KEY (dni, nombre),
    CONSTRAINT fk_fam_trab FOREIGN KEY (dni) REFERENCES trabajador(dni),
);
CREATE TABLE Trabajador
(
    dni VARCHAR2(9) PRIMARY KEY,
    nombre VARCHAR2(50)NOT NULL,
    direccion VARCHAR2(100), 
    cod_depto NUMBER(3,0),
    
    CONSTRAINT fk_tra_dpto FOREIGN KEY (cod_dpto)REFERENCES departamento (cod_dpto)
);
CREATE TABLE Proyecto
(
    nombre_proyecto VARCHAR2(100) PRIMARY KEY,
    presupuesto NUMBER (7,0), DEFAULT 5000,
    cod_depto NUMBER(3,0)
    
    CONSTRAINT fk_proy FOREIGN KEY (cod_dpto) REFeRENCES departamento(cod_dpto),
);
CREATE TABLE Trabaja
(
    dni VARCHAR2(9),
    nombre_proy VARCHAR(50),
    n_horas NUMBER(4) DEFAULT NULL CHECK (n_horas >=50),
    
    CONSTRAINT pk_trabaja PRIMARY KEY (dni, nombre_proy),
    CONSTRAINT fk_trabaja_trab FOREIGN KEY (dni) REFERENCES trabajador(dni),
    CONSTRAINT fk_trab_proy FOREIGN KEY (nombre_proy) REFERENCES proyecto(nombre_proyecto)
);

CREATE TABLE linea 
(
    nombre VARCHAR2 (50) PRIMARY KEY,
    inicio VARCHAR2 (5),
    fin (5),
    
    
);
CREATE TABLE tren
(
    id_tren NUMBER(5) PRIMARY KEY,
    vagones NUMBER(1) CHECK (vagones >=1 AND vagones <=3),
    
    CONSTRAINT fk_tren_linea FOREIGN KEY (linea) REFERENCES (linea(nombre),
    CONSTRAINT fk_acc_est FOREIGN KEY (id_e) REFERENCES estacion(id_e)
);
CREATE TABLE cochera
(
    id_cochera VARCHAR2 (20) PRIMARY KEY,
    metros NUMBER (4,2) CHECK (metros > 100),
    estacion NUMBER(5),
    
     CONSTRAINT fk_coch_est FOREIGN KEY (estacion) REFERENCES estacion(id_estacion),
);
CREATE TABLE acceso
(
    id_estacion NUMBER (5),
    num_acceso NUMBER (2),
    discapacitados  VARCHAR2(2) NOT NULL CHECK(parentesco IN ('N', 'S')),
    
    CONSTRAINT pk_acceso PRIMARY KEY (id_e, num_acceso),
    CONSTRAINT fk_acc_est FOREIGN KEY (id_e) REFERENCES estacion(id_e)
);
CREATE TABLE estacion
(
    id_estacion NUMBER (5) PRIMARY KEY,
    horario VARCHAR2 (5) NOT NULL,
    dirección VARCHAR (20) NOT NULL
);
CREATE TABLE recorridos
(
    linea VARCHAR2 (30),
    estacion NUMBER (5),
    orden NUMBER (2)
    
    CONSTRAINT pk_reco PRIMARY KEY (linea, estacion),
    CONSTRAINT fk_reco_linea FOREIGN KEY (linea) REFERENCES linea(nombre),
    CONSTRAINT fk_reco_est FOREIGN KEY (estacion) REFERENCES estacion(id_e),
);
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
    precio DEFAULT(0) CHECK (precio>=0 AND precio<=10)
);
AFTER TABLE 

INSERT INTO clientes (dni, nombre, fecha_nac, direccion, sexo) VALUES 
('11111111Z', 'Lucía', '12/07/2002', 'Granada', 'M');
INSERT INTO clientes (dni, nombre, fecha_nac, direccion, sexo) VALUES 
('22222222B', 'Mónica', '18/12/2008', 'Jaén', 'M');
INSERT INTO clientes (dni, nombre, fecha_nac, direccion, sexo) VALUES 
('12345678C', 'Luis', '03/01/2005', 'Granada', 'H');
INSERT INTO clientes (dni, nombre, fecha_nac, direccion, sexo) VALUES 
('33333333R', 'César', '08/09/2003', 'Granada', 'H');
INSERT INTO clientes (dni, nombre, fecha_nac, direccion, sexo) VALUES 
('55555555T', 'Roberto', '24/11/2008', 'Granada', 'H');

ALTER TABLE producto
MODIFY NUMBER(2,0);

ALTER TABLE producto
MODIFY precio NULL;

INSERT INTO productos (cod_prod, nombre, stock, precio, tipo) VALUES
(1, 'Lápiz negro', 100, 0.75, '1');
INSERT INTO productos (cod_prod, nombre, stock, precio, tipo) VALUES
(2, 'Bolígrafo azul', 85, NULL, '1');
INSERT INTO productos (cod_prod, nombre, stock, precio, tipo) VALUES
(3, 'Libreta A4', 60, 1.75, '2');
INSERT INTO productos (cod_prod, nombre, stock, precio, tipo) VALUES
(4, 'Cuaderno rubio', 50, 3.25, '2');
INSERT INTO productos (cod_prod, nombre, stock, precio, tipo) VALUES
(5, 'Corrector', 86, NULL, '3');
INSERT INTO productos (cod_prod, nombre, stock, precio, tipo) VALUES
(6, 'Goma Borrar', 150, 0.35, '3');

INSERT INTO compras (cliente, producto, fecha, cantidad) VALUES
('11111111Z', 1, '25/10/2023', 2);
INSERT INTO compras (cliente, producto, fecha, cantidad) VALUES
('12345678C', 1, '26/10/2023', 1);
INSERT INTO compras (cliente, producto, fecha, cantidad) VALUES
('11111111Z' 2, '25/10/2023', 4);
INSERT INTO compras (cliente, producto, fecha, cantidad) VALUES
('55555555T', 2, '26/10/2023', 3);
INSERT INTO compras (cliente, producto, fecha, cantidad) VALUES
('11111111Z', 2, '26/10/2023', 1);
INSERT INTO compras (cliente, producto, fecha, cantidad) VALUES
('12345678C', 4, '26/10/2023', 1);
INSERT INTO compras (cliente, producto, fecha, cantidad) VALUES
('33333333R', 2, '25/10/2023', 6);
INSERT INTO compras (cliente, producto, fecha, cantidad) VALUES
('11111111Z', 1, '30/10/2023', 5);
INSERT INTO compras (cliente, producto, fecha, cantidad) VALUES
('12345678C', 3, '2/11/2023', 2);
INSERT INTO compras (cliente, producto, fecha, cantidad) VALUES
('12345678C', 4, '30/10/2023', 1);
INSERT INTO compras (cliente, producto, fecha, cantidad) VALUES
('33333333R', 1, '25/10/2023', 4);
INSERT INTO compras (cliente, producto, fecha, cantidad) VALUES
('55555555T', 2, '30/10/2023', 3);
INSERT INTO compras (cliente, producto, fecha, cantidad) VALUES
('55555555T', 3, '30/10/2023', 1);
INSERT INTO compras (cliente, producto, fecha, cantidad) VALUES
('55555555T', 3, '02/11/2023', 2);
INSERT INTO compras (cliente, producto, fecha, cantidad) VALUES
('12345678C', 4, '02/11/2023', 2);

DELETE FROM compras;
DELETE FROM clientes WHERE direccion= 'Málaga';
DELETE FROM productos WHERE precio<1;
DELETE FROM cliente WHERE sexo= 'H';
DELETE FROM productos; 
DELETE FROM clientes;

DELETE FROM compra WHERE cantidad<3;

UPDATE clientes
SET fecha_nac='11/05/2002';
WHERE dni='11111111Z';

UPDATE producto
SET precio=1.25
stock = 125
WHERE nombre='Bolígrafo azul';

UPDATE clientes
SET direccion='Malaga'
WHERE nombre='Monica';

UPDATE producto
SET precio = precio + 0,25;

UPDATE compra
SET cantidad = cantidad + 1
WHERE producto=2;

UPDATE producto
SET precio=1.25
WHERE tipo=1 OR tipo=2;

SELECT dni,nombre FROM clientes;
SELECT direccion FROM clientes;
SELECT * FROM clientes;
SELECT dni,nombre,fecha_nac,direccion,sexo FROM clientes;

SELECT nombre FROM cliente WHERE direccion='Granada';

SELECT nombre FROM cliente WHERE sexo='M';

SELECT nombre, dni FROM clientes WHERE direccion != 'Granada';

SELECT * FROM clientes WHERE nombre = 'Lucia';

SELECT nombre FROM productos
SELECT precio FROM productos
SELECT cod_prod, precio From productos
SELECT precio FROM productos WHERE tipo=2
SELECT * FROM productos WHERE cod_prod=4
SELECT * FROM productos WHERE precio>0.75
SELECT nombre FROM productos WHERE precio =<0.75 and >=1.25;

SELECT clientes FROM compras
SELECT clientes FROM compras WHERE producto=3
SELECT clientes FROM compras WHERE producto=1 AND cantidad>3
SELECT clientes, productos FROM compras WHERE cantidad>3
SELECT nombre, precio*1.21 FROM productos
SELECT nombre FROM producto WHERE precio IS NOT NULL
SELECT * FROM cliente WHERE direccion IS NOT NULL
SELECT direccion FROM cliente WHERE direccion IS NOT NULL
SELECT DISTINCT direccion FROM cliente WHERE direccion IS NOT NULL

CREATE TABLE duenios
(
    DNI VARCHAR2(9) PRIMARY KEY,
    nom VARCHAR2(50)
);

CREATE TABLE perros
(
    num NUMBER(4) PRIMARY KEY,
    nom VARCHAR2(20),
    dni_DUE VARCHAR(9),
    
    CONSTRAINT fk_perr_due FOREIGN KEY (dni_DUE) REFERENCES duenios(DNI)
);

INSERT INTO duenios VALUES ('11111111R', 'Rocio');
INSERT INTO duenios VALUES ('22222222D', 'Federico');
INSERT INTO duenios VALUES ('12345678P', 'Erica');
INSERT INTO duenios VALUES ('11131511R', 'Paloma');

INSERT INTO perros VALUES (1, '11111111Z', 'Coco');
INSERT INTO perros VALUES (2, '11123411R', 'Rot');
INSERT INTO perros VALUES (3, '55555555L', 'Moc');
INSERT INTO perros VALUES (4, '13344111R', 'Loc');

SELECT * FROM duenios ,perros WHERE dni=dni_DUE;

SELECT * FROM compras, productos WHERE cod_prod = producto

SELECT compras.*, clientes.nombre FROM clientes, compras WHERE producto > 4 AND cod_prod = 2
SELECT compras.*, clientes.nombre FROM clientes, compras WHERE producto < 3
SELECT compras, clientes.nombre FROM clientes, compras WHERE nombre = 'Monica' 

SELECT compras.*, producto.nombre FROM compras, clientes WHERE dni=cliente;

SELECT * FROM cliente, compra WHERE cantidad > 4 AND producto=2;

SELECT producto.nombre FROM compra, producto WHERE cantidad < 3 AND cod=producto;

SELECT DISTINCT producto.* FROM compra, producto, cliente WHERE compra.cliente=cliente.dni AND compra.producto=producto.cod_prod AND cliente.nombre='Monica'

CREATE TABLE trabajadores
(
    codigo NUMERIC(10) PRIMARY KEY,
    nombre VARCHAR2(50), 
    categoria VARCHAR2(30),
    area NUMERIC(4,2) CHECK ( area > 100),
    tienda VARCHAR2(30)
);

CREATE TABLE tiendas 
(
    cod_tienda NUMERIC(20) PRIMARY KEY,
    metros NUMBER(4,4) 
);
CREATE TABLE ofertas
(
    cod_of NUMERIC(20) PRIMARY KEY,
    tienda VARCHAR2(30),
    producto  NUMERIC(5),
    trabajador VARCHAR2(30),
    tipo_of VARCHAR(20) NOT NULL,
    inicio VARCHAR2(20),
    fin VARCHAR2(20)
);

INSERT INTO trabajadores (codigo, nombre, categoria, area, tienda) VALUES (18, 'Pedro', 'Encargado','cajas', 1);
INSERT INTO trabajadores (codigo, nombre, categoria, area, tienda) VALUES (21, 'Elena', 'Encargado','reposicion', 1);
INSERT INTO trabajadores (codigo, nombre, categoria, area, tienda) VALUES (35, 'Manuel', 'suplente','reposicion', 3);

INSERT INTO tiendas (cod_tienda, metros) VALUES (1,500);
INSERT INTO tiendas (cod_tienda, metros) VALUES (2,800);
INSERT INTO tiendas (cod_tienda, metros) VALUES (3,250);

INSERT INTO ofertas (cod_of, tienda, producto, trabajador, tipo_of, inicio, fin) VALUES (1,1,2,18,1,'septiembre','octubre');
INSERT INTO ofertas (cod_of, tienda, producto, trabajador, tipo_of, inicio, fin) VALUES (2,2,6,null,1,'octubre','noviembre');
INSERT INTO ofertas (cod_of, tienda, producto, trabajador, tipo_of, inicio, fin) VALUES (3,3,6,35,2,'julio','agosto');
INSERT INTO ofertas (cod_of, tienda, producto, trabajador, tipo_of, inicio, fin) VALUES (4,3,3,35,3,'octubre','diciembre');

SELECT productos.nombre FROM productos, ofertas WHERE productos.oferta=producto.cod WHERE producto.nombre;
SELECT oferta.cod FROM oferta, producto WHERE producto.nombre='Boligrafo azul' AND oferta.producto=producto.cod;
SELECT trabajadores.nombre, trabajadores.categoria FROM trabajadores, tienda WHERE trabajadores.tienda=tienda.cod_tienda AND tienda.cod_tienda=1;
SELECT oferta.* FROM oferta, tienda, trabajadores WHERE oferta.tienda=tienda.cod_tienda AND trabajadores.tienda=tienda.cod_tienda AND trabajadores.nombre='Elena';


SELECT nombre.productos FROM ofertas, productos WHERE oferta.producto=productos.cod_prod AND inicio<'septiembre' AND fin>'octubre';
SELECT nombre.productos FROM tiendas, productos, oferta  WHERE oferta.producto=productos.cod_prod AND oferta.tienda=tienda.cod_tienda AND tienda.metros>500;
SELECT DISTINCT nombre.productos FROM clientes, productos, compras WHERE productos.cod_prod=productos.compras AND compras.cliente=cliente.DNI AND clientes.direccion='Granada'
SELECT direccion.clientes FROM clientes, productos, compras WHERE productos.cod_prod=productos.compras AND compras.cliente=cliente.DNI AND compras.cantidad>7 AND productos.nombre='Boligrafo azul';

SELECT nombres.clientes, compras.* FROM clientes, compras WHERE clientes.dni=clientes.compras AND direccion='Granada' ORDER BY clientes.nombre;
SELECT tienda.* FROM tienda,oferta,producto WHERE precio IS NULL AND tienda.cod=oferta.tienda AND oferta.producto=producto.cod;
SELECT nombre.productos, productos.precio FROM oferta, productos WHERE productos.cod_prod=producto.oferta AND producto.tipo=2;
SELECT DISTINCT clientes.* FROM clientes, compras, productos WHERE productos.cod_prod=producto.compras AND compras.clientes=clientes.DNI AND productos.nombre='Boligrafo Azul' ORDER BY clientes.fech_nac;
SELECT clientes.nombre, precio.cantidad*1.21 FROM clientes, compras, productos WHERE productos.cod_prod= compras.producto AND compras.clientes=clientes.DNI AND clientes.direccion='Málaga'; 
SELECT DISTINCT cliente.nombre FROM cliente,producto, compra WHERE dni=compra.cliente AND producto.cod=compra.producto AND precio IS NOT NULL;
SELECT oferta.codigo, oferta.tienda, producto.nombre, trabajador.nombre, oferta.tipo, inicio,fin
FROM oferta, trabajador, tienda, producto
WHERE producto.cod=oferta.producto AND trabajador.cod=oferta.trabajador
AND tienda.codigo=oferta.tienda AND mteros>500;