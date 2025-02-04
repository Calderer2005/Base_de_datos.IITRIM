// Tema_4_Ejercicios_SQL_04.pdf
// Maria Angeles Buzon Campana

// CREACION DE TABLAS:
// Tablas
CREATE TABLE equipo (
    id NUMBER(3) PRIMARY KEY,
    nombre VARCHAR2(25) NOT NULL
);

-- Fusiono en una sola tabla Superheroes y Villanos porque tienen los mismos atributos (excepto equipo):
CREATE TABLE personas (
    id NUMBER(3) PRIMARY KEY,
    nombre VARCHAR2(25) NOT NULL,
    alias VARCHAR2(50) NOT NULL,
    ciudad_orig VARCHAR2(50),
    tipo VARCHAR2(10) CHECK (tipo IN ('Superheroe', 'Villano')),
    equipo NUMBER(3),
    
    -- Que solo los superheroes puedan pertenecer a un equipo:
    CONSTRAINT chk_equipo CHECK ((tipo = 'Villano' AND equipo IS NULL) OR (tipo='Superheroe')),
    -- Relacion 'Pertenece':
    CONSTRAINT fk_superheroes_eq FOREIGN KEY (equipo) REFERENCES equipo(id)
);

CREATE TABLE poderes (
    id NUMBER(3) PRIMARY KEY,
    nombre VARCHAR2(25) NOT NULL
);

// Relaciones aparte
CREATE TABLE personas_poderes (
    persona NUMBER(3),
    poder NUMBER(3),
    
    CONSTRAINT pk_pp PRIMARY KEY (persona, poder),
    CONSTRAINT fk_pp_pers FOREIGN KEY (persona) REFERENCES personas(id),
    CONSTRAINT fk_pp_pod FOREIGN KEY (poder) REFERENCES poderes(id)    
);


// INSERCION DE DATOS:
INSERT INTO equipo VALUES (1, 'Vengadores');
INSERT INTO equipo VALUES (2, 'Liga de la Justicia');
INSERT INTO equipo VALUES (3, 'Red de Guerreros');
INSERT INTO equipo VALUES (4, 'Guardianes de la Galaxia');
INSERT INTO equipo VALUES (5, 'Los 4 Fantasticos');


INSERT INTO personas VALUES (1, 'Alexander Joseph Luthor', 'Lex Luthor', 'Metropolis', 'Villano', NULL);
INSERT INTO personas VALUES (2, 'Clark Kent', 'Superman', 'Kripton', 'Superheroe', 2);
INSERT INTO personas VALUES (3, 'Peter Parker', 'Spiderman', 'Nueva York', 'Superheroe', 1);
INSERT INTO personas VALUES (4, 'Otto Octavius', 'Doctor Octopus', 'Nueva York', 'Villano', NULL);
INSERT INTO personas VALUES (5, 'Gwendolyne Maxine Stacy', 'Spidergwen', 'Nueva York', 'Superheroe', 3);
INSERT INTO personas VALUES (6, 'Norman Osborn', 'Duende Verde', 'Nueva York', 'Villano', NULL);
INSERT INTO personas VALUES (7, 'Jonathan Storm', 'Antorcha Humana', 'Nueva York', 'Superheroe', 5);
INSERT INTO personas VALUES (8, 'Rocket Raccoon', 'Rocket', 'Keystone', 'Superheroe', 4);
INSERT INTO personas VALUES (9, 'Steven Grant Rogers', 'Capitan America', 'Nueva York', 'Superheroe', 1);
INSERT INTO personas VALUES (10, 'Diana de Temiscira', 'Mujer Maravilla', 'Temiscira', 'Superheroe', 2);
INSERT INTO personas VALUES (11, 'Juan Lopez Fernandez', 'Superlopez', 'Chiton', 'Superheroe', NULL);

INSERT INTO poderes VALUES (1, 'Superfuerza');
INSERT INTO poderes VALUES (2, 'Sentido aracnido');
INSERT INTO poderes VALUES (3, 'Adherencia a superficies');
INSERT INTO poderes VALUES (4, 'Vuelo');
INSERT INTO poderes VALUES (5, 'Vision de rayos X');
INSERT INTO poderes VALUES (6, 'Tentaculos mecanicos');
INSERT INTO poderes VALUES (7, 'Superinteligencia');
INSERT INTO poderes VALUES (8, 'Piroquinesis');
INSERT INTO poderes VALUES (9, 'Armas avanzadas');
INSERT INTO poderes VALUES (10, 'Invisibilidad');
INSERT INTO poderes VALUES (11, 'Hablar con animales');
INSERT INTO poderes VALUES (12, 'Supertorpeza');

INSERT INTO personas_poderes VALUES (1, 7); -- Luthor - Inteligencia
INSERT INTO personas_poderes VALUES (2, 1); -- Superman - Superfuerza
INSERT INTO personas_poderes VALUES (2, 4); -- Superman - Vuelo
INSERT INTO personas_poderes VALUES (2, 5); -- Superman - rayos X

INSERT INTO personas_poderes VALUES (3, 1); -- Spiderman - Superfuerza
INSERT INTO personas_poderes VALUES (3, 2); -- Spiderman - sentido arac
INSERT INTO personas_poderes VALUES (3, 3); -- Spiderman - adherencia

INSERT INTO personas_poderes VALUES (5, 1); -- Spidergwen - Idem
INSERT INTO personas_poderes VALUES (5, 2);
INSERT INTO personas_poderes VALUES (5, 3);

INSERT INTO personas_poderes VALUES (7, 8); -- Antorcha Hum

INSERT INTO personas_poderes VALUES (4, 6); -- Octopus - Brazos
INSERT INTO personas_poderes VALUES (4, 7); -- Octopus - Intelig

INSERT INTO personas_poderes VALUES (6, 7); -- Duende - Intelig
INSERT INTO personas_poderes VALUES (6, 1); -- Duende - Superf
INSERT INTO personas_poderes VALUES (6, 9); -- Duende - Armas

INSERT INTO personas_poderes VALUES (8, 9); -- Rocket

INSERT INTO personas_poderes VALUES (9, 1); -- Cap AMerica

INSERT INTO personas_poderes VALUES (10, 1); -- Mujer Marav
INSERT INTO personas_poderes VALUES (10, 11); -- Mujer Marav

INSERT INTO personas_poderes VALUES (11, 1); --Superlopez
INSERT INTO personas_poderes VALUES (11, 4);
INSERT INTO personas_poderes VALUES (11, 12);


// CONSULTAS

--1. Anade la columna 'edad' a la tabla de superheroes
ALTER TABLE personas
ADD edad NUMBER(3);

--2. Modifica el tipo de dato de la columna 'nombre' en superheroes
--para que tenga 100 cars como maximo
ALTER TABLE personas
MODIFY nombre VARCHAR2(100);

--3. Cambia el nombre de la tabla superheroes a personaje
ALTER TABLE personas
RENAME TO personajes;

ALTER TABLE personas_poderes
RENAME TO personajes_poderes;

--4. Muestra los datos de todos los heroes
SELECT * FROM personajes
WHERE tipo='Superheroe';

--5. Muestra el nombre y el alias de todos los heroes de Nueva York
SELECT nombre, alias FROM personajes
WHERE tipo='Superheroe'
AND ciudad_orig='Nueva York';

--6. Muestra el nombre y el equipo de todos los heroes que pertenezcan a uno.
SELECT personajes.nombre AS superh, equipo.nombre AS equipo FROM personajes, equipo
WHERE personajes.equipo=equipo.id;

--7. Muestra cuantos villanos hay insertado en la base de datos.
SELECT COUNT(*) FROM personajes
WHERE tipo='Villano';

--8. Muestra el alias de los villanos junto a sus poderes.
SELECT per.alias, pod.nombre FROM personajes per, personajes_poderes pp, poderes pod
WHERE tipo='Villano'
AND per.id=pp.persona AND pp.poder=pod.id
ORDER BY per.alias;

--9. Muestra todos los héroes y villanos junto a sus equipos y sus poderes.
SELECT per.alias AS personaje, e.nombre AS equipo, pod.nombre AS poderes
FROM personajes per, equipo e, poderes pod, personajes_poderes pp
WHERE per.equipo=e.id
AND per.id = pp.persona AND pp.poder=pod.id
ORDER BY per.alias;

--10. Muestra todos los héroes que pertenecen a los Vengadores.
SELECT * FROM personajes, equipo
WHERE equipo.nombre='Vengadores'
AND personajes.equipo=equipo.id;

--CORREGIR - 11. Muestra todos los héroes que comparten el mismo poder.
--??

--12. Cuenta cuantas personas tiene cada equipo.
SELECT equipo.nombre, COUNT(equipo.id)
FROM equipo, personajes
WHERE personajes.equipo=equipo.id
GROUP BY equipo.nombre;

--CORREGIR - 13. Muestra la persona con más poderes.
SELECT alias, COUNT(pp.poder)
FROM personajes per, personajes_poderes pp, poderes pod
WHERE per.id=pp.persona AND pp.poder=pod.id
HAVING COUNT(pp.poder) > ALL (
    SELECT COUNT(pp.poder) FROM personajes_poderes pp
    );

--14. Muestra cuántos poderes de media tienen los personajes.
SELECT AVG(pp.poder)
FROM personajes_poderes pp
WHERE persona IS NOT NULL;

--15. Muestra la persona con menos poderes.
SELECT personajes.nombre, COUNT(pp.poder)
FROM personajes, personajes_poderes pp 
WHERE personajes.id=pp.persona
HAVING COUNT(pp.poder) <= ALL (
    SELECT poder FROM personajes_poderes)
GROUP BY personajes.nombre;

--16. Muestra cuántos héroes y villanos hay por cada tipo de poder.
SELECT pod.nombre, per.tipo, COUNT(per.tipo)
FROM personajes per, poderes pod, personajes_poderes pp
WHERE per.id=pp.persona AND pp.poder=pod.id
GROUP BY pod.nombre, per.tipo
ORDER BY pod.nombre;

--CORREGIR - 17. Muestra las personas que no pueden volar.
--?
SELECT DISTINCT alias FROM personajes, personajes_poderes pp, poderes
WHERE personajes.id=pp.persona AND pp.poder=poderes.id
AND poderes.nombre != ALL (
    SELECT nombre
    FROM poderes
    WHERE nombre='Vuelo'
    );

--18. Muestra las personas que tienen más poderes que ‘Spider-Man’.
SELECT per.alias, COUNT(pp.poder)
FROM personajes per, personajes_poderes pp
WHERE per.id=pp.persona
HAVING COUNT(pp.poder) > ANY
    (SELECT COUNT(poder)
    FROM personajes per, personajes_poderes pp
    WHERE per.id=pp.persona
    AND alias='Spiderman')
group by per.alias;

--19. Muestra las personas que trabajan en solitario.
SELECT * FROM personajes
WHERE equipo IS NULL;

--20. Muestra las personas con los mismos poderes que 'Capitan America'
SELECT DISTINCT pod.nombre, per.alias
FROM personajes per, personajes_poderes pp, poderes pod
WHERE per.id=pp.persona AND pp.poder=pod.id
AND pod.id = ANY
    (SELECT pod.id
    FROM personajes per, personajes_poderes pp, poderes pod
    WHERE per.id=pp.persona AND pp.poder=pod.id
    AND alias='Capitan America');

-- 21. Obten los héroes que tienen más de dos poderes y no pertenecen a ningún equipo.
SELECT personajes.alias, COUNT(pp.poder) AS n_poderes
FROM personajes, personajes_poderes pp, poderes
WHERE tipo='Superheroe'
AND equipo IS NULL
AND personajes.id=pp.persona AND pp.poder=poderes.id
HAVING COUNT(*) > 2
GROUP BY personajes.alias;

--22. Elimina todos los villanos que no tienen superpoderes.
--(Lo dejo para el final)

--23. Cambia el nombre de ‘Spider-Man’ a ‘Miles Morales’.
UPDATE personajes
SET nombre='Miles Morales'
WHERE alias='Spiderman';

--24. Inserta a Moon Knight (Marc Spector) a la tabla de héroes.
INSERT INTO personajes
VALUES (12, 'Marc Spector', 'Moon Knight', NULL, 'Superheroe', NULL, NULL);

--25. Añade a Moon Knight al equipo de los ‘Vengadores’.
UPDATE personajes
SET equipo=1
WHERE alias='Moon Knight';

--26. Elimina a los héroes que no tienen un equipo asignado.
--(Lo dejo para el final)

--27. Elimina a las personas que no pueden volar.
--(Lo dejo para el final)

--28. Muestra todos los villanos que tienen 'Superfuerza' y pueden volar.
-- (En villanos no hay ninguno; en superheroes deberian salir solo Superman y Superlopez)
SELECT DISTINCT per.alias
FROM personajes per, personajes_poderes pp, personajes_poderes pp2
WHERE per.id=pp.persona AND per.id=pp2.persona AND pp.poder < pp2.poder
AND tipo='Villano'
AND pp.poder =
    (SELECT id
    FROM poderes
    WHERE nombre='Superfuerza')
AND pp2.poder =
    (SELECT id
    FROM poderes
    WHERE nombre='Vuelo');

