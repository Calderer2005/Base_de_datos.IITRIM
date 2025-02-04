CREATE TABLE Superheroes (
    ID NUMERIC(4) PRIMARY KEY,
    NOMBRE VARCHAR2(25) NOT NULL,
    CIUDAD_ORIGEN VARCHAR2(50) NOT NULL,
    ALIAS VARCHAR2(50) NOT NULL
);

CREATE TABLE Equipo (
    ID NUMERIC(4) PRIMARY KEY,
    NOMBRE VARCHAR2(25) NOT NULL
);

CREATE TABLE Poderes (
    ID NUMERIC(4) PRIMARY KEY,
    NOMBRE VARCHAR2(300) NOT NULL 
);

CREATE TABLE Villanos (
    ID NUMERIC(4) PRIMARY KEY,
    NOMBRE VARCHAR2(25) NOT NULL,
    CIUDAD_ORIGEN VARCHAR2(50),
    ALIAS VARCHAR2(50)
);


INSERT INTO Superheroes (ID, NOMBRE, CIUDAD_ORIGEN, ALIAS) VALUES 
(1, 'Batman', 'Arkham', 'El Justiciero'),
(2, 'Spiderman', 'Nueva York', 'Spidey'),
(3, 'Superman', 'Metrópolis', 'El Hombre del Mañana'),
(4, 'Hulk', 'Dayton', 'El Gigante Verde'),
(5, 'Ironman', 'Nueva York', 'Tony Stark');



INSERT INTO Superheroes (ID, NOMBRE, CIUDAD_ORIGEN, ALIAS) VALUES (1, 'Batman', 'Arkham', 'El Justiciero');
INSERT INTO Superheroes (ID, NOMBRE, CIUDAD_ORIGEN, ALIAS) VALUES (2, 'Spider-man', 'Nueva York', 'Spidey');
INSERT INTO Superheroes (ID, NOMBRE, CIUDAD_ORIGEN, ALIAS) VALUES (3, 'Superman', 'Metrópolis', 'El Hombre del Mañana');
INSERT INTO Superheroes (ID, NOMBRE, CIUDAD_ORIGEN, ALIAS) VALUES (4, 'Hulk', 'Dayton', 'El Gigante Verde');
INSERT INTO Superheroes (ID, NOMBRE, CIUDAD_ORIGEN, ALIAS) VALUES (5, 'Ironman', 'Nueva York', 'Tony Stark');



INSERT INTO Equipo (ID, NOMBRE) VALUES (1, 'DC');
INSERT INTO Equipo (ID, NOMBRE) VALUES (2, 'Marvel');
INSERT INTO Equipo (ID, NOMBRE) VALUES (3, 'DC');
INSERT INTO Equipo (ID, NOMBRE) VALUES (4, 'Marvel');
INSERT INTO Equipo (ID, NOMBRE) VALUES (5, 'Marvel');


INSERT INTO Poderes (ID, NOMBRE) VALUES (1, 'Resistencia telepática');
INSERT INTO Poderes (ID, NOMBRE) VALUES (2, 'Fuerza, velocidad, durabilidad, agilidad, sentidos, reflejos, coordinación, equilibrio y resistencia sobrehumanos');
INSERT INTO Poderes (ID, NOMBRE) VALUES (3, 'Súper fuerza, velocidad, resistencia, agilidad, reflejos, durabilidad, sentidos y longevidad, Vuelo');
INSERT INTO Poderes (ID, NOMBRE) VALUES (4, 'Fuerza sobrehumana, velocidad sobrehumana, factor curativo, estratega experto, emite radiación gamma.');
INSERT INTO Poderes (ID, NOMBRE) VALUES (5, 'Superfuerza, durabilidad y resistencia por armadura. Vuelo supersónico. Repulsores de energía y misiles de proyección. Regenerativo soporte vital.');


INSERT INTO Villanos (ID, NOMBRE, CIUDAD_ORIGEN, ALIAS) VALUES (1, 'Joker', 'Arkham City', 'Príncipe Payaso del Crimen');
INSERT INTO Villanos (ID, NOMBRE, CIUDAD_ORIGEN, ALIAS) VALUES (2, 'Gru', 'Rusia', 'Glavnoye Razvedyvatel');
INSERT INTO Villanos (ID, NOMBRE, CIUDAD_ORIGEN, ALIAS) VALUES (3, 'Darth Vader', 'Tatooine', 'Lord Vader');
INSERT INTO Villanos (ID, NOMBRE, CIUDAD_ORIGEN, ALIAS) VALUES (4, 'Capitán Garfio', 'Trivandrum', 'Bacalao');
INSERT INTO Villanos (ID, NOMBRE, CIUDAD_ORIGEN, ALIAS) VALUES (5, 'Thanos', 'Titán', 'El Titán Loco');


-- 1
ALTER TABLE Superheroes ADD EDAD NUMERIC(3);

-- 2
ALTER TABLE Superheroes MODIFY NOMBRE VARCHAR2(100);

-- 3
ALTER TABLE Superheroes RENAME TO Personaje;

-- 4
SELECT * FROM Personaje;

-- 5
SELECT NOMBRE, ALIAS FROM Personaje WHERE CIUDAD_ORIGEN = 'Nueva York';

-- 6
SELECT NOMBRE, (SELECT NOMBRE FROM Equipo WHERE ID = P.ID) AS Equipo
FROM Personaje P
WHERE ID IN (SELECT ID FROM Equipo);

-- 7
SELECT COUNT(*) FROM Villanos;

-- 8
SELECT  ALIAS,
(SELECT NOMBRE FROM Poderes WHERE ID = V.ID) AS Poder
FROM Villanos V;

-- 9
SELECT NOMBRE, ALIAS, 
       (SELECT NOMBRE FROM Equipo WHERE ID = P.ID) AS Equipo,
       (SELECT NOMBRE FROM Poderes WHERE ID = P.ID) AS Poder
FROM Personaje P
UNION ALL
SELECT NOMBRE, ALIAS,
       (SELECT NOMBRE FROM Equipo WHERE ID = V.ID) AS Equipo,
       (SELECT NOMBRE FROM Poderes WHERE ID = V.ID) AS Poder
FROM Villanos V;

-- 10
SELECT NOMBRE FROM Personaje WHERE ID IN (SELECT ID FROM Equipo WHERE NOMBRE = 'Vengadores');

-- 11
SELECT NOMBRE FROM Personaje WHERE ID IN 
    (SELECT ID FROM Poderes WHERE NOMBRE IN 
        (SELECT NOMBRE FROM Poderes GROUP BY NOMBRE HAVING COUNT(ID) > 1));

-- 12
SELECT (SELECT NOMBRE FROM Equipo WHERE ID = P.ID) AS Equipo, COUNT(*) 
FROM Personaje P
GROUP BY P.ID;

-- 13


-- 14
SELECT AVG(Total)
FROM (
    SELECT COUNT(*) AS Total
    FROM Poderes
    GROUP BY ID
);

-- 15
SELECT NOMBRE FROM Personaje WHERE ID IN 
    (SELECT ID FROM Poderes GROUP BY ID HAVING COUNT(*) = 
        (SELECT MIN(Total) FROM (SELECT COUNT(*) AS Total FROM Poderes GROUP BY ID)));

-- 16
SELECT NOMBRE, COUNT(*) FROM Poderes GROUP BY NOMBRE;

-- 17
SELECT NOMBRE FROM Personaje WHERE ID NOT IN 
    (SELECT ID FROM Poderes WHERE NOMBRE LIKE '%volar%');

-- 18


-- 19
SELECT NOMBRE FROM Personaje WHERE ID NOT IN (SELECT ID FROM Equipo);

-- 20
SELECT NOMBRE FROM Personaje WHERE ID IN 
    (SELECT ID FROM Poderes WHERE NOMBRE IN 
        (SELECT NOMBRE FROM Poderes WHERE ID = (SELECT ID FROM Personaje WHERE NOMBRE = 'Capitán América')));

-- 21
SELECT NOMBRE FROM Personaje WHERE ID IN 
    (SELECT ID FROM Poderes GROUP BY ID HAVING COUNT(*) > 2) 
AND ID NOT IN (SELECT ID FROM Equipo);

-- 22
DELETE FROM Villanos WHERE ID NOT IN (SELECT ID FROM Poderes);

-- 23
UPDATE Personaje SET NOMBRE = 'Miles Morales' WHERE NOMBRE = 'Spider-Man';

-- 24
INSERT INTO Personaje (ID, NOMBRE, ALIAS, CIUDAD_ORIGEN) VALUES (6, 'Marc Spector', 'Moon Knight', 'Chicago');

-- 25
INSERT INTO Equipo (ID, NOMBRE) VALUES (6, 'Vengadores');

-- 26
DELETE FROM Personaje WHERE ID NOT IN (SELECT ID FROM Equipo);

-- 27
DELETE FROM Personaje WHERE ID NOT IN (SELECT ID FROM Poderes WHERE NOMBRE LIKE '%volar%');

-- 28
SELECT NOMBRE FROM Villanos WHERE ID IN 
    (SELECT ID FROM Poderes WHERE NOMBRE LIKE '%Superfuerza%' AND NOMBRE LIKE '%volar%');

