CREATE TABLE equipo(
    id NUMBER(3) PRIMARY KEY,
    nombre VARCHAR2(25) NOT NULL
);

CREATE TABLE superheroes(
    id NUMBER(3) PRIMARY KEY,
    nombre VARCHAR2(25) NOT NULL,
    alias VARCHAR2(50) NOT NULL,
    ciudad VARCHAR2(50),
    id_equipo NUMBER(3),
    
    CONSTRAINT fk_sh_eq FOREIGN KEY (id_equipo) REFERENCES equipo(id)
);

CREATE TABLE poderes(
    id NUMBER(3) PRIMARY KEY,
    nombre VARCHAR2(25) NOT NULL
);

CREATE TABLE villanos(
    id NUMBER(3) PRIMARY KEY,
    nombre VARCHAR2(25) NOT NULL,
    alias VARCHAR2(50) NOT NULL,
    ciudad VARCHAR2(50)
);

CREATE TABLE heroes_poderes(
    id_heroe NUMBER(3),
    id_poder NUMBER(3),
    
    CONSTRAINT pk_h_p PRIMARY KEY (id_heroe, id_poder),
    CONSTRAINT fk_h FOREIGN KEY (id_heroe) REFERENCES superheroes(id),
    CONSTRAINT fk_p FOREIGN KEY (id_poder) REFERENCES poderes(id)
);

CREATE TABLE villanos_poderes(
    id_villano NUMBER(3),
    id_poder NUMBER(3),
    
    CONSTRAINT pf_v_p PRIMARY KEY (id_villano, id_poder),
    CONSTRAINT fk_v FOREIGN KEY (id_villano) REFERENCES villanos(id),
    CONSTRAINT fk_vp FOREIGN KEY (id_poder) REFERENCES poderes(id)  
);

INSERT INTO equipo VALUES (1, 'Vengadores');
INSERT INTO equipo VALUES (2, 'Liga de la Justicia');
INSERT INTO equipo VALUES (3, 'Guardianes de la Galaxia');
INSERT INTO equipo VALUES (4, 'Revengadores');
INSERT INTO equipo VALUES (5, 'X-Men');

INSERT INTO superheroes VALUES (1, 'Spider-Man', 'Spidey', 'Nueva York', 1);
INSERT INTO superheroes VALUES (2, 'Wonderwoman', 'Mujer Maravilla', 'Molvizar', 2);
INSERT INTO superheroes VALUES (3, 'Gamora', 'Mujer Letal', 'Benajarafe', 3);
INSERT INTO superheroes VALUES (4, 'Valquiria', 'Valeria', 'Ítrabo', 4);
INSERT INTO superheroes VALUES (5, 'Lobezno', 'El garras', 'Montefrío', 5);

INSERT INTO poderes VALUES (1, 'Sentido arácnido');
INSERT INTO poderes VALUES (2, 'Volar');
INSERT INTO poderes VALUES (3, 'Rayos X');
INSERT INTO poderes VALUES (4, 'Poder mental');
INSERT INTO poderes VALUES (5, 'Superfuerza');

INSERT INTO villanos VALUES (1, 'Magneto', 'Imán', 'Benamocarra');
INSERT INTO villanos VALUES (2, 'Victor Von Doom', 'El holandés', 'Carratraca');
INSERT INTO villanos VALUES (3, 'Kang', 'DonkeyKong', 'Lobres');
INSERT INTO villanos VALUES (4, 'Galactus', 'MrWorldWide', 'Cómpeta');
INSERT INTO villanos VALUES (5, 'Thanos', 'Antonio', 'Armilla');

INSERT INTO heroes_poderes VALUES (1,1);
INSERT INTO heroes_poderes VALUES (2,4);
INSERT INTO heroes_poderes VALUES (3,2);
INSERT INTO heroes_poderes VALUES (4,5);
INSERT INTO heroes_poderes VALUES (5,3);

INSERT INTO villanos_poderes VALUES (1, 3);
INSERT INTO villanos_poderes VALUES (2, 1);
INSERT INTO villanos_poderes VALUES (3, 4);
INSERT INTO villanos_poderes VALUES (4, 5);
INSERT INTO villanos_poderes VALUES (5, 2);

1. ALTER TABLE superheroes ADD edad NUMBER(4);
2. ALTER TABLE superheroes
    MODIFY nombre VARCHAR2(100);
3. ALTER TABLE superheroes
    RENAME TO personaje;
4. SELECT * from personaje;
5. SELECT nombre, alias FROM personaje WHERE ciudad='Nueva York';
6. SELECT nombre, id_equipo FROM personaje WHERE id_equipo IS NOT NULL;
7. SELECT COUNT(id) AS cantidad FROM villanos;
8. SELECT alias, id_poder FROM villanos, villanos_poderes WHERE villanos.id = villanos_poderes.id_villano;
9. SELECT personaje.nombre AS nombre_heroes, personaje.id_equipo, heroes_poderes.id_poder AS poder_heroes, villanos.nombre AS nombre_villanos, villanos_poderes.id_poder AS poder_villanos 
FROM personaje, villanos, heroes_poderes, villanos_poderes, poderes
WHERE villanos_poderes.id_villano = villanos.id AND personaje.id = heroes_poderes.id_heroe AND 
villanos_poderes.id_poder = poderes.id AND heroes_poderes.id_poder = poderes.id;
10. SELECT personaje.nombre FROM personaje, equipo WHERE equipo.nombre = 'Vengadores' AND equipo.id = personaje.id_equipo;
    INSERT INTO heroes_poderes VALUES (1,2);
11. SELECT personaje.nombre, poderes.nombre FROM personaje, poderes, heroes_poderes WHERE personaje.id = heroes_poderes.id_heroe AND poderes.id = heroes_poderes.id_poder;

12. SELECT equipo.nombre, COUNT(personaje.id_equipo) FROM equipo, personaje WHERE equipo.id = personaje.id_equipo GROUP BY equipo.nombre;
13. SELECT personaje.nombre, COUNT(heroes_poderes.id_heroe) FROM personaje, heroes_poderes WHERE personaje.id = heroes_poderes.id_heroe GROUP BY (personaje.nombre) HAVING COUNT(heroes_poderes.id_heroe)>1;
14. 
SELECT personaje.nombre, AVG(cont) 
FROM personaje, (SELECT hp.id_heroe, COUNT(hp.id_poder) AS cont FROM heroes_poderes hp GROUP BY (hp.id_heroe)) tr
WHERE personaje.id = tr.id_heroe
GROUP BY (personaje.nombre); 
15. 
SELECT personaje.nombre FROM personaje, heroes_poderes hp2
WHERE personaje.id = hp2.id_heroe GROUP BY (personaje.nombre)
HAVING COUNT(hp2.id_poder) <= (SELECT COUNT(hp1.id_poder) FROM heroes_poderes hp1);

16. SELECT poderes.nombre, COUNT(heroes_poderes.id_heroe), COUNT(villanos_poderes.id_villano) FROM poderes, villanos_poderes, heroes_poderes 
WHERE poderes.id = heroes_poderes.id_poder AND poderes.id = villanos_poderes.id_poder GROUP BY poderes.nombre;

17. SELECT personaje.nombre FROM personaje, heroes_poderes WHERE heroes_poderes.id_heroe = personaje.id AND heroes_poderes.id_poder != 2;
18.
SELECT personaje.nombre FROM personaje, heroes_poderes 
        WHERE heroes_poderes.id_heroe = personaje.id AND personaje.id IN
            (SELECT COUNT(id_heroe) FROM heroes_poderes HAVING COUNT(id_heroe)>=
                (SELECT COUNT(heroes_poderes.id_heroe) FROM heroes_poderes, personaje WHERE heroes_poderes.id_heroe = personaje.id AND personaje.nombre = 'Gamora' GROUP BY id_heroe)); 
19. 
INSERT INTO personaje VALUES (6, 'Hulk', 'El Hombre Increible', 'San Fernando', NULL, NULL);
SELECT personaje.nombre FROM personaje WHERE id_equipo IS NULL;

20. 
21. INSERT INTO heroes_poderes VALUES (6, 4);
    INSERT INTO heroes_poderes VALUES (6, 3);
SELECT personaje.nombre, COUNT(heroes_poderes.id_poder) FROM personaje, heroes_poderes WHERE id_equipo IS NULL GROUP BY personaje.nombre HAVING COUNT(heroes_poderes.id_poder)>2;
22. INSERT INTO villanos VALUES (6, 'Loki', 'Lokito', 'El Padul');
    ALTER TABLE villanos_poderes DROP CONSTRAINT pf_v_p;
    INSERT INTO villanos_poderes VALUES (6, NULL);
    DELETE FROM villanos_poderes WHERE id_poder IS NULL;
23. UPDATE personaje SET nombre='Miles Morales' WHERE nombre='Spider-Man';
24. INSERT INTO personaje VALUES (7, 'Moon Knight', 'Marc Spector', 'Aguadulce', NULL, NULL);
25. UPDATE personaje SET id_equipo = 1 WHERE nombre = 'Moon Knight';
26. DELETE FROM personaje WHERE id_equipo IS NULL;
27. DELETE FROM










