create table videojuegos (
    id numeric(4) primary key,
    titulo varchar(50) not null,
    pegi varchar(3) check(pegi in ('+3','+7','+12','+16','+18')),
    id_desarrolladora numeric(4)
);
create table consolas(
    id numeric(4) primary key,
    nombre varchar(25) not null,
    id_fabricante numeric(4),
    fecha_lanzamiento date,
    generacion numeric(1) check(generacion>= 0)
);
create table generos(
    id numeric(4) primary key,
    nombre varchar(25) not null
);
create table desarrolladores(
     id numeric(4) primary key,
     nombre varchar(25) not null,
     pais_origen varchar (50),
     año_fundacion numeric(4)
);
create table lanzamientos(
    id_juego numeric (4),
    id_consola numeric (4),
    fecha_lanzamiento date,
    
    constraint id_juego_fk foreign key (id_juego) references videojuegos(id),
    constraint fk_consola foreign key (id_consola) references consolas(id)
);
create table juegos_generos(
    id_juego numeric(4),
    id_genero numeric (4),
    constraint id_juego_gen_fk foreign key (id_juego) references videojuegos(id),
    constraint fk_genero foreign key (id_genero) references generos(id)
);

INSERT INTO desarrolladores (id, nombre, pais_origen, año_fundacion) VALUES (1, 'CD Projekt Red', 'Polonia', 1994);
INSERT INTO desarrolladores (id, nombre, pais_origen, año_fundacion) VALUES (2, 'Nintendo EPD', 'Japón', 1889);
INSERT INTO desarrolladores (id, nombre, pais_origen, año_fundacion) VALUES (3, 'Rockstar Games', 'Estados Unidos', 1998);
INSERT INTO desarrolladores (id, nombre, pais_origen, año_fundacion) VALUES (4, 'Mojang Studios', 'Suecia', 2009);
INSERT INTO desarrolladores (id, nombre, pais_origen, año_fundacion) VALUES (5, 'Sony Interactive', 'Japón', 1993);
INSERT INTO desarrolladores (id, nombre, pais_origen, año_fundacion) VALUES (6, 'Insomniac Games', 'Estados Unidos', 1994);
INSERT INTO desarrolladores (id, nombre, pais_origen, año_fundacion) VALUES (7, 'Microsoft', 'Estados Unidos', 1975);

INSERT INTO videojuegos (id, Titulo, PEGI, id_desarrolladora) VALUES (1, 'Cyberpunk 2077', '+18', 1);
INSERT INTO videojuegos (id, Titulo, PEGI, id_desarrolladora) VALUES (2, 'The Legend of Zelda Breath of the Wild', '+12', 2);
INSERT INTO videojuegos (id, Titulo, PEGI, id_desarrolladora) VALUES (3, 'Red Dead Redemption 2', '+18', 3);
INSERT INTO videojuegos (id, Titulo, PEGI, id_desarrolladora) VALUES (4, 'Minecraft', '+7', 4);
INSERT INTO videojuegos (id, Titulo, PEGI, id_desarrolladora) VALUES (5, 'Spyro the Dragon', '+3', 6);

INSERT INTO Consolas (ID, Nombre, id_fabricante, fecha_lanzamiento, generacion) VALUES (1, 'PlayStation', 5, '03-12-1994', 5);
INSERT INTO Consolas (ID, Nombre, id_fabricante, fecha_lanzamiento, generacion) VALUES (2, 'PlayStation 4', 5, '15-11-2013', 8);
INSERT INTO Consolas (ID, Nombre, id_fabricante, fecha_lanzamiento, generacion) VALUES (3, 'PlayStation 5', 5, '12-11-2020', 9);
INSERT INTO Consolas (ID, Nombre, id_fabricante, fecha_lanzamiento, generacion) VALUES (4, 'XBOX Series X', 7, '10-11-2020', 9);
INSERT INTO Consolas (ID, Nombre, id_fabricante, fecha_lanzamiento, generacion) VALUES (5, 'Nintendo Switch', 2, '03-03-2017', 8);

INSERT INTO generos (ID, Nombre) VALUES (1, 'RPG');
INSERT INTO generos (ID, Nombre) VALUES (2, 'Aventura');
INSERT INTO generos (ID, Nombre) VALUES (3, 'Acción');
INSERT INTO generos (ID, Nombre) VALUES (4, 'Sandbox');
INSERT INTO generos (ID, Nombre) VALUES (5, '3rd Person Shooter');

INSERT INTO juegos_generos (ID_juego, ID_genero) VALUES (1, 1);
INSERT INTO juegos_generos (ID_juego, ID_genero) VALUES (1, 3);
INSERT INTO juegos_generos (ID_juego, ID_genero) VALUES (1, 5);
INSERT INTO juegos_generos (ID_juego, ID_genero) VALUES (2, 2);
INSERT INTO juegos_generos (ID_juego, ID_genero) VALUES (2, 3);
INSERT INTO juegos_generos (ID_juego, ID_genero) VALUES (3, 3);
INSERT INTO juegos_generos (ID_juego, ID_genero) VALUES (3, 4);
INSERT INTO juegos_generos (ID_juego, ID_genero) VALUES (3, 5);
INSERT INTO juegos_generos (ID_juego, ID_genero) VALUES (4, 4);
INSERT INTO juegos_generos (ID_juego, ID_genero) VALUES (5, 2);
INSERT INTO juegos_generos (ID_juego, ID_genero) VALUES (5, 3);

INSERT INTO Lanzamientos (ID_juego, ID_consola, fecha_lanzamiento) VALUES (1, 2, '10-12-2020');
INSERT INTO Lanzamientos (ID_juego, ID_consola, fecha_lanzamiento) VALUES (1, 3, '14-02-2022');
INSERT INTO Lanzamientos (ID_juego, ID_consola, fecha_lanzamiento) VALUES (1, 4, '14-02-2022');
INSERT INTO Lanzamientos (ID_juego, ID_consola, fecha_lanzamiento) VALUES (2, 5, '03-03-2017');
INSERT INTO Lanzamientos (ID_juego, ID_consola, fecha_lanzamiento) VALUES (3, 2, '26-10-2018');
INSERT INTO Lanzamientos (ID_juego, ID_consola, fecha_lanzamiento) VALUES (4, 2, '04-09-2014');
INSERT INTO Lanzamientos (ID_juego, ID_consola, fecha_lanzamiento) VALUES (4, 5, '12-05-2017');
INSERT INTO Lanzamientos (ID_juego, ID_consola, fecha_lanzamiento) VALUES (5, 1, '09-09-1998');

--Consultas

--1
select v.titulo from videojuegos v join desarrolladores d on v.id_desarrolladora = d.id where d.pais_origen = 'Japón';

--2
select v.titulo from videojuegos v join desarrolladores d on v.id_desarrolladora = d.id WHERE CAST(REPLACE(v.pegi, '+', '') AS INTEGER) >= (
    SELECT MAX(CAST(REPLACE(v.pegi, '+', '') AS INTEGER))
    FROM videojuegos v
    JOIN desarrolladores d ON v.id_desarrolladora = d.id
    WHERE d.pais_origen = 'Suecia');
    
--3
select d.nombre from videojuegos v join desarrolladores d on v.id=d.id join lanzamientos l on v.id = l.id_juego where l.fecha_lanzamiento> '01-01-2015';

--4

select v.titulo from videojuegos v join lanzamientos l on l.id_juego = v.id
group by v.titulo having count(distinct l.id_consola) > (select count(l.id_consola) from lanzamientos l,videojuegos v where l.id_juego = v.id and v.titulo = 'Cyberpunk 2077');


--6
select g.nombre from generos g join juegos_generos on g.id = juegos_generos.id_genero and g.id not in(select g.id from generos g join juegos_generos on g.id = juegos_generos.id_genero);

--7

select v.titulo from videojuegos v join lanzamientos l on l.id_juego = v.id and l.id_consola = 1;

--8
select d.nombre from desarrolladores d where d.año_fundacion < (select min(d.año_fundacion) from desarrolladores d where d.pais_origen = 'Estados Unidos');

--9

select * from videojuegos v join juegos_generos j on v.id = j.id_juego join generos g on j.id_juego = g.id where g.nombre != '3rd Person Shooter';

--10

select v.titulo from videojuegos v  where v.titulo like 'The%';

--11

select g.nombre from generos g where g.nombre like '________';

--12

select d.nombre, c.nombre from consolas c join lanzamientos l on c.id = l.id_consola join videojuegos v on l.id_juego = v.id join desarrolladores d on v.id_desarrolladora = d.id; 

--13

select v.titulo from videojuegos v join juegos_generos j on v.id = j.id_juego where (select count(j.id_genero) from juegos_generos j group by (j.id_juego));

--21

select d.nombre from desarrolladores d join videojuegos v on d.id = v.id_desarrolladora join lanzamientos l on v.id = l.id_juego;
