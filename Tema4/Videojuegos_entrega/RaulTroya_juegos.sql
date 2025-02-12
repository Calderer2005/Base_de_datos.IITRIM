CREATE TABLE desarrolladores(
    id NUMBER(2) CHECK(id > 0) PRIMARY KEY,
    nombre VARCHAR2(25) NOT NULL,
    paisOrigen VARCHAR2(50),
    añoFund NUMBER(4)
);
CREATE TABLE videojuegos(
    id NUMBER(2) CHECK(id > 0) PRIMARY KEY,
    titulo VARCHAR2(50) NOT NULL,
    pegi NUMBER(3) CHECK (pegi IN (3, 7, 12, 16, 18)),
    id_desarr NUMBER(2),
    
    CONSTRAINT fk_vJuegos_desar FOREIGN KEY (id_desarr) REFERENCES desarrolladores(id)
);
CREATE TABLE consolas(
    id NUMBER(2) CHECK(id > 0) PRIMARY KEY,
    nombre VARCHAR2(25) NOT NULL,
    id_desarr NUMBER(2),
    fec_lanz DATE,
    generacion NUMBER(1) NOT NULL,   
    
    CONSTRAINT fk_consolas_desar FOREIGN KEY (id_desarr) REFERENCES desarrolladores(id)
);
CREATE TABLE lanzamientos(
    id_juego NUMBER(2),
    id_consola NUMBER(2),
    fec_lanz DATE,
    
    CONSTRAINT fk_vJuegos_lanz FOREIGN KEY (id_juego) REFERENCES videojuegos(id),
    CONSTRAINT fk_consola_lanz FOREIGN KEY (id_consola) REFERENCES consolas(id)
);
CREATE TABLE generos(
    id NUMBER(2) CHECK(id > 0) PRIMARY KEY,
    nombre VARCHAR2(25) NOT NULL
);
CREATE TABLE juego_genero(
    id_juego NUMBER(2),
    id_genero NUMBER(2),
    
    CONSTRAINT fk_vJuegos_jGen FOREIGN KEY (id_juego) REFERENCES videojuegos(id),
    CONSTRAINT fk_gen_jGen FOREIGN KEY (id_juego) REFERENCES generos(id)
);

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

INSERT INTO consolas VALUES (1, 'PlayStation', 5, '03/12/1994', 5);
INSERT INTO consolas VALUES (2, 'PlayStation 4', 5, '15/11/2013', 8);
INSERT INTO consolas VALUES (3, 'PlayStation 5', 5, '12/11/2020', 9);
INSERT INTO consolas VALUES (4, 'XBOX Series X', 7, '10/11/2020 ', 9);
INSERT INTO consolas VALUES (5, 'Nintendo Switch', 2, '03/03/2017', 8);

INSERT INTO generos VALUES (1, 'RPG');
INSERT INTO generos VALUES (2, 'Aventura');
INSERT INTO generos VALUES (3, 'Acción');
INSERT INTO generos VALUES (4, 'Sandbox');
INSERT INTO generos VALUES (5, '3rd Person Shooter');

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

-- 1
SELECT v.titulo
FROM videojuegos v
JOIN desarrolladores d ON v.id_desarr = d.id
WHERE d.paisOrigen = 'Japón';
-- 2
SELECT v.titulo, v.pegi
FROM videojuegos v
JOIN desarrolladores d ON v.id_desarr = d.id
WHERE v.pegi > (
    SELECT MAX(v2.pegi)
    FROM videojuegos v2
    JOIN desarrolladores d2 ON v2.id_desarr = d2.id
    WHERE d2.paisOrigen = 'Suecia'
);
-- 3
SELECT d.nombre, l.fec_lanz
FROM desarrolladores d
JOIN videojuegos v ON d.id = v.id_desarr
JOIN lanzamientos l ON v.id = l.id_juego
WHERE l.fec_lanz > '31/12/2015';
-- 4
SELECT v.titulo
FROM videojuegos v
JOIN lanzamientos l ON v.id = l.id_juego
GROUP BY v.id, v.titulo
HAVING COUNT(DISTINCT l.id_consola) > (
    SELECT COUNT(DISTINCT l2.id_consola)
    FROM videojuegos v2
    JOIN lanzamientos l2 ON v2.id = l2.id_juego
    WHERE v2.titulo = 'Cyberpunk'
);
-- 5
SELECT c.nombre, c.fec_lanz
FROM consolas c
JOIN desarrolladores d ON c.id_desarr = d.id
WHERE c.fec_lanz > (
    SELECT c2.fec_lanz
    FROM consolas c2
    JOIN desarrolladores d2 ON c2.id_desarr = d2.id
    WHERE d2.nombre LIKE '%Nintendo%'
);
-- 6
SELECT g.nombre
FROM generos g
LEFT JOIN juego_genero jg ON g.id = jg.id_genero
WHERE jg.id_juego IS NULL;
-- 7
SELECT v.titulo
FROM videojuegos v
JOIN lanzamientos l ON v.id = l.id_juego
JOIN consolas c ON l.id_consola = c.id
WHERE c.nombre LIKE '%Sony%';
-- 8 
SELECT d.nombre, d.añoFund
FROM desarrolladores d
WHERE d.añoFund < (
    SELECT MIN(d2.añoFund)
    FROM desarrolladores d2
    WHERE d2.paisOrigen = 'Estados Unidos'
);
-- 9
SELECT v.titulo
FROM videojuegos v
JOIN juego_genero jg ON v.id = jg.id_juego
JOIN generos g ON jg.id_genero = g.id
WHERE g.nombre != '3rd Person Shooter';
-- 10
SELECT v.titulo
FROM videojuegos v
WHERE v.titulo LIKE 'The%';
-- 11
SELECT g.*
FROM generos g
WHERE LENGTH(g.nombre) = 8;
-- 12
SELECT d.nombre AS desarrolladora, c.nombre AS consola
FROM desarrolladores d
JOIN consolas c ON d.id = c.id_desarr;
-- 13
SELECT v.*
FROM videojuegos
JOIN juego_genero jg ON jg.id_juego = v.id
JOIN genero g ON g.id = jd.id_genero
WHERE COUNT() > 1;
-- 14
SELECT g.nombre AS genero, COUNT(jg.id_juego) AS cantidad_juegos
FROM generos g
LEFT JOIN juego_genero jg ON g.id = jg.id_genero
GROUP BY g.nombre
ORDER BY cantidad_juegos DESC;
-- 15
SELECT c.nombre AS consola, MAX(l.fec_lanz) AS ultimo_lanzamiento
FROM consolas c
JOIN lanzamientos l ON c.id = l.id_consola
GROUP BY c.nombre
ORDER BY ultimo_lanzamiento DESC;
-- 16
ALTER TABLE consolas DROP COLUMN generacion;
-- 17
DELETE FROM lanzamientos WHERE id_consola = (SELECT id FROM consolas WHERE nombre = 'PlayStation');
-- 18
SELECT d.nombre AS desarrollador, v.titulo AS juego, v.pegi
FROM desarrolladores d
JOIN videojuegos v ON d.id = v.id_desarr
JOIN (
    SELECT d.paisOrigen, AVG(v.pegi) AS promedio_pegi
    FROM desarrolladores d
    JOIN videojuegos v ON d.id = v.id_desarr
    GROUP BY d.paisOrigen
) p ON d.paisOrigen = p.paisOrigen
WHERE v.pegi > p.promedio_pegi;
-- 19
SELECT d.nombre AS desarrolladora
FROM desarrolladores d
JOIN videojuegos v ON d.id = v.id_desarr
JOIN juego_genero jg ON v.id = jg.id_juego
GROUP BY d.nombre
HAVING COUNT(DISTINCT jg.id_genero) = (SELECT COUNT(*) FROM generos);
-- 20
SELECT g.nombre AS genero, c.generacion, COUNT(*) AS juegos_lanzados
FROM lanzamientos l
JOIN consolas c ON l.id_consola = c.id
JOIN juego_genero jg ON l.id_juego = jg.id_juego
JOIN generos g ON jg.id_genero = g.id
WHERE c.generacion = 9
GROUP BY g.nombre, c.generacion
ORDER BY juegos_lanzados DESC
FETCH FIRST ROWS ONLY;
-- 21 ES LO MISMO QUE EL 19
-- 22
SELECT v.titulo
FROM videojuegos v
JOIN lanzamientos l ON v.id = l.id_juego
JOIN consolas c ON l.id_consola = c.id
GROUP BY v.titulo
HAVING COUNT(DISTINCT c.generacion) = 3;
-- 23
SELECT v.titulo
FROM videojuegos v
JOIN lanzamientos l ON v.id = l.id_juego
WHERE l.id_consola = 5 
GROUP BY v.titulo;
-- 24
SELECT con.nombre, juegos, g.nombre, COUNT(jg.id_juego), COUNT(jg.id_juego) / juegos * 100 AS porcentaje
FROM consolas con JOIN (SELECT COUNT(id_juego) AS juegos, c.id AS consola
                            FROM consolas c JOIN lanzamientos ON id_consola = c.id
                            GROUP BY c.id) ON con.id=consola
JOIN lanzamientos l ON con.id = l.id_consola
JOIN juego_genero jg ON jg.id_juego = l.id_juego
JOIN generos g ON jg.id_genero = g.id
GROUP BY con.nombre, juegos, g.nombre;
-- 25
SELECT v.id, v.titulo
FROM videojuegos v
JOIN lanzamientos lz ON lz.id_juego = v.id
JOIN (
    SELECT c.id as cid
    FROM consolas c
    WHERE fec_lanz != ALL 
        (SELECT MAX(fec_lanz) FROM consolas co
        JOIN desarrolladores d ON co.id_desarr = d.id
        GROUP BY d.id
        )) ON cid = lz.id_consola;        
-- 26
SELECT c.id AS consola_id, c.nombre AS consola_nombre, COUNT(DISTINCT g.id) AS num_generos
FROM consolas c
JOIN lanzamientos l ON c.id = l.id_consola
JOIN videojuegos v ON l.id_juego = v.id
JOIN juego_genero jg ON v.id = jg.id_juego
JOIN generos g ON jg.id_genero = g.id
WHERE  ADD_MONTHS(c.fec_lanz, 12) = ADD_MONTHS(l.fec_lanz, 12)  
GROUP BY c.id, c.nombre;
    

