CREATE TABLE superheroe
(
    id NUMERIC(3) PRIMARY KEY CHECK (id > 0),
    nombre VARCHAR2(25) NOT NULL,
    ciudad VARCHAR2(50),
    alias VARCHAR2(50) NOT NULL
);

CREATE TABLE equipos
(
    id NUMERIC(3) PRIMARY KEY CHECK (id > 0),
    nombre VARCHAR2(25) NOT NULL
);

CREATE TABLE heroe_equipo
(
    heroe VARCHAR2(25) NOT NULL,
    equipo VARCHAR2(25) 
);

CREATE TABLE poder
(
    id NUMERIC(3) PRIMARY KEY CHECK (id > 0),
    poder VARCHAR2(50) NOT NULL,
    cantidad NUMERIC(3) NOT NULL
);

CREATE TABLE villano
(
    id NUMERIC(3) PRIMARY KEY CHECK (id > 0),
    nombre VARCHAR2(25) NOT NULL,
    ciudad VARCHAR2(50),
    alias VARCHAR2(50) NOT NULL
);

INSERT INTO superheroes VALUES(1, 'Clark Kent', 'Metrópolis', 'Superman');
INSERT INTO superheroes VALUES(2, 'Bruce Wayne', 'Gotham City', 'Batman');
INSERT INTO superheroes VALUES(3, 'James Howlett', 'Alberta', 'Lobezno');
INSERT INTO superheroes VALUES(4, 'Peter Parker', 'Nueva York', 'Spider-Man');
INSERT INTO superheroes VALUES(5, 'Peter Jason Quill', 'St. Charles', 'Star-Lord');

INSERT INTO equipo VALUES(1, 'X-men');
INSERT INTO equipo VALUES(2, 'Guardianes de la galaxia');
INSERT INTO equipo VALUES(3, 'La liga de la justicia');
INSERT INTO equipo VALUES(4, 'Pride');
INSERT INTO equipo VALUES(5, 'Los Vengadores');

INSERT INTO equipo VALUES('Superman', 'La liga de la justicia');
INSERT INTO equipo VALUES('Batman', 'La liga de la justicia');
INSERT INTO equipo VALUES('Lobezno', 'X-men');
INSERT INTO equipo VALUES('Spider-Man', 'Vengadores');
INSERT INTO equipo VALUES('Star-Lord', 'Guardianes de la galaxia');

INSERT INTO poderes VALUES(1, 'Super fuerza, rayos x, volar', 3);
INSERT INTO poderes VALUES(2, 'Ninguno', 0);
INSERT INTO poderes VALUES(3, 'Regeneración, fuerza, garras', 3);
INSERT INTO poderes VALUES(4, 'regeneracion, sentido aracnido, lanza telarañas', 3);
INSERT INTO poderes VALUES(5, 'Viajar a través del espacio', 1);
INSERT INTO poderes VALUES(6, 'Agilidad, coeficiente intelectual de genio', 2);
INSERT INTO poderes VALUES(7, 'Controla todas las formas del magnetismo', 1);
INSERT INTO poderes VALUES(8, 'Proyección astral, el cambio de forma, la hipnosis...', 6);
INSERT INTO poderes VALUES(9, 'Usa tentáculos mecánicos superfuertes y duraderos', 1);
INSERT INTO poderes VALUES(10, 'Telequinesis, telepatía, teletransportación, inmunidad a ataques psíquicos', 4);

INSERT INTO villanos VALUES(6, 'Arthur Fleck ', 'Gotham', 'Joker');
INSERT INTO villanos VALUES(7, 'Erik Magnus Lehnsherr', 'Genosha', 'Magneto');
INSERT INTO villanos VALUES(8, 'Loki Loufeyson', 'Asgard', 'Loki');
INSERT INTO villanos VALUES(9, 'Otto Octavius', 'New York', 'Doctor Octopus');
INSERT INTO villanos VALUES(10, 'Thanos', 'Titán', 'Thanos');


--1
ALTER TABLE superheroes ADD COLUMN edad NUMERIC(3);
--2
ALTER TABLE superheroes MODIFY COLUMN nombre VARCHAR(100);
--3
ALTER TABLE superheroes RENAME TO personaje;
--4
SELECT * FROM personaje WHERE tipo = 'heroe';
--5
SELECT nombre, alias FROM personaje WHERE ciudad = 'Gotham City';
--6
SELECT nombre, equpo FROM  personaje WHERE equipo IS NOT NULL;
--7
SELECT COUNT(*) AS total_villanos FROM villanos;
--8
SELECT * FROM poderes WHERE id > 5;
AND SELECT alias FROM villanos;
--9
SELECT * FROM personaje AND villanos;
AND SELECT * FROM poderes AND equipo;
--10
SELECT nombre, alias FROM personaje WHERE equipo = 'Vengadores';
--11
SELECT * FROM heroe_equipo WHERE equipo = 'Vengadores';
--12
SELECT equipo, COUNT(*) AS total_personas FROM heroe_equipo GROUP BY equipo;
--13
SELECT * FROM poderes WHERE poder ORDER BY cantidad_poderes DESC; 
--14
SELECT AVG(total_poderes) AS media_poderes
--15
SELECT * FROM cantidad_poderes WHERE poder = 'ninguno';
--16
SELECT poder, alias COUNT(*) AS total FROM poderes, personaje ORDER BY DESC;
--17
SELECT alias FROM personaje WHERE alias = 'Superman' AND 'Magneto';
--18
SELECT nombre, COUNT(poder) AS total_poderes FROM personaje 
HAVING total_poderes > (
    SELECT COUNT(poder) 
    FROM personaje p
    JOIN poderes po ON id = id_personaje
    WHERE alias = 'Spider-Man'
);
--19
SELECT heroe FROM heroe_equipo WHERE equipo IS NULL;
--20

--21
SELECT * FROM poderes, heroe_equipo WHERE cantidad > 2 AND equipo IS NULL;
--22
DELETE FROM personaje 
WHERE tipo = 'villano' AND id NOT IN (
    SELECT id_personaje 
    FROM poderes
);
--23
UPDATE personaje 
SET nombre = 'Miles Morales' 
WHERE alias = 'Spider-Man';
--24
INSERT INTO personaje  VALUES ('Marc Spector', 'Moon Knight', 'héroe');
--25
UPDATE personaje 
SET equipo = 'Vengadores' 
WHERE alias = 'Moon Knight';
--26
DELETE FROM personaje 
WHERE equipo IS NULL;
--27


