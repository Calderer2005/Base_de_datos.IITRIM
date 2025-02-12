CREATE TABLE Desarrolladoras (
  ID INT PRIMARY KEY CHECK (ID > 0),
  Nombre VARCHAR2(25) NOT NULL,
  PaisOrigen VARCHAR2(50),
  AnioFund INT CHECK (AnioFund BETWEEN 1850 AND 2025)
);

CREATE TABLE Videojuegos (
  ID INT PRIMARY KEY CHECK (ID > 0),
  Titulo VARCHAR2(50) NOT NULL,
  PEGI INT CHECK (PEGI IN (3, 7, 12, 16, 18)),
  ID_Desa INT,
  
  CONSTRAINT fk_vid_desa FOREIGN KEY (ID_Desa) REFERENCES Desarrolladoras(ID)
);

CREATE TABLE Consolas (
  ID INT PRIMARY KEY CHECK (ID > 0),
  Nombre VARCHAR2(25) NOT NULL,
  ID_Fab INT,       
  FechaLanz DATE,
  Generacion NUMERIC(1),
  
  CONSTRAINT fk_cons_desa FOREIGN KEY(ID_Fab) REFERENCES Desarrolladoras(ID)
);

CREATE TABLE Generos (
  ID INT PRIMARY KEY CHECK (ID > 0),
  Nombre VARCHAR2(25) NOT NULL UNIQUE
);

CREATE TABLE Lanzamientos (
  ID_Juego INT,
  ID_Cons INT,
  FechaLanz DATE,
  PRIMARY KEY (ID_Juego, ID_Cons),
  FOREIGN KEY (ID_Juego) REFERENCES Videojuegos(ID),
  FOREIGN KEY (ID_Cons) REFERENCES Consolas(ID)
);

CREATE TABLE Juego_Genero (
  ID_juego INT,
  ID_Genero INT,
  PRIMARY KEY (ID_juego, ID_Genero),
  FOREIGN KEY (ID_juego) REFERENCES Videojuegos(ID),
  FOREIGN KEY (ID_Genero) REFERENCES Generos(ID)
);

INSERT INTO Desarrolladoras (ID, Nombre, PaisOrigen, AnioFund) VALUES
(1, 'CD Projekt Red', 'Polonia', 1994);
INSERT INTO Desarrolladoras (ID, Nombre, PaisOrigen, AnioFund) VALUES
(2, 'Nintendo EPD', 'Japón', 1889);
INSERT INTO Desarrolladoras (ID, Nombre, PaisOrigen, AnioFund) VALUES
(3, 'Rockstar Games', 'Estados Unidos', 1988);
INSERT INTO Desarrolladoras (ID, Nombre, PaisOrigen, AnioFund) VALUES
(4, 'Mojang Studios', 'Suecia', 2009);
INSERT INTO Desarrolladoras (ID, Nombre, PaisOrigen, AnioFund) VALUES
(5, 'Sony Interactive', 'Japón', 1993);
INSERT INTO Desarrolladoras (ID, Nombre, PaisOrigen, AnioFund) VALUES
(6, 'Insomniac Games', 'Estados Unidos', 1994);
INSERT INTO Desarrolladoras (ID, Nombre, PaisOrigen, AnioFund) VALUES
(7, 'Microsoft', 'Estados Unidos', 1975);

INSERT INTO Consolas (ID, Nombre, ID_Fab, FechaLanz, Generacion) VALUES
(1, 'PlayStation', 5, '03-12-1994', 5);
INSERT INTO Consolas (ID, Nombre, ID_Fab, FechaLanz, Generacion) VALUES
(2, 'PlayStation 4', 5, '15-11-2013', 8);
INSERT INTO Consolas (ID, Nombre, ID_Fab, FechaLanz, Generacion) VALUES
(3, 'PlayStation 5', 5, '12-11-2020', 9);
INSERT INTO Consolas (ID, Nombre, ID_Fab, FechaLanz, Generacion) VALUES
(4, 'Xbox Series X', 7, '10-11-2020', 9);
INSERT INTO Consolas (ID, Nombre, ID_Fab, FechaLanz, Generacion) VALUES
(5, 'Nintendo Switch', 2, '03-03-2017', 8);

INSERT INTO Videojuegos (ID, Titulo, PEGI, ID_desa) VALUES
(1, 'Cyberpunk 2077', 18, 1);
INSERT INTO Videojuegos (ID, Titulo, PEGI, ID_desa) VALUES
(2, 'The Legend of Zelda: Breath of the Wild', 12, 2);
INSERT INTO Videojuegos (ID, Titulo, PEGI, ID_desa) VALUES
(3, 'Red Dead Redemption 2', 18, 3);
INSERT INTO Videojuegos (ID, Titulo, PEGI, ID_desa) VALUES
(4, 'Minecraft', 7, 4);
INSERT INTO Videojuegos (ID, Titulo, PEGI, ID_desa) VALUES
(5, 'Spyro the Dragon', 3, 6);

INSERT INTO Videojuegos VALUES (6, 'Ratchet And Clank', 3, 6);
INSERT INTO Videojuegos VALUES (7, 'Marvels Spider-Man', 16, 6);

INSERT INTO Generos (ID, Nombre) VALUES (1, 'RPG');
INSERT INTO Generos (ID, Nombre) VALUES (2, 'Aventura');
INSERT INTO Generos (ID, Nombre) VALUES (3, 'Acción');
INSERT INTO Generos (ID, Nombre) VALUES (4, 'Sandbox');
INSERT INTO Generos (ID, Nombre) VALUES (5, '3rd Person Shooter');
INSERT INTO Generos (ID, Nombre) VALUES (6, 'Ritmo');
INSERT INTO Generos (ID, Nombre) VALUES (7, 'MMO');

INSERT INTO Juego_Genero (ID_juego, ID_genero) VALUES (1, 1); -- Cyberpunk: RPG
INSERT INTO Juego_Genero (ID_juego, ID_genero) VALUES (1, 3); -- Cyberpunk: Acción
INSERT INTO Juego_Genero (ID_juego, ID_genero) VALUES (1, 5); -- Cyberpunk: 3rd Person Shooter
INSERT INTO Juego_Genero (ID_juego, ID_genero) VALUES (2, 2); -- Zelda: Aventura
INSERT INTO Juego_Genero (ID_juego, ID_genero) VALUES (2, 3); -- Zelda: Acción
INSERT INTO Juego_Genero (ID_juego, ID_genero) VALUES (3, 3); -- Red Dead 2: Acción
INSERT INTO Juego_Genero (ID_juego, ID_genero) VALUES (3, 4); -- Red Dead 2: Sandbox
INSERT INTO Juego_Genero (ID_juego, ID_genero) VALUES (3, 5); -- Red Dead 2: 3rd Person Shooter
INSERT INTO Juego_Genero (ID_juego, ID_genero) VALUES (4, 4); -- Minecraft: Sandbox
INSERT INTO Juego_Genero (ID_juego, ID_genero) VALUES (5, 2); -- Spyro: Aventura
INSERT INTO Juego_Genero (ID_juego, ID_genero) VALUES (5, 3); -- Spyro: Acción
INSERT INTO Juego_Genero (ID_juego, ID_genero) VALUES (6, 5); -- Ratchet And Clank: 3rd Person Shooter
INSERT INTO Juego_Genero (ID_juego, ID_genero) VALUES (7, 2);
INSERT INTO Juego_Genero (ID_juego, ID_genero) VALUES (7, 3);
INSERT INTO Juego_Genero (ID_juego, ID_genero) VALUES (7, 4);
INSERT INTO Juego_Genero (ID_juego, ID_genero) VALUES (7, 1);

INSERT INTO Lanzamientos (ID_Juego, ID_Cons, FechaLanz) VALUES
(1, 2, '10-12-2020'); -- Cyberpunk en PS4
INSERT INTO Lanzamientos (ID_Juego, ID_Cons, FechaLanz) VALUES
(1, 3, '14-02-2022'); -- Cyberpunk en PS5
INSERT INTO Lanzamientos (ID_Juego, ID_Cons, FechaLanz) VALUES
(1, 4, '14-02-2022'); -- Cyberpunk en XBOX
INSERT INTO Lanzamientos (ID_Juego, ID_Cons, FechaLanz) VALUES
(2, 5, '03-03-2017'); -- Zelda en Switch
INSERT INTO Lanzamientos (ID_Juego, ID_Cons, FechaLanz) VALUES
(3, 2, '26-10-2018'); -- Red Dead 2 en PS4
INSERT INTO Lanzamientos (ID_Juego, ID_Cons, FechaLanz) VALUES
(4, 2, '04-09-2014'); -- Minecraft en PS4
INSERT INTO Lanzamientos (ID_Juego, ID_Cons, FechaLanz) VALUES
(4, 5, '12-05-2017'); -- Minecraft en Switch
INSERT INTO Lanzamientos (ID_Juego, ID_Cons, FechaLanz) VALUES
(5, 1, '09-09-1998'); -- Spyro en PS1

INSERT INTO Lanzamientos (ID_Juego, ID_Cons, FechaLanz) VALUES
(7, 2, '07-09-2018'); -- Spider-Man PS4
INSERT INTO Lanzamientos (ID_Juego, ID_Cons, FechaLanz) VALUES
(7, 3, '12-11-2020'); -- Spider-Man en PS5

INSERT INTO Lanzamientos (ID_Juego, ID_Cons, FechaLanz) VALUES
(5, 2, '18-11-2018');

INSERT INTO Lanzamientos (ID_Juego, ID_Cons, FechaLanz) VALUES
(5, 3, '18-11-2018');


-- 18
SELECT DISTINCT de.nombre 
FROM desarrolladoras de JOIN videojuegos vi ON de.id=vi.id_desa
WHERE vi.pegi > (SELECT AVG(PEGI) 
                    FROM videojuegos vi2 JOIN desarrolladoras de2 ON vi2.id_desa=de2.id
                    WHERE de2.paisorigen=de.paisorigen);
                    
-- 19
SELECT DISTINCT de.nombre, COUNT(DISTINCT jg.id_genero)
FROM desarrolladoras de JOIN videojuegos vi ON de.id=vi.id_desa
    JOIN juego_genero jg ON vi.id=jg.id_juego
GROUP BY de.nombre
HAVING COUNT(DISTINCT jg.id_genero) = (SELECT COUNT(*)
                                        FROM generos);
                                        
-- 20                           
SELECT g.nombre
FROM generos g JOIN juego_genero jg ON g.id=jg.id_genero
            JOIN videojuegos v ON jg.id_juego=v.id
            JOIN lanzamientos l ON l.id_juego=v.id
            JOIN consolas c ON l.id_cons=c.id
WHERE c.generacion = 9
GROUP BY g.nombre
HAVING COUNT(jg.id_genero) >= ALL (SELECT COUNT(jg.id_genero) cnt
                                 FROM generos g JOIN juego_genero jg ON g.id=jg.id_genero
                                                JOIN videojuegos v ON jg.id_juego=v.id
                                                JOIN lanzamientos l ON l.id_juego=v.id
                                                JOIN consolas c ON l.id_cons=c.id
                                WHERE c.generacion = 9
                                GROUP BY g.nombre);

-- 21
SELECT de.nombre 
FROM desarrolladoras de JOIN videojuegos vid ON de.id=vid.id_desa
                    JOIN juego_genero jg ON vid.id=jg.id_juego
GROUP BY de.nombre
HAVING COUNT(DISTINCT jg.id_genero) = (SELECT COUNT(*) FROM generos);

-- 22 
SELECT vid.titulo
FROM videojuegos vid JOIN lanzamientos lz ON vid.id=lz.id_juego
                    JOIN consolas con ON lz.id_cons=con.id
GROUP BY vid.titulo
HAVING COUNT(DISTINCT con.generacion) = 3;

-- 23
SELECT vid.titulo
FROM videojuegos vid JOIN lanzamientos lz ON vid.id=lz.id_juego
                    JOIN consolas con ON lz.id_cons=con.id
                    JOIN desarrolladoras des ON con.id_fab=des.id
WHERE des.nombre='Sony Interactive'
GROUP BY vid.titulo
HAVING COUNT(DISTINCT con.id) = (SELECT COUNT(cons.id)
                                FROM consolas cons JOIN desarrolladoras de ON cons.id_fab=de.id
                                WHERE de.nombre='Sony Interactive');
                            
-- 24                           
SELECT con.nombre, g.nombre, count(DISTINCT jg.id_juego), cont, TRUNC((COUNT(DISTINCT jg.id_juego)/cont)*100, 2)
FROM consolas con JOIN lanzamientos lz ON con.id=lz.id_cons
                    JOIN videojuegos vid ON lz.id_juego=vid.id
                    JOIN juego_genero jg ON jg.id_juego=vid.id
                    JOIN generos g ON g.id=jg.id_genero
                    JOIN (SELECT lanz.id_cons as consolas, COUNT(lanz.id_juego) as cont 
                                FROM lanzamientos lanz
                            GROUP BY lanz.id_cons) ON con.id=consolas
GROUP BY con.nombre, g.nombre, cont;

-- 25
SELECT DISTINCT vid.titulo
FROM videojuegos vid JOIN lanzamientos lz ON vid.id=lz.id_juego
                    JOIN consolas con ON con.id=lz.id_cons
WHERE con.fechalanz NOT IN (SELECT MAX(fechalanz)
                            FROM consolas con JOIN desarrolladoras des ON con.id_fab=des.id
                            GROUP BY des.id);
            
-- 26                
SELECT COUNT(DISTINCT jg.id_genero)
FROM juego_genero jg JOIN lanzamientos lz ON jg.id_juego=lz.id_juego
                    JOIN consolas con ON lz.id_cons=con.id
WHERE lz.fechalanz BETWEEN con.fechalanz AND ADD_MONTHS(con.fechalanz, 12);

SELECT vi.*
FROM videojuegos vi JOIN lanzamientos lz ON vi.id=lz.id_juego
                    JOIN consolas con ON lz.id_cons=con.id
WHERE lz.fechalanz BETWEEN con.fechalanz AND ADD_MONTHS(con.fechalanz, 12);


-- 36

SELECT nombre FROM desarrolladoras
WHERE id IN (

SELECT de.id FROM desarrolladoras de

MINUS

(SELECT id_fab FROM consolas

UNION 

SELECT vi.id_desa FROM videojuegos vi JOIN juego_genero jg ON vi.id=jg.id_juego
                                    JOIN generos g ON jg.id_genero=g.id
WHERE g.nombre='Sandbox'));

-- 37

SELECT nombre FROM generos
WHERE id IN
((SELECT id FROM generos

MINUS

(SELECT jg.id_genero FROM juego_genero jg JOIN lanzamientos lz ON jg.id_juego=lz.id_juego
                                        JOIN consolas c ON lz.id_cons=c.id
                                        JOIN desarrolladoras d ON c.id_fab=d.id
WHERE d.nombre LIKE 'Nintendo%'
UNION
SELECT jg.id_genero FROM juego_genero jg JOIN lanzamientos lz ON jg.id_juego=lz.id_juego
                                        JOIN consolas c ON lz.id_cons=c.id
                                        JOIN desarrolladoras d ON c.id_fab=d.id
WHERE d.nombre LIKE 'Microsoft%'))

UNION

(SELECT jg.id_genero FROM juego_genero jg JOIN lanzamientos lz ON jg.id_juego=lz.id_juego
                                        JOIN consolas c ON lz.id_cons=c.id
WHERE c.generacion < 8

UNION

SELECT jg.id_genero FROM juego_genero jg JOIN lanzamientos lz ON jg.id_juego=lz.id_juego
                                        JOIN videojuegos vi ON lz.id_juego=vi.id
                                        JOIN desarrolladoras de ON vi.id_desa=de.id
WHERE de.nombre LIKE 'CD%P%R%'));
