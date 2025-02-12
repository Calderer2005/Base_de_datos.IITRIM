//Creación tablas
CREATE TABLE desarrolladores(
    id NUMERIC(5) CHECK (id >0) PRIMARY KEY,
    nombre VARCHAR2(25) NOT NULL,
    paisOrigen VARCHAR2(50),
    anioFundacion NUMERIC(5)
);

CREATE TABLE videojuegos(
    id NUMERIC(5) CHECK (id >0) PRIMARY KEY,
    titulo VARCHAR2(50) NOT NULL,
    pegi NUMERIC(5) CHECK (pegi IN(3, 7, 12, 16, 18)),
    id_desarrolladora NUMERIC(5),
    
    CONSTRAINT fk_videojuegos_desarrolladora FOREIGN KEY (id_desarrolladora) REFERENCES desarrolladores(id)
);

CREATE TABLE consolas(
    id NUMERIC(5) CHECK (id >0) PRIMARY KEY,
    nombre VARCHAR2(25) NOT NULL,
    id_fabricante NUMERIC(5),
    fechaLanzamiento DATE,
    generacion NUMERIC(1) CHECK (generacion >0) NOT NULL,
    
    CONSTRAINT fk_consolas_fabricante FOREIGN KEY (id_fabricante) REFERENCES desarrolladores(id)
);

CREATE TABLE genero(
    id NUMERIC(5) CHECK (id >0) PRIMARY KEY,
    nombre VARCHAR2(25) NOT NULL
);

CREATE TABLE juego_genero(
    id_juego NUMERIC(5),
    id_genero NUMERIC(5),
    
    CONSTRAINT pk_juegos_genero PRIMARY KEY (id_juego, id_genero),
    CONSTRAINT fk_juegoGenero_juego FOREIGN KEY (id_juego) REFERENCES videojuegos(id),
    CONSTRAINT fk_juegoGenero_genero FOREIGN KEY (id_genero) REFERENCES genero(id)
);

CREATE TABLE lanzamientos(
    id_juego NUMERIC(5),
    id_consola NUMERIC(5),
    fechaLanzamiento DATE,
    
    CONSTRAINT pk_juegos_consola PRIMARY KEY (id_juego, id_consola),
    CONSTRAINT fk_lanzamiento_juego FOREIGN KEY (id_juego) REFERENCES videojuegos(id),
    CONSTRAINT fk_lanzamiento_consola FOREIGN KEY (id_consola) REFERENCES consolas(id)
);

//Inserción datos
INSERT INTO desarrolladores VALUES (1, 'CD Projekt Red', 'Polonia', 1994);
INSERT INTO desarrolladores VALUES (2, 'Nintendo EPD', 'Japón', 1889);
INSERT INTO desarrolladores VALUES (3, 'Rockstar Games', 'Estados Unidos', 1998);
INSERT INTO desarrolladores VALUES (4, 'Mojang Studios', 'Suecia', 2009);
INSERT INTO desarrolladores VALUES (5, 'Sony Interactive', 'Japón', 1993);
INSERT INTO desarrolladores VALUES (6, 'Insomniac Games', 'Estados Unidos', 1994);
INSERT INTO desarrolladores VALUES (7, 'Microsoft', 'Estados Unidos', 1975);

INSERT INTO videojuegos VALUES (1, 'Cyberpunk 2077', 18, 1);
INSERT INTO videojuegos VALUES (2, 'The Legend of Zelda Breath of the Wild', 12, 2);
INSERT INTO videojuegos VALUES (3, 'Red Dead Redemption 2', 18, 3);
INSERT INTO videojuegos VALUES (4, 'Minecraft', 7, 4);
INSERT INTO videojuegos VALUES (5, 'Spyro the Dragon', 3, 6);

INSERT INTO consolas VALUES (1, 'Playstation', 5, '03/12/1994', 5);
INSERT INTO consolas VALUES (2, 'Playstation 4', 5, '15/11/2013', 8);
INSERT INTO consolas VALUES (3, 'Playstation 5', 5, '12/11/2020', 9);
INSERT INTO consolas VALUES (4, 'XBOX Series X', 7, '10/11/2020', 9);
INSERT INTO consolas VALUES (5, 'Nintendo Switch', 2, '03/03/2017', 8);

INSERT INTO genero VALUES (1, 'RPG');
INSERT INTO genero VALUES (2, 'Aventura');
INSERT INTO genero VALUES (3, 'Acción');
INSERT INTO genero VALUES (4, 'Sandbox');
INSERT INTO genero VALUES (5, '3rd Person Shooter');

INSERT INTO juego_genero VALUES (1, 1);
INSERT INTO juego_genero VALUES (1, 3);
INSERT INTO juego_genero VALUES (1, 5);
INSERT INTO juego_genero VALUES (2, 2);
INSERT INTO juego_genero VALUES (2, 3);
INSERT INTO juego_genero VALUES (3, 3);
INSERT INTO juego_genero VALUES (3, 4);
INSERT INTO juego_genero VALUES (3, 5);
INSERT INTO juego_genero VALUES (4, 4);
INSERT INTO juego_genero VALUES (5, 2);
INSERT INTO juego_genero VALUES (5, 3);

INSERT INTO lanzamientos VALUES (1, 2, '10/12/2020');
INSERT INTO lanzamientos VALUES (1, 3, '14/02/2022');
INSERT INTO lanzamientos VALUES (1, 4, '14/02/2022');
INSERT INTO lanzamientos VALUES (2, 5, '03/03/2017');
INSERT INTO lanzamientos VALUES (3, 2, '26/10/2018');
INSERT INTO lanzamientos VALUES (4, 2, '04/09/2014');
INSERT INTO lanzamientos VALUES (4, 5, '12/05/2017');
INSERT INTO lanzamientos VALUES (5, 1, '09/09/1998');
INSERT INTO lanzamientos VALUES (5, 2, '13/11/2018');
INSERT INTO lanzamientos VALUES (5, 3, '03/09/2021');

//Consultas
--1 Muestra los videojuegos desarrollados en Japón.
SELECT titulo FROM videojuegos JOIN desarrolladores ON videojuegos.id_desarrolladora=desarrolladores.id
WHERE paisOrigen='Japón';
--2 Obtén los juegos con un PEGI mayor que los juegos desarrollados en Suecia.
SELECT videojuegos.titulo FROM videojuegos
WHERE pegi > ALL (SELECT pegi FROM videojuegos JOIN desarrolladores ON videojuegos.id_desarrolladora=desarrolladores.id
WHERE paisOrigen='Suecia');
--3 Selecciona las desarrolladoras que hayan lanzado un juego después de 2015.
SELECT DISTINCT desarrolladores.nombre 
FROM desarrolladores JOIN videojuegos ON videojuegos.id_desarrolladora=desarrolladores.id 
JOIN lanzamientos ON lanzamientos.id_juego=videojuegos.id
WHERE fechaLanzamiento>'31/12/2015';
--4 Muestra los juegos que estén disponibles en más consolas que Cyberpunk.
SELECT titulo FROM videojuegos JOIN lanzamientos ON id=id_juego
GROUP BY titulo
HAVING COUNT(id_consola)>
(SELECT COUNT(DISTINCT id_consola)
FROM lanzamientos JOIN videojuegos ON id_juego=id WHERE titulo LIKE 'Cyberpunk%');
--5 Obtén las consolas que se hayan lanzado después de alguna de las consolas de Nintendo.
SELECT consolas.nombre
FROM desarrolladores JOIN consolas ON desarrolladores.id=consolas.id_fabricante
WHERE fechaLanzamiento>'03/03/2017';
--6 Muestra los géneros que no tengan ningún juego asignado.
SELECT genero.nombre
FROM genero JOIN juego_genero ON genero.id=juego_genero.id_genero
WHERE id_juego IS NULL;
--7 Selecciona los juegos que se hayan lanzado en consolas de Sony.
SELECT videojuegos.titulo FROM videojuegos JOIN desarrolladores ON videojuegos.id_desarrolladora=desarrolladores.id
JOIN consolas ON desarrolladores.id=consolas.id_fabricante
WHERE consolas.nombre = ALL (SELECT consolas.nombre FROM consolas JOIN desarrolladores ON consolas.id_fabricante=desarrolladores.id
WHERE consolas.nombre='Sony');
--8 Muestra las desarrolladoras más antiguas que las desarrolladoras de Estados Unidos.
SELECT nombre FROM desarrolladores
WHERE anioFundacion < ALL (SELECT anioFundacion FROM desarrolladores WHERE paisOrigen='Estados Unidos');
--9 Muestra todos los juegos que no sean Shooters en 3ª Persona.
SELECT videojuegos.titulo FROM videojuegos
WHERE videojuegos.id != ALL (SELECT jg.id_juego FROM juego_genero jg JOIN genero ON genero.id=jg.id_genero 
WHERE genero.nombre='3rd Person Shooter');
--10 Obtén los juegos cuyo título empiece por ‘The’.
SELECT titulo FROM videojuegos WHERE titulo LIKE 'The%';
--11 Muestra los géneros que se escriban con 8 letras.
SELECT nombre FROM genero WHERE nombre LIKE '________';
--12 Muestra todas las desarrolladoras y sus consolas asociadas.
SELECT desarrolladores.nombre, consolas.nombre FROM desarrolladores LEFT JOIN consolas ON desarrolladores.id=consolas.id_fabricante;
--13 Muestra los juegos con más de un género.
SELECT DISTINCT titulo FROM videojuegos JOIN juego_genero ON videojuegos.id=juego_genero.id_juego
WHERE id_juego IN
(SELECT id_juego FROM juego_genero WHERE id_juego!=id_genero);
--14 Obtén cuantos juegos tienen asignados cada género.

--15 Muestra la fecha del último lanzamiento de cada consola.

--16 Elimina la columna de generación de la tabla consolas.

--17 Elimina todos los lanzamientos de la PlayStation1.

--18 Muestra los desarrolladores cuyos juegos tienen un PEGI mayor que el promedio de su país.

--19 Obtén las desarrolladoras que hayan lanzado al menos un juego en cada género.

--20 Muestra el género con más juegos lanzados en 9ª generación.

--21 Selecciona las desarrolladoras que hayan lanzado juegos para todos los géneros.

--22 Muestra los juegos que hayan sido lanzados en 3 generaciones distintas.

--23 Muestra los juegos que hayan salido para todas las consolas de Sony.
SELECT titulo FROM videojuegos vid JOIN lanzamientos lan ON vid.id=lan.id_juego
JOIN consolas con ON con.id=lan.id_consola
JOIN desarrolladores des ON des.id=con.id_fabricante
WHERE des.nombre='Sony Interactive'
GROUP BY titulo HAVING COUNT (con.id) =
(SELECT COUNT (consolas.id) FROM consolas JOIN desarrolladores ON consolas.id_fabricante=desarrolladores.id
WHERE desarrolladores.nombre='Sony Interactive');
--24 Calcula el porcentaje de juegos por cada género en cada una de las consolas.
SELECT gen.nombre, vid.titulo FROM genero gen JOIN juego_genero juge ON gen.id=juge.id_genero
JOIN videojuegos vid ON vid.id=juge.id_juego
ORDER BY gen.nombre

(SELECT COUNT (titulo) FROM videojuegos)

--25 Muestra los juegos que hayan sido lanzados en consolas que ya no reciben soporte.

--26 Muestra para cuántos géneros se lanzan juegos en el primer año de cada consola.