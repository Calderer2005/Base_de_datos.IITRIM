// 1TDAW_BD_Tema_4_Ejercicios_SQL_05.pdf

// CREACION DE TABLAS
CREATE TABLE desarrolladoras (
    id INT PRIMARY KEY CHECK (id > 0),
    nombre VARCHAR2(25) NOT NULL,
    pais_orig VARCHAR2(50),
    a_fundacion INT CHECK (a_fundacion >= 1800 AND a_fundacion <= 2025)
);

CREATE TABLE videojuegos (
    id INT PRIMARY KEY CHECK (id > 0),
    titulo VARCHAR2(50) NOT NULL,
    pegi INT CHECK (pegi IN (3, 7, 12, 16, 18)),
    id_desarrolladora INT,
    
    CONSTRAINT fk_vj_des FOREIGN KEY (id_desarrolladora) REFERENCES desarrolladoras(id)
);

CREATE TABLE generos (
    id INT PRIMARY KEY CHECK (id > 0),
    nombre VARCHAR2(25) NOT NULL
);

CREATE TABLE videojuego_genero (
    id_juego INT,
    id_genero INT,
    
    CONSTRAINT fk_vjgen_vj FOREIGN KEY (id_juego) REFERENCES videojuegos(id),
    CONSTRAINT fk_vjgen_gen FOREIGN KEY (id_genero) REFERENCES generos(id)
);

CREATE TABLE consolas (
    id INT PRIMARY KEY CHECK (id > 0),
    nombre VARCHAR2(25) NOT NULL,
    id_fabr INT,
    f_lanz DATE,
    generacion NUMBER(1) CHECK (generacion > 0),
    
    CONSTRAINT fk_cons_fabr FOREIGN KEY (id_fabr) REFERENCES desarrolladoras(id)
);

CREATE TABLE lanzamientos (
    id_juego INT,
    id_consola INT,
    f_lanz DATE,
    
    CONSTRAINT pk_lanz PRIMARY KEY (id_juego, id_consola, f_lanz),
    CONSTRAINT fk_lanz_vj FOREIGN KEY (id_juego) REFERENCES videojuegos(id),
    CONSTRAINT fk_lanz_cons FOREIGN KEY (id_consola) REFERENCES consolas(id)   
);



// INSERCION DE DATOS
INSERT INTO desarrolladoras VALUES (1, 'CD Projekt Red', 'Polonia', 1994);
INSERT INTO desarrolladoras VALUES (2, 'Nintendo EPD', 'Japon', 1889);
INSERT INTO desarrolladoras VALUES (3, 'Rockstar Games', 'Estados Unidos', 1998);
INSERT INTO desarrolladoras VALUES (4, 'Mojang Studios', 'Suecia', 2009);
INSERT INTO desarrolladoras VALUES (5, 'Sony Interactive', 'Japon', 1993);
INSERT INTO desarrolladoras VALUES (6, 'Insomniac Games', 'Estados Unidos', 1994);
INSERT INTO desarrolladoras VALUES (7, 'Microsoft', 'Estados Unidos', 1975);

INSERT INTO videojuegos VALUES (1, 'Cyberpunk 2077', 18, 1);
INSERT INTO videojuegos VALUES (2, 'The Legend of Zelda: Breath of the Wild', 12, 2);
INSERT INTO videojuegos VALUES (3, 'Red Dead Redemption 2', 18, 3);
INSERT INTO videojuegos VALUES (4, 'Minecraft', 7, 4);
INSERT INTO videojuegos VALUES (5, 'Spyro the Dragon', 3, 6);

INSERT INTO consolas VALUES (1, 'PlayStation', 5, '03/12/1994', 5);
INSERT INTO consolas VALUES (2, 'PlayStation 4', 5, '15/11/2013', 8);
INSERT INTO consolas VALUES (3, 'PlayStation 5', 5, '12/11/2020', 9);
INSERT INTO consolas VALUES (4, 'XBOX Series X', 7, '10/11/2020', 9);
INSERT INTO consolas VALUES (5, 'Nintendo Switch', 2, '03/03/2017', 8);

INSERT INTO generos VALUES (1, 'RPG');
INSERT INTO generos VALUES (2, 'Aventura');
INSERT INTO generos VALUES (3, 'Accion');
INSERT INTO generos VALUES (4, 'Sandbox');
INSERT INTO generos VALUES (5, 'Disparos en 3a persona');

INSERT INTO videojuego_genero VALUES (1, 1);
INSERT INTO videojuego_genero VALUES (1, 3);
INSERT INTO videojuego_genero VALUES (1, 5);
INSERT INTO videojuego_genero VALUES (2, 2);
INSERT INTO videojuego_genero VALUES (2, 3);
INSERT INTO videojuego_genero VALUES (3, 3);
INSERT INTO videojuego_genero VALUES (3, 4);
INSERT INTO videojuego_genero VALUES (3, 5);
INSERT INTO videojuego_genero VALUES (4, 4);
INSERT INTO videojuego_genero VALUES (5, 2);
INSERT INTO videojuego_genero VALUES (5, 3);

INSERT INTO lanzamientos VALUES (1, 2, '10/12/2020');
INSERT INTO lanzamientos VALUES (1, 3, '14/02/2022');
INSERT INTO lanzamientos VALUES (1, 4, '14/02/2022');
INSERT INTO lanzamientos VALUES (2, 5, '03/03/2017');
INSERT INTO lanzamientos VALUES (3, 2, '26/10/2018');
INSERT INTO lanzamientos VALUES (4, 2, '04/09/2014');
INSERT INTO lanzamientos VALUES (4, 5, '12/05/2017');
INSERT INTO lanzamientos VALUES (5, 1, '09/09/1998');



// CONSULTAS
--1. Muestra videojuegos desarrollados en Japon
SELECT * FROM videojuegos vj
JOIN desarrolladoras d ON vj.id_desarrolladora = d.id
WHERE d.pais_orig = 'Japon';

--2. Muestra juegos con PEGI mayor que los juegos desarrollados en Suecia
-- (= mayor que Minecraft, +7)
SELECT * FROM videojuegos vj
WHERE pegi > ALL (
    SELECT pegi FROM videojuegos vj
    JOIN desarrolladoras d ON vj.id_desarrolladora = d.id
    WHERE d.pais_orig = 'Suecia'
);

--3. Selecciona desarrolladoras que hayan lanzado un juego después de 2015
SELECT * FROM desarrolladoras d
JOIN videojuegos vj ON d.id=vj.id_desarrolladora
JOIN lanzamientos l ON vj.id=l.id_juego
WHERE f_lanz > '31/12/2015';

-- 4. Muestra juegos disponibles en más consolas que Cyberpunk
-- (ninguno)
SELECT titulo, COUNT(id_consola) FROM videojuegos vj
JOIN lanzamientos l ON vj.id = l.id_juego
HAVING COUNT(id_consola) > (
    SELECT COUNT(id_consola) FROM lanzamientos l
    JOIN videojuegos vj ON vj.id=l.id_juego
    WHERE vj.titulo = 'Cyberpunk 2077'
) GROUP BY titulo;

-- 5 Muestra consolas lanzadas después de alguna de las de Nintendo
SELECT * FROM consolas c
WHERE f_lanz > (
    SELECT f_lanz FROM consolas c
    JOIN desarrolladoras d on c.id_fabr=d.id
    WHERE d.nombre LIKE '%Nintendo%'
);

--6. Muestra generos sin ningun juego asignado
--(todos tienen uno asignado, asi que añado uno sin relaciones)
INSERT INTO generos VALUES (6, 'Simulacion');

SELECT * FROM generos
WHERE id != ALL (
    SELECT id_genero FROM videojuego_genero
);

--7 Selecciona juegos lanzados en consolas de Sony
SELECT * FROM videojuegos vj
JOIN lanzamientos l ON vj.id=l.id_juego
WHERE id_consola = ANY (
    SELECT c.id FROM consolas c
    JOIN desarrolladoras d on c.id_fabr=d.id
    WHERE d.nombre LIKE '%Sony%'
);

--8 Muestra las desarrolladoras mas antiguas que las de EE UU
--(deberia salir Nintendo)
SELECT * FROM desarrolladoras
WHERE a_fundacion < ALL (
    SELECT a_fundacion FROM desarrolladoras
    WHERE pais_orig = 'Estados Unidos'
);

--9 Muestra juegos que no sean shooters en 3a persona
SELECT v.*, g.nombre AS genero FROM videojuegos v
JOIN videojuego_genero vg ON v.id=vg.id_juego
JOIN generos g ON vg.id_genero=g.id
WHERE id_genero != ALL (
    SELECT id_genero FROM videojuego_genero vg
    JOIN generos g ON vg.id_genero=g.id
    WHERE g.nombre = 'Disparos en 3a persona'
);

--10. Muestra juegos cuyo titulo empiece por The
SELECT * FROM videojuegos
WHERE titulo LIKE 'The%';

--11. Muestra generos que se escriban con 8 letras
--(= aventura)
SELECT * FROM generos
WHERE LENGTH(nombre) = 8;

-- O bien:
SELECT * FROM generos
WHERE nombre LIKE '________';

--12. Muestra todas las desarrolladoras y sus consolas asociadas
SELECT * FROM desarrolladoras
FULL JOIN consolas ON consolas.id_fabr=desarrolladoras.id;

--13. Muestra juegos con más de un género
-- (deberian salir todos menos Minecraft)
SELECT v.titulo FROM videojuegos v
JOIN videojuego_genero vg ON v.id=vg.id_juego
JOIN generos g ON vg.id_genero=g.id
GROUP BY v.titulo
HAVING COUNT(vg.id_genero) > 1
ORDER BY v.titulo;

--14. Muestra cuantos juegos tienen asignados cada genero
SELECT id_genero, COUNT(id_juego) FROM videojuego_genero vgen
GROUP BY id_genero
ORDER BY id_genero;

--15. Muestra la fecha del último lanzamiento de cada consola.
SELECT c.nombre AS consola, v.titulo AS juego, l.f_lanz AS lanzamiento_juego FROM lanzamientos l
JOIN consolas c ON l.id_consola=c.id
JOIN videojuegos v ON l.id_juego=v.id
WHERE l.f_lanz >= ALL (
    SELECT f_lanz FROM lanzamientos
)
ORDER BY c.nombre;

-- 16. Elimina la columna de generación de la tabla consolas.
ALTER TABLE consolas
DROP COLUMN generacion;

-- 17. Elimina todos los lanzamientos de la PlayStation1.
DELETE *
FROM lanzamientos
    JOIN consolas ON consolas.id=lanzamientos.id_consola
WHERE consolas.nombre = 'PlayStation';


--------------------------------------
--
-- PEDIR CORREGIR A PARTIR DE AQUI
--
--------------------------------------


--- 18. Muestra los desarrolladores cuyos juegos tienen un PEGI mayor
--que el promedio de su país.
SELECT distinct d.nombre
FROM desarrolladoras d
    JOIN videojuegos v ON d.id=v.id_desarrolladora
WHERE v.pegi >
    (SELECT AVG(pegi)
    FROM videojuegos v2 JOIN desarrolladoras d2 ON v2.id_desarrolladora=d2.id
    WHERE d2.pais_orig=d.pais_orig
    );    


-- PEDIR CORREGIR - 19. Obtén las desarrolladoras que hayan lanzado al menos un juego en cada género.
SELECT d.nombre AS desarrolladora, g.nombre, COUNT(vgen.id_juego)
FROM desarrolladoras d
JOIN videojuegos v ON v.id_desarrolladora = d.id
JOIN videojuego_genero vgen ON vgen.id_juego = v.id
FULL JOIN generos g ON vgen.id_genero = g.id
HAVING COUNT(vgen.id_juego) >= 1
GROUP BY d.nombre, g.nombre;


--20. Muestra el género con más juegos lanzados en 9ª generación.
SELECT DISTINCT g.nombre
FROM generos g
    JOIN videojuego_genero vg ON vg.id_genero = g.id
    JOIN lanzamientos l ON l.id_juego = vg.id_juego
    JOIN consolas c ON c.id = l.id_consola
WHERE c.generacion = 9
HAVING COUNT(l.id_juego) >= ALL
    (SELECT COUNT(l.id_juego) FROM lanzamientos
    JOIN consolas ON lanzamientos.id_consola = consolas.id
    WHERE generacion=9)
GROUP BY g.nombre;

--21. Selecciona las desarrolladoras que hayan lanzado juegos para todos los géneros.
SELECT d.nombre, COUNT(g.id) FROM desarrolladoras d
JOIN videojuegos v ON v.id_desarrolladora=d.id
JOIN videojuego_genero vg ON vg.id_juego=v.id
JOIN generos g ON g.id=vg.id_genero
HAVING COUNT(g.id) = (
    SELECT COUNT(g.id) FROM generos g
) GROUP BY d.nombre;

--22. Muestra los juegos que hayan sido lanzados en 3 generaciones distintas.
SELECT v.titulo
FROM videojuegos v
    JOIN lanzamientos l ON v.id = l.id_juego
    JOIN consolas c ON l.id_consola = c.id
HAVING COUNT(DISTINCT c.generacion) >= 3
GROUP BY v.titulo;

--23. Muestra los juegos que hayan salido para todas las consolas de Sony.
SELECT v.titulo FROM videojuegos v
JOIN lanzamientos l ON v.id = l.id_juego
WHERE l.id_consola = ALL (
    SELECT c.id FROM consolas c
    JOIN desarrolladoras d ON c.id_fabr=d.id
    WHERE d.nombre LIKE 'Sony%'
);
-- Arreglar (cambiar a count)

--24. Calcula el porcentaje de juegos por cada género en cada una de las consolas.
SELECT g.nombre AS genero, c.nombre AS consola, (COUNT(v.id)*100)/COUNT(g.id)
FROM videojuegos v
    JOIN videojuego_genero vg ON vg.id_juego=v.id
    JOIN generos g ON g.id=vg.id_genero
    JOIN lanzamientos l ON l.id_juego=v.id
    JOIN consolas c ON l.id_consola=c.id

GROUP BY g.nombre, c.nombre

;

-- (sub) juegos por cada genero en cada consola
SELECT g.nombre, c.nombre, v.titulo
FROM videojuegos v
    JOIN videojuego_genero vg ON vg.id_juego=v.id
    JOIN generos g ON g.id=vg.id_genero
    JOIN lanzamientos l ON l.id_juego=v.id
    JOIN consolas c ON l.id_consola=c.id
;

--25. Muestra los juegos que hayan sido lanzados en consolas que ya no reciben soporte.
--(!= la ultima consola de cada fabricante)
SELECT v.titulo
FROM videojuegos v
    JOIN lanzamientos l ON v.id=l.id_juego
    JOIN consolas c ON c.id=l.id_consola
    JOIN desarrolladoras c ON c.id_fabricante=d.id

WHERE l.id_consola !=

(
SELECT d.nombre, c.nombre, c.f_lanz FROM consolas c
JOIN desarrolladoras d ON c.id_fabr=d.id
HAVING c.f_lanz >= ALL
    (SELECT c.f_lanz FROM consolas c
    JOIN desarrolladoras d ON c.id_fabr=d.id)
ORDER BY d.nombre, c.nombre
)    

;    

--26. Muestra para cuántos géneros se lanzan juegos en el primer año de cada consola.
SELECT c.nombre AS consola, COUNT(g.id) AS numero_generos_primerano
FROM generos g
    JOIN videojuego_genero vg ON g.id=vg.id_genero
    JOIN videojuegos v ON vg.id_juego=v.id
    JOIN lanzamientos l ON l.id_juego=v.id
    FULL JOIN consolas c ON l.id_consola=c.id
WHERE l.f_lanz = c.f_lanz
GROUP BY c.nombre;





