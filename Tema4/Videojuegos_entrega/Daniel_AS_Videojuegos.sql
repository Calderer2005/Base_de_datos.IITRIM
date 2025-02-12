DROP TABLE desarrollador CASCADE CONSTRAINTS;
DROP TABLE videojuego CASCADE CONSTRAINTS;
DROP TABLE consola CASCADE CONSTRAINTS;
DROP TABLE genero CASCADE CONSTRAINTS;
DROP TABLE genero_juego CASCADE CONSTRAINTS;
DROP TABLE lanzamiento CASCADE CONSTRAINTS;


CREATE TABLE desarrollador
(
    id NUMBER(5) PRIMARY KEY,
    nombre VARCHAR2(25) NOT NULL,
    pais_ori VARCHAR2(50),
    anio_funda NUMBER(4)
);

CREATE TABLE videojuego
(
    id NUMBER(5) PRIMARY KEY,
    titulo VARCHAR2(50) NOT NULL,
    pegi NUMBER(2) CHECK (pegi IN (3, 7, 12, 16, 18)),
    id_desa NUMBER(5),
    
    CONSTRAINT fk_desarrollador_videojuego FOREIGN KEY (id_desa) REFERENCES desarrollador(id)
);

CREATE TABLE consola
(
    id NUMBER(5) PRIMARY KEY,
    nombre VARCHAR2(25) NOT NULL,
    id_fabri NUMBER(5),
    fecha_lanza DATE,
    generacion NUMBER(1) NOT NULL,
    
    CONSTRAINT fk_fabricante_consola FOREIGN KEY (id_fabri) REFERENCES desarrollador(id)
);

CREATE TABLE genero
(
    id NUMBER(5) PRIMARY KEY,
    nombre VARCHAR2(25) NOT NULL
);

CREATE TABLE genero_juego
(
    id_juego NUMBER(5),
    id_genero NUMBER(5),
    
    CONSTRAINT pk_genero_juego PRIMARY KEY (id_juego, id_genero),
    CONSTRAINT fk_juego_genero_juego FOREIGN KEY (id_juego) REFERENCES videojuego(id),
    CONSTRAINT fk_genero_genero_juego FOREIGN KEY (id_genero) REFERENCES genero(id)
);

CREATE TABLE lanzamiento
(
    id_juego NUMBER(5),
    id_consola NUMBER(5),
    fecha_lanz DATE,
    
    CONSTRAINT pk_lanzamiento PRIMARY KEY (id_juego, id_consola),
    CONSTRAINT fk_juego_lanzamiento FOREIGN KEY (id_juego) REFERENCES videojuego(id),
    CONSTRAINT fk_consola_lanzamiento FOREIGN KEY (id_consola) REFERENCES consola(id)
);

INSERT INTO desarrollador VALUES (1, 'CD Projekt Red', 'Polonia', 1994);
INSERT INTO desarrollador VALUES (2, 'Nintendo EPD', 'Japón', 1889);
INSERT INTO desarrollador VALUES (3, 'Rockstar Games', 'Estados Unidos', 1998);
INSERT INTO desarrollador VALUES (4, 'Mojang Studios', 'Suecia', 2009);
INSERT INTO desarrollador VALUES (5, 'Sony Interactive', 'Japón', 1993);
INSERT INTO desarrollador VALUES (6, 'Insomniac Games', 'Estados Unidos', 1994);
INSERT INTO desarrollador VALUES (7, 'Microsoft', 'Estados Unidos', 1975);
INSERT INTO desarrollador VALUES (8, 'Tango Gameworks', 'Japón', 2010);

INSERT INTO videojuego VALUES (1, 'Cyberpunk 2077', 18, 1);
INSERT INTO videojuego VALUES (2, 'The Legend of Zelda: Breath of the Wild', 12, 2);
INSERT INTO videojuego VALUES (3, 'Red Dead Redemption 2', 18, 3);
INSERT INTO videojuego VALUES (4, 'Minecraft', 7, 4);
INSERT INTO videojuego VALUES (5, 'Spyro the Dragon', 3, 6);
INSERT INTO videojuego VALUES (6, 'Hi-Fi Rush', 3, 8);

INSERT INTO consola VALUES (1, 'PlayStation', 5, '03/12/1994', 5);
INSERT INTO consola VALUES (2, 'PlayStation 4', 5, '15/11/2013', 8);
INSERT INTO consola VALUES (3, 'PlayStation 5', 5, '12/11/2020', 9);
INSERT INTO consola VALUES (4, 'XBOX Series X', 7, '10/11/2020', 9);
INSERT INTO consola VALUES (5, 'Nintendo Switch', 2, '03/03/2017', 8);

INSERT INTO genero VALUES (1, 'RPG');
INSERT INTO genero VALUES (2, 'Aventura');
INSERT INTO genero VALUES (3, 'Acción');
INSERT INTO genero VALUES (4, 'Sandbox');
INSERT INTO genero VALUES (5, '3rd Person Shooter');
INSERT INTO genero VALUES (6, 'Ritmo');

INSERT INTO genero_juego VALUES (1, 1);
INSERT INTO genero_juego VALUES (1, 3);
INSERT INTO genero_juego VALUES (1, 5);
INSERT INTO genero_juego VALUES (2, 2);
INSERT INTO genero_juego VALUES (2, 3);
INSERT INTO genero_juego VALUES (3, 3);
INSERT INTO genero_juego VALUES (3, 4);
INSERT INTO genero_juego VALUES (3, 5);
INSERT INTO genero_juego VALUES (4, 4);
INSERT INTO genero_juego VALUES (5, 2);
INSERT INTO genero_juego VALUES (5, 3);
INSERT INTO genero_juego VALUES (6, 2);
INSERT INTO genero_juego VALUES (6, 3);
INSERT INTO genero_juego VALUES (6, 6);

INSERT INTO lanzamiento VALUES (1, 2, '10/12/2020');
INSERT INTO lanzamiento VALUES (1, 3, '14/02/2022');
INSERT INTO lanzamiento VALUES (1, 4, '14/02/2022');
INSERT INTO lanzamiento VALUES (2, 5, '03/03/2017');
INSERT INTO lanzamiento VALUES (3, 2, '26/10/2018');
INSERT INTO lanzamiento VALUES (4, 2, '04/09/2014');
INSERT INTO lanzamiento VALUES (4, 5, '12/05/2017');
INSERT INTO lanzamiento VALUES (5, 1, '09/09/1998');
INSERT INTO lanzamiento VALUES (6, 3, '25/01/2023');
INSERT INTO lanzamiento VALUES (6, 4, '25/01/2023');
INSERT INTO lanzamiento VALUES (4, 1, '25/01/2023');
INSERT INTO lanzamiento VALUES (4, 3, '25/01/2023');



--1: Muestra los videojuegos desarrollados en Japón
SELECT titulo 
FROM videojuego 
JOIN desarrollador ON desarrollador.id=videojuego.id_desa 
WHERE pais_ori='Japón';

--2: Obtén los juegos con un PEGI mayor que los juegos desarrollados en Suecia
SELECT titulo, pegi 
FROM videojuego 
WHERE pegi>(
    SELECT pegi 
    FROM videojuego 
    JOIN desarrollador ON desarrollador.id=id_desa 
    WHERE pais_ori='Suecia'
);

--3: Selecciona las desarrolladoras que hayan lanzado un juego después de 2015
SELECT DISTINCT nombre 
FROM desarrollador 
JOIN videojuego ON id_desa=desarrollador.id 
JOIN lanzamiento ON videojuego.id=id_juego 
WHERE fecha_lanz>'31/12/2015';

--4: Muestra los juegos que estén disponibles en más consolas que Cyberpunk
SELECT titulo 
FROM videojuego 
JOIN lanzamiento ON id_juego=id 
GROUP BY titulo 
HAVING COUNT(id_consola)>(
    SELECT COUNT(id_consola) 
    FROM lanzamiento 
    JOIN videojuego ON id_juego=id 
    WHERE titulo LIKE 'Cyberpunk%'
);

--5: Obtén las consolas que se hayan lanzado después de alguna de las consolas de Nintendo
SELECT nombre 
FROM consola
WHERE fecha_lanza> ANY(
    SELECT fecha_lanza 
    FROM consola 
    JOIN desarrollador ON desarrollador.id=id_fabri 
    WHERE desarrollador.nombre LIKE 'Nintendo%'
);

--6: Muestra los géneros que no tengan ningún juego asignado
SELECT nombre 
FROM genero 
WHERE id NOT IN (
    SELECT id_genero 
    FROM genero_juego
);

--7:  Selecciona los juegos que se hayan lanzado en consolas de Sony
SELECT titulo 
FROM videojuego 
WHERE id IN (
    SELECT id_juego 
    FROM lanzamiento 
    JOIN consola ON consola.id=id_consola 
    JOIN desarrollador ON desarrollador.id=id_fabri 
    WHERE desarrollador.nombre LIKE 'Sony%'
);

--8: Muestra las desarrolladoras más antiguas que las desarrolladoras de Estados Unidos
SELECT nombre 
FROM desarrollador 
WHERE anio_funda < ALL(
    SELECT anio_funda 
    FROM desarrollador 
    WHERE pais_ori='Estados Unidos'
);

--9: Muestra todos los juegos que no sean Shooters en 3ª Persona
SELECT titulo 
FROM videojuego 
WHERE id NOT IN (
    SELECT id_juego 
    FROM genero_juego 
    JOIN genero ON id_genero=id 
    WHERE nombre LIKE '%ooter%'
);

--10: Obtén los juegos cuyo título empiece por ‘The’
SELECT titulo 
FROM videojuego 
WHERE titulo LIKE 'The%';

--11: Muestra los géneros que se escriban con 8 letras
SELECT nombre FROM genero WHERE nombre LIKE '________';

--12: Muestra todas las desarrolladoras y sus consolas asociadas
SELECT desarrollador.nombre, COALESCE(consola.nombre, 'No ha desarrollado una consola') 
FROM desarrollador 
LEFT JOIN consola ON id_fabri=desarrollador.id;

--13: Muestra los juegos con más de un género
SELECT titulo 
FROM videojuego 
JOIN genero_juego ON videojuego.id=id_juego 
GROUP BY titulo 
HAVING COUNT(id_genero)>1;

--14: Obtén cuantos juegos tienen asignados cada género
SELECT nombre, COUNT(id_juego) 
FROM genero 
LEFT JOIN genero_juego ON id=id_genero
GROUP BY nombre;

--15: Muestra la fecha del último lanzamiento de cada consola
SELECT nombre, MAX(fecha_lanz) 
FROM consola 
LEFT JOIN lanzamiento ON id_consola=id 
GROUP BY nombre;

--16: Elimina la columna de generación de la tabla consolas
ALTER TABLE consola DROP COLUMN generacion;

--17: Elimina todos los lanzamientos de la PlayStation1
DELETE FROM lanzamiento 
WHERE id_consola=(
    SELECT id 
    FROM consola 
    WHERE nombre='PlayStation'
);

--18: Muestra los desarrolladores cuyos juegos tienen un PEGI mayor que que el promedio de su país
SELECT nombre 
FROM desarrollador des 
JOIN videojuego ON id_desa=des.id 
WHERE pegi>(
    SELECT AVG(pegi) 
    FROM videojuego 
    JOIN desarrollador ON desarrollador.id=id_desa 
    WHERE des.pais_ori=desarrollador.pais_ori
);

--19: Obtén las desarrolladoras que hayan lanzado al menos un juego en cada género
SELECT nombre 
FROM desarrollador 
WHERE id IN (
    SELECT id_desa 
    FROM videojuego 
    JOIN genero_juego ON id_juego=id 
    GROUP BY id_desa 
    HAVING COUNT(id_genero)= (SELECT COUNT(*) FROM genero)
);

--20: Muestra el género con más juegos lanzados en 9ª generación
SELECT nombre 
FROM genero 
WHERE id IN (
    SELECT id_genero 
    FROM genero_juego 
    JOIN lanzamiento ON lanzamiento.id_juego = genero_juego.id_juego
    JOIN consola ON consola.id = lanzamiento.id_consola
    WHERE generacion = 9 
    GROUP BY id_genero 
    HAVING COUNT(DISTINCT lanzamiento.id_juego) >= ALL(
        SELECT COUNT(DISTINCT lanzamiento.id_juego) 
        FROM lanzamiento 
        JOIN consola ON id_consola = consola.id 
        JOIN genero_juego ON genero_juego.id_juego = lanzamiento.id_juego 
        WHERE generacion=9)
);

--21: Selecciona las desarrolladoras que hayan lanzado juegos para todos los géneros
SELECT desarrollador.nombre, videojuego.titulo, genero.nombre
FROM desarrollador
JOIN videojuego ON id_desa = desarrollador.id 
LEFT JOIN genero_juego ON id_juego = videojuego.id
LEFT JOIN genero ON genero_juego.id_genero = genero.id
GROUP BY desarrollador.nombre, videojuego.titulo, genero.nombre
HAVING COUNT(genero_juego.id_juego) = (
    SELECT COUNT(id) 
    FROM genero
)
ORDER BY desarrollador.nombre;

--22: Muestra los juegos que hayan sido lanzados en 3 generaciones distintas
SELECT titulo 
FROM videojuego 
WHERE id IN (
    SELECT id_juego 
    FROM lanzamiento 
    JOIN consola ON id_consola=consola.id 
    GROUP BY id_juego 
    HAVING COUNT(DISTINCT generacion) >= 3
);

--23: Muestra los juegos que hayan salido para todas las consolas de Sony
SELECT titulo 
FROM videojuego 
JOIN lanzamiento ON videojuego.id = lanzamiento.id_juego
JOIN consola ON consola.id = id_consola 
JOIN desarrollador ON desarrollador.id = id_fabri 
WHERE desarrollador.nombre LIKE 'Sony%'
GROUP BY titulo
HAVING COUNT(id_consola) = (
    SELECT COUNT(consola.id) 
    FROM consola 
    JOIN desarrollador ON id_fabri = desarrollador.id 
    WHERE desarrollador.nombre LIKE 'Sony%'
);

--24: Calcula el porcentaje de juegos por cada género en cada una de las consolas
SELECT consola.nombre, genero.nombre, (COUNT(id_juego)/total)*100
FROM consola, genero
JOIN (
    SELECT cons.id as consolas, COUNT(lz.id_juego) as total 
    FROM consola cons 
    JOIN lanzamiento lz ON cons.id = lz.id_consola
    GROUP BY cons.id
) ON consola.id = consolas
GROUP BY consola.nombre, genero.nombre;

SELECT consola.nombre, genero.nombre, (COUNT(videojuego.id))

--25: Muestra los juegos que hayan sido lanzados en consolas que ya no reciben soporte
SELECT DISTINCT titulo 
FROM videojuego 
JOIN lanzamiento ON id_juego = videojuego.id 
JOIN consola elegida ON elegida.id = id_consola 
WHERE elegida.fecha_lanza != (
    SELECT MAX(fecha_lanza) 
    FROM consola 
    WHERE consola.id_fabri=elegida.id_fabri
);

--26: Muestra para cuántos géneros se lanzan juegos en el primer año de cada consola
SELECT consola.nombre, COUNT(DISTINCT genero_juego.id_genero) 
FROM consola
JOIN lanzamiento ON id_consola=consola.id
JOIN genero_juego ON genero_juego.id_juego = lanzamiento.id_juego
WHERE lanzamiento.fecha_lanz <= ADD_MONTHS(consola.fecha_lanza, 12)
GROUP BY consola.nombre;














