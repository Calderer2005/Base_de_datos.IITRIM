create table equipo(
    id numeric (3) primary key,
    nombre varchar(25) not null
);

create table superheroe (
    id numeric (3) primary key,
    nombre varchar (25)not null,
    ciudad_origen varchar (50),
    alias varchar (50),
    id_equipo numeric(3),
    
    foreign key (id_equipo) references equipo(id)
);
create table villanos (
    id numeric (3) primary key,
    nombre varchar (25)not null,
    ciudad_origen varchar (50),
    alias varchar (50)
);
create table poderes (
    id numeric (3) primary key,
    nombre varchar (25)not null
);
create table super_poderes (
    id_poder numeric (3),
    id_super numeric (3),
    
    foreign key (id_poder) references poderes(id),
    foreign key (id_super) references superheroe(id)
);
create table villanos_poderes (
    id_poder numeric (3),
    id_villano numeric (3),
    
    foreign key (id_poder) references poderes(id),
    foreign key (id_villano) references villanos(id)
);

INSERT INTO equipo (id, nombre) VALUES (111, 'Justice League');
INSERT INTO equipo (id, nombre) VALUES (222, 'Avengers');
INSERT INTO equipo (id, nombre) VALUES (333, 'X-Men');
INSERT INTO equipo (id, nombre) VALUES (444, 'Fantastic Four');
INSERT INTO equipo (id, nombre) VALUES (555, 'Guardians of the Galaxy');

INSERT INTO superheroe (id, nombre, ciudad_origen, alias, id_equipo) VALUES (1, 'Bruce Wayne', 'Gotham', 'Batman', 111);
INSERT INTO superheroe (id, nombre, ciudad_origen, alias, id_equipo) VALUES (2, 'Clark Kent', 'Smallville', 'Superman', 111);
INSERT INTO superheroe (id, nombre, ciudad_origen, alias, id_equipo) VALUES (3, 'Diana Prince', 'Themyscira', 'Wonder Woman', 111);
INSERT INTO superheroe (id, nombre, ciudad_origen, alias, id_equipo) VALUES (4, 'Tony Stark', 'Long Island', 'Iron Man', 222);
INSERT INTO superheroe (id, nombre, ciudad_origen, alias, id_equipo) VALUES (5, 'Peter Parker', 'New York', 'Spider-Man', 222);

INSERT INTO villanos (id, nombre, ciudad_origen, alias) VALUES (1, 'Lex Luthor', 'Metropolis', 'Lex Luthor');
INSERT INTO villanos (id, nombre, ciudad_origen, alias) VALUES (2, 'Joker', 'Gotham', 'Joker');
INSERT INTO villanos (id, nombre, ciudad_origen, alias) VALUES (3, 'Thanos', 'Titan', 'Mad Titan');
INSERT INTO villanos (id, nombre, ciudad_origen, alias) VALUES (4, 'Magneto', 'Poland', 'Magneto');
INSERT INTO villanos (id, nombre, ciudad_origen, alias) VALUES (5, 'Green Goblin', 'New York', 'Green Goblin');

INSERT INTO poderes (id, nombre) VALUES (1, 'Super Fuerza');
INSERT INTO poderes (id, nombre) VALUES (2, 'Vuelo');
INSERT INTO poderes (id, nombre) VALUES (3, 'Invulnerabilidad');
INSERT INTO poderes (id, nombre) VALUES (4, 'Control del Magnetismo');
INSERT INTO poderes (id, nombre) VALUES (5, 'Inteligencia Superior');

INSERT INTO super_poderes (id_poder, id_super) VALUES (1, 1);
INSERT INTO super_poderes (id_poder, id_super) VALUES (2, 2);
INSERT INTO super_poderes (id_poder, id_super) VALUES (3, 3);
INSERT INTO super_poderes (id_poder, id_super) VALUES (4, 4);
INSERT INTO super_poderes (id_poder, id_super) VALUES (5, 5);

INSERT INTO villanos_poderes (id_poder, id_villano) VALUES (1, 1);
INSERT INTO villanos_poderes (id_poder, id_villano) VALUES (2, 2);
INSERT INTO villanos_poderes (id_poder, id_villano) VALUES (3, 3);
INSERT INTO villanos_poderes (id_poder, id_villano) VALUES (4, 4);
INSERT INTO villanos_poderes (id_poder, id_villano) VALUES (5, 5);





alter table superheroe add column edad date;
alter table superheroe change column nombre nombre varchar(100);
ALTER TABLE superheroe RENAME TO personaje;
ALTER TABLE personaje RENAME TO superheroe;
select * from personaje;
select personaje.nombre, equipo.nombre from personaje, equipo where equipo.id = personaje.id_equipo
and personaje.ciudad_origen = 'New York';
select personaje.nombre equipo.nombre from personaje, equipo where equipo.id = personaje.id_equipo
and personaje.id_equipo != null;
select villanos from villanos;
select villanos.alias, poderes.nombre from poderes p,villanos v,villanos_poderes vp where v.id = vp.id_villano and p.id = vp.id_poder;
select villanos.alias, superheroe.alias from villanos,heroes;
select superheroe.alias from superheroe,equipo where superheroe.id_equipo = equipo.id and equipo.nombre = 'Vengadores';
select max(super_poderes.id_poder), superheroe.alias from super_poderes,superheroe where superheroe.id = super_poderes.id_super group by superheroe.alias;
select max(super_poderes.id_poder), superheroe.alias from super_poderes,superheroe where superheroe.id = super_poderes.id_super group by superheroe.alias;