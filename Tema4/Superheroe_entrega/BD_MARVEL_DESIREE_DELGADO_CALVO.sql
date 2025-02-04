//BD MARVEL

//1.Creación de tablas

CREATE TABLE equipo
(
  id_equipo NUMBER(3)PRIMARY KEY,
  nombre VARCHAR2 (30) NOT NULL
);

CREATE TABLE superheroes 
(
   id NUMBER(3)PRIMARY KEY,
   nombre VARCHAR2 (25)NOT NULL,
   alias VARCHAR2(50)NOT NULL,
   ciudad_origen VARCHAR (30),
   id_equipo  NUMBER(3),
   
   CONSTRAINT fk_super_equipo FOREIGN KEY (id_equipo) REFERENCES equipo(id_equipo)
);

CREATE TABLE poderes
(
   id NUMBER (3)PRIMARY KEY,
   nombre VARCHAR2 (25)NOT NULL
);

CREATE TABLE superheroes_poderes
(
    id_poder NUMBER (3),
    id_superheroe NUMBER(3),

CONSTRAINT pk_superpod PRIMARY KEY (id_poder, id_superheroe),
CONSTRAINT fk_pod FOREIGN KEY (id_poder) REFERENCES poderes (id),
CONSTRAINT fk_sup FOREIGN KEY (id_superheroe) REFERENCES superheroes (id)
);

CREATE TABLE villanos 
(
   id NUMBER(3)PRIMARY KEY,
   nombre VARCHAR2 (25) NOT NULL,
   alias VARCHAR2(50)NOT NULL,
   ciudad_origen VARCHAR (30)
);

CREATE TABLE villanos_poderes
(
    id_poder NUMBER (3),
    id_villano NUMBER(3),
    
CONSTRAINT pk_vill_pod PRIMARY KEY (id_poder, id_villano),
CONSTRAINT fk_pod_v FOREIGN KEY (id_poder)REFERENCES poderes(id),
CONSTRAINT fk_villano FOREIGN KEY (id_villano)REFERENCES villanos(id)
);

//2.Insertar datos

--Equipos
INSERT INTO equipo VALUES (1, 'Vengadores');
INSERT INTO equipo VALUES (2,'Liga de la Justicia');
INSERT INTO equipo VALUES (3,'Guardianes de la galaxia');
INSERT INTO equipo VALUES (4,'Revengadores');
INSERT INTO equipo VALUES (5,'X-men');

--Superhéroes
INSERT INTO superheroes VALUES (1, 'Spiderman', 'Spidey','Nueva York',1);
INSERT INTO superheroes VALUES (2, 'Wonderwoman', 'Mujer Maravilla','Temiscira',2);
INSERT INTO superheroes VALUES (3, 'Gamora', 'Mujer Letal','Zen-Whoberi',3);
INSERT INTO superheroes VALUES (4, 'Valquiria', 'Val','New Asgard',4);
INSERT INTO superheroes VALUES (5, 'Lobezno', 'Wolverine','Canadá',5);

--Poderes
INSERT INTO poderes VALUES(1,'Sentido arácnido');
INSERT INTO poderes VALUES (2,'Volar');
INSERT INTO poderes VALUES (3,'Superfuerza');
INSERT INTO poderes VALUES (4,'Regeneración');
INSERT INTO poderes VALUES (5,'Invisibilidad');

--Supeheroes_poderes
INSERT INTO superheroes_poderes VALUES (1,1);
INSERT INTO superheroes_poderes VALUES (2,2);
INSERT INTO superheroes_poderes VALUES (3,3);
INSERT INTO superheroes_poderes VALUES (5,4);
INSERT INTO superheroes_poderes VALUES (4,5);
INSERT INTO superheroes_poderes VALUES (3,4);
INSERT INTO superheroes_poderes VALUES (3,5);

--Villanos
INSERT INTO villanos VALUES (1, 'Venom', 'Eddie Brock','Klyntar');
INSERT INTO villanos VALUES (2, 'Magneto', 'Magnus','Polonia');
INSERT INTO villanos VALUES (3, 'Thanos', 'El Gemas','Titán');
INSERT INTO villanos VALUES (4, 'Deadpool', 'Winston Wilson','Canadá');
INSERT INTO villanos VALUES (5, 'Loki', 'Dios de las Travesuras','Jotunheim');

--Villanos_poderes
INSERT INTO villanos_poderes VALUES(2,2);
INSERT INTO villanos_poderes VALUES(3,3);
INSERT INTO villanos_poderes VALUES(1,1);
INSERT INTO villanos_poderes VALUES(5,1);
INSERT INTO villanos_poderes VALUES(2,5);
INSERT INTO villanos_poderes VALUES(4,4);

//3.Consultas

--1.Añade la columna de edad a la tabla de superhéroe.
ALTER TABLE superheroes
ADD edad NUMBER (5);

--2.Modificar el tipo de dato de la columna nombre en la tabla superhéroe para que tenga un máximo de 100 caracteres.
ALTER TABLE superheroes
MODIFY nombre VARCHAR2(100);

--3.Cambia el nombre de la tabla superhéroe a personaje.
ALTER TABLE superheroes
RENAME TO personajes;

--4.Muestra los datos de todos los héroes.
SELECT * FROM personajes; 

--5.Muestra el nombre y el alias de todos los héroes de Nueva York.
SELECT nombre, alias FROM personajes WHERE ciudad_origen='Nueva York';

--6. Muestra el nombre y el equipo de todos los héroes que pertenezcan a uno.
SELECT nombre, id_equipo FROM personajes;

--7.Muestra cuantos villanos hay insertado en la base de datos.
SELECT * FROM villanos;

--8.Muestra el alias de los villanos junto a sus poderes.
SELECT villanos.alias, villanos_poderes.id_poder FROM villanos, villanos_poderes
WHERE villanos.id=villanos_poderes.id_villano;

--9.Muestra todos los héroes y villanos junto a sus equipos y sus poderes.
SELECT personajes.*, superheroes_poderes.id_poder AS poder_superheroe
FROM personajes, superheroes_poderes
WHERE personajes.id=superheroes_poderes.id_superheroe;

SELECT villanos.*, villanos_poderes.id_poder AS poder_villano
FROM villanos, villanos_poderes 
WHERE villanos.id=villanos_poderes.id_villano;
//Al seleccionar todos los datos de heroes ya sale sus equipos, no hace falta seleccionar esa tabla en el FROM

--10.Muestra todos los héroes que pertenecen a los Vengadores.
SELECT personajes.*, equipo.nombre FROM  personajes, equipo WHERE personajes.id_equipo=equipo.id_equipo AND equipo.nombre='Vengadores';

--11. Muestra todos los héroes que comparten el mismo poder.
SELECT personajes.*, superheroes_poderes.id_poder FROM personajes, superheroes_poderes 
WHERE personajes.id=superheroes_poderes.id_superheroe AND superheroes_poderes.id_poder=3;

--12.Cuenta cuantas personas tiene cada equipo.
SELECT nombre, COUNT (id_equipo)FROM equipo GROUP BY nombre;

--13.Muestra la persona con más poderes.
SELECT personajes.nombre, MAX(cuenta) AS maximo FROM personajes, superheroes_poderes 
WHERE personajes.id=superheroes_poderes.id_superheroe AND cuenta = (SELECT count(id_poder) AS cuenta FROM superheroes_poderes WHERE personajes.id=id_superheroe) GROUP BY personajes.nombre;

--14.Muestra cuántos poderes de media tienen los personajes.
SELECT COUNT (id_poder)/COUNT(id_superheroe)FROM superheroes_poderes;

--15.Muestra la persona con menos poderes.
SELECT personajes.nombre, MIN(cuenta) AS maximo FROM personajes, superheroes_poderes 
WHERE personajes.id=superheroes_poderes.id_superheroe AND cuenta = (SELECT count(id_poder) AS cuenta FROM superheroes_poderes WHERE personajes.id=id_superheroe) GROUP BY personajes.nombre;

--16.Muestra cuántos héroes y villanos hay por cada tipo de poder.
SELECT poderes.nombre, COUNT (personajes.id) FROM poderes, personajes, superheroes_poderes 
WHERE personajes.id=superheroes_poderes.id_superheroe AND superheroes_poderes.id_poder=poderes.id
GROUP BY poderes.nombre;//HÉROES

SELECT poderes.nombre, COUNT (villanos.id) FROM poderes, villanos, villanos_poderes 
WHERE villanos_poderes.id_poder=poderes.id AND villanos.id=villanos_poderes.id_villano
GROUP BY poderes.nombre;//VILLANOS

--17.Muestra las personas que no pueden volar.
SELECT personajes.nombre, villanos.nombre FROM personajes, villanos, superheroes_poderes, villanos_poderes 
WHERE personajes.id=superheroes_poderes.id_superheroe AND villanos.id=villanos_poderes.id_villano 
AND id_poder=(SELECT id_poder FROM poderes WHERE nombre != 'Volar');

--18.Muestra las personas que tienen más poderes que ‘Spider-Man’.


--19.Muestra las personas que trabajan en solitario.
SELECT personajes.nombre FROM personajes WHERE id_equipo IS NULL;

--20.Muestra las personas con los mismos poderes que ‘Gamora’.
SELECT personajes.nombre FROM personajes, superheroes_poderes WHERE personajes.id=superheroes_poderes.id_superheroe 
AND superheroes_poderes.id_poder IN (SELECT superheroes_poderes.id_poder FROM superheroes_poderes, personajes WHERE personajes.id=superheroes_poderes.id_superheroe
              AND personajes.nombre='Gamora');
                                                                                                                                    
--21.Obten los héroes que tienen más de dos poderes y no pertenecen a ningún equipo.


--22.Elimina todos los villanos que no tienen superpoderes.
 

--23.Cambia el nombre de ‘Spider-Man’ a ‘Miles Morales’.
UPDATE personajes SET nombre='Miles Morales'
WHERE nombre='Spiderman';

--24.Inserta a Moon Knight (Marc Spector) a la tabla de héroes y 25.Añadelo al equipo de los ‘Vengadores’
INSERT INTO personajes VALUES (6,' Moon Knight','Marc Spector','Chicago',1, null);

--26.Elimina a los héroes que no tienen un equipo asignado.
DELETE FROM personajes WHERE id_equipo IS NULL;

--27.Elimina a las personas que no pueden volar.


--28.Muestra todos los villanos que tienen ‘Superfuerza’ y pueden volar.
SELECT DISTINCT villanos.nombre FROM villanos, villanos_poderes, poderes WHERE villanos.id=villanos_poderes.id_villano AND  poderes.id=villanos_poderes.id_poder
AND poderes.nombre='Superfuerza' OR poderes.nombre='Volar';











