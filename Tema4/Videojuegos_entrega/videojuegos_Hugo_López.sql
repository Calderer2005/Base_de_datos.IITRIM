CREATE TABLE videojuegos
(
    id NUMBER(3) PRIMARY KEY CHECK (('id' > 0)),
    titulo VARCHAR2(50) NOT NULL,
    pegi VARCHAR2(3) SET('+3', '+7', '+12', '+16', '+18') NOT NULL,
    id_desarrolladora NUMBER(3) NOT NULL,
    FOREIGN KEY (id_desarrolladora) REFERENCES desarrolladores(id)
);
CREATE TABLE lanzamientos
(
    id_juego NUMBER(3),
    id_consola NUMBER(3),
    fecha_lanzamiento DATE,
    PRIMARY KEY (id_Juego, id_Consola),
    FOREIGN KEY (id_Juego) REFERENCES Videojuegos(id),
    FOREIGN KEY (id_Consola) REFERENCES Consolas(id)
);
CREATE TABLE consolas
(
    id NUMBER(3) PRIMARY KEY CHECK (id > 0),
    nombre VARCHAR2(25) NOT NULL,
    id_fabricante NUMBER(3),
    fecha_lanzamiento DATE,
    generación NUMBER(1) NOT NULL CHECK generación > 0,
    FOREIGN KEY (id_fabricante) REFERENCES desarrolladores(id)
);
CREATE TABLE generos
(
    id NUMBER(3) PRIMARY KEY CHECK id > 0,
    nombre VARCHAR2(25) NOT NULL
);
CREATE TABLE juego_genero
(
    id_juego NUMBER(3),
    id_genero NUMBER(3),
    CONSTRAINT pk_id PRIMARY KEY (id_juego, id_genero),
    CONSTRAINT fk_id_juego FOREIGN KEY (id_juego) REFERENCES videojuegos(id),
    CONSTRAINT fk_id_genero FOREIGN KEY (id_genero) REFERENCES generos(id)
);
CREATE TABLE desarrolladores
(
    id INT PRIMARY KEY,
    nombre VARCHAR(25) NOT NULL,
    pais_origen VARCHAR(50),
    año_fundacion DATE
);    


INSERT INTO desarrolladores VALUES(1, 'ProjektRed', 'Polonia', 1994);
INSERT INTO desarrolladores VALUES(2, 'Nintendo EPD', 'Japón', 1889);
INSERT INTO desarrolladores VALUES(3, 'Rockstargames', 'Estados Unidos' 1998);
INSERT INTO desarrolladores VALUES(4, 'Mojang Studios', 'Suecia', 2009);
INSERT INTO desarrolladores VALUES(5, 'Sony interactive', 'Japón', 1993);
INSERT INTO desarrolladores VALUES(6, 'Insomniac Games', 'Estados Unidos', 1994);
INSERT INTO desarrolladores VALUES(7, 'Microsoft', 'Estados Unidos', 1975);

INSERT INTO videojuegos VALUES(1, 'Cyberpunk 77', '+18', 1);
INSERT INTO videojuegos VALUES(2, 'Legend of Zelda', '+12', 2);
INSERT INTO videojuegos VALUES(3, 'Red Dead Redemption 2', '+18', 3);
INSERT INTO videojuegos VALUES(4, 'Minecraft', '+7', 4);
INSERT INTO videojuegos VALUES(5, 'Spyro the dragon', '+3', 6);


INSERT INTO Consolas VALUES(1, 'PlayStation 1', 5, '1994-12-03', 5);
INSERT INTO Consolas VALUES(2, 'PlayStation 4', 5, '2013-11-15', 8);
INSERT INTO Consolas VALUES(3, 'PlayStation 5', 5, '2020-11-12', 9);
INSERT INTO Consolas VALUES(4, 'XBOX Series X', 7, '2020-11-10', 9);
INSERT INTO Consolas VALUES(5, 'Nintendo Switch', 2, '2017-03-03', 8);

-- Insertar géneros
INSERT INTO Generos VALUES(1, 'RPG');
INSERT INTO Generos VALUES(2, 'Aventura');
INSERT INTO Generos VALUES(3, 'Acción');
INSERT INTO Generos VALUES(4, 'Sandbox');
INSERT INTO Generos VALUES(5, '3rd Person Shooter');

-- Insertar relación Juego-Género
INSERT INTO Juego_Genero VALUES(1, 1);
INSERT INTO Juego_Genero VALUES(1, 3);
INSERT INTO Juego_Genero VALUES(1, 5);
INSERT INTO Juego_Genero VALUES(2, 2);
INSERT INTO Juego_Genero VALUES(2, 3);
INSERT INTO Juego_Genero VALUES(3, 3);
INSERT INTO Juego_Genero VALUES(3, 4);
INSERT INTO Juego_Genero VALUES(3, 5);
INSERT INTO Juego_Genero VALUES(4, 4);
INSERT INTO Juego_Genero VALUES(5, 2);
INSERT INTO Juego_Genero VALUES(5, 3);

-- Insertar lanzamientos de juegos en consolas
INSERT INTO Lanzamientos VALUES(1, 2, '2020-12-10');
INSERT INTO Lanzamientos VALUES(1, 3, '2022-02-14');
INSERT INTO Lanzamientos VALUES(1, 4, '2022-02-14');
INSERT INTO Lanzamientos VALUES(2, 5, '2017-03-03');
INSERT INTO Lanzamientos VALUES(3, 2, '2018-10-26');
INSERT INTO Lanzamientos VALUES(4, 2, '2014-09-04');
INSERT INTO Lanzamientos VALUES(4, 5, '2017-05-12');
INSERT INTO Lanzamientos VALUES(5, 1, '1998-09-09');



--1
SELECT Titulo
FROM Videojuegos 
JOIN Desarrolladores  ON ID_desarrolladora = ID
WHERE PaisOrigen = 'Japón';

--2
SELECT Titulo
FROM Videojuegos 
WHERE PEGI > (
    SELECT MAX(V2.PEGI)
    FROM Videojuegos 
    JOIN Desarrolladores ON ID_desarrolladora = ID
    WHERE PaisOrigen = 'Suecia'
);

--3
SELECT DISTINCT Nombre
FROM Desarrolladores 
JOIN Videojuegos ON ID = ID_desarrolladora
JOIN Lanzamientos ON ID = ID_Juego
WHERE YEAR(FechaLanzamiento) > 2015;

--4
SELECT Titulo
FROM Videojuegos
JOIN Lanzamientos ON ID = ID_Juego
GROUP BY ID
HAVING COUNT(DISTINCT ID_Consola) > (
    SELECT COUNT(DISTINCT ID_Consola)
    FROM Videojuegos 
    JOIN Lanzamientos L2 ON V2.ID = L2.ID_Juego
    WHERE Titulo = 'Cyberpunk 2077'
);

--5
SELECT Nombre
FROM Consolas 
WHERE FechaLanzamiento > (
    SELECT MIN(FechaLanzamiento)
    FROM Consolas 
    JOIN Desarrolladores ON ID_Fabricante = ID
    WHERE Nombre = 'Nintendo'
);

--6
SELECT Nombre
FROM Generos 
LEFT JOIN Juego_Genero JG ON G.ID = JG.ID_genero
WHERE ID_juego IS NULL;

--7
SELECT DISTINCT V.Titulo
FROM Videojuegos V
JOIN Lanzamientos ON ID = ID_Juego
JOIN Consolas ON ID_Consola = C.ID
JOIN Desarrolladores ON ID_Fabricante = D.ID
WHERE Nombre = 'Sony Interactive';

--8
SELECT D.Nombre
FROM Desarrolladores D
WHERE D.AñoFundacion < (
    SELECT MIN(D2.AñoFundacion)
    FROM Desarrolladores D2
    WHERE D2.PaisOrigen = 'Estados Unidos'
);

--9
Copy
SELECT V.Titulo
FROM Videojuegos V
WHERE V.ID NOT IN (
    SELECT JG.ID_juego
    FROM Juego_Genero JG
    JOIN Generos G ON JG.ID_genero = G.ID
    WHERE G.Nombre = '3rd Person Shooter'
);

--10
SELECT V.Titulo
FROM Videojuegos V
WHERE V.Titulo LIKE 'The%';

--11
Copy
SELECT G.Nombre
FROM Generos G
WHERE LENGTH(G.Nombre) = 8;

--12
SELECT D.Nombre AS Desarrolladora, C.Nombre AS Consola
FROM Desarrolladores D
JOIN Consolas C ON D.ID = C.ID_Fabricante;

--13
SELECT V.Titulo
FROM Videojuegos V
JOIN Juego_Genero JG ON V.ID = JG.ID_juego
GROUP BY V.ID
HAVING COUNT(JG.ID_genero) > 1;

--14
SELECT G.Nombre, COUNT(JG.ID_juego) AS Cantidad_Juegos
FROM Generos G
LEFT JOIN Juego_Genero JG ON G.ID = JG.ID_genero
GROUP BY G.ID;

--15
SELECT C.Nombre, MAX(L.FechaLanzamiento) AS Ultimo_Lanzamiento
FROM Consolas C
JOIN Lanzamientos L ON C.ID = L.ID_Consola
GROUP BY C.ID;

--16
ALTER TABLE Consolas
DROP COLUMN Generación;

--17
DELETE FROM Lanzamientos
WHERE ID_Consola = (
    SELECT C.ID
    FROM Consolas C
    WHERE C.Nombre = 'PlayStation 1'
);

--18
SELECT D.Nombre
FROM Desarrolladores D
JOIN Videojuegos V ON D.ID = V.ID_desarrolladora
WHERE V.PEGI > (
    SELECT AVG(V2.PEGI)
    FROM Videojuegos V2
    JOIN Desarrolladores D2 ON V2.ID_desarrolladora = D2.ID
    WHERE D2.PaisOrigen = D.PaisOrigen
);

--19
SELECT D.Nombre
FROM Desarrolladores D
WHERE NOT EXISTS (
    SELECT G.ID
    FROM Generos G
    WHERE NOT EXISTS (
        SELECT 1
        FROM Videojuegos V
        JOIN Juego_Genero JG ON V.ID = JG.ID_juego
        WHERE V.ID_desarrolladora = D.ID AND JG.ID_genero = G.ID
    )
);

--20
SELECT G.Nombre
FROM Generos G
JOIN Juego_Genero JG ON G.ID = JG.ID_genero
JOIN Lanzamientos L ON JG.ID_juego = L.ID_Juego
JOIN Consolas C ON L.ID_Consola = C.ID
WHERE C.Generación = 9
GROUP BY G.ID
ORDER BY COUNT(JG.ID_juego) DESC
LIMIT 1;

--21
SELECT D.Nombre
FROM Desarrolladores D
WHERE NOT EXISTS (
    SELECT G.ID
    FROM Generos G
    WHERE NOT EXISTS (
        SELECT 1
        FROM Videojuegos V
        JOIN Juego_Genero JG ON V.ID = JG.ID_juego
        WHERE V.ID_desarrolladora = D.ID AND JG.ID_genero = G.ID
    )
);

--22
SELECT V.Titulo
FROM Videojuegos V
JOIN Lanzamientos L ON V.ID = L.ID_Juego
JOIN Consolas C ON L.ID_Consola = C.ID
GROUP BY V.ID
HAVING COUNT(DISTINCT C.Generación) = 3;

--23
SELECT Titulo
FROM Videojuegos 
WHERE NOT EXISTS (
    SELECT ID
    FROM Consolas
    JOIN Desarrolladores ON ID_Fabricante = ID
    WHERE Nombre = 'Sony Interactive'
    AND NOT EXISTS (
        SELECT 1
        FROM Lanzamientos 
        WHERE ID_Juego = ID AND ID_Consola = ID
    )
);

--24
SELECT Nombre AS Consola, Nombre AS Genero,
       COUNT(ID_juego) * 100.0 / (SELECT COUNT(*) FROM Juego_Genero) AS Porcentaje
FROM Consolas 
JOIN Lanzamientos ON ID = ID_Consola
JOIN Juego_Genero JG ON ID_Juego = ID_juego
JOIN Generos ON ID_genero = ID
GROUP BY ID, ID;

--25
SELECT DISTINCT Titulo
FROM Videojuegos 
JOIN Lanzamientos ON ID = ID_Juego
JOIN Consolas  ON ID_Consola = ID
WHERE C.FechaLanzamiento < DATE_SUB(CURDATE(), INTERVAL 10 YEAR);

--26
SELECT Nombre AS Consola, COUNT(DISTINCT JG.ID_genero) AS Cantidad_Generos
FROM Consolas 
JOIN Lanzamientos ON ID = ID_Consola
JOIN Juego_Genero ON ID_Juego = ID_juego
WHERE YEAR(FechaLanzamiento) = YEAR(FechaLanzamiento)
GROUP BY ID;