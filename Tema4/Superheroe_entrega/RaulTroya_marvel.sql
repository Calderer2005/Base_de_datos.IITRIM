CREATE TABLE equipo(
    id NUMBER(1) PRIMARY KEY,
    nombre VARCHAR2(25)
);
CREATE TABLE superheroes(
    id NUMBER(1) PRIMARY KEY,
    nombre VARCHAR2(25),
    alias VARCHAR2(50),
    ciudad VARCHAR2(50),
    equipo NUMBER(1),
    
    CONSTRAINT fk_sup_eq FOREIGN KEY (equipo) REFERENCES equipo(id)
);
CREATE TABLE poderes(
    id NUMBER(1) PRIMARY KEY,
    nombre VARCHAR2(25)
);
CREATE TABLE sup_pod(
    superheroe NUMBER(1),
    poder NUMBER(1),
    
    CONSTRAINT pk_sup_pod PRIMARY KEY (superheroe, poder),
    CONSTRAINT fk_suppod_superh FOREIGN KEY (superheroe) REFERENCES superheroes(id),
    CONSTRAINT fk_suppod_poder FOREIGN KEY (poder) REFERENCES poderes(id)
);
CREATE TABLE villanos(
    id NUMBER(1) PRIMARY KEY,
    nombre VARCHAR2(25),
    alias VARCHAR2(50),
    ciudad VARCHAR2(50)
);
CREATE TABLE vill_pod(
    villano NUMBER(1),
    poder NUMBER(1),
    
    CONSTRAINT pk_vill_pod PRIMARY KEY (villano, poder),
    CONSTRAINT fk_villpod_vill FOREIGN KEY (villano) REFERENCES villanos(id),
    CONSTRAINT fk_villpod_poder FOREIGN KEY (poder) REFERENCES poderes(id)
);

INSERT INTO equipo VALUES (1, 'Vengadores');
INSERT INTO equipo VALUES (2, 'X-Men');
INSERT INTO equipo VALUES (3, 'Liga de la Justicia');
INSERT INTO equipo VALUES (4, 'Guardianes de la Galaxia');
INSERT INTO equipo VALUES (5, 'Los Cuatro Fantásticos');

INSERT INTO superheroes VALUES (1, 'Tony Stark', 'Iron Man', 'Nueva York', 1);
INSERT INTO superheroes VALUES (2, 'Peter Parker', 'Spider-Man', 'Nueva York', 1);
INSERT INTO superheroes VALUES (3, 'Clark Kent', 'Superman', 'Metrópolis', 3);
INSERT INTO superheroes VALUES (4, 'Bruce Wayne', 'Batman', 'Gotham', 3);
INSERT INTO superheroes VALUES (5, 'Wade Wilson', 'Deadpool', 'Ciudad de Nueva York', 4);

INSERT INTO poderes VALUES (1, 'Super fuerza');
INSERT INTO poderes VALUES (2, 'Vuelo');
INSERT INTO poderes VALUES (3, 'Invisibilidad');
INSERT INTO poderes VALUES (4, 'Regeneración');
INSERT INTO poderes VALUES (5, 'Telequinesis');

INSERT INTO sup_pod VALUES (1, 1); -- Iron Man y Super fuerza
INSERT INTO sup_pod VALUES (1, 2); -- Iron Man y Vuelo
INSERT INTO sup_pod VALUES (2, 3); -- Spider-Man y Invisibilidad
INSERT INTO sup_pod VALUES (3, 1); -- Superman y Super fuerza
INSERT INTO sup_pod VALUES (4, 4); -- Batman y Regeneración

INSERT INTO villanos VALUES (1, 'Lex Luthor', 'Ninguno', 'Metrópolis');
INSERT INTO villanos VALUES (2, 'Magneto', 'Erik Lehnsherr', 'Ciudad X');
INSERT INTO villanos VALUES (3, 'Thanos', 'Ninguno', 'Espacio');
INSERT INTO villanos VALUES (4, 'Joker', 'Ninguno', 'Gotham');
INSERT INTO villanos VALUES (5, 'Deadpool', 'Ninguno', 'Ciudad de Nueva York');

INSERT INTO vill_pod VALUES (1, 5); -- Lex Luthor y Telequinesis
INSERT INTO vill_pod VALUES (2, 1); -- Magneto y Super fuerza
INSERT INTO vill_pod VALUES (3, 4); -- Thanos y Regeneración
INSERT INTO vill_pod VALUES (4, 3); -- Joker y Invisibilidad
INSERT INTO vill_pod VALUES (5, 2); -- Deadpool y Vuelo

-- 1
ALTER TABLE superheroes ADD edad NUMBER(3);
-- 2
ALTER TABLE superheroes MODIFY nombre VARCHAR2(100);
-- 3
ALTER TABLE superheroes RENAME TO personajes; 
-- 4
SELECT * FROM personajes;
-- 5
SELECT nombre, alias FROM personajes WHERE ciudad = 'Nueva York';
-- 6
SELECT nombre, equipo FROM personajes;
-- 7
SELECT COUNT(id) FROM villanos;
-- 8 
SELECT villanos.nombre, alias, poder, poderes.nombre FROM villanos, vill_pod, poderes WHERE villano = villanos.id AND poder = poderes.id;
-- 9
SELECT * FROM personajes, equipo WHERE equipo = equipo.id AND equipo.nombre = 'Vengadores';
-- 10
SELECT pers.* FROM personajes pers, equipo WHERE equipo.nombre = 'Vengadores' AND equipo = equipo.id; 
-- 11
SELECT sp1.superheroe, sp2.superheroe, sp1.poder, sp2.poder FROM sup_pod sp1, sup_pod sp2 WHERE sp1.poder = sp2.poder AND sp1.superheroe > sp2.superheroe;
-- 12
SELECT equipo, COUNT(*) AS cantidad FROM personajes GROUP BY equipo;
-- 13
SELECT superheroe, COUNT(poder) AS cantidad_pod FROM sup_pod GROUP BY superheroe ORDER BY cantidad_pod DESC FETCH FIRST 1 ROWS ONLY;
-- 14 
SELECT AVG(cantidad_pod) AS media_pod FROM 
    (SELECT superheroe, COUNT(poder) AS cantidad_pod FROM sup_pod GROUP BY superheroe);
-- 15
SELECT superheroe, COUNT(poder) AS cantidad_pod FROM sup_pod GROUP BY superheroe ORDER BY cantidad_pod ASC FETCH FIRST 1 ROWS ONLY;
-- 16
SELECT p.nombre AS poder,
    (SELECT COUNT(DISTINCT superheroe) 
     FROM sup_pod sp 
     WHERE sp.poder = p.id) AS cantidad_heroes,
    (SELECT COUNT(DISTINCT villano) 
     FROM vill_pod vp 
     WHERE vp.poder = p.id) AS cantidad_villanos
FROM 
    poderes p;
-- 17
SELECT personajes.nombre, villanos.nombre
FROM personajes, villanos
WHERE villanos.id, personajes.id NOT IN (SELECT personajes.id, villanos.id FROM sup_pod, vill_pod WHERE poder = 2);
-- 18
SELECT nombre, 'Superhéroe' AS tipo
FROM personajes p
WHERE (SELECT COUNT(poder) FROM sup_pod sp WHERE sp.superheroe = p.id) > 
      (SELECT COUNT(poder) FROM sup_pod sp WHERE sp.superheroe = (SELECT id FROM personajes WHERE alias = 'Spider-Man'))
OR p.id IN (SELECT villano FROM vill_pod vp WHERE (SELECT COUNT(poder) FROM vill_pod vp2 WHERE vp2.villano = vp.villano) >
            (SELECT COUNT(poder) FROM sup_pod sp WHERE sp.superheroe = (SELECT id FROM personajes WHERE alias = 'Spider-Man')));
-- 19
SELECT * FROM personajes WHERE equipo IS NULL;
-- 20 
-- Muestra las personas con los mismos poderes que ‘Capitán América’. NO TENGO A CAPITÁN AMÉRICA.
SELECT p.nombre, 'Superhéroe' AS tipo
FROM personajes p
WHERE p.id IN (
    SELECT sp.superheroe
    FROM sup_pod sp
    WHERE sp.poder IN (
        SELECT sp2.poder
        FROM sup_pod sp2
        WHERE sp2.superheroe = (SELECT id FROM personajes WHERE alias = 'Capitán América')
    )
)
OR p.id IN (
    SELECT vp.villano
    FROM vill_pod vp
    WHERE vp.poder IN (
        SELECT sp2.poder
        FROM sup_pod sp2
        WHERE sp2.superheroe = (SELECT id FROM personajes WHERE alias = 'Capitán América')
    )
);
-- 21 
SELECT p.nombre, 'Superhéroe' AS tipo FROM personajes p WHERE p.equipo IS NULL AND (SELECT COUNT(poder) FROM sup_pod sp WHERE sp.superheroe = p.id) > 2;
-- 22 
DELETE FROM villanos WHERE id NOT IN (SELECT villano FROM vill_pod);
-- 23
UPDATE personajes SET alias = 'Miles Morales' WHERE alias = 'Spider-Man';
-- 24
INSERT INTO personajes (id, nombre, alias, ciudad, equipo) VALUES (6, 'Marc Spector', 'Moon Knight', 'Nueva York', NULL);
-- 25
UPDATE personajes SET equipo = 1 WHERE alias = 'Moon Knight';
-- 26
DELETE FROM personajes WHERE equipo IS NULL;
-- 27
DELETE FROM personajes WHERE id NOT IN (SELECT superheroe FROM sup_pod WHERE poder = 2);
-- 28 
SELECT v.nombre, v.alias FROM villanos v WHERE v.id IN (SELECT vp.villano FROM vill_pod vp WHERE vp.poder = 1) AND v.id IN (SELECT vp.villano FROM vill_pod vp WHERE vp.poder = 2);






