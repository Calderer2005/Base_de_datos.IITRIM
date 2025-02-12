//BD VIDEOJUEGOS

//1.CREAR TABLAS
drop table consola cascade constraints;
drop table desarrolladores cascade constraints;
drop table genero cascade constraints;
drop table juego_genero cascade constraints;
drop table lanzamientos cascade constraints;
drop table videojuegos cascade constraints;

CREATE TABLE desarrolladores
(
  id NUMBER(2)PRIMARY KEY CHECK (id > 0),
  nombre VARCHAR2(25)NOT NULL,
  paisorigen VARCHAR2(50),
  añofundacion NUMBER(4)
);

CREATE TABLE videojuegos
(
  id NUMBER(2)PRIMARY KEY CHECK (id > 0),
  titulo VARCHAR2(50)NOT NULL,
  PEGI NUMBER(2)CHECK (PEGI IN(3,7,12,16,18)),
  id_desarrolladora NUMBER(2),
  
  CONSTRAINT fk_des FOREIGN KEY(id_desarrolladora)REFERENCES desarrolladores(id)
);

CREATE TABLE consolas
(
  id NUMBER(3)PRIMARY KEY CHECK (id > 0),
  nombre VARCHAR2(25)NOT NULL,
  id_fabricante NUMBER(2),
  fechalanzamiento DATE,
  generacion NUMBER(1)NOT NULL,
  
CONSTRAINT fk_des_con FOREIGN KEY(id_fabricante)REFERENCES desarrolladores(id)
);

CREATE TABLE generos
(
  id NUMBER(3)PRIMARY KEY CHECK (id > 0),
  nombre VARCHAR2(25)NOT NULL
);

CREATE TABLE juego_genero
(
  id_juego NUMBER(2),
  id_genero NUMBER(3),
  
  CONSTRAINT pk_juegogen PRIMARY KEY (id_juego,id_genero),
  CONSTRAINT fk_juego_gen FOREIGN KEY (id_juego)REFERENCES videojuegos(id),
  CONSTRAINT fk_gen_juego FOREIGN KEY (id_genero)REFERENCES generos (id)
);

CREATE TABLE lanzamientos 
(
  id_juego NUMBER(2),
  id_consola NUMBER(3),
  fechalanzamiento DATE,
  
  CONSTRAINT pk_lanzamiento PRIMARY KEY (id_juego,id_consola),
  CONSTRAINT pk_juegol FOREIGN KEY (id_juego)REFERENCES videojuegos(id),
  CONSTRAINT pk_consolal FOREIGN KEY (id_consola)REFERENCES consolas (id)
);

//2.INSERTAR DATOS
INSERT INTO desarrolladores VALUES (1,'CD Projekt Red','Polonia',1994);
INSERT INTO desarrolladores VALUES (2,'Nintendo EPD','Japón',1889);
INSERT INTO desarrolladores VALUES (3,'Rockstar Games','Estados Unidos',1998);
INSERT INTO desarrolladores VALUES (4,'Mojanj Studios','Suecia',2009);
INSERT INTO desarrolladores VALUES (5,'Sony Interactive','Japón',1993);
INSERT INTO desarrolladores VALUES (6,'Insomniac Games','Estados Unidos',1994);
INSERT INTO desarrolladores VALUES (7,'Microsoft','Estados Unidos',1975);

INSERT INTO videojuegos VALUES (1,'Cyberpunk 2077',18,1);
INSERT INTO videojuegos VALUES (2,'The Legend of Zelda Breath of the Wild',12,2);
INSERT INTO videojuegos VALUES (3,'Red Dead Redemption 2',18,3);
INSERT INTO videojuegos VALUES (4,'Minecraft',7,4);
INSERT INTO videojuegos VALUES (5,'Spyro the Dragon',3,6);
INSERT INTO videojuegos VALUES (6,'The Sims',12,7);

INSERT INTO consolas VALUES (1,'PlayStation',5,'03/12/1994',5);
INSERT INTO consolas VALUES (2,'PlayStation 4',5,'15/11/2013',8);
INSERT INTO consolas VALUES (3,'PlayStation 5',5,'12/11/2020',9);
INSERT INTO consolas VALUES (4,'XBOX Series X',7,'10/11/2020',9);
INSERT INTO consolas VALUES (5,'Nintendo Switch',2,'03/03/2017',8);

INSERT INTO generos VALUES (1,'RPG');
INSERT INTO generos VALUES (2,'Aventura');
INSERT INTO generos VALUES (3,'Accion');
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

INSERT INTO lanzamientos VALUES(1,2,'10/12/2020');
INSERT INTO lanzamientos VALUES(1,3,'14/02/2022');
INSERT INTO lanzamientos VALUES(1,4,'14/02/2022');
INSERT INTO lanzamientos VALUES(2,5,'03/03/2017');
INSERT INTO lanzamientos VALUES(3,2,'26/10/2018');
INSERT INTO lanzamientos VALUES(4,2,'04/09/2014');
INSERT INTO lanzamientos VALUES(4,5,'12/05/2017');
INSERT INTO lanzamientos VALUES(5,1,'09/09/1998');

//3.CONSULTAS CON JOIN

--1.Muestra los videojuegos desarrollados en Japon 
SELECT v.titulo 
FROM videojuegos v JOIN desarrolladores d ON v.id_desarrolladora=d.id 
WHERE d.paisorigen='Japón';

--2.Juegos con un PEGI mayor que los juegos desarrollados en Suecia
SELECT v.titulo
FROM videojuegos v JOIN desarrolladores d ON v.id_desarrolladora=d.id 
WHERE v.PEGI >(SELECT v.PEGI 
               FROM videojuegos v JOIN desarrolladores d ON v.id_desarrolladora=d.id 
               WHERE d.paisorigen='Suecia');

--3.Selecciona las desarrolladoras que hayan lanzado un juego despues de 2015
SELECT d.*, l.fechalanzamiento
FROM desarrolladores d JOIN videojuegos v ON d.id=v.id_desarrolladora 
                       JOIN  lanzamientos l ON l.id_juego=v.id
WHERE l.fechalanzamiento > '31/12/2015';

--4.Muestra los juegos que estén disponibles en más consolas que Cyberpunk
SELECT v.titulo
FROM desarrolladores d JOIN videojuegos v ON d.id=v.id_desarrolladora
                       JOIN consolas c ON d.id=c.id_fabricante
WHERE c.id > (SELECT COUNT (l.id_consola)
                     FROM  lanzamientos l JOIN consolas c ON l.id_consola=c.id
                      JOIN videojuegos v ON l.id_juego=v.id
                     WHERE v.titulo='Cyberpunk');//Revisar

SELECT COUNT (l.id_consola)
FROM  lanzamientos l JOIN consolas c ON l.id_consola=c.id
                    JOIN videojuegos v ON l.id_juego=v.id
WHERE v.titulo='Cyberpunk';

--5.Consolas que se hayan lanzado despues de alguna de las consolas de nintendo
SELECT c.nombre, c.fechalanzamiento FROM lanzamientos l JOIN consolas c ON l.id_consola=c.id
                                    JOIN desarrolladores d ON d.id=c.id_fabricante 
WHERE d.nombre !='Nintendo EPD' AND c.fechalanzamiento > '04/03/17';

--6. Muestra los géneros que no tengan ningun juego asignado
SELECT g.nombre,v.titulo  FROM juego_genero jg RIGHT JOIN videojuegos v ON jg.id_juego=v.id
                              LEFT JOIN generos g ON jg.id_genero=g.id
WHERE jg.id_juego IS NULL AND jg.id_genero IS NULL;

--7.Selecciona los juegos que se hayan lanzado en consolas Sony 
SELECT v.titulo, d.nombre FROM lanzamientos l JOIN videojuegos v ON l.id_juego=v.id
                                   JOIN consolas c ON l.id_consola=c.id 
                                   JOIN desarrolladores d ON d.id=c.id_fabricante
WHERE d.nombre LIKE 'Sony%';

--8.Muestra las desarrolladoras mas antiguas que las desarrolladoras de Estados Unidos
SELECT d.* FROM desarrolladores d WHERE añofundacion < 1998;

--9. Muestra todos los juegos que no sean Shooters en 3ª persona
SELECT v.titulo, g.nombre FROM juego_genero jg JOIN generos g ON jg.id_genero=g.id
                                        JOIN videojuegos v ON jg.id_juego=v.id
WHERE g.nombre != '3rd Person Shooter';

--10. Obten los juegos cuyo titulo empiece por 'The'
SELECT * FROM videojuegos WHERE titulo LIKE 'The%';

--11.Muestra los generos que se escriban con 8 letras
SELECT * FROM generos WHERE nombre LIKE '________';

--12. Muestra todas las desarrolladoras y sus consolas asociadas.
SELECT d.nombre AS desarrolladoras, c.nombre AS consolas
FROM desarrolladores d JOIN consolas c ON d.id=c.id_fabricante;

--13. Muestra los juegos con más de un género.
SELECT v.titulo
FROM juego_genero jg JOIN videojuegos v ON jg.id_juego=v.id
GROUP BY v.titulo
HAVING COUNT(DISTINCT jg.id_genero) > 1;

--14.Obten cuantos juegos tienen asignados cada genero
SELECT g.nombre AS genero, COUNT (jg.id_juego) AS cantidad_juegos
FROM juego_genero jg JOIN generos g ON jg.id_genero=g.id
GROUP BY g.nombre;

--15.Muestra la fecha del ultimo lanzamiento de cada consola
SELECT c.nombre AS consola, MAX(l.fechalanzamiento) AS ultimo_lanzamiento
FROM consolas c JOIN lanzamientos l ON c.id = l.id_consola
GROUP BY c.nombre;

--16. Elimina la columna de generacion de la tabla de consolas
ALTER TABLE consolas DROP COLUMN generacion;

--17.Elimina todos los lanzamientos de la PlayStation1
DELETE FROM lanzamientos
WHERE id_consola=1;

--18.Muestra los desarrolladores cuyos juegos tienen un PEGI mayor que el promedio de su país
select distinct d.nombre 
from desarrolladores d join videojuegos v ON d.id=v.id_desarrolladora 
WHERE v.PEGI > (Select avg (PEGI)
       FROM videojuegos v2 JOIN desarrolladores d2 ON v2.id_desarrolladora=d2.id
       where d2.paisorigen=d.paisorigen);
       
--19.Obten las desarrolladoras que hayan lanzado al menos un juego en cada género

SELECT d.nombre AS desarrolladora, COUNT (DISTINCT jg.id_genero)
FROM desarrolladores d JOIN videojuegos v ON v.id_desarrolladora=d.id
                    JOIN juego_genero jg ON jg.id_juego=v.id
                    JOIN generos g ON g.id=jg.id_genero
GROUP BY d.id, d.nombre
HAVING COUNT(DISTINCT g.id) = (SELECT COUNT(*) FROM generos);

--20.Muestra el genero con mas juegos lanzados en la 9º generación
SELECT g.nombre AS generos, COUNT (v.id) AS  cantidad_juegos, c.generacion
FROM juego_genero jg JOIN generos g ON jg.id_genero=g.id
            JOIN videojuegos v ON jg.id_juego=v.id
            JOIN lanzamientos l ON l.id_juego=v.id
            JOIN consolas c ON l.id_consola=c.id
WHERE c.generacion=9
GROUP BY g.nombre, c.generacion;

--21.Selecciona las desarrolladoras que hayan lanzado juegos para todos los generos //MIRAR
SELECT d.nombre, COUNT (DISTINCT jg.id_genero)
FROM desarrolladores d JOIN videojuegos v ON v.id_desarrolladora=d.id
                JOIN lanzamientos l ON v.id=l.id_juego
                JOIN juego_genero jg ON v.id=jg.id_juego
                JOIN generos g ON g.id=jg.id_genero    
GROUP BY d.nombre
HAVING COUNT (DISTINCT jg.id_genero) IN (SELECT jg.id_genero  FROM juego_genero 
                                                              JOIN videojuegos v ON v.id=jg.id_juego
                                                              JOIN desarrolladores ON v.id_desarrolladora=d.id);
                                        
--22. Muestra los juegos que hayan sido lanzados en 3 generaciones distintas
SELECT v.titulo
FROM lanzamientos l JOIN videojuegos v ON l.id_juego=v.id
                    JOIN consolas c ON l.id_consola=c.id
GROUP BY v.titulo
HAVING COUNT (DISTINCT c.generacion) = 3;

--23.Muestra los juegos que hayan salido para todas las consolas de Sony
SELECT v.titulo AS juegos FROM videojuegos v JOIN desarrolladores d ON v.id_desarrolladora=d.id
                                   JOIN consolas c ON c.id_fabricante=d.id
WHERE d.nombre='Sony Interactive';
                        












