//1. Creación de tablas
CREATE TABLE poderes
(
    id NUMBER(2) PRIMARY KEY,
    nombre VARCHAR2(25) NOT NULL
);

CREATE TABLE equipo
(
    id NUMBER(2) PRIMARY KEY,
    nombre VARCHAR2(25) NOT NULL
);

CREATE TABLE superPersona
(
    id NUMBER(2) PRIMARY KEY,
    nombre VARCHAR2(25) NOT NULL,
    alias VARCHAR2(50) NOT NULL,
    ciudadOrigen VARCHAR2(50),
    tipo VARCHAR2(15) CHECK (tipo IN ('Heroe', 'Villano')),
    id_poder NUMBER(2),
    id_equipo NUMBER(2),
    
    CONSTRAINT fk_superPersona_poder FOREIGN KEY (id_poder) REFERENCES poderes(id),
    CONSTRAINT fk_superPersona_equipo FOREIGN KEY (id_equipo) REFERENCES equipo(id)
);

CREATE TABLE poderes_persona
(
    id_persona NUMBER(2),
    id_poder NUMBER(2),
    
    CONSTRAINT pk_poderes_persona PRIMARY KEY (id_persona, id_poder),
    CONSTRAINT fk_poderpersona_persona FOREIGN KEY (id_persona) REFERENCES superPersona(id),
    CONSTRAINT fk_poderpersona_poder FOREIGN KEY (id_poder) REFERENCES poderes(id)
);

//2.Inserción de datos
INSERT INTO poderes VALUES (1, 'Longevidad');
INSERT INTO poderes VALUES (2, 'Trepar muros');
INSERT INTO poderes VALUES (3, 'Superfuerza');
INSERT INTO poderes VALUES (4, 'Invisibilidad');
INSERT INTO poderes VALUES (5, 'Regeneración');

INSERT INTO equipo VALUES (1, 'Los Vengadores');
INSERT INTO equipo VALUES (2, 'Los 4 Fantasticos');
INSERT INTO equipo VALUES (3, 'X-Men');
INSERT INTO equipo VALUES (4, 'Guardianes de la Galaxia');
INSERT INTO equipo VALUES (5, 'S.H.I.E.L.D.');

INSERT INTO superPersona VALUES (1, 'Peter Parker', 'Spiderman', 'Nueva York', 'Heroe', 2, 1);
INSERT INTO superPersona VALUES (2, 'Groot', 'Groot', 'Planeta X', 'Heroe', 5, 4);
INSERT INTO superPersona VALUES (3, 'Susan Storm', 'Mujer invisible', 'Nueva York', 'Heroe', 4, 2);
INSERT INTO superPersona VALUES (4, 'Nicholas Joseph Fury', 'Nick Furia', 'Huntsville', 'Heroe', 1, 5);
INSERT INTO superPersona VALUES (5, 'Cain Marko', 'Juggernaut', 'Berkeley', 'Villano', 3, 3);

INSERT INTO poderes_persona VALUES (1, 2);
INSERT INTO poderes_persona VALUES (1, 3);
INSERT INTO poderes_persona VALUES (1, 5);
INSERT INTO poderes_persona VALUES (2, 5);
INSERT INTO poderes_persona VALUES (3, 4);
INSERT INTO poderes_persona VALUES (4, 1);
INSERT INTO poderes_persona VALUES (5, 3);
INSERT INTO poderes_persona VALUES (5, 5);

//3. Consultas
//1
ALTER TABLE superPersona ADD edad NUMBER(3);
//2
ALTER TABLE superPersona MODIFY nombre VARCHAR2(100);
//3
ALTER TABLE superPersona RENAME TO personaje;
//4
SELECT * FROM personaje WHERE tipo='Heroe';
//5
SELECT nombre, alias FROM personaje WHERE ciudadOrigen='Nueva York';
//6
SELECT personaje.nombre, equipo.nombre FROM personaje, equipo
WHERE personaje.id_equipo=equipo.id;
//7
SELECT* FROM personaje WHERE tipo='Villano';
//8
SELECT alias, poderes.nombre FROM personaje, poderes, poderes_persona
WHERE personaje.id=poderes_persona.id_persona
AND poderes.id=poderes_persona.id_poder AND tipo='Villano';
//9
SELECT personaje.alias, equipo.nombre, poderes.nombre FROM personaje, equipo, poderes, poderes_persona
WHERE personaje.id=poderes_persona.id_persona AND poderes.id=poderes_persona.id_poder
AND personaje.id_equipo=equipo.id;
//10
SELECT personaje.* FROM personaje, equipo
WHERE personaje.id_equipo=equipo.id AND equipo.nombre='Los Vengadores';
//11
SELECT DISTINCT personaje.alias FROM personaje, poderes_persona p1
WHERE personaje.id=p1.id_persona
AND p1.id_poder in (SELECT p2.id_poder FROM poderes_persona p2 WHERE p1.id_persona!=p2.id_persona);
//12
SELECT equipo.nombre, COUNT(personaje.id) FROM equipo, personaje
WHERE equipo.id=personaje.id_equipo GROUP BY equipo.nombre;
//13
SELECT personaje.alias, COUNT(poderes_persona.id_poder) FROM personaje, poderes_persona
WHERE personaje.id=poderes_persona.id_persona GROUP BY personaje.alias 
HAVING COUNT(poderes_persona.id_poder) = (SELECT MAX(cont) FROM (SELECT COUNT(id_poder) AS cont FROM poderes_persona GROUP BY id_persona));
//14
SELECT SUM(cont)/COUNT(cont) FROM (SELECT COUNT(poderes_persona.id_poder) AS cont FROM poderes_persona GROUP BY id_persona);
//15
SELECT personaje.alias, COUNT(poderes_persona.id_poder) FROM personaje, poderes_persona
WHERE personaje.id=poderes_persona.id_persona GROUP BY personaje.alias 
HAVING COUNT(poderes_persona.id_poder) = (SELECT MIN(cont) FROM (SELECT COUNT(id_poder) AS cont FROM poderes_persona GROUP BY id_persona));
//16

//17

//18

//19

//20

//21

//22

//23

//24

//25

//26

//27

//28