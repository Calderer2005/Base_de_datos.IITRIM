CREATE TABLE videojuegos (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Titulo VARCHAR(50) NOT NULL,
    PEGI CHAR(3) CHECK (PEGI IN ('+3', '+7', '+12', '+16', '+18')),
    ID_desarrolladora INT,
    FOREIGN KEY (ID_desarrolladora) REFERENCES Desarrolladores(ID)
);
CREATE TABLE consolas (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(25) NOT NULL,
    ID_Fabricante INT,
    FechaLanzamiento DATE,
    Generación INT NOT NULL CHECK (Generación > 0 AND Generación < 10),
    FOREIGN KEY (ID_Fabricante) REFERENCES Desarrolladores(ID)
);
CREATE TABLE lanzamientos (
    ID INT,
    ID_Consola INT,
    FechaLanzamiento DATE,
    PRIMARY KEY (ID_Juego, ID_Consola),
    FOREIGN KEY (ID_Juego) REFERENCES Videojuegos(ID),
    FOREIGN KEY (ID_Consola) REFERENCES Consolas(ID)
);
CREATE TABLE Generos (
    ID_genero INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(25) NOT NULL
);
CREATE TABLE juego_genero (
    ID_juego INT,
    ID_genero INT,
    PRIMARY KEY (ID_juego, ID_genero),
    FOREIGN KEY (ID_juego) REFERENCES Videojuegos(ID),
    FOREIGN KEY (ID_genero) REFERENCES Generos(ID)
);
CREATE TABLE desarrolladores (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(50) NOT NULL,
    PaisOrig en VARCHAR(50) NOT NULL,
    AñoFundacion INT
);

/*Valores de la Tabla*/

/*Videojuegos*/

INSERT INTO videojuegos(ID_videojuegos, Titulo, PEGI, ID_desarrolladora) VALUES
    (1, 'Cyberpunk 2077', '+18' , 1);
INSERT INTO videojuegos(ID_videojuegos, Titulo, PEGI, ID_desarrolladora) VALUES
    (2, 'The Legend of Zeld Breath of the Wild', '+12' ,2 );
INSERT INTO videojuegos(ID_videojuegos, Titulo, PEGI, ID_desarrolladora) VALUES
    (3, 'Red Dead Redemption 2', '+18' ,3 );
INSERT INTO videojuegos(ID_videojuegos, Titulo, PEGI, ID_desarrolladora) VALUES
    (4, 'Minecraft', '+7' ,4);
INSERT INTO videojuegos(ID_videojuegos, Titulo, PEGI, ID_desarrolladora) VALUES
    (5, 'Spyro the Dragon','+3'  ,6);

/*lANZAMIENTO*/

INSERT INTO lanzamientos(ID_Juego, ID_Consola, FechaLanzamiento) VALUES 
    (1 , 2 , '10/12/2020');
INSERT INTO lanzamientos(ID_Juego, ID_Consola, FechaLanzamiento) VALUES 
    (1 , 3 , '1 3 14/02/2022');
INSERT INTO lanzamientos(ID_Juego, ID_Consola, FechaLanzamiento) VALUES 
    (1 , 4 , '14/02/2022');
INSERT INTO lanzamientos(ID_Juego, ID_Consola, FechaLanzamiento) VALUES 
    (2 , 5 , '03/03/2017');
INSERT INTO lanzamientos(ID_Juego, ID_Consola, FechaLanzamiento) VALUES 
    (3 , 2 , '26/10/2018');
INSERT INTO lanzamientos(ID_Juego, ID_Consola, FechaLanzamiento) VALUES 
    (4 , 2 , '04/09/2014');
INSERT INTO lanzamientos(ID_Juego, ID_Consola, FechaLanzamiento) VALUES 
    (4 , 5 , '12/05/2017');
INSERT INTO lanzamientos(ID_Juego, ID_Consola, FechaLanzamiento) VALUES 
    (5 , 1 , '09/09/1998');

/*CONSOLA*/

INSERT INTO consolas (Nombre, ID_Fabricante, FechaLanzamiento, Generación)VALUES
    ('PlayStation 5', 3, '1994-12-03', 5),
INSERT INTO consolas (Nombre, ID_Fabricante, FechaLanzamiento, Generación)VALUES
    ('PlayStation 4', 5, '2013-11-15', 8),
INSERT INTO consolas (Nombre, ID_Fabricante, FechaLanzamiento, Generación)VALUES
    ('PlayStation 5', 5, '2020-11-12', 9),
INSERT INTO consolas (Nombre, ID_Fabricante, FechaLanzamiento, Generación)VALUES
    ('XBOX Series X', 7, '2020-11-10', 9),
INSERT INTO consolas (Nombre, ID_Fabricante, FechaLanzamiento, Generación)VALUES
    ('Nintendo Switch', 2, '2017-03-03', 8);

/*GENERO*/

INSERT INTO Generos (ID, Nombre)VALUES
    (1, 'RPG'),
INSERT INTO Generos (ID, Nombre)VALUES
    (2, 'Aventura'),
INSERT INTO Generos (ID, Nombre)VALUES
    (3, 'Acción'),
INSERT INTO Generos (ID, Nombre)VALUES
    (4, 'Sandbox'),
INSERT INTO Generos (ID, Nombre)VALUES
    (5, '3rd Person Shooter');

/*Juego_Genero*/

INSERT INTO Juego_Genero (ID_juego, ID_genero)VALUES
    (1, 1),
INSERT INTO Juego_Genero (ID_juego, ID_genero)VALUES
    (1, 3),
INSERT INTO Juego_Genero (ID_juego, ID_genero)VALUES
    (1, 5),
INSERT INTO Juego_Genero (ID_juego, ID_genero)VALUES
    (2, 2),
INSERT INTO Juego_Genero (ID_juego, ID_genero)VALUES
    (2, 3),
INSERT INTO Juego_Genero (ID_juego, ID_genero)VALUES
    (3, 3),
INSERT INTO Juego_Genero (ID_juego, ID_genero)VALUES
    (3, 4),
INSERT INTO Juego_Genero (ID_juego, ID_genero)VALUES
    (3, 5),
INSERT INTO Juego_Genero (ID_juego, ID_genero)VALUES
    (4, 4),
INSERT INTO Juego_Genero (ID_juego, ID_genero)VALUES
    (5, 2),
INSERT INTO Juego_Genero (ID_juego, ID_genero)VALUES
    (5, 3);

/*Desarrolladores*/

INSERT INTO Desarrolladoras (ID, Nombre, PaisOrigen, AñoFundación)VALUES
    (1, 'CD Projekt Red', 'Polonia', 1994),
INSERT INTO Desarrolladoras (ID, Nombre, PaisOrigen, AñoFundación)VALUES
    (2, 'Nintendo EPD', 'Japón', 1889),
INSERT INTO Desarrolladoras (ID, Nombre, PaisOrigen, AñoFundación)VALUES
    (3, 'Rockstar Games', 'Estados Unidos', 1998),
INSERT INTO Desarrolladoras (ID, Nombre, PaisOrigen, AñoFundación)VALUES
    (4, 'Mojang Studios', 'Suecia', 2009),
INSERT INTO Desarrolladoras (ID, Nombre, PaisOrigen, AñoFundación)VALUES
    (5, 'Sony Interactive', 'Japón', 1993),
INSERT INTO Desarrolladoras (ID, Nombre, PaisOrigen, AñoFundación)VALUES
    (6, 'Insomniac Games', 'Estados Unidos', 1994),
INSERT INTO Desarrolladoras (ID, Nombre, PaisOrigen, AñoFundación)VALUES
    (7, 'Microsoft', 'Estados Unidos', 1975);

/*Consultas*/

/*1*/
SELECT v.Titulo FROM videojuegos v JOIN desarrolladores d 
    ON v.ID_desarrolladora = d.ID WHERE d.PaisOrigen = 'Japón';
/*2*/
SELECT v.Titulo FROM videojuegos v JOIN desarrolladores d ON v.ID_desarrolladora = d.ID
    WHERE v.PEGI > ( SELECT PEGI FROM videojuegos v2 JOIN desarrolladores d2 ON v2.ID_desarrolladora = d2.ID WHERE d2.PaisOrigen = 'Suecia' LIMIT 1
);
/*3*/
SELECT DISTINCT d.Nombre FROM desarrolladores d JOIN videojuegos v ON d.ID = v.ID_desarrolladora
    JOIN lanzamientos l ON v.ID = l.ID_Juego WHERE l.FechaLanzamiento > '2015-01-01';
/*4*/
SELECT v.Titulo FROM videojuegos v JOIN lanzamientos l ON v.ID = l.ID_Juego GROUP BY v.Titulo
    HAVING COUNT(l.ID_Consola) > ( SELECT COUNT(l2.ID_Consola) FROM lanzamientos l2
        JOIN videojuegosv2 ON l2.ID_Juego = v2.IDWHERE v2.Titulo = 'Cyberpunk 2077'
);
/*5*/
SELECT c.Nombre FROM consolas c WHERE c.FechaLanzamiento > (
    SELECT MIN(c2.FechaLanzamiento) FROM consolas c2 JOIN desarrolladores d 
        ON c2.ID_Fabricante = d.ID WHERE d.Nombre LIKE 'Nintendo%'
);
/*6*/
SELECT g.ID_genero, g.Nombre FROM generos g 
    LEFT JOIN juego_genero jg ON g.ID_genero = JG.ID_genero WHERE JG.ID_Juego is NULL;
/*7*/
SELECT v.Titulo, C.Nombre AS consolas, l.FechaLanzamiento FROM videojuegos v 
    JOIN lanzamientos l ON v.ID = l.ID_Juego JOIN consolas ON l.ID_Consola = c.ID
        JOIN desarrolladores d on c.ID_Fabricante = d.ID WHERE d.Nombre = 'Sony Interactive'
/*8*/
SELECT d.Nombre, d.PaisOrig, d.AñoFundacion 
    FROM desarrolladores d WHERE d.AñoFundacion 
        <(SELECT MIN (d2.AñoFundacion) FROM desarrolladores d2 WHERE d2.PaisOrig = 'Estados Unidos ');
/*9*/
SELECT v.Titulo FROM Videojuegos v JOIN Juego_Genero jg ON v.ID = jg.ID_juego
    JOIN Generos g ON jg.ID_genero = g.ID_genero WHERE NOT EXISTS (SELECT 1
        FROM Juego_Genero jg2 JOIN Generos g2 ON jg2.ID_genero = g2.ID_genero
            WHERE jg2.ID_juego = v.ID AND g2.Nombre = '3rd Person Shooter'
);
/*10*/
SELECT Titulo FROM Videojuegos WHERE Titulo LIKE 'The%';
/*11*/
SELECT Nombre FROM Generos WHERE LENGTH(Nombre) = 8;
/*12*/
SELECT d.Nombre AS Desarrolladora, c.Nombre AS Consola FROM Desarrolladores d
    JOIN Consolas c ON d.ID = c.ID_Fabricante;
/*13*/
SELECT v.Titulo FROM Videojuegos v JOIN Juego_Genero jg ON v.ID = jg.ID_juego
    GROUP BY v.ID HAVING COUNT(jg.ID_genero) > 1;
/*14*/
SELECT g.Nombre, COUNT(jg.ID_juego) AS JuegosAsignados FROM Generos g 
    LEFT JOIN Juego_Genero jg ON g.ID_genero = jg.ID_genero GROUP BY g.ID_genero;
/*15*/
SELECT c.Nombre AS Consola, MAX(l.FechaLanzamiento) AS UltimoLanzamiento
    FROM Consolas c JOIN Lanzamientos l ON c.ID = l.ID_Consola GROUP BY c.ID;
/*16*/
ALTER TABLE Consolas DROP COLUMN Generacion;
/*17*/
DELETE FROM Lanzamientos WHERE ID_Consola = (
    SELECT ID FROM Consolas WHERE Nombre = 'PlayStation 1');
/*18*/
SELECT d.Nombre, AVG
            (CASE
                    WHEN v.PEGI = '+18' THEN 18
                    WHEN v.PEGI = '+16' THEN 16
                    WHEN v.PEGI = '+12' THEN 12
                    WHEN v.PEGI = '+7' THEN 7
                    ELSE 3

            END) AS PromedioPEGI
    FROM Desarrolladores d JOIN Videojuegos v ON d.ID = v.ID_desarrolladora
    GROUP BY d.IDHAVING AVG
            (CASE
                    WHEN v.PEGI = '+18' THEN 18
                    WHEN v.PEGI = '+16' THEN 16
                    WHEN v.PEGI = '+12' THEN 12
                    WHEN v.PEGI = '+7' THEN 7
                    ELSE 3
            END) > (SELECT AVG(CASE
                    WHEN v2.PEGI = '+18' THEN 18
                    WHEN v2.PEGI = '+16' THEN 16
                    WHEN v2.PEGI = '+12' THEN 12
                    WHEN v2.PEGI = '+7' THEN 7
                    ELSE 3 
            END)
    FROM Videojuegos v2 JOIN Desarrolladores d2 ON v2.ID_desarrolladora = d2.ID
        WHERE d2.PaisOrigen = d.PaisOrigen);
/*19*/
SELECT d.Nombre FROM Desarrolladores d JOIN Videojuegos v ON d.ID = v.ID_desarrolladora
    JOIN Juego_Genero jg ON v.ID = jg.ID_juego GROUP BY d.ID
        HAVING COUNT(DISTINCT jg.ID_genero) = (SELECT COUNT(*) FROM Generos);
/*20*/
SELECT g.Nombre, COUNT(jg.ID_juego) AS JuegosLanzados FROM Generos g JOIN Juego_Genero jg 
    ON g.ID_genero = jg.ID_genero JOIN Videojuegos v ON jg.ID_juego = v.ID JOIN Lanzamientos l ON v.ID = l.ID_Juego
        JOIN Consolas c ON l.ID_Consola = c.ID WHERE c.Generacion = 9 GROUP BY g.ID_genero
            ORDER BY JuegosLanzados DESC LIMIT 1;
/*21*/
SELECT d.Nombre FROM Desarrolladores d JOIN Videojuegos v ON d.ID = v.ID_desarrolladora
    JOIN Juego_Genero jg ON v.ID = jg.ID_juego GROUP BY d.ID HAVING COUNT
    (DISTINCT jg.ID_genero)  = (SELECT COUNT(*) FROM Generos);
/*22*/
SELECT v.Titulo FROM Videojuegos v JOIN Lanzamientos l ON v.ID = l.ID_Juego JOIN Consolas c 
    ON l.ID_Consola = c.ID GROUP BY v.ID HAVING COUNT(DISTINCT c.Generación) >= 3;
/*23*/
SELECT v.Titulo FROM Videojuegos v JOIN Lanzamientos l ON v.ID = l.ID_Juego JOIN Consolas c 
    ON l.ID_Consola = c.ID WHERE c.ID_Fabricante = 5  HAVING COUNT
        (DISTINCT c.ID) = (SELECT COUNT(*) FROM Consolas WHERE ID_Fabricante = 5);
/*24*/
SELECT c.Nombre AS Consola, g.Nombre AS Genero,
       (COUNT(jg.ID_juego) * 100.0 / (SELECT COUNT(*) FROM Lanzamientos l2 WHERE l2.ID_Consola = c.ID)) AS Porcentaje
    FROM Consolas c JOIN Lanzamientos l ON c.ID = l.ID_Consola JOIN Videojuegos v ON l.ID_Juego = v.ID
        JOIN Juego_Genero jg ON v.ID = jg.ID_juego JOIN Generos g ON jg.ID_genero = g.ID GROUP BY c.ID, g.ID;
/*25*/
SELECT v.Titulo FROM Videojuegos v JOIN Lanzamientos l ON v.ID = l.ID_Juego
    JOIN Consolas c ON l.ID_Consola = c.ID WHERE c.is_supported = 0;

/*26*/
SELECT c.Nombre AS Consola, COUNT(DISTINCT g.ID) AS Generos_Lanzados FROM Consolas c
    JOIN Lanzamientos l ON c.ID = l.ID_Consola JOIN Videojuegos v ON l.ID_Juego = v.ID JOIN Juego_Genero jg ON v.ID = jg.ID_juego
        JOIN Generos g ON jg.ID_genero = g.ID WHERE YEAR(l.FechaLanzamiento) = (SELECT MIN(YEAR(FechaLanzamiento)) 
            FROM Lanzamientos WHERE ID_Consola = c.ID) GROUP BY c.ID;
