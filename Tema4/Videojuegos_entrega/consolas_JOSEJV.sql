--CREACION TABLAS
CREATE TABLE Desarrolladores (
    ID INT PRIMARY KEY,
    Nombre VARCHAR(25) NOT NULL,
    PaisOrigen VARCHAR(50),
    AñoFundacion NUMBER (3)
)
CREATE TABLE Videojuegos (
    ID INT PRIMARY KEY, 
    Titulo VARCHAR(50) NOT NULL, 
    PEGI VARCHAR2(3) CHECK (PEGI IN (2,3,12,16,18))NOT NULL,
    ID_desarrolladora NUMBER (3),
    FOREIGN KEY (ID_desarrolladora) REFERENCES Desarrolladores(ID)
);
CREATE TABLE Consolas (
    ID INT PRIMARY KEY,
    Nombre VARCHAR(25) NOT NULL,
    ID_Fabricante NUMBER (3),
    FechaLanzamiento DATE,
    Generación INT NOT NULL,
    FOREIGN KEY (ID_Fabricante) REFERENCES Desarrolladores(ID)
);
CREATE TABLE Lanzamientos (
    ID_Juego NUMBER (3),
    ID_Consola NUMBER (3),
    FechaLanzamiento DATE,
    PRIMARY KEY (ID_Juego, ID_Consola),
    FOREIGN KEY (ID_Juego) REFERENCES Videojuegos(ID),
    FOREIGN KEY (ID_Consola) REFERENCES Consolas(ID)
);
CREATE TABLE Generos (
    ID INT PRIMARY KEY,
    Nombre VARCHAR(25) NOT NULL
);
CREATE TABLE Juego_Genero (
    ID_juego NUMBER (3),
    ID_genero NUMBER (3),
    PRIMARY KEY (ID_juego, ID_genero),
    FOREIGN KEY (ID_juego) REFERENCES Videojuegos(ID),
    FOREIGN KEY (ID_genero) REFERENCES Generos(ID)
);

--INSERCCION DATOS
INSERT INTO Desarrolladores (ID, Nombre, PaisOrigen, AñoFundacion) VALUES (1, 'CD Projekt Red', 'Polonia', 1994);
INSERT INTO Desarrolladores (ID, Nombre, PaisOrigen, AñoFundacion) VALUES (2, 'Nintendo EPD', 'Japón', 1889);
INSERT INTO Desarrolladores (ID, Nombre, PaisOrigen, AñoFundacion) VALUES(3, 'Rockstar Games', 'Estados Unidos', 1998);
INSERT INTO Desarrolladores (ID, Nombre, PaisOrigen, AñoFundacion) VALUES (4, 'Mojang Studios', 'Suecia', 2009);
INSERT INTO Desarrolladores (ID, Nombre, PaisOrigen, AñoFundacion) VALUES (5, 'Sony Interactive', 'Japón', 1993);
INSERT INTO Desarrolladores (ID, Nombre, PaisOrigen, AñoFundacion) VALUES (6, 'Insomniac Games', 'Estados Unidos', 1994);
INSERT INTO Desarrolladores (ID, Nombre, PaisOrigen, AñoFundacion) VALUES (7, 'Microsoft', 'Estados Unidos', 1975);

INSERT INTO Videojuegos (ID, Titulo, PEGI, ID_desarrolladora) VALUES (1, 'Cyberpunk 2077', '+18', 1);
INSERT INTO Videojuegos (ID, Titulo, PEGI, ID_desarrolladora) VALUES (2, 'The Legend of Zelda Breath of the Wild', '+12', 2);
INSERT INTO Videojuegos (ID, Titulo, PEGI, ID_desarrolladora) VALUES (3, 'Red Dead Redemption 2', '+18', 3);
INSERT INTO Videojuegos (ID, Titulo, PEGI, ID_desarrolladora) VALUES (4, 'Minecraft', '+7', 4);
INSERT INTO Videojuegos (ID, Titulo, PEGI, ID_desarrolladora) VALUES (5, 'Spyro the Dragon', '+3', 6);

INSERT INTO Consolas (ID, Nombre, ID_Fabricante, FechaLanzamiento, Generación) VALUES (1, 'PlayStation 5', 5, '12-11-2020', 9);
INSERT INTO Consolas (ID, Nombre, ID_Fabricante, FechaLanzamiento, Generación) VALUES (2, 'PlayStation 4', 5, '15-11-2013', 8);
INSERT INTO Consolas (ID, Nombre, ID_Fabricante, FechaLanzamiento, Generación) VALUES (3, 'XBOX Series X', 7, '10-11-2020', 9);
INSERT INTO Consolas (ID, Nombre, ID_Fabricante, FechaLanzamiento, Generación) VALUES (4, 'Nintendo Switch', 2, '03-03-2017', 8);

INSERT INTO Generos (ID, Nombre) VALUES (1, 'RPG');
INSERT INTO Generos (ID, Nombre) VALUES (2, 'Aventura');
INSERT INTO Generos (ID, Nombre) VALUES (3, 'Acción');
INSERT INTO Generos (ID, Nombre) VALUES (4, 'Sandbox');
INSERT INTO Generos (ID, Nombre) VALUES (5, '3rd Person Shooter');

INSERT INTO Juego_Genero (ID_juego, ID_genero) VALUES (1, 1);
INSERT INTO Juego_Genero (ID_juego, ID_genero) VALUES (1, 3);
INSERT INTO Juego_Genero (ID_juego, ID_genero) VALUES (1, 5);
INSERT INTO Juego_Genero (ID_juego, ID_genero) VALUES (2, 2);
INSERT INTO Juego_Genero (ID_juego, ID_genero) VALUES (2, 3);
INSERT INTO Juego_Genero (ID_juego, ID_genero) VALUES (3, 3);
INSERT INTO Juego_Genero (ID_juego, ID_genero) VALUES (3, 4);
INSERT INTO Juego_Genero (ID_juego, ID_genero) VALUES (3, 5);
INSERT INTO Juego_Genero (ID_juego, ID_genero) VALUES (4, 4);
INSERT INTO Juego_Genero (ID_juego, ID_genero) VALUES (5, 2);
INSERT INTO Juego_Genero (ID_juego, ID_genero) VALUES (5, 3);

INSERT INTO Lanzamientos (ID_juego, ID_consola, FechaLanzamiento) VALUES (1, 2, '10-12-2020');
INSERT INTO Lanzamientos (ID_juego, ID_consola, FechaLanzamiento) VALUES  (1, 3, '14-11-2022');
INSERT INTO Lanzamientos (ID_juego, ID_consola, FechaLanzamiento) VALUES (2, 4, '03-03-2017');
INSERT INTO Lanzamientos (ID_juego, ID_consola, FechaLanzamiento) VALUES (3, 2, '26-10-2018');
INSERT INTO Lanzamientos (ID_juego, ID_consola, FechaLanzamiento) VALUES (4, 2, '04-09-2014'); 
INSERT INTO Lanzamientos (ID_juego, ID_consola, FechaLanzamiento) VALUES (4, 4, '12-05-2017');
INSERT INTO Lanzamientos (ID_juego, ID_consola, FechaLanzamiento) VALUES (5, 1, '09-09-1998');

--CONSULTAS
-- 1. Videojuegos desarrollados en Japón
SELECT V.Titulo FROM Videojuegos V JOIN Desarrolladores D ON V.ID_desarrolladora = D.ID WHERE D.PaisOrigen = 'Japón';

-- 2. Juegos con PEGI mayor que los juegos desarrollados en Suecia
SELECT Titulo FROM Videojuegos WHERE PEGI > (SELECT MAX(PEGI) FROM Videojuegos V JOIN Desarrolladores D ON V.ID_desarrolladora = D.ID WHERE D.PaisOrigen = 'Suecia');

-- 3. Desarrolladoras con juegos lanzados después de 2015
SELECT DISTINCT D.Nombre FROM Desarrolladores D JOIN Videojuegos V ON D.ID = V.ID_desarrolladora JOIN Lanzamientos L ON V.ID = L.ID_juego WHERE L.FechaLanzamiento > '2015-01-01';

-- 4. Juegos disponibles en más consolas que Cyberpunk
SELECT V.Titulo FROM Videojuegos V JOIN Lanzamientos L ON V.ID = L.ID_juego GROUP BY V.Titulo HAVING COUNT(L.ID_consola) > (SELECT COUNT(ID_consola) FROM Lanzamientos WHERE ID_juego = 1);

-- 5. Consolas lanzadas después de alguna de Nintendo
SELECT C.Nombre FROM Consolas C WHERE C.FechaLanzamiento > (SELECT MIN(FechaLanzamiento) FROM Consolas WHERE ID_Fabricante = 2);

-- 6. Géneros sin juegos asignados
SELECT G.Nombre FROM Generos G LEFT JOIN Juego_Genero JG ON G.ID = JG.ID_genero WHERE JG.ID_juego IS NULL;

-- 7. Juegos lanzados en consolas de Sony
SELECT DISTINCT V.Titulo FROM Videojuegos V JOIN Lanzamientos L ON V.ID = L.ID_juego JOIN Consolas C ON L.ID_consola = C.ID WHERE C.ID_Fabricante = 5;

-- 8. Desarrolladoras más antiguas que las de Estados Unidos
SELECT Nombre FROM Desarrolladores WHERE AñoFundacion < (SELECT MIN(AñoFundacion) FROM Desarrolladores WHERE PaisOrigen = 'Estados Unidos');

-- 9. Juegos que no son Shooters en 3ª Persona
SELECT V.Titulo FROM Videojuegos V WHERE V.ID NOT IN (SELECT ID_juego FROM Juego_Genero WHERE ID_genero = 5);

-- 10. Juegos cuyo título empieza por 'The'
SELECT Titulo FROM Videojuegos WHERE Titulo LIKE 'The%';

-- 11. Géneros con nombres de 8 letras
SELECT Nombre FROM Generos WHERE LENGTH(Nombre) = 8;

-- 12. Desarrolladoras y sus consolas asociadas
SELECT DISTINCT D.Nombre, C.Nombre FROM Desarrolladores D 
JOIN Videojuegos V ON D.ID = V.ID_desarrolladora 
JOIN Lanzamientos L ON V.ID = L.ID_juego 
JOIN Consolas C ON L.ID_consola = C.ID;

-- 13. Juegos con más de un género
SELECT V.Titulo FROM Videojuegos V 
JOIN Juego_Genero JG ON V.ID = JG.ID_juego 
GROUP BY V.Titulo HAVING COUNT(JG.ID_genero) > 1;

-- 14. Cantidad de juegos por género
SELECT G.Nombre, COUNT(JG.ID_juego) AS Total FROM Generos G 
LEFT JOIN Juego_Genero JG ON G.ID = JG.ID_genero 
GROUP BY G.Nombre;

-- 15. Última fecha de lanzamiento por consola
SELECT C.Nombre, MAX(L.FechaLanzamiento) AS UltimoLanzamiento FROM Consolas C 
JOIN Lanzamientos L ON C.ID = L.ID_consola 
GROUP BY C.Nombre;

-- 16. Eliminar la columna Generación de Consolas
ALTER TABLE Consolas DROP COLUMN Generación;

-- 17. Eliminar lanzamientos de PlayStation 1
DELETE FROM Lanzamientos WHERE ID_consola = (SELECT ID FROM Consolas WHERE Nombre = 'PlayStation 1');

-- 18. Desarrolladores con juegos con PEGI mayor al promedio de su país
SELECT D.Nombre FROM Desarrolladores D 
JOIN Videojuegos V ON D.ID = V.ID_desarrolladora 
WHERE V.PEGI > (SELECT AVG(PEGI) FROM Videojuegos V2 
JOIN Desarrolladores D2 ON V2.ID_desarrolladora = D2.ID WHERE D2.PaisOrigen = D.PaisOrigen);

-- 19. Desarrolladoras que han lanzado un juego en cada género
SELECT D.Nombre FROM Desarrolladores D 
WHERE NOT EXISTS (
    SELECT G.ID FROM Generos G 
    WHERE NOT EXISTS (
        SELECT * FROM Videojuegos V 
        JOIN Juego_Genero JG ON V.ID = JG.ID_juego 
        WHERE V.ID_desarrolladora = D.ID AND JG.ID_genero = G.ID
    )
);

-- 20. Género con más juegos lanzados en 9ª generación
SELECT G.Nombre FROM Generos G 
JOIN Juego_Genero JG ON G.ID = JG.ID_genero 
JOIN Videojuegos V ON JG.ID_juego = V.ID 
JOIN Lanzamientos L ON V.ID = L.ID_juego 
JOIN Consolas C ON L.ID_consola = C.ID 
WHERE C.Generación = 9 
GROUP BY G.Nombre ORDER BY COUNT(V.ID) DESC LIMIT 1;

-- 21. Desarrolladoras con juegos en todos los géneros
SELECT D.Nombre FROM Desarrolladores D 
WHERE NOT EXISTS (
    SELECT G.ID FROM Generos G 
    WHERE NOT EXISTS (
        SELECT * FROM Videojuegos V 
        JOIN Juego_Genero JG ON V.ID = JG.ID_juego 
        WHERE V.ID_desarrolladora = D.ID AND JG.ID_genero = G.ID
    )
);

-- 22. Juegos lanzados en tres generaciones distintas
SELECT V.Titulo FROM Videojuegos V 
JOIN Lanzamientos L ON V.ID = L.ID_juego 
JOIN Consolas C ON L.ID_consola = C.ID 
GROUP BY V.Titulo HAVING COUNT(DISTINCT C.Generación) >= 3;

-- 23. Juegos lanzados en todas las consolas de Sony
SELECT V.Titulo FROM Videojuegos V 
JOIN Lanzamientos L ON V.ID = L.ID_juego 
JOIN Consolas C ON L.ID_consola = C.ID 
WHERE C.ID_Fabricante = 5 
GROUP BY V.Titulo HAVING COUNT(DISTINCT C.ID) = (SELECT COUNT(ID) FROM Consolas WHERE ID_Fabricante = 5);

-- 24. Porcentaje de juegos por género en cada consola
SELECT C.Nombre AS Consola, G.Nombre AS Género, 
       COUNT(JG.ID_juego) * 100.0 / (SELECT COUNT(*) FROM Lanzamientos WHERE ID_consola = C.ID) AS Porcentaje
FROM Consolas C 
JOIN Lanzamientos L ON C.ID = L.ID_consola 
JOIN Videojuegos V ON L.ID_juego = V.ID 
JOIN Juego_Genero JG ON V.ID = JG.ID_juego 
JOIN Generos G ON JG.ID_genero = G.ID 
GROUP BY C.Nombre, G.Nombre;

-- 25. Juegos lanzados en consolas sin soporte
SELECT V.Titulo FROM Videojuegos V 
JOIN Lanzamientos L ON V.ID = L.ID_juego 
JOIN Consolas C ON L.ID_consola = C.ID 
WHERE C.FechaLanzamiento < DATE_SUB(CURDATE(), INTERVAL 10 YEAR);

-- 26. Géneros con juegos lanzados en el primer año de cada consola
SELECT C.Nombre AS Consola, G.Nombre AS Género, COUNT(V.ID) AS TotalJuegos
FROM Consolas C 
JOIN Lanzamientos L ON C.ID = L.ID_consola 
JOIN Videojuegos V ON L.ID_juego = V.ID 
JOIN Juego_Genero JG ON V.ID = JG.ID_juego 
JOIN Generos G ON JG.ID_genero = G.ID 
WHERE YEAR(L.FechaLanzamiento) = YEAR(C.FechaLanzamiento) 
GROUP BY C.Nombre, G.Nombre;

