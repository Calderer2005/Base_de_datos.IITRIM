--BBDD SUPER HEROE
-- JOSE JUSTICIA VICO

-- CREACIÓN DE TABLAS

CREATE TABLE Equipo (
    id INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE Superheroe (
    id INT PRIMARY KEY,
    nombre VARCHAR(25) NOT NULL,
    alias VARCHAR(50) NOT NULL,
    ciudad_origen VARCHAR(50),
    edad INT,
    equipo_id INT,
    FOREIGN KEY (equipo_id) REFERENCES Equipo(id)
);

CREATE TABLE Poder (
    id INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE Superheroe_Poder (
    superheroe_id INT,
    poder_id INT,
    PRIMARY KEY (superheroe_id, poder_id),
    FOREIGN KEY (superheroe_id) REFERENCES Superheroe(id),
    FOREIGN KEY (poder_id) REFERENCES Poder(id)
);

--INSERCION DE DATOS

INSERT INTO Equipo (id, nombre) VALUES (1, 'Vengadores');
INSERT INTO Equipo (id, nombre) VALUES (2, 'X-Men');
INSERT INTO Equipo (id, nombre) VALUES (3, 'Liga de la Justicia');

INSERT INTO Superheroe (id, nombre, alias, ciudad_origen, edad, equipo_id)  VALUES (1, 'Peter Parker', 'Spider-Man', 'Nueva York', 25, 1);
INSERT INTO Superheroe (id, nombre, alias, ciudad_origen, edad, equipo_id) VALUES(2, 'Tony Stark', 'Iron Man', 'Nueva York', 45, 1);
INSERT INTO Superheroe (id, nombre, alias, ciudad_origen, edad, equipo_id)  VALUES (3, 'Bruce Wayne', 'Batman', 'Gotham', 40, 3);
INSERT INTO Superheroe (id, nombre, alias, ciudad_origen, edad, equipo_id) VALUES (4, 'Clark Kent', 'Superman', 'Metrópolis', 35, 3);
INSERT INTO Superheroe (id, nombre, alias, ciudad_origen, edad, equipo_id) VALUES (5, 'Logan', 'Wolverine', 'Desconocida', 200, 2);

INSERT INTO Poder (id, nombre) VALUES (1, 'Superfuerza');
INSERT INTO Poder (id, nombre) VALUES (2, 'Vuelo');
INSERT INTO Poder (id, nombre) VALUES (3, 'Regeneración');
INSERT INTO Poder (id, nombre) VALUES (4, 'Sentido arácnido');
INSERT INTO Poder (id, nombre) VALUES (5, 'Riqueza');

INSERT INTO Superheroe_Poder (superheroe_id, poder_id) VALUES (1, 4);
INSERT INTO Superheroe_Poder (superheroe_id, poder_id) VALUES (2, 5);
INSERT INTO Superheroe_Poder (superheroe_id, poder_id) VALUES (3, 5);
INSERT INTO Superheroe_Poder (superheroe_id, poder_id) VALUES (4, 1);
INSERT INTO Superheroe_Poder (superheroe_id, poder_id) VALUES (4, 2);
INSERT INTO Superheroe_Poder (superheroe_id, poder_id) VALUES (5, 3);

-- CONSULTAS

-- 1. Añadir la columna de edad a la tabla de superhéroe.
ALTER TABLE Superheroe ADD COLUMN edad INT;

-- 2. Modificar el tipo de dato de la columna nombre en la tabla superhéroe para que tenga un máximo de 100 caracteres.
ALTER TABLE Superheroe MODIFY COLUMN nombre VARCHAR(100);

-- 3. Cambia el nombre de la tabla superhéroe a personaje.
ALTER TABLE Superheroe RENAME TO Personaje;

-- 4. Muestra los datos de todos los héroes.
SELECT * FROM Personaje;

-- 5. Muestra el nombre y el alias de todos los héroes de Nueva York.
SELECT nombre, alias FROM Personaje WHERE ciudad_origen = 'Nueva York';

-- 6. Muestra el nombre y el equipo de todos los héroes que pertenezcan a uno.
SELECT p.nombre, e.nombre AS equipo FROM Personaje p INNER JOIN Equipo e ON p.equipo_id = e.id;

-- 7. Muestra cuántos villanos hay insertado en la base de datos.
SELECT COUNT(*) FROM Personaje WHERE equipo_id IS NULL;

-- 8. Muestra el alias de los villanos junto a sus poderes.
SELECT p.alias, po.nombre AS poder FROM Personaje p INNER JOIN Superheroe_Poder pp ON p.id = pp.superheroe_id INNER JOIN Poder po ON pp.poder_id = po.id WHERE p.equipo_id IS NULL;

-- 9. Muestra todos los héroes y villanos junto a sus equipos y sus poderes.
SELECT p.nombre, e.nombre AS equipo, po.nombre AS poder FROM Personaje p LEFT JOIN Equipo e ON p.equipo_id = e.id LEFT JOIN Superheroe_Poder pp ON p.id = pp.superheroe_id LEFT JOIN Poder po ON pp.poder_id = po.id;

-- 10. Muestra todos los héroes que pertenecen a los Vengadores.
SELECT * FROM Personaje WHERE equipo_id = (SELECT id FROM Equipo WHERE nombre = 'Vengadores');

-- 11. Muestra todos los héroes que comparten el mismo poder.
SELECT p1.nombre AS personaje1, p2.nombre AS personaje2, po.nombre AS poder FROM Superheroe_Poder pp1 INNER JOIN Personaje p1 ON pp1.superheroe_id = p1.id INNER JOIN Superheroe_Poder pp2 ON pp1.poder_id = pp2.poder_id INNER JOIN Personaje p2 ON pp2.superheroe_id = p2.id INNER JOIN Poder po ON pp1.poder_id = po.id WHERE p1.id < p2.id;

-- 12. Cuenta cuántas personas tiene cada equipo.
SELECT e.nombre, COUNT(p.id) AS cantidad FROM Equipo e LEFT JOIN Personaje p ON e.id = p.equipo_id GROUP BY e.id;

-- 13. Muestra la persona con más poderes.
SELECT p.nombre, COUNT(pp.poder_id) AS cantidad FROM Personaje p INNER JOIN Superheroe_Poder pp ON p.id = pp.superheroe_id GROUP BY p.id ORDER BY cantidad DESC LIMIT 1;

-- 14. Muestra cuántos poderes de media tienen los personajes.
SELECT AVG(cantidad) FROM (SELECT COUNT(poder_id) AS cantidad FROM Superheroe_Poder GROUP BY superheroe_id) AS subquery;

-- 15. Muestra la persona con menos poderes.
SELECT p.nombre, COUNT(pp.poder_id) AS cantidad FROM Personaje p LEFT JOIN Superheroe_Poder pp ON p.id = pp.superheroe_id GROUP BY p.id ORDER BY cantidad ASC LIMIT 1;

-- 16. Muestra cuántos héroes y villanos hay por cada tipo de poder.
SELECT po.nombre AS poder, COUNT(DISTINCT pp.superheroe_id) AS cantidad FROM Poder po LEFT JOIN Superheroe_Poder pp ON po.id = pp.poder_id GROUP BY po.id;

-- 17. Muestra las personas que no pueden volar.
SELECT p.nombre FROM Personaje p WHERE p.id NOT IN (SELECT superheroe_id FROM Superheroe_Poder WHERE poder_id = (SELECT id FROM Poder WHERE nombre = 'Vuelo'));

-- 18. Muestra las personas que tienen más poderes que 'Spider-Man'.
SELECT p.nombre FROM Personaje p WHERE (SELECT COUNT(*) FROM Superheroe_Poder WHERE superheroe_id = p.id) > (SELECT COUNT(*) FROM Superheroe_Poder WHERE superheroe_id = (SELECT id FROM Personaje WHERE alias = 'Spider-Man'));

-- 19. Muestra las personas que trabajan en solitario.
SELECT p.nombre FROM Personaje p WHERE equipo_id IS NULL;

-- 20. Muestra las personas con los mismos poderes que 'Capitán América'.
SELECT DISTINCT p.nombre FROM Personaje p WHERE p.id IN (SELECT superheroe_id FROM Superheroe_Poder WHERE poder_id IN (SELECT poder_id FROM Superheroe_Poder WHERE superheroe_id = (SELECT id FROM Personaje WHERE alias = 'Capitán América')));

-- 21. Obtener los héroes que tienen más de dos poderes y no pertenecen a ningún equipo.
SELECT p.nombre 
FROM Personaje p
JOIN Superheroe_Poder pp ON p.id = pp.Personaje_id
GROUP BY p.id
HAVING COUNT(pp.poder_id) > 2 AND p.equipo_id IS NULL;

-- 22. Eliminar todos los villanos que no tienen superpoderes.
DELETE FROM Personaje 
WHERE equipo_id IS NULL 
AND id NOT IN (SELECT personaje_id FROM Superheroe_Poder);

-- 23. Cambiar el nombre de ‘Spider-Man’ a ‘Miles Morales’.
UPDATE Personaje 
SET nombre = 'Miles Morales' 
WHERE alias = 'Spider-Man';

-- 24. Insertar a Moon Knight (Marc Spector) a la tabla de héroes.
INSERT INTO Personaje (id, nombre, alias, ciudad_origen, edad, equipo_id) 
VALUES (6, 'Marc Spector', 'Moon Knight', 'Chicago', 35, NULL);

-- 25. Añadir a Moon Knight al equipo de los ‘Vengadores’.
UPDATE Personaje 
SET equipo_id = (SELECT id FROM Equipo WHERE nombre = 'Vengadores') 
WHERE alias = 'Moon Knight';

-- 26. Eliminar a los héroes que no tienen un equipo asignado.
DELETE FROM Personaje 
WHERE equipo_id IS NULL;

-- 27. Eliminar a las personas que no pueden volar.
DELETE FROM Personaje 
WHERE id NOT IN (SELECT personaje_id FROM Superheroe_Poder WHERE poder_id = (SELECT id FROM Poder WHERE nombre = 'Vuelo'));

-- 28. Mostrar todos los villanos que tienen ‘Superfuerza’ y pueden volar.
SELECT p.nombre 
FROM Personaje p
JOIN Superheroe_Poder pp1 ON p.id = pp1.personaje_id
JOIN Superheroe_Poder pp2 ON p.id = pp2.personaje_id
WHERE p.equipo_id IS NULL 
AND pp1.poder_id = (SELECT id FROM Poder WHERE nombre = 'Superfuerza') 
AND pp2.poder_id = (SELECT id FROM Poder WHERE nombre = 'Vuelo');

