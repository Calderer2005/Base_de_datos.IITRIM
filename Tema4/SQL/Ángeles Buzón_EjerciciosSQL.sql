// MODIFICACION DE TABLAS

// Primero creamos un conjunto de tablas
CREATE TABLE clientes
(
    dni VARCHAR2(9) PRIMARY KEY,
    nombre VARCHAR2(50) NOT NULL,
    fecha_nac DATE NOT NULL,
    direccion VARCHAR2(100),
    sexo VARCHAR2(1) CHECK (sexo IN ('H', 'M'))
);

CREATE TABLE productos
(
    cod_prod NUMBER(5) PRIMARY KEY,
    nombre VARCHAR2(20) UNIQUE NOT NULL,
    stock NUMBER(6) NOT NULL CHECK (stock >= 0),
    precio NUMBER(4,2) NOT NULL,
    tipo VARCHAR2(20)
);

CREATE TABLE compras
(
    cliente VARCHAR2(9),
    producto NUMBER(5),
    fecha DATE,
    cantidad NUMBER(3) NOT NULL CHECK (cantidad >= 1),
    
    CONSTRAINT pk_compras PRIMARY KEY (cliente, producto, fecha),
    CONSTRAINT fk_compras_cli FOREIGN KEY (cliente) REFERENCES clientes(dni),
    CONSTRAINT fk_compras_prod FOREIGN KEY (producto) REFERENCES productos(cod_prod)
);

CREATE TABLE tiendas
(
    cod NUMBER(5) PRIMARY KEY,
    metros NUMBER(4) NOT NULL CHECK (metros >= 1)
);

CREATE TABLE trabajadores
(
    codigo NUMBER(5) PRIMARY KEY,
    nombre VARCHAR2(50) NOT NULL,
    categoria VARCHAR2(20) NOT NULL,
    area VARCHAR2(20) NOT NULL,
    tienda NUMBER(5),
    
    CONSTRAINT fk_trab_tienda FOREIGN KEY (tienda) REFERENCES tiendas(cod)
);

CREATE TABLE ofertas
(
    cod_of NUMBER(5) PRIMARY KEY,
    tienda NUMBER(5),
    producto  NUMBER(5),
    trabajador NUMBER(5),
    tipo VARCHAR2(20) NOT NULL,
    inicio DATE NOT NULL,
    fin DATE NOT NULL,
    
    CONSTRAINT fk_oferta_tienda FOREIGN KEY (tienda) REFERENCES tiendas(cod),
    CONSTRAINT fk_oferta_prod FOREIGN KEY (producto) REFERENCES productos(cod_prod),
    CONSTRAINT fk_oferta_trab FOREIGN KEY (trabajador) REFERENCES trabajadores(codigo)
    
);

// Luego las modificamos
ALTER TABLE clientes
ADD tlf NUMBER(9);
ALTER TABLE trabajadores
ADD tlf NUMBER(9);

ALTER TABLE productos
DROP COLUMN stock;

ALTER TABLE clientes
MODIFY tlf CHECK (tlf >= 600000000);
ALTER TABLE trabajadores
MODIFY tlf CHECK (tlf >= 600000000);

ALTER TABLE productos
MODIFY precio DEFAULT 0;

ALTER TABLE tiendas ADD
(
    nombre VARCHAR2(50) NOT NULL,
    localizacion VARCHAR2(100)
);

ALTER TABLE productos
MODIFY precio CHECK (precio >= 0 AND precio <= 10);

INSERT INTO clientes VALUES ('00123456A', 'ERICA', '01/01/90', 'GRANADA', 'M', NULL);
INSERT INTO clientes(dni, fecha_nac, sexo, nombre) VALUES ('00333333H', '15/02/03', 'H', 'Manolo');


INSERT INTO clientes (dni, nombre, fecha_nac, direccion, sexo) VALUES ('11111111Z', 'Lucia', '12/05/2002', 'Granada', 'M');
INSERT INTO clientes (dni, nombre, fecha_nac, direccion, sexo) VALUES ('22222222B', 'Monica', '18/12/2008', 'Jaen', 'M');
INSERT INTO clientes (dni, nombre, fecha_nac, direccion, sexo) VALUES ('12345678C', 'Luis', '03/01/2005', 'Granada', 'H');
INSERT INTO clientes (dni, nombre, fecha_nac, direccion, sexo) VALUES ('33333333R', 'Cesar', '08/09/2003', 'Granada', 'H');
INSERT INTO clientes (dni, nombre, fecha_nac, direccion, sexo) VALUES ('55555555T', 'Roberto', '24/11/2008', 'Malaga', 'H');

ALTER TABLE productos ADD stock NUMBER(6) NOT NULL CHECK (stock >= 0);

ALTER TABLE productos MODIFY (
precio NULL,
stock NULL
);

INSERT INTO productos VALUES (1, 'Lapiz negro', 0.75, 1, 100);
INSERT INTO productos VALUES (2, 'Boligrafo azul', NULL, 1, 85);
INSERT INTO productos VALUES (3, 'Libreta A4', 1.75, 2, 60);
INSERT INTO productos VALUES (4, 'Cuaderno Rubio', 3.25, 2, 50);
INSERT INTO productos VALUES (5, 'Corrector', NULL, 3, 86);
INSERT INTO productos VALUES (6, 'Goma borrar', 0.35, 3, 150);

INSERT INTO compras VALUES ('11111111Z', 1, '25/10/2023', 2);
INSERT INTO compras VALUES ('11111111Z', 2, '25/10/2023', 4);
INSERT INTO compras VALUES ('11111111Z', 3, '26/10/2023', 1);
INSERT INTO compras VALUES ('11111111Z', 1, '30/10/2023', 5);

INSERT INTO compras VALUES ('12345678C', 1, '26/10/2023', 1);
INSERT INTO compras VALUES ('12345678C', 4, '26/10/2023', 1);
INSERT INTO compras VALUES ('12345678C', 3, '02/11/2023', 2);
INSERT INTO compras VALUES ('12345678C', 4, '30/10/2023', 1);
INSERT INTO compras VALUES ('12345678C', 4, '02/11/2023', 2);

INSERT INTO compras VALUES ('55555555T', 2, '30/10/2023', 3);
INSERT INTO compras VALUES ('55555555T', 2, '30/10/2023', 1);
INSERT INTO compras VALUES ('55555555T', 3, '30/10/2023', 1);
INSERT INTO compras VALUES ('55555555T', 3, '02/11/2023', 2);

INSERT INTO compras VALUES ('33333333R', 2, '25/10/2023', 6);
INSERT INTO compras VALUES ('33333333R', 1, '25/10/2023', 4);

// DELETE FROM compras WHERE (sexo='M');

DROP TABLE compras CASCADE CONSTRAINTS;

DELETE FROM clientes WHERE (DIRECCION='Malaga');

DELETE FROM productos WHERE (precio < 1);

DELETE FROM clientes WHERE (sexo='H');

DROP TABLE clientes CASCADE CONSTRAINTS;
DROP TABLE productos CASCADE CONSTRAINTS;

DELETE FROM compras WHERE (cantidad < 3);

UPDATE clientes
SET fecha_nac='11/05/2002'
WHERE dni='11111111Z';

UPDATE clientes
SET direccion='Malaga'
WHERE dni='22222222B'; // DNI de Monica (mejor este valor Ãºnico que el nombre)

UPDATE productos
SET precio = precio + 0.25;

UPDATE compras
SET cantidad = cantidad + 1
WHERE producto=2;

UPDATE productos
SET precio=1.25
WHERE tipo=1 OR tipo=2;

// MANIPULACION DE FILAS
// SELECT es para mostrar

SELECT dni, nombre FROM clientes;

SELECT direccion FROM clientes;

SELECT * FROM clientes;

SELECT nombre FROM clientes WHERE direccion='Granada'; // Es case sensitive, asÃ­ que 'GRANADA' no lo pillarÃ­a

SELECT nombre FROM clientes WHERE sexo='M';

SELECT dni, nombre FROM clientes WHERE direccion != 'Granada'; // TambiÃ©n podemos usar <> para no igual, o WHERE NOT direccion='Granada'

SELECT * FROM clientes WHERE nombre='Lucia';

SELECT nombre FROM productos;
SELECT precio FROM productos;
SELECT codigo, precio FROM productos;
SELECT precio FROM productos WHERE tipo=2;
SELECT * FROM productos WHERE codigo=4;
SELECT * FROM productos WHERE precio > 0.75;
SELECT nombre FROM productos WHERE precio >= 0.75 AND precio <= 1.25;

SELECT cliente FROM compras;
SELECT cliente FROM compras WHERE producto = 3;
SELECT cliente FROM compras WHERE producto = 1 AND cantidad > 3;
SELECT cliente, producto FROM compras WHERE cantidad>3;

SELECT nombre, precio*1.21 FROM productos; // Muestra el precio con IVA aplicado pero sin cambiar el precio base en la BD

SELECT nombre FROM productos WHERE precio IS NULL;

SELECT DISTINCT direccion FROM clientes;

SELECT nombre FROM productos ORDER BY dni DESC;

SELECT direccion, nombre FROM clientes ORDER BY direccion DESC, nombre ASC; // La segunda ordenaciÃ³n serÃ¡ un subconjunto de la primera

CREATE TABLE duenos
(
    dni VARCHAR2(9) PRIMARY KEY,
    nom VARCHAR2(50)
);

CREATE TABLE perros
(
    numero NUMBER(4) PRIMARY KEY,
    nom VARCHAR2(20),
    dni_due VARCHAR2(9),
    
    CONSTRAINT fk_perro_due FOREIGN KEY (dni_due) REFERENCES duenos(dni)
);

INSERT INTO duenos VALUES ('11111111S', 'Rocio');
INSERT INTO duenos VALUES ('33333333E', 'Paloma');
INSERT INTO duenos VALUES ('66666666B', 'Victor');

INSERT INTO perros VALUES (1, 'Ali', '11111111S');
INSERT INTO perros VALUES (2, 'Buda', '33333333E');
INSERT INTO perros VALUES (3, 'Pico', '11111111S');
INSERT INTO perros VALUES (4, 'Rufo', '66666666B');

SELECT * FROM duenos, perros; // Producto cartesiano: como si se hiciera una sola tabla que suma las dos, pero la correspondencia entre datos puede ser incorrecta
SELECT * FROM duenos, perros WHERE duenos.dni = perros.dni_due; // Con esta condiciÃ³n lo arreglamos
SELECT duenos.nom, perros.nom FROM duenos, perros WHERE duenos.dni = perros.dni_due;
SELECT * FROM duenos d, perros p WHERE dni=dni_due ORDER BY d.nom; // Especificamos d y p como "apodo" de esas tablas

SELECT compras.*, productos.nombre FROM compras, productos WHERE cod_prod=producto;

// "CONSULTAS SOBRE VARIAS TABLAS"
SELECT compras.*, clientes.nombre FROM compras, clientes WHERE cliente = dni;
SELECT clientes.nombre FROM compras, clientes WHERE cliente = dni AND cantidad > 4 AND producto = 2;
SELECT DISTINCT productos.nombre FROM compras, productos WHERE producto = cod_prod AND cantidad < 3;
SELECT DISTINCT productos.* FROM compras, productos, clientes WHERE compras.cliente = clientes.dni AND compras.producto = productos.cod_prod AND clientes.nombre = 'Mónica';

INSERT INTO tiendas VALUES (1, 500);
INSERT INTO tiendas VALUES (2, 800);
INSERT INTO tiendas VALUES (3, 250);
INSERT INTO trabajadores VALUES (18, 'Pedro', 'Encargado', 'Cajas', 1);
INSERT INTO trabajadores VALUES (21, 'Elena', 'Encargado', 'Reposición', 1);
INSERT INTO trabajadores VALUES (35, 'Manuel', 'Suplente', 'Reposición', 3);

INSERT INTO ofertas VALUES (1, 1, 2, 18, 1, '01/09/2024', '01/10/2024');
INSERT INTO ofertas VALUES (2, 2, 6, NULL, 1, '01/10/2024', '01/11/2024');
INSERT INTO ofertas VALUES (3, 3, 6, 35, 2, '01/07/2024', '01/08/2024');
INSERT INTO ofertas VALUES (4, 3, 3, 35, 3, '01/10/2024', '01/12/2024');

// Mostrar el nombre de los productos ofertados en la tienda T3
SELECT productos.nombre FROM productos, ofertas WHERE productos.cod_prod = ofertas.producto AND ofertas.tienda = 3;

// Mostrar los códigos de los ofertas de Bolígrafo Azul.
SELECT ofertas.cod_of FROM ofertas, productos
WHERE productos.nombre='Boligrafo azul' AND ofertas.producto=productos.cod;

// Mostrar los códigos de los ofertas de Goma de borrar.
SELECT ofertas.cod_of FROM ofertas, productos
WHERE productos.nombre='Goma borrar' AND ofertas.producto=productos.cod;

// Mostrar los metros de las tiendas en las que se oferta Lápiz Negro.
SELECT metros FROM tiendas, productos, ofertas
WHERE productos.nombre='Lapiz negro' AND ofertas.producto=productos.cod;

// Listar el nombre y la categoría de los trabajadores que trabajan en la tienda T1.
SELECT nombre, categoria FROM trabajadores
WHERE tienda=1;

// Visualizar todos los datos de las ofertas de la tienda en la que trabaja Elena
SELECT ofertas.* FROM ofertas, trabajadores
WHERE trabajadores.nombre='Elena' AND ofertas.tienda = trabajadores.tienda;


// Visualizar los nombres de los productos que se ofertan en septiembre.
SELECT productos.nombre FROM productos, ofertas
WHERE inicio<='01/09/2024' AND fin>='31/09/2024' AND ofertas.producto=productos.cod_prod;

// Mostrar los nombres de los productos que se ofertan en tiendas más grandes de 500 metros.
SELECT productos.nombre FROM productos, ofertas, tiendas
WHERE metros > 500 AND productos.cod_prod=ofertas.producto AND ofertas.tienda=tiendas.cod;

// Mostrar los nombres de los productos que han comprado los clientes de Granada.
SELECT DISTINCT productos.nombre FROM productos, clientes, compras
WHERE clientes.direccion='Granada' AND productos.cod_prod=compras.producto AND compras.cliente = cliente.dni;

// Listar las provincias de las que vienen los clientes que han comprado más de 7 Bolígrafos azules.
SELECT clientes.direccion FROM clientes, compras, productos
WHERE productos.nombre='Boligrafo azul' AND productos.cod_prod=compras.producto AND compras.cliente=clientes.dni
GROUP BY compras.cliente, compras.producto, clientes.direccion
HAVING SUM(compra.cantidad) > 7;


// Mostrar los nombres y las compras de todos los clientes de Granada, ordenados alfabéticamente.
SELECT clientes.nombre, compras.* FROM clientes, compras
WHERE clientes.dni=compras.cliente AND direccion='Granada'
ORDER BY clientes.nombre ASC; // ORDER BY va al final siempre

// Mostrar las provincias de los clientes que han comprado 8 Bolígrafos Azules. // No corregido
SELECT clientes.direccion FROM clientes, productos, compras
WHERE clientes.dni=compras.cliente AND compras.producto=productos.cod_prod
AND productos.nombre='Boligrafo azul'
GROUP BY clientes.direccion, compras.producto, compras.cliente
HAVING SUM(compras.cantidad) = 8;

// Mostrar las tiendas en las que se ofertan productos que aún no tienen asignado precio.
SELECT DISTINCT tiendas.* FROM productos, ofertas, tiendas
WHERE productos.cod_prod=ofertas.producto AND ofertas.tienda=tiendas.cod
AND precio IS NULL;

// Mostrar los nombres y los precios de los productos que se han ofertado con ofertas de tipo 2.
SELECT productos.nombre, productos.precio FROM productos, ofertas
WHERE productos.cod_prod=ofertas.producto
AND ofertas.tipo=2;


// Listar los datos de los clientes que han comprado Bolígrafo Azul, ordenados por su fecha de nacimiento.
SELECT DISTINCT clientes.* FROM clientes, productos, compras
WHERE clientes.dni=compras.cliente AND compras.producto=productos.cod_prod
AND productos.nombre='Boligrafo azul'
ORDER BY clientes.fecha_nac ASC;

// Mostrar por pantalla los nombres de los clientes que han comprado productos que sí tienen el precio marcado.
SELECT DISTINCT clientes.nombre FROM clientes, productos, compras
WHERE clientes.dni=compras.cliente AND compras.producto=productos.cod_prod
AND precio IS NOT NULL;

// Suponiendo que el IVA es de 21%, mostrar para cada cliente de Málaga lo que ha tenido que pagar en sus compras
SELECT clientes.nombre, ROUND(precio * cantidad * 1.21, 2) FROM clientes, compras, productos // ROUND redondea y se especifican los decimales (2)
WHERE clientes.dni=compras.cliente AND compras.producto=productos.cod_prod
AND clientes.direccion='Malaga';


// Mostrar todas las ofertas que hay en las tiendas de más de 500 metros cuadrados. Se deberá mostrar el nombre de los productos y de los trabajadores.
SELECT ofertas.cod_of, tiendas.cod, productos.nombre, trabajadores.nombre FROM ofertas, tiendas, productos, trabajadores
WHERE ofertas.tienda=tiendas.cod AND ofertas.producto=productos.cod_prod AND ofertas.trabajador=trabajadores.codigo
AND metros>500;

// Mostrar las provincias de las que vienen los clientes que han comprado productos con precios asignados.
SELECT clientes.direccion FROM clientes, productos, compras
WHERE clientes.dni=compras.cliente AND compras.producto=productos.cod_prod
AND precio IS NOT NULL;

// Sacar los nombres y los precios de los productos que aparecen en ofertas que no se sabe qué trabajador ha creado.
SELECT productos.nombre, productos.precio FROM productos, ofertas
WHERE productos.cod_prod=ofertas.producto
AND ofertas.trabajador IS NULL;

// Mostrar los nombres de los productos que están asociados a ofertas que empiezan en abril o en junio
SELECT productos.nombre FROM productos, ofertas
WHERE productos.cod_prod=ofertas.producto
AND ((inicio>='01/04/2024' OR inicio<='30/04/2024') OR (inicio>='01/06/2024' OR inicio<='30/06/2024'));


