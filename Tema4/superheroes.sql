CREATE TABLE equipo(
    id INT PRIMARY KEY,
    nombre VARCHAR2(25) NOT NULL
);

CREATE TABLE superpersona(
    id INT PRIMARY KEY,
    nombre VARCHAR2(25) NOT NULL,
    alias VARCHAR2(50) NOT NULL,
    ciudad_orig VARCHAR2(50),
    id_equipo INT,
    alineamiento VARCHAR2(10) CHECK (alineamiento IN ('héroe', 'villano')),
    
    CONSTRAINT fk_equi_super FOREIGN KEY (id_equipo) REFERENCES equipo(id)
);

CREATE TABLE poderes(
    id INT PRIMARY KEY,
    nombre VARCHAR2(25) NOT NULL
);

CREATE TABLE poderes_persona(
    id_persona INT,
    id_poder INT,
    
    CONSTRAINT pk_pp PRIMARY KEY(id_persona, id_poder),
    CONSTRAINT fk_pp_persona FOREIGN KEY (id_persona) REFERENCES superpersona(id),
    CONSTRAINT fk_pp_poder FOREIGN KEY (id_poder) REFERENCES poderes(id)
);

INSERT INTO equipo VALUES (1, 'Los Vengadores');
INSERT INTO equipo VALUES (2, 'Guardianes de la Galaxia');
INSERT INTO equipo VALUES (3, 'Sinister Six');

INSERT INTO superpersona VALUES (1, 'Peter Parker', 'Spider-Man', 'Queens', 1, 'héroe');
INSERT INTO superpersona VALUES (2, 'Steve Rogers', 'Capitán América', null, 1, 'héroe');
INSERT INTO superpersona VALUES (3, 'Eddie Brock', 'Venom', 'Nueva York', 3, 'villano');
INSERT INTO superpersona VALUES (4, 'Steven Strange', 'Dr.Strange', 'Nueva York', 1, 'héroe');
INSERT INTO superpersona VALUES (5, 'Peter Quill', 'Starlord', null, 2, 'héroe');
INSERT INTO superpersona VALUES (6, 'Victor Von Doom', 'Dr Doom', null, null, 'villano');

INSERT INTO poderes VALUES (1, 'Superfuerza');
INSERT INTO poderes VALUES (2, 'Trepar Muros');
INSERT INTO poderes VALUES (3, 'Control de la magia');
INSERT INTO poderes VALUES (4, 'Super regeneración');
INSERT INTO poderes VALUES (5, 'Sentido arácnido');
INSERT INTO poderes VALUES (6, 'Vuelo');

INSERT INTO poderes_persona VALUES (1, 1);
INSERT INTO poderes_persona VALUES (1, 2);
INSERT INTO poderes_persona VALUES (1, 4);
INSERT INTO poderes_persona VALUES (1, 5);
INSERT INTO poderes_persona VALUES (3, 1);
INSERT INTO poderes_persona VALUES (3, 2);
INSERT INTO poderes_persona VALUES (3, 4);
INSERT INTO poderes_persona VALUES (3, 5);
INSERT INTO poderes_persona VALUES (2, 1);
INSERT INTO poderes_persona VALUES (4, 3);

-- 1
ALTER TABLE superpersona 
ADD edad INT CHECK(edad BETWEEN 1 AND 120);

-- 2
ALTER TABLE superpersona
MODIFY nombre VARCHAR2(100);

-- 3
ALTER TABLE superpersona RENAME TO personaje;

-- 4
SELECT * FROM personaje WHERE alineamiento='héroe';

-- 5
SELECT nombre, alias FROM personaje 
WHERE alineamiento='héroe' AND ciudad_orig='Nueva York';

-- 6
SELECT p.nombre, e.nombre FROM personaje p, equipo e 
WHERE p.id_equipo=e.id AND alineamiento='héroe';

-- 7
SELECT COUNT(*) FROM personaje WHERE alineamiento='villano';

-- 8
SELECT p.nombre, COALESCE(pod.nombre, 'Sin poderes') 
FROM personaje p LEFT JOIN poderes_persona pp ON p.id=pp.id_persona
LEFT JOIN poderes pod ON pp.id_poder=pod.id
WHERE alineamiento='villano';

-- 9
SELECT p.nombre, COALESCE(eq.nombre, 'Sin equipo') AS equ, COALESCE(pod.nombre, 'Sin poderes') 
FROM personaje p LEFT JOIN equipo eq ON p.id_equipo=eq.id 
                    LEFT JOIN poderes_persona pp ON p.id=pp.id_persona
                    LEFT JOIN poderes pod ON pp.id_poder=pod.id
ORDER BY equ;

-- 10
SELECT p.* 
FROM personaje p, equipo eq
WHERE p.id_equipo=eq.id AND eq.nombre='Los Vengadores';

-- 11
SELECT DISTINCT p1.alias, p2.alias, poderes.nombre 
FROM personaje p1, poderes_persona pp, poderes_persona pp2, personaje p2, poderes
WHERE p1.id=pp.id_persona AND pp.id_poder=pp2.id_poder AND pp2.id_persona=p2.id AND poderes.id=pp.id_poder
AND p1.id < p2.id;

-- 12
SELECT eq.nombre, COUNT(DISTINCT p.id) 
FROM personaje p, equipo eq
WHERE p.id_equipo=eq.id
GROUP BY eq.nombre;

-- 13
SELECT sp.alias FROM poderes_persona pp, personaje sp
WHERE pp.id_persona=sp.id
GROUP BY sp.alias 
HAVING COUNT(id_poder) = (SELECT MAX(cont) 
                            FROM (SELECT id_persona, COUNT(id_poder) AS cont 
                                FROM poderes_persona GROUP BY id_persona));
                                
SELECT alias FROM poderes_persona pp, personaje sp
WHERE pp.id_persona=sp.id
GROUP BY alias 
HAVING COUNT(id_poder) >= ALL (SELECT COUNT(id_poder) AS cont 
                                FROM poderes_persona GROUP BY id_persona);
                                
--14
SELECT (SUM(cont)/tot) 
FROM (SELECT COUNT(id_poder) AS cont FROM poderes_persona GROUP BY id_persona),
    (SELECT COUNT(*) AS tot FROM superpersona)
GROUP BY tot;

SELECT AVG(cont) FROM (SELECT COUNT(id_poder) AS cont FROM poderes_persona GROUP BY id_persona);

SELECT COUNT(id_poder)/COUNT(DISTINCT sp.id) 
FROM superpersona sp LEFT JOIN poderes_persona pp ON pp.id_persona=sp.id;


-- 15
SELECT alias FROM poderes_persona pp, superpersona sp
WHERE pp.id_persona=sp.id
GROUP BY alias 
HAVING COUNT(id_poder) = (SELECT MIN(cont) 
                            FROM (SELECT id_persona, COUNT(id_poder) AS cont 
                                FROM poderes_persona GROUP BY id_persona));
                                
SELECT alias FROM poderes_persona pp, superpersona sp
WHERE pp.id_persona=sp.id
GROUP BY alias 
HAVING COUNT(id_poder) <= ALL (SELECT COUNT(id_poder) AS cont 
                                FROM poderes_persona GROUP BY id_persona);
                                
-- 16
SELECT po.nombre, COUNT(DISTINCT pp.id_persona)
FROM poderes po, poderes_persona pp
WHERE pp.id_poder=po.id
GROUP BY po.nombre;

-- 17
SELECT alias 
FROM personaje
WHERE id NOT IN (
                SELECT id_persona
                FROM poderes_persona , poderes
                WHERE id_poder=id AND nombre='Vuelo');
                
-- 18
SELECT alias 
FROM personaje, poderes_persona
WHERE id=id_persona
GROUP BY alias
HAVING COUNT(id_poder) > (
                        SELECT COUNT(id_poder)
                        FROM personaje, poderes_persona
                        WHERE id=id_persona AND alias='Spider-Man');

-- 19
SELECT * FROM personaje WHERE id_equipo IS null;

-- 20
SELECT DISTINCT p1.alias, p2.alias, poderes.nombre 
FROM personaje p1, poderes_persona pp, poderes_persona pp2, personaje p2, poderes
WHERE p1.id=pp.id_persona AND pp.id_poder=pp2.id_poder AND pp2.id_persona=p2.id AND poderes.id=pp.id_poder
AND p1.id != p2.id AND p2.alias='Capitán América';

SELECT p.alias
FROM personaje p
WHERE  (SELECT id_poder 
            FROM poderes_persona, personaje p2
            WHERE p2.id=id_persona AND p2.id!=p.id AND p2.alias='Capitán América')
    IN
        (SELECT id_poder 
            FROM poderes_persona 
            WHERE p.id=id_persona);
            
-- 21
SELECT p.alias
FROM personaje p, poderes_persona pp
WHERE p.id=pp.id_persona AND id_equipo IS NULL
GROUP BY p.alias
HAVING COUNT(pp.id_poder) > 2;

-- 22
DELETE FROM personaje WHERE alineamiento='villano' AND id NOT IN (SELECT DISTINCT id_persona FROM poderes_persona);

-- 23
UPDATE personaje SET nombre='Miles Morales' WHERE alias='Spider-Man';

-- 24
INSERT INTO personaje VALUES (6, 'Marc Spector', 'Moon Knight', 'Nueva York', null, 'héroe', null);

-- 25
UPDATE personaje SET id_equipo=(SELECT id FROM equipo WHERE nombre='Los Vengadores') WHERE alias='Moon Knight';

-- 26
DELETE FROM personaje WHERE id_equipo=null AND alineamiento='héroe';

-- 27
DELETE FROM poderes_persona WHERE id_persona NOT IN (SELECT DISTINCT id_persona 
                                                        FROM poderes_persona, poderes 
                                                        WHERE id_poder=id AND nombre='Vuelo');
DELETE FROM personaje WHERE id NOT IN (SELECT DISTINCT id_persona 
                                        FROM poderes_persona, poderes 
                                        WHERE id_poder=id AND nombre='Vuelo');
                                        
-- 28
SELECT p.alias 
FROM personaje p
WHERE p.id IN (SELECT id_persona
                FROM poderes_persona, poderes 
                WHERE id_poder=id AND nombre='Vuelo')
AND p.id IN (SELECT id_persona
                FROM poderes_persona, poderes 
                WHERE id_poder=id AND nombre='Superfuerza');




