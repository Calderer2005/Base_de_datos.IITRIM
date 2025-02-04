CREATE TABLE Departamento
(
cod_depto NUMBER (3) PRIMARY KEY,
nombre VARCHAR2 (50)NOT NULL
);

CREATE TABLE Trabajador 
(
DNI VARCHAR2(9) PRIMARY KEY,
nombre VARCHAR2(20)NOT NULL,
direccion VARCHAR2(20),
cod_depto NUMBER(3),
CONSTRAINT pk_cod_depto FOREIGN KEY (cod_depto) REFERENCES Departamento (cod_depto) ,
);
CREATE TABLE Familiar 
(
DNI VARCHAR2(9) PRIMARY KEY,
nombre VARCHAR2 (50) PRIMARY KEY,
parentesco VARCHAR2 (20) CHECK (parentesco IN ('hijo', 'padre'))

CONSTRAINT pk_familiar PRIMARY KEY (DNI, nombre)
CONSTRAINT fk_fam_trab FOREIGN KEY (DNI) REFERENCES trabajador(DNI)
);
CREATE TABLE Proyecto
(
nombre_proyecto VARCHAR2 (20) PRIMARY KEY,
presupuesto NUMBER(7) DEFAULT 5000,
cod_depto NUMBER(3),
CONSTRAINT fk_proy FOREIGN KEY (cod_depto) REFERENCES Departamento(cod_depto)
);
CREATE TABLE Trabaja
(
DNI VARCHAR2(9),
nombre_proy VARCHAR2(50),
n_horas NUMBER(4) DEFAULT NULL CHECK(n_horas >=50),

CONSTRAINT pk_trabaja PRIMARY KEY (DNI, nombre_proy),
CONSTRAINT fk_trabaja_trab FOREIGN KEY (DNI) REFERENCES Trabajador(DNI),
CONSTRAINT fk_trab_proy FOREIGN KEY (nombre_proy) REFERENCES Proyecto(nombre_proyecto),
);

CREATE TABLE estacion
(
id_e NUMBER (5) PRIMARY KEY,
horario VARCHAR2 (5) NOT NULL,
direccion VARCHAR2(20) NOT NULL
);

CREATE TABLE acceso
(
id_e NUMBER(5),
num_acceso NUMBER (2),
discapacitados NOT NULL CHECK (discapacitados IN ('N','S'))

CONSTRAINT fk_acceso PRIMARY KEY (id_e ),
CONSTRAINT pk_acceso PRIMARY KEY  (id_e, num_acceso)
);

CREATE TABLE linea 
(
nombre VARCHAR2(50) PRIMARY KEY,
inicio NUMBER(5),
fin NUMBER(5),

CONSTRAINT fk_linea_ini FOREIGN KEY (inicio) REFERENCES estacion(id_e),
CONSTRAINT fk_linea_fin FOREIGN KEY (fin) REFERENCES estacion (id_e)
);

CREATE TABLE cochera 
(
id_c NUMBER(5) PRIMARY KEY,
metros NUMBER (4,2) CHECK (metros > 100),
estacion NUMBER (5)

CONSTRAINT fk_coch_est FOREIGN KEY (estacion) REFERENCES estacion(id_e)
);

CREATE TABLE tren
(
id_t NUMBER (5) PRIMARY KEY,
vagones NUMBER (1) CHECK (vagones >=1 AND vagones <=3),
linea VARCHAR2(50), 
cochera NUMBER (5),

CONSTRAINT fk_tren_linea FOREIGN KEY  (linea, ), REFERENCES linea (nombre), 
CONSTRAINT fk_reco_cochera FOREIGN KEY  (cochera) REFERENCES cochera (id_c)
);



CREATE TABLE recorridos
(
linea VARCHAR2(50),
estacion NUMBER (5),
orden

CONSTRAINT fk_reco_linea FOREIGN KEY (linea) REFERENCES linea (nombre),
CONSTRAINT pk_reco PRIMARY KEY  (linea, estacion),
CONSTRAINT fk_reco_estacion FOREIGN KEY (estacion) REFERENCES estacion (id_e)
);

CREATE TABLE equipo
(
nombre VARCHAR2(30) PRIMARY KEY,
ciudad VARCHAR2(30) NOT NULL
);
CREATE TABLE jugador 
(
DNI VARCHAR2(9) PRIMARY KEY,
nombre VARCHAR2(30)NOT NULL,
dorsal NUMBER (2) CHECK (dorsal >=1 AND dorsal <=30),
equipo VARCHAR2 (30), 

CONSTRAINT fk_jug_eq FOREIGN KEY (equipo) REFERENCES equipo(nombre)
);

CREATE TABLE partido 
(
id_p NUMBER(10) PRIMARY KEY,
fecha DATE NOT NUL,
resultado VARCHAR2(5) DEFAULT NULL
);

CREATE TABLE juega
(
DNI VARCHAR2(9) ,
partido NUMBER (2) ,
posicion VARCHAR2 (1) CHECK (posicion IN ('D', 'F', 'P','S')),

CONSTRAINT pk_juega PRIMARY KEY (DNI , partido),
CONSTRAINT fk_jueg_jug FOREIGN KEY (DNI) REFERENCES jugador (DNI),
CONSTRINT fk_jueg_part FOREIGN KEY (partido) REFERENCES partido(id_p)
);

CREATE TABLE rivales
(
id_p NUMBER (10),
local VARCHAR2(30),
visitante VARCHAR (30),

CONSTRAINT pk_rivales PRIMARY KEY (id_p , local, visitante),
CONSTRAINT fk_riv_local FOREIGN KEY (local) REFERENCES equipo (nombre),
CONSTRAINT fk_riv_visitante FOREIGN KEY (visitante) REFERENCES equipo (nombre)
);







CREATE TABLE clientes
(
DNI VARCHAR2(9) PRIMARY KEY,
nombre VARCHAR2(30) NOT NULL,
fecha_nac DATE NOT NULL,
direccion VARCHAR2 (30) NOT NULL,
sexo VARCHAR2 (1) CHECK (sexo IN ('H', 'M'))
);

CREATE TABLE tienda 
(
cod_tie NUMBER (5) PRIMARY KEY,
metros NUMBER (4,3) NOT NULL
);

CREATE TABLE trabajadores
(
cod_tra NUMBER (5) PRIMARY KEY,
nombre VARCHAR2 (30) NOT NULL,
categoria VARCHAR2 (20) NOT NULL,
area VARCHAR2(20) NOT NULL,
tienda NUMBER (5),

CONSTRAINT fk_trab_tie FOREIGN KEY (tienda) REFERENCES tienda (cod_tie)
);


CREATE TABLE productos
(
cod_prod NUMBER (5) PRIMARY KEY,
nombre VARCHAR2 (20) UNIQUE NOT NULL,
stock NUMBER (6) NOT NULL,
precio NUMBER (4,2) NOT NULL,
tipo VARCHAR2 (20) NOT NULL
);

CREATE TABLE compras 
(
cliente VARCHAR2(9),
producto NUMBER (5),
fecha DATE,
cantidad NUMBER(3) NOT NULL,

CONSTRAINT pk_cliente PRIMARY KEY (cliente) REFERENCES tienda (cod_tie),
CONSTRAINT pk_producto PRIMARY KEY (producto) REFERENCES producto (cod_prod)

);

CREATE TABLE oferta
(
cod_of NUMBER (5) PRIMARY KEY,
tienda NUMBER (5),
producto NUMBER (5),
trabajador NUMBER (5),
tipo VARCHAR2 (20) NOT NULL,
inicio, 
fin,

CONSTRAINT fk_of_tienda FOREIGN KEY (tienda) REFERENCES tienda (cod_tie),
CONSTRAINT fk_of_producto FOREIGN KEY (producto) REFERENCES producto (cod_prod),
CONSTRAINT fk_of_trabajador FOREIGN KEY (trabajadores) REFERENCES trabajadores (cod_tra)
);

DROP TABLE clientes ;

ALTER TABLE clientes 
ADD telefono NUMBER (9);

ALTER TABLE trabajadores 
ADD telefono NUMBER (9);

ALTER TABLE clientes 
MODIFY telefono NUMBER (9) CHECK (telefono >= 600000000);

ALTER TABLE trabajadores 
MODIFY telefono NUMBER (9) CHECK (telefono >= 600000000);

ALTER TABLE productoS
MODIFY precio NUMBER (4, 2) DEFAULT 0;

ALTER TABLE tienda ADD
( nombre VARCHAR2 (30),
 localizacion VARCHAR2(30)
 );

ALTER TABLE productos 
MODIFY stock NUMBER (6) CHECK (stock > 0 AND stock < 10);

SELECT producto.nombre FROM oferta, producto WHERE oferta.cod = prodcuto.cod AND oferta.tienda=3;

SELECT  oferta.cod FROM oferta, producto WHERE producto.nombre = 'Boligrafo azul'
and oferta.cod = producto.cod;

SELECT metros FROM tienda, producto, oferta WHERE producto.cod = oferta.producto
AND tienda.cod=oferta.tienda AND prodcuto.nombre = 'Lapiz negro';

SELECT nombre, categoria FROM trabajador WHERE tienda='1';

SELECT oferta.* FROM oferta, trabajador
WHERE oferta. tienda= tienda.cod AND trabajador.tienda=tienda.cod AND trabajador.nombre='Elena';

SELECT producto.nombre FROM productos, oferta WHERE productos.cod_prod=oferta.producto  AND inicio <='01/09/24' ;

SELECT producto.nombre FROM productos, oferta, tienda WHERE producto.cod=oferta.producto AND tienda .cod = oferta.product AND tienda.metros> 500 ;

SELECT DISTINCT producto.nombre FROM producto, compra ,cliente WHERE producto.cod=compra.producto AND cliente.dni=compra.cliente AND direccion='Granada';

SELECT direccion FROM cliente, compra, producto WHERE producto

SELECT compra.cliente FROM compra, cliente, direccion WHERE 
ORDER BY 

SELECT provincia.clientes FROM clientes,compra , provincia WHERE compra.cliente = '8 boligrafos azules';

SELECT oferta.producto FROM producto WHERE precio.producto IS 'NULL';

SELECT nombre, precio  FROM producto,oferta  WHERE producto.cod=oferta.producto AND oferta.tipo=2;

SELECT cliente.* FROM cliente, producto, compra WHERE dni=cliente AND producto.cod=producto AND producto.nombre ='Boligrafo azul'
ORDER BY f_nac ASC;

SELECT nombre.cliente FROM compra, clientes, productos WHERE precio.producto IS NOT NULL;

SELECT IVA, compra  FROM cliente, compra, WHERE p 

