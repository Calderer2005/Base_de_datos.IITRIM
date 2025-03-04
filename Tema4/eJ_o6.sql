//CREACION DE TABLAS
CREATE TABLE salas
(
    S VARCHAR2(2) PRIMARY KEY,
    nombre VARCHAR2(10) UNIQUE,
    capacidad INT CHECK (capacidad BETWEEN 79 AND 301),
    filas INT NOT NULL
);
CREATE TABLE peliculas
(
    P VARCHAR2(3) PRIMARY KEY,
    nombre VARCHAR2(45),
    calificacion VARCHAR2(2) CHECK (calificacion IN('TP',7,18)),
    nacionalidad VARCHAR2(10)
);
CREATE TABLE proyecciones
(
    sala VARCHAR2(2),
    pelicula VARCHAR2(3),
    hora VARCHAR2(5),
    ocupacion INT CHECK (ocupacion >= 0),
    
    PRIMARY KEY (sala, pelicula,hora),
    FOREIGN KEY (sala) REFERENCES salas (S),
    FOREIGN KEY (pelicula) REFERENCES peliculas(P)
);
//INSERCCION DE DATOS
INSERT INTO salas VALUES ('S1','África',125,10);
INSERT INTO salas VALUES ('S2','América',255,24);
INSERT INTO salas VALUES ('S3','Europa',136,14);
INSERT INTO salas VALUES ('S4','Asia',85,7);
INSERT INTO salas VALUES ('S5','Oceanía',100,10);
INSERT INTO salas VALUES ('S6','Antártida',150,15);
INSERT INTO salas VALUES ('S7','Atlántida',300,30);

INSERT INTO peliculas VALUES ('P1','Minios: el origen de Gru','TP','EEUU');
INSERT INTO peliculas VALUES ('P2','Black Panther: Wakanda forever','18','EEUU');
INSERT INTO peliculas VALUES ('P3','Astérix y Obélix: el reino medio','7','Francia');
INSERT INTO peliculas VALUES ('P4','El autor','','España');
INSERT INTO peliculas VALUES ('P5','Perfectos desconocidos','18','España');
INSERT INTO peliculas VALUES ('P6','ResidentEvil','18','');
INSERT INTO peliculas VALUES ('P7','Tadeo Jones 3','TP','España');
INSERT INTO peliculas VALUES ('P8','Eiffel','7','Francia');
INSERT INTO peliculas VALUES ('P9','Puñales por la espalda 2','18','EEUU');
INSERT INTO peliculas VALUES ('P10','La abuela','','España');

INSERT INTO proyecciones VALUES ('S1','P1','12.00',75);
INSERT INTO proyecciones VALUES ('S1','P1','18.00',84);
INSERT INTO proyecciones VALUES ('S1','P2','23.00',100);
INSERT INTO proyecciones VALUES ('S2','P3','12.00',89);
INSERT INTO proyecciones VALUES ('S2','P3','18.00',104);
INSERT INTO proyecciones VALUES ('S2','P3','23.00',200);
INSERT INTO proyecciones VALUES ('S3','P2','17.00',100);
INSERT INTO proyecciones VALUES ('S3','P2','20.00',120);
INSERT INTO proyecciones VALUES ('S4','P4','12.00',14);
INSERT INTO proyecciones VALUES ('S4','P4','17.00',60);
INSERT INTO proyecciones VALUES ('S4','P4','20.00',78);
INSERT INTO proyecciones VALUES ('S4','P6','23.00',80);
INSERT INTO proyecciones VALUES ('S1','P1','23.00',35);
INSERT INTO proyecciones VALUES ('S5','P4','20.00',16);
INSERT INTO proyecciones VALUES ('S3','P4','12.00',25);
INSERT INTO proyecciones VALUES ('S5','P1','12.00',100);
INSERT INTO proyecciones VALUES ('S5','P8','12.00',152);
INSERT INTO proyecciones VALUES ('S5','P4','13.00',250);
INSERT INTO proyecciones VALUES ('S6','P2','20.00',120);
INSERT INTO proyecciones VALUES ('S6','P10','23.00',68);
INSERT INTO proyecciones VALUES ('S6','P9','23.00',50);
INSERT INTO proyecciones VALUES ('S4','P8','12.00',36);

//CONSULTAS

--1
SELECT nombre FROM peliculas;

--2
SELECT DISTINCT calificacion FROM peliculas;

--3
SELECT nombre FROM peliculas WHERE calificacion IS NULL;

--4
SELECT * FROM salas ORDER BY capacidad DESC;

--5
SELECT salas 

--6

-- 7

-- 8

-- 9

-- 10

-- 11

-- 12

-- 13

-- 14

-- 15

-- 16

-- 17

-- 18

-- 19

-- 20

-- 21

-- 22

-- 23

-- 24

-- 25

-- 26

-- 27

-- 28

-- 29

-- 30

-- 31

-- 32

-- 33

-- 34

-- 35

-- 36

-- 37

-- 38

-- 39

-- 40

-- 41

-- 42

-- 43

-- 44

-- 45

-- 46

-- 47

-- 48

-- 49

-- 50

-- 51

-- 52

-- 53

-- 54



DECLARE 
    titulo_pel peliculas.nombre%TYPE;
BEGIN
    SELECT nombre INTO titulo_pel FROM peliculas JOIN proyecciones ON p=peliculas;
    WHERE sala='S2' AND hora='23.00';
    
    DBMS_OUTPUT.put_line('Nombre de la pelicula: '||titulo_pel);
END;

