DROP TABLE equipo CASCADE CONSTRAINTS;
DROP TABLE personaje CASCADE CONSTRAINTS;
DROP TABLE poder CASCADE CONSTRAINTS;
DROP TABLE poder_personaje CASCADE CONSTRAINTS;


CREATE TABLE equipo
(
    id NUMBER(2) PRIMARY KEY,
    nombre VARCHAR2(25) NOT NULL
);

CREATE TABLE personaje
(
    id NUMBER(3) PRIMARY KEY,
    nombre VARCHAR2(25) NOT NULL,
    alias VARCHAR2(50) NOT NULL,
    tipo VARCHAR2(25) NOT NULL,
    ciudad VARCHAR2(50),
    equipo NUMBER(2),
    
    CONSTRAINT fk_equipo_personaje FOREIGN KEY (equipo) REFERENCES equipo(id)
);

CREATE TABLE poder
(
    id NUMBER(3) PRIMARY KEY,
    nombre VARCHAR2(25) NOT NULL
);

CREATE TABLE poder_personaje
(
    personaje NUMBER(3),
    poder NUMBER(3),
    
    CONSTRAINT pk_poder_personaje PRIMARY KEY (personaje, poder),
    CONSTRAINT fk_personaje_poder_personaje FOREIGN KEY (personaje) REFERENCES personaje(id),
    CONSTRAINT fk_poder_poder_personaje FOREIGN KEY (poder) REFERENCES poder(id)
);

INSERT INTO equipo VALUES(1, 'Vengadores');
INSERT INTO equipo VALUES(2, 'X-Men');
INSERT INTO equipo VALUES(3, 'Cuatro Fantásticos');
INSERT INTO equipo VALUES(4, 'X-Force');
INSERT INTO equipo VALUES(5, 'Guardianes de la Galaxia');

INSERT INTO personaje VALUES(1, 'Peter Parker', 'Spiderman', 'Héroe', 'New York', 1);
INSERT INTO personaje VALUES(2, 'Stephen Strange', 'Dr Strange', 'Héroe', 'New York', 1);
INSERT INTO personaje VALUES(3, 'James Logan', 'Lobezno', 'Héroe', 'Alberta', 2);
INSERT INTO personaje VALUES(4, 'Elizabeth Braddock', 'Psylocke', 'Héroe', NULL, 2);
INSERT INTO personaje VALUES(5, 'Reed Richards', 'Mr Fantástico', 'Héroe', 'New York', 3);
INSERT INTO personaje VALUES(6, 'Susan Storm', 'Mujer Invisible', 'Héroe', 'New York', 3);
INSERT INTO personaje VALUES(7, 'Wade Wilson', 'Deadpool', 'Héroe', NULL, 4);
INSERT INTO personaje VALUES(8, 'Piotr Rasputin', 'Coloso', 'Héroe', NULL, 4);
INSERT INTO personaje VALUES(9, 'Peter Quill', 'Star-Lord', 'Héroe', NULL, 5);
INSERT INTO personaje VALUES(10, 'Groot', 'Groot', 'Héroe', NULL, 5);
INSERT INTO personaje VALUES(11, 'Thanos', 'Thanos', 'Villano', NULL, NULL);

INSERT INTO poder VALUES(1, 'Tela de araña');
INSERT INTO poder VALUES(2, 'Regeneración');
INSERT INTO poder VALUES(3, 'Superfuerza');
INSERT INTO poder VALUES(4, 'Teletransporte');
INSERT INTO poder VALUES(5, 'Elasticidad');
INSERT INTO poder VALUES(6, 'Supervelocidad');
INSERT INTO poder VALUES(7, 'Artes Marciales');
INSERT INTO poder VALUES(8, 'Superinteligencia');
INSERT INTO poder VALUES(9, 'Magia');
INSERT INTO poder VALUES(10, 'Invisibilidad');

INSERT INTO poder_personaje VALUES(1,1);
INSERT INTO poder_personaje VALUES(1,6);
INSERT INTO poder_personaje VALUES(1,3);
INSERT INTO poder_personaje VALUES(1,8);
INSERT INTO poder_personaje VALUES(1,10);
INSERT INTO poder_personaje VALUES(2,4);
INSERT INTO poder_personaje VALUES(2,8);
INSERT INTO poder_personaje VALUES(2,9);
INSERT INTO poder_personaje VALUES(3,2);
INSERT INTO poder_personaje VALUES(3,3);
INSERT INTO poder_personaje VALUES(3,7);
INSERT INTO poder_personaje VALUES(4,6);
INSERT INTO poder_personaje VALUES(4,7);
INSERT INTO poder_personaje VALUES(5,5);
INSERT INTO poder_personaje VALUES(6,10);
INSERT INTO poder_personaje VALUES(7,2);
INSERT INTO poder_personaje VALUES(7,3);
INSERT INTO poder_personaje VALUES(7,7);
INSERT INTO poder_personaje VALUES(8,2);
INSERT INTO poder_personaje VALUES(8,3);
INSERT INTO poder_personaje VALUES(9,7);
INSERT INTO poder_personaje VALUES(10,2);
INSERT INTO poder_personaje VALUES(11,2);
INSERT INTO poder_personaje VALUES(11,3);
INSERT INTO poder_personaje VALUES(11,4);
INSERT INTO poder_personaje VALUES(11,7);
INSERT INTO poder_personaje VALUES(11,8);
INSERT INTO poder_personaje VALUES(11,9);

--1
ALTER TABLE personaje ADD edad NUMBER(3);

--2
ALTER TABLE personaje MODIFY nombre VARCHAR2(100);

--3
ALTER TABLE superheroe RENAME TO personaje;

--4
SELECT * FROM personaje;

--5
SELECT nombre, alias FROM personaje WHERE ciudad = 'New York';

--6
SELECT personaje.nombre, equipo.nombre FROM personaje, equipo WHERE personaje.equipo = equipo.id;

--7
SELECT COUNT(*) FROM personaje WHERE tipo='Villano';

--8
SELECT personaje.nombre, poder.nombre FROM personaje, poder_personaje, poder WHERE personaje.id=poder_personaje.personaje AND poder_personaje.poder=poder.id AND tipo='Villano' ORDER BY personaje.nombre;

--9
SELECT personaje.nombre, equipo.nombre, poder.nombre FROM equipo, personaje, poder_personaje, poder WHERE equipo.id=personaje.equipo AND personaje.id=poder_personaje.personaje AND poder_personaje.poder=poder.id ORDER BY equipo.nombre, personaje.nombre;

--10
SELECT personaje.nombre FROM personaje, equipo WHERE personaje.equipo=equipo.id AND equipo.nombre='Vengadores';

--11
SELECT personaje.nombre, poder.nombre FROM personaje, poder_personaje, poder WHERE personaje.id=poder_personaje.personaje AND poder_personaje.poder=poder.id AND tipo='Héroe' ORDER BY poder.nombre;

--12
SELECT equipo.nombre, COUNT(*) FROM equipo, personaje WHERE equipo.id=personaje.equipo GROUP BY equipo.nombre;

--13 SIN COMPLETAR
SELECT personaje.nombre, MAX(p1.poder) FROM personaje, poder_personaje p1 WHERE personaje.id=p1.personaje GROUP BY personaje.nombre ;

--14
SELECT COUNT(*)/COUNT(DISTINCT personaje) FROM poder_personaje;

--15 SIN COMPLETAR
SELECT personaje.nombre FROM personaje, poder_personaje WHERE personaje.id=poder_personaje.personaje AND poder_personaje.personaje = (SELECT MAX(SELECT COUNT(*) FROM poder_personaje WHERE poder_personaje.personaje=poder_personaje.personaje) FROM poder_personaje);

--16
SELECT poder.nombre, COUNT(poder_personaje.personaje) FROM personaje, poder_personaje, poder WHERE personaje.id=poder_personaje.personaje AND poder_personaje.poder=poder.id GROUP BY poder.nombre;

--17
SELECT nombre FROM personaje WHERE id NOT IN (SELECT personaje FROM poder_personaje, poder WHERE poder_personaje.poder=poder.id AND nombre='Superfuerza');

--18
SELECT nombre FROM personaje, poder_personaje WHERE personaje.id=poder_personaje.personaje GROUP BY nombre HAVING COUNT(poder)>(SELECT COUNT(poder_personaje) FROM poder_personaje, personaje WHERE poder_personaje.personaje=personaje.id AND nombre='Spiderman');


SELECT COUNT(poder) FROM poder_personaje, personaje WHERE poder_personaje.personaje=personaje.id AND nombre='Spiderman';










