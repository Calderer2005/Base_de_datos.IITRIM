CREATE TABLE departamento(
    cod_depto NUMBER(3) PRIMARY KEY,
    nombre VARCHAR2(50) NOT NULL
);

CREATE TABLE trabajador(
    dni VARCHAR2(9) PRIMARY KEY,
    nombre VARCHAR2(50) NOT NULL,
    direccion VARCHAR2(100),
    cod_depto NUMBER(3),
    
    CONSTRAINT fk_tra_dpto FOREIGN KEY (cod_depto) REFERENCES departamento(cod_depto)
);

CREATE TABLE familiar(
    dni VARCHAR2(9),
    nombre VARCHAR2 (50),
    parentesco VARCHAR2(5) CHECK (parentesco IN ('hijo', 'padre')),
    
    CONSTRAINT pk_familiar PRIMARY KEY (dni, nombre),
    CONSTRAINT fk_fam_trab FOREIGN KEY (dni) REFERENCES trabajador(dni)
);

CREATE TABLE proyecto(
    nombre_proy VARCHAR2(50) PRIMARY KEY,
    presup NUMBER(7) DEFAULT 5000,
    cod_depto NUMBER(3),
    
    CONSTRAINT fk_proy FOREIGN KEY (cod_depto) REFERENCES departamento(cod_depto)
);

CREATE TABLE trabaja(
    dni VARCHAR2(9),
    nombre_proy VARCHAR2(50),
    n_horas NUMBER(4) DEFAULT NULL CHECK (n_horas >= 50),
    
    CONSTRAINT pk_trabaja PRIMARY KEY (dni, nombre_proy),
    CONSTRAINT fk_trabaja_trab FOREIGN KEY (dni) REFERENCES trabajador(dni),
    CONSTRAINT fk_trab_proy FOREIGN KEY (nombre_proy) REFERENCES proyecto(nombre_proy)
);

//--------------------------------------------

CREATE TABLE estacion(
    id_estacion NUMBER(5) PRIMARY KEY,
    horario VARCHAR2(5) NOT NULL,
    direccion VARCHAR2(20) NOT NULL
);
CREATE TABLE linea(
    nombre VARCHAR2(50) PRIMARY KEY,
    inicio NUMBER(5),
    fin NUMBER(5),
    
    CONSTRAINT fk_linea_ini FOREIGN KEY (inicio) REFERENCES estacion(id_estacion),
    CONSTRAINT fk_linea_ini FOREIGN KEY (fin) REFERENCES estacion(id_estacion)
);
CREATE TABLE recorridos(
    linea VARCHAR2(20),
    estacion NUMBER(5),
    orden NUMBER(5),
    
    CONSTRAINT pk_reco PRIMARY KEY (linea, estacion),
    CONSTRAINT fk_reco_linea FOREIGN KEY (linea) REFERENCES linea(nombre),
    CONSTRAINT fk_reco_est FOREIGN KEY (estacion) REFERENCES estacion(id_estacion)
);
CREATE TABLE acceso(
    id_estacion NUMBER(5),
    num_acceso NUMBER(2),
    discap NOT NULL CHECK (discapacitados IN ('N', 'S')),
    
    CONSTRAINT pk_acceso PRIMARY KEY (id_estacion, num_acceso),
    CONSTRAINT fk_acc_est FOREIGN KEY (estacion) REFERENCES estacion(id_estacion)
);
CREATE TABLE cochera(
    id_cochera NUMBER(5) PRIMARY KEY,
    metros NUMBER(4, 2) CHECK (metros > 100),
    estacion NUMBER(5),
    
    CONSTRAINT fk_coch_est FOREIGN KEY (estacion) REFERENCES estacion(id_estacion)
);
CREATE TABLE tren(
    id_tren NUMBER(5) PRIMARY KEY,
    vagones NUMBER(1) CHECK (vagones >= 1 AND vagones <= 3),
    linea VARCHAR2(50),
    cochera NUMBER(5),
    
    CONSTRAINT fk_tren_linea FOREIGN KEY (linea) REFERENCES linea(nombre),
    CONSTRAINT fk_coch_rec FOREIGN KEY (cochera) REFERENCES cochera(id_cochera)
);

//--------------------------------------------

CREATE TABLE equipo(
    nombre VARCHAR2(30) PRIMARY KEY,
    ciudad VARCHAR2(30) NOT NULL
);
CREATE TABLE jugador(
    dni VARCHAR2(9) PRIMARY KEY,
    nombre VARCHAR2(50) NOT NULL,
    dorsal NUMBER(2) CHECK (dorsal >= 1 AND drosal <= 30),
    equipo VARCHAR2(30) NOT NULL,
    
    CONSTRAINT fk_jug_equ FOREIGN KEY (equipo) REFERENCES equipo(nombre)
);
CREATE TABLE partido(
    id_partido NUMBER(5) PRIMARY KEY,
    fecha DATE NOT NULL,
    resultado VARCHAR2(5) DEFAULT NULL
);
CREATE TABLE juega(
    dni_jugador VARCHAR2(9),
    id_partido NUMBER(5),
    posicion VARCHAR2(1) CHECK (posicion IN ('D', 'F', 'P', 'S')),
    
    CONSTRAINT pk_jug_part PRIMARY KEY (dni_jugador, id_partido),
    CONSTRAINT fk_juega_jug FOREIGN KEY (dni_jugador) REFERENCES jugador(dni),
    CONSTRAINT fk_juega_part FOREIGN KEY (id_partido) REFERENCES partido(id_partido)
);
CREATE TABLE rivales(
    id_partido NUMBER(5),
    local VARCHAR2(30),
    visitante VARCHAR2(30),
    
    CONSTRAINT pk_rivales PRIMARY KEY (id_partido, local, visitante),
    CONSTRAINT fk_riv_part FOREIGN KEY (id_partido) REFERENCES partido(id_partido),
    CONSTRAINT fk_riv_local FOREIGN KEY (local) REFERENCES equipo(nombre),
    CONSTRAINT fk_riv_visi FOREIGN KEY (visitante) REFERENCES equipo(nombre)
);

//--------------------------------------------

CREATE TABLE clientes(
    dni VARCHAR2(9) PRIMARY KEY,
    nombre VARCHAR2(50) NOT NULL,
    fecha_nac DATE,
    direccion VARCHAR2(50),
    sexo VARCHAR2(6) CHECK (sexo IN ('hombre', 'mujer'))
);
CREATE TABLE productos(
    cod NUMBER(10) PRIMARY KEY,
    nombre VARCHAR2(20) UNIQUE NOT NULL,
    stock NUMBER(4),
    precio NUMBER(2),
    tipo VARCHAR2(10)
);
CREATE TABLE compras(
    dni_cliente VARCHAR2(9),
    cod_prod NUMBER(10),
    fecha DATE,
    cantidad NUMBER(2),
    
    CONSTRAINT pk_compras PRIMARY KEY (dni_cliente, cod_prod, fecha),
    CONSTRAINT fk_comp_cli FOREIGN KEY (dni_cliente) REFERENCES clientes(dni),
    CONSTRAINT fk_comp_prod FOREIGN KEY (cod_prod) REFERENCES productos(cod)
);
CREATE TABLE tiendas(
    cod NUMBER(10) PRIMARY KEY,
    metros NUMBER(5)
);
CREATE TABLE trabajadores(
    cod NUMBER(5) PRIMARY KEY,
    nombre VARCHAR2(50) NOT NULL,
    categoria VARCHAR2(20) NOT NULL,
    area VARCHAR2(20) NOT NULL,
    cod_tienda NUMBER(10),
    
    CONSTRAINT fk_trab_tiend FOREIGN KEY (cod_tienda) REFERENCES tiendas(cod)
);
CREATE TABLE ofertas(
    cod NUMBER(10) PRIMARY KEY,
    cod_tienda NUMBER(10),
    cod_prod NUMBER(10),
    cod_trabajador NUMBER(10),
    tipo VARCHAR2(20) NOT NULL,
    inicio DATE,
    fin DATE,
    
    CONSTRAINT fk_ofer_tiend FOREIGN KEY (cod_tienda) REFERENCES tiendas(cod),
    CONSTRAINT fk_ofer_prod FOREIGN KEY (cod_prod) REFERENCES productos(cod),
    CONSTRAINT fk_ofer_trab FOREIGN KEY (cod_trabajador) REFERENCES trabajadores(cod)
);

DROP TABLE clientes CASCADE CONSTRAINT;

ALTER TABLE clientes
ADD tlf NUMBER(9)

ALTER TABLE trabajadores
ADD tlf NUMBER(9)

ALTER TABLE productos
DROP COLUMN stock

ALTER TABLE clientes
MODIFY tlf CHECK( tlf >= 600000000);

ALTER TABLE trabajadores
MODIFY tlf CHECK( tlf >= 600000000);

ALTER TABLE productos
MODIFY precio DEFAULT 0;

ALTER TABLE tiendas ADD(
    nombre VARCHAR2(50) NOT NULL,
    localizacion VARCHAR2(100)
);

ALTER TABLE productos
MODIFY precio CHECK (precio >= 0 AND precio <=10);

ALTER TABLE productos
ADD stock NUMBER(6)

ALTER TABLE productos
MODIFY stock CHECK (stock >= 0);

INSERT INTO clientes VALUES ('11111111F', 'ERICA', '01/01/00', 'GRANADA', 'M', NULL);
INSERT INTO clientes VALUES ('11111111Z', 'LUCIA', '12/05/02', 'GRANADA', 'mujer');
INSERT INTO clientes VALUES ('22222222B', 'MONICA', '18/12/08', 'JAEN', 'mujer');
INSERT INTO clientes VALUES ('12345678C', 'LUIS', '03/01/05', 'GRANADA', 'hombre');
INSERT INTO clientes VALUES ('33333333R', 'CÉSAR', '08/09/03', 'GRANADA', 'hombre');
INSERT INTO clientes VALUES ('55555555T', 'ROBERTO', '24/11/08', 'MALAGA', 'hombre');   


ALTER TABLE productos
MODIFY precio NUMBER(4,2) check (precio > 0.0 AND precio <= 10.0);

ALTER TABLE productos
MODIFY tipo NUMBER(2);

INSERT INTO productos VALUES (1, 'Lápiz negro', 100, 0.75, 1);
INSERT INTO productos VALUES (2, 'Bolígrafo azul', 85, NULL, 1);
INSERT INTO productos VALUES (3, 'Libreta A4', 60, 1.75, 2);
INSERT INTO productos VALUES (4, 'Cuaderno rubio', 50, 3.25, 2);
INSERT INTO productos VALUES (5, 'Corrector', 86, NULL, 3);
INSERT INTO productos VALUES (6, 'Goma borrar', 150, 0.35, 3);

INSERT INTO compras VALUES ('11111111Z', 1, '25/10/23', 2);
INSERT INTO compras VALUES ('12345678C', 1, '26/10/23', 1);
INSERT INTO compras VALUES ('11111111Z', 2, '25/10/23', 4);
INSERT INTO compras VALUES ('55555555T', 2, '26/10/23', 3);
INSERT INTO compras VALUES ('11111111Z', 3, '26/10/23', 1);
INSERT INTO compras VALUES ('12345678C', 4, '26/10/23', 1);
INSERT INTO compras VALUES ('33333333R', 2, '25/10/23', 6);
INSERT INTO compras VALUES ('11111111Z', 1, '30/10/23', 5);
INSERT INTO compras VALUES ('12345678C', 3, '02/11/23', 2);
INSERT INTO compras VALUES ('12345678C', 4, '30/10/23', 1);
INSERT INTO compras VALUES ('33333333R', 1, '25/10/23', 4);
INSERT INTO compras VALUES ('55555555T', 2, '30/10/23', 3);
INSERT INTO compras VALUES ('55555555T', 3, '30/10/23', 1);
INSERT INTO compras VALUES ('55555555T', 3, '02/11/23', 2);
INSERT INTO compras VALUES ('12345678C', 4, '02/11/23', 2);

SELECT compras.*, clientes.nombre FROM compras, clientes WHERE clientes.dni = dni_cliente;
SELECT compras.*, clientes.nombre FROM compras, clientes WHERE clientes.dni = dni_cliente AND cantidad > 4 AND cod_prod = 2;
SELECT DISTINCT productos.nombre FROM compras, productos WHERE cod_prod = productos.cod AND cantidad < 3; /*DISTINCT PARA QUE NO SE REPITA EL PRODUCTO*/
SELECT DISTINCT productos.* FROM compras, productos, clientes WHERE compras.dni_cliente = clientes.dni AND compras.cod_prod = productos.cod AND clientes.nombre = 'LUCIA';

DROP TABLE tiendas CASCADE CONSTRAINTS;
DROP TABLE trabajadores CASCADE CONSTRAINTS;
DROP TABLE ofertas CASCADE CONSTRAINTS;


INSERT INTO tiendas VALUES (1, 500);
INSERT INTO tiendas VALUES (2, 800);
INSERT INTO tiendas VALUES (3, 250);
INSERT INTO trabajadores VALUES (18, 'Pedro', 'Encargado', 'Cajas', 1);
INSERT INTO trabajadores VALUES (21, 'Elena', 'Encargado', 'Reposición', 1);
INSERT INTO trabajadores VALUES (35, 'Manuel', 'Suplente', 'Reposición', 3);

ALTER TABLE ofertas
MODIFY inicio VARCHAR2(20);

ALTER TABLE ofertas
MODIFY fin VARCHAR2(20);

INSERT INTO ofertas VALUES (1, 1, 2, 18, 1, 'Septiembre', 'Octubre');
INSERT INTO ofertas VALUES (2, 2, 6, NULL, 1, 'Octubre', 'Noviembre');
INSERT INTO ofertas VALUES (3, 3, 6, 35, 2, 'Julio', 'Agosto');
INSERT INTO ofertas VALUES (4, 3, 3, 35, 3, 'Octubre', 'Diciembre');

SELECT productos.nombre FROM productos, ofertas, tiendas WHERE tiendas.cod = 3 AND ofertas.cod_tienda = tiendas.cod AND ofertas.cod_prod = productos.cod;
SELECT ofertas.cod FROM ofertas, productos WHERE productos.nombre = 'Bolígrafo azul' AND ofertas.cod_prod = productos.cod;
SELECT ofertas.cod FROM ofertas, productos WHERE productos.nombre = 'Goma borrar' AND ofertas.cod_prod = productos.cod;
SELECT tiendas.metros FROM ofertas, productos, tiendas WHERE productos.nombre = 'Bolígrafo azul' AND ofertas.cod_prod = productos.cod AND cod_tienda = tiendas.cod;
SELECT trabajadores.nombre, trabajadores.categoria FROM trabajadores, tiendas WHERE cod_tienda = 1 AND cod_tienda = tiendas.cod;
SELECT ofertas.* FROM ofertas, trabajadores, tiendas WHERE trabajadores.nombre = 'Elena' AND ofertas.cod_tienda = tiendas.cod AND trabajadores.cod_tienda = tiendas.cod;

SELECT productos.nombre FROM productos, ofertas WHERE ofertas.inicio = 'Septiembre' AND productos.cod = ofertas.cod_prod;
SELECT productos.nombre FROM productos, ofertas, tiendas WHERE productos.cod = ofertas.cod_prod AND ofertas.cod_tienda = tiendas.cod AND metros = 500;
SELECT productos.nombre FROM productos, clientes, compras WHERE direccion = 'GRANADA' AND compras.dni_cliente = clientes.dni AND cod_prod = productos.cod;
SELECT clientes.direccion FROM clientes, compras, productos WHERE cantidad > 7 AND productos.nombre = 'Bolígrafo azul' AND dni_cliente = clientes.dni AND cod_prod = productos.cod;

SELECT clientes.nombre, compras.* FROM  clientes, compras WHERE direccion = 'GRANADA' AND dni_cliente = clientes.dni ORDER BY clientes.nombre;
SELECT direccion FROM clientes, compras, productos WHERE cantidad = 8 AND productos.nombre = 'Bolígrafo azul' AND cod_prod = productos.cod AND dni_cliente = clientes.dni;
SELECT tiendas.* FROM tiendas, ofertas, productos WHERE precio is null AND cod_tienda = tiendas.cod AND cod_prod = productos.cod;
SELECT productos.nombre, productos.precio FROM productos, ofertas WHERE ofertas.tipo = 2 AND cod_prod = productos.cod;

SELECT DISTINCT clientes.* FROM clientes, compras, productos WHERE productos.nombre = 'Bolígrafo azul' AND cod_prod = productos.cod AND dni_cliente = clientes.dni ORDER BY fecha_nac;
SELECT DISTINCT clientes.nombre FROM clientes, compras, productos WHERE precio is not null AND dni_cliente = clientes.dni AND cod_prod = productos.cod;
SELECT clientes.nombre, productos.nombre, cantidad, precio*1.21 FROM compras, clientes, productos WHERE cod_prod = productos.cod AND dni_cliente = clientes.dni AND direccion = 'MALAGA';

SELECT ofertas.*, productos.nombre, trabajadores.nombre FROM ofertas, tiendas, trabajadores, productos WHERE metros = 500 AND ofertas.cod_tienda = tiendas.cod AND ofertas.cod_prod = productos.cod AND cod_trabajador = trabajadores.cod;
SELECT DISTINCT direccion FROM clientes, compras, productos WHERE precio is not null AND dni_cliente = clientes.dni AND cod_prod = productos.cod;
SELECT DISTINCT productos.nombre, productos.precio FROM productos, ofertas, trabajadores WHERE cod_trabajador is null AND cod_prod = productos.cod;
SELECT productos.nombre FROM productos, ofertas WHERE cod_prod = productos.cod AND inicio = 'Abril' OR inicio = 'Junio';

 






