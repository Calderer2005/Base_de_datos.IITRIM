CREATE TABLE videojuegos
(
    id INT PRIMARY KEY CHECK (id>0),
    titulo VARCHAR2(50) NOT NULL,
    PEGI NUMERIC(2) CHECK (PEGI = 3 OR PEGI = 7 OR PEGI = 12 OR PEGI = 16 OR PEGI = 18) ,
    id_desarrollador INT ,
    
    CONSTRAINT fk_des_c FOREIGN KEY (id_desarrollador) REFERENCES desarrolladores(id)
);
CREATE TABLE lanzamientos
(
    id_juego INT,
    id_consola INT,
    fecha_lanzamiento DATE,
    
    CONSTRAINT pk_lanz PRIMARY KEY (id_juego, id_consola),
    CONSTRAINT fk_j FOREIGN KEY (id_juego) REFERENCES videojuegos(id),
    CONSTRAINT fk_c FOREIGN KEY (id_consola) REFERENCES consolas(id)
);
CREATE TABLE consolas
(
    id INT PRIMARY KEY CHECK (id>0),
    nombre VARCHAR2(25) NOT NULL,
    id_fabricante INT,
    fecha_lanzamiento DATE,
    generacion INT CHECK (generacion > 0 AND generacion < 10),
    
    CONSTRAINT fk_fab_c FOREIGN KEY (id_fabricante) REFERENCES desarrolladores(id)
);
CREATE TABLE generos
(
    id INT PRIMARY KEY CHECK (id>0),
    nombre VARCHAR2(25) NOT NULL
);
CREATE TABLE juego_genero
(
    id_juego INT,
    id_genero INT,
    
    CONSTRAINT pk_jg PRIMARY KEY (id_juego, id_genero),
    CONSTRAINT fk_j_jg FOREIGN KEY (id_juego) REFERENCES videojuegos(id),
    CONSTRAINT fk_g FOREIGN KEY (id_genero) REFERENCES generos(id)
);
CREATE TABLE desarrolladores
(
    id INT PRIMARY KEY CHECK (id>0),
    nombre VARCHAR2(25) NOT NULL,
    pais_origen VARCHAR2(50),
    año_fundacion INT
);
--INSERTAR VALORES

INSERT INTO desarrolladores VALUES (1,'CD Project Red','Polonia',1994);
INSERT INTO desarrolladores VALUES (2,'Nintendo EPD','Japón',1889);
INSERT INTO desarrolladores VALUES (3,'Rockstar Games','Estados Unidos',1998);
INSERT INTO desarrolladores VALUES (4,'Mojang Studios','Suecia',2009);
INSERT INTO desarrolladores VALUES (5,'Sony Interactive','Japón',1993);
INSERT INTO desarrolladores VALUES (6,'Insomniac Games','Estados Unidos',1994);
INSERT INTO desarrolladores VALUES (7,'Microsoft','Estados Unidos',1975);

INSERT INTO videojuegos VALUES (1,'Cyberpunk 2077',18,1);
INSERT INTO videojuegos VALUES (2,'The Legend of Zelda Breath of the Wild',12,2);
INSERT INTO videojuegos VALUES (3,'Red Dead Redemption 2',18,3);
INSERT INTO videojuegos VALUES (4,'Minecraft',7,4);
INSERT INTO videojuegos VALUES (5,'Sypro the Dragon',3,6);

INSERT INTO lanzamientos VALUES (1,2,'10-12-2020');
INSERT INTO lanzamientos VALUES (1,3,'14/02/2022');
INSERT INTO lanzamientos VALUES (1,4,'14/02/2022');
INSERT INTO lanzamientos VALUES (2,5,'03/03/2017');
INSERT INTO lanzamientos VALUES (3,2,'26/10/2018');
INSERT INTO lanzamientos VALUES (4,2,'04/09/2014');
INSERT INTO lanzamientos VALUES (4,5,'12/05/2017');
INSERT INTO lanzamientos VALUES (5,1,'09/09/1998');

INSERT INTO consolas VALUES (1,'PlayStation',5,'03/12/1994',5);
INSERT INTO consolas VALUES (2,'PlayStation 4',5,'15/11/2013',8);
INSERT INTO consolas VALUES (3,'PlayStation 5',5,'12/11/2020',9);
INSERT INTO consolas VALUES (4,'XBOX Series X',7,'10/11/2020',9);
INSERT INTO consolas VALUES (5,'Nintendo Switch',2,'03/03/2017',8);

INSERT INTO generos VALUES (1,'RPG');
INSERT INTO generos VALUES (2,'Aventura');
INSERT INTO generos VALUES (3,'Acción');
INSERT INTO generos VALUES (4,'Sandbox');
INSERT INTO generos VALUES (5,'3rd Person Shooter');

INSERT INTO juego_genero VALUES (1,1);
INSERT INTO juego_genero VALUES (1,3);
INSERT INTO juego_genero VALUES (1,5);
INSERT INTO juego_genero VALUES (2,2);
INSERT INTO juego_genero VALUES (2,3);
INSERT INTO juego_genero VALUES (3,3);
INSERT INTO juego_genero VALUES (3,4);
INSERT INTO juego_genero VALUES (3,5);
INSERT INTO juego_genero VALUES (4,4);
INSERT INTO juego_genero VALUES (5,2);
INSERT INTO juego_genero VALUES (5,3);

--CONSULTAS

--1
U
--2

--3

--4

--5

--6

--7

--8

--9

--10

--11

--12

--13

--14

--15

--16

--17

--18

--19

--20

--21

--22

--23

--24

--25

--26

