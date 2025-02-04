CREATE TABLE superheroes 
(
    id INT PRIMARY KEY,
    nombre VARCHAR2(25) NOT NULL,
    alias VARCHAR(50) NOT NULL,
    ciudad_origen VARCHAR(50)
);

CREATE TABLE villanos 
(
    id INT PRIMARY KEY,
    nombre VARCHAR2(25) NOT NULL,
    alias VARCHAR(50) NOT NULL, 
    ciudad_origen VARCHAR(50)
);
    
CREATE TABLE poderes 
(
    id INT PRIMARY KEY,
    nombre VARCHAR2(25) NOT NULL
);
    
CREATE TABLE equipos 
(
    id INT PRIMARY KEY,
    nombre VARCHAR2(25) NOT NULL
);
CREATE TABLE superheroes_equipos
(
    superheroe_id INT ,
    equipo_id INT,
    
    CONSTRAINT pk_se PRIMARY KEY (superheroe_id, equipo_id),
    CONSTRAINT fk_se_sup FOREIGN KEY (superheroe_id) REFERENCES superheroes(id),
    CONSTRAINT fk_se_e FOREIGN KEY (equipo_id) REFERENCES equipos(id)
    
);
CREATE TABLE superheroes_poderes
(
    superheroe_id INT ,
    poder_id INT,
    
    CONSTRAINT pk_sp PRIMARY KEY (superheroe_id, poder_id),
    CONSTRAINT fk_sp_sup FOREIGN KEY (superheroe_id) REFERENCES superheroes(id),
    CONSTRAINT fk_sp_pod FOREIGN KEY (poder_id) REFERENCES poderes(id)
);
CREATE TABLE villanos_poderes
(
    villano_id INT,
    poder_id INT,
    
    CONSTRAINT pk_vp PRIMARY KEY (villano_id, poder_id),
    CONSTRAINT fk_vp_vil FOREIGN KEY(villano_id) REFERENCES villanos(id),
    CONSTRAINT fk_vp_pod FOREIGN KEY (poder_id) REFERENCES poderes(id)
);
INSERT INTO superheroes  VALUES (1,'Peter Parker','Spider Man','Nueva York');
INSERT INTO superheroes  VALUES (2,'Wade Wilson','Deadpool Arma XI','Regina');
INSERT INTO superheroes  VALUES (3,'Clark Kent','Superman','Krypton');
INSERT INTO superheroes  VALUES (4,'Bruce Wayne','Batman','Gotham City');
INSERT INTO superheroes  VALUES (5,'Steve Rogers','Capitán América','Nueva York');

INSERT INTO villanos  VALUES (1,'Joker','El Guasón','Gotham City');
INSERT INTO villanos  VALUES (2,'Lex Luthor','Lex Luthor','Metropolis');
INSERT INTO villanos  VALUES (3,'Norman Osborn','Duende Verde','Nueva York');
INSERT INTO villanos  VALUES (4,'Erik Lehnserr','Magneto','Nuremberg');
INSERT INTO villanos  VALUES (5,'Thano','El Titán Loco','Titán');

INSERT INTO poderes VALUES (1,'Súper Fuerza');
INSERT INTO poderes VALUES (2,'Vuelo');
INSERT INTO poderes VALUES (3,'Regeneración');
INSERT INTO poderes VALUES (4,'Intelecto superior');
INSERT INTO poderes VALUES (5,'Manipulación energía');

INSERT INTO equipos  VALUES (1,'Vengadores');
INSERT INTO equipos  VALUES (2,'Liga de la Justicia');
INSERT INTO equipos  VALUES (3,'X-Men');
INSERT INTO equipos  VALUES (4,'Legión del Mal');
INSERT INTO equipos  VALUES (5,'Los Seis Siniestros');

INSERT INTO superheroes_poderes VALUES (1,1);
INSERT INTO superheroes_poderes VALUES (1,3);
INSERT INTO superheroes_poderes VALUES (3,1);
INSERT INTO superheroes_poderes VALUES (3,2);
INSERT INTO superheroes_poderes VALUES (3,5);
INSERT INTO superheroes_poderes VALUES (5,1);

INSERT INTO villanos_poderes VALUES (1,3);
INSERT INTO villanos_poderes VALUES (1,4);
INSERT INTO villanos_poderes VALUES (2,4);
INSERT INTO villanos_poderes VALUES (3,2);
INSERT INTO villanos_poderes VALUES (3,3);
INSERT INTO villanos_poderes VALUES (3,4);
INSERT INTO villanos_poderes VALUES (4,1);
INSERT INTO villanos_poderes VALUES (4,2);
INSERT INTO villanos_poderes VALUES (4,4);
INSERT INTO villanos_poderes VALUES (4,5);
INSERT INTO villanos_poderes VALUES (5,1);
INSERT INTO villanos_poderes VALUES (5,3);
INSERT INTO villanos_poderes VALUES (5,4);

INSERT INTO superheroes_equipos VALUES (1,1);
INSERT INTO superheroes_equipos VALUES (3,2);
INSERT INTO superheroes_equipos VALUES (4,2);
INSERT INTO superheroes_equipos VALUES (5,1);
--CONSULTAS
--1

    ALTER TABLE superheroes ADD edad NUMBER(2) CHECK(edad>0);

--2

    ALTER TABLE superheroes MODIFY nombre VARCHAR2(100);
    
--3

    ALTER TABLE superheroes RENAME TO personaje;

--4

    SELECT * FROM personaje;

--5

    SELECT nombre, alias FROM personaje WHERE ciudad_origen = 'Nueva York';

--6

    SELECT p.nombre, e.nombre FROM personaje p, superheroes_equipos se, equipos e WHERE p.id = se.superheroe_id AND se.equipo_id = e.id;

--7

    SELECT COUNT(*) AS total_villanos FROM villanos;

--8

    SELECT p.nombre, e.nombre FROM personaje p, superheroes_equipos se, equipos e WHERE p.id = se.superheroe_id AND se.equipo_id = e.id;

--9

    SELECT p.nombre AS personaje, e.nombre AS equipo, po.nombre AS poder FROM personaje p, superheroes_equipos se, equipos e, superheroes_poderes sp, poderes po 
    WHERE p.id = se.superheroe_id(+) AND se.equipo_id = e.id(+) AND p.id = sp.superheroe_id(+) AND sp.poder_id = po.id(+) UNION
    SELECT v.nombre AS personaje, NULL AS equipo, po.nombre AS poder FROM villanos v, villanos_poderes vp, poderes po WHERE v.id = vp.villano_id(+) AND vp.poder_id = po.id(+);

--10

    SELECT p.nombre 
    FROM personaje p, superheroes_equipos se, equipos e 
    WHERE p.id = se.superheroe_id AND se.equipo_id = e.id AND e.nombre = 'Vengadores';

--11

    SELECT p1.nombre AS heroe1, p2.nombre AS heroe2, po.nombre AS poder
    FROM personaje p1, personaje p2, superheroes_poderes sp1, superheroes_poderes sp2, poderes po
    WHERE sp1.poder_id = sp2.poder_id AND sp1.superheroe_id <> sp2.superheroe_id 
    AND sp1.superheroe_id = p1.id AND sp2.superheroe_id = p2.id AND sp1.poder_id = po.id;

--12

    SELECT e.nombre AS equipo, COUNT(se.superheroe_id) AS cantidad_personas
    FROM equipos e, superheroes_equipos se 
    WHERE e.id = se.equipo_id 
    GROUP BY e.nombre;

--13

    SELECT p.nombre, COUNT(sp.poder_id) AS cantidad_poderes
    FROM personaje p, superheroes_poderes sp
    WHERE p.id = sp.superheroe_id
    GROUP BY p.nombre
    HAVING COUNT(sp.poder_id) = (
    SELECT MAX(cantidad)
    FROM (
        SELECT COUNT(sp2.poder_id) AS cantidad
        FROM superheroes_poderes sp2
        GROUP BY sp2.superheroe_id
    ) );
    
--14

    SELECT AVG(cantidad) AS promedio_poderes 
    FROM(
        SELECT COUNT (sp.poder_id) AS cantidad
        FROM superheroes_poderes sp
        GROUP BY sp.superheroe_id
    );

--15

    SELECT p.nombre, COUNT(sp.poder_id) AS cantidad_poderes
    FROM personaje p, superheroes_poderes sp
    WHERE p.id = sp.superheroe_id
    GROUP BY p.nombre
    HAVING COUNT(sp.poder_id) = (
    SELECT MIN(cantidad)
    FROM (
        SELECT COUNT(sp2.poder_id) AS cantidad
        FROM superheroes_poderes sp2
        GROUP BY sp2.superheroe_id
    ) );

--16

    SELECT po.nombre AS poder, 
       (SELECT COUNT(DISTINCT sp.superheroe_id) FROM superheroes_poderes sp WHERE sp.poder_id = po.id) AS cantidad_heroes,
       (SELECT COUNT(DISTINCT vp.villano_id) FROM villanos_poderes vp WHERE vp.poder_id = po.id) AS cantidad_villanos
    FROM poderes po;

--17

    SELECT p.nombre FROM personaje p WHERE p.id NOT IN 
    (SELECT superheroe_id FROM superheroes_poderes WHERE poder_id = 2)
    UNION SELECT v.nombre FROM villanos v WHERE v.id NOT IN 
    (SELECT villano_id FROM villanos_poderes WHERE poder_id = 2);

--18

    SELECT p.nombre FROM personaje p, superheroes_poderes sp WHERE p.id = sp.superheroe_id GROUP BY p.nombre 
    HAVING COUNT(sp.poder_id) > (SELECT COUNT(sp.poder_id) FROM superheroes_poderes sp WHERE sp.superheroe_id = 1);

--19

    SELECT p.nombre FROM personaje p WHERE p.id NOT IN (SELECT DISTINCT superheroe_id FROM superheroes_equipos);

--20

    SELECT DISTINCT p.nombre FROM personaje p, superheroes_poderes sp WHERE p.id = sp.superheroe_id 
    AND sp.poder_id IN (SELECT poder_id FROM superheroes_poderes WHERE superheroe_id = 5);

--21

    SELECT p.nombre
    FROM personaje p
    WHERE p.id IN (
    SELECT sp.superheroe_id
    FROM superheroes_poderes sp
    GROUP BY sp.superheroe_id
    HAVING COUNT(sp.poder_id) > 2)
    AND p.id NOT IN (
    SELECT DISTINCT se.superheroe_id FROM superheroes_equipos se);
    
--22

    DELETE FROM villanos WHERE id NOT IN (SELECT DISTINCT villano_id 
    FROM villanos_poderes);

--23

    UPDATE personaje SET alias = 'Miles Morales' 
    WHERE alias = 'Spider Man';

--24

    INSERT INTO personaje 
    VALUES (6, 'Marc Spector', 'Moon Knight', 'Chicago', NULL);

--25

    INSERT INTO superheroes_equipos VALUES (6, 1);

--26

    DELETE FROM personaje
    WHERE id NOT IN (SELECT DISTINCT superheroe_id FROM superheroes_equipos);

--27

    DELETE FROM personaje WHERE id NOT IN ( SELECT superheroe_id FROM superheroes_poderes WHERE poder_id = 2
    UNION SELECT villano_id FROM villanos_poderes WHERE poder_id = 2);

--28

    SELECT DISTINCT v.nombre FROM villanos v, villanos_poderes vp1, villanos_poderes vp2 
    WHERE v.id = vp1.villano_id AND vp1.poder_id = 1; 
