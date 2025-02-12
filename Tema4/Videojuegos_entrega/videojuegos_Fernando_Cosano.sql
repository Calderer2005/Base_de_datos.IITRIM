CREATE TABLE Desarrolladores (
    ID NUMBER(4) PRIMARY KEY CHECK (ID > 0),
    Nombre VARCHAR2(25) NOT NULL,
    PaisOrigen VARCHAR2(50) NOT NULL,
    AñoFundacion NUMBER(4)
);


CREATE TABLE Videojuegos (
    ID NUMBER (4) PRIMARY KEY CHECK (ID > 0),
    Titulo VARCHAR2(50) NOT NULL,
    PEGI VARCHAR2(3) CHECK (PEGI IN ('+3', '+7', '+12', '+16', '+18')),
    ID_Desarrolladora INT,
    FOREIGN KEY (ID_Desarrolladora) REFERENCES Desarrolladores(ID)
);


CREATE TABLE Consolas (
    ID NUMBER (4) PRIMARY KEY CHECK (ID > 0),
    Nombre VARCHAR2(25) NOT NULL,
    ID_Fabricante NUMBER (4),
    FechaLanzamiento DATE,
    Generación NUMBER(1) NOT NULL CHECK (Generación BETWEEN 1 AND 9),
    FOREIGN KEY (ID_Fabricante) REFERENCES Desarrolladores(ID)
);


CREATE TABLE Generos (
    ID NUMBER (4) PRIMARY KEY CHECK (ID > 0),
    Nombre VARCHAR2(25) NOT NULL
);


CREATE TABLE Juego_Genero (
    ID_Juego NUMBER (4),
    ID_Genero NUMBER (4),
    PRIMARY KEY (ID_Juego, ID_Genero),
    FOREIGN KEY (ID_Juego) REFERENCES Videojuegos(ID),
    FOREIGN KEY (ID_Genero) REFERENCES Generos(ID)
);


CREATE TABLE Lanzamientos (
    ID_Juego NUMBER(4),
    ID_Consola NUMBER(4),
    FechaLanzamiento DATE,
    PRIMARY KEY (ID_Juego, ID_Consola),
    FOREIGN KEY (ID_Juego) REFERENCES Videojuegos(ID),
    FOREIGN KEY (ID_Consola) REFERENCES Consolas(ID)
);
INSERT INTO Desarrolladores (ID, Nombre, PaisOrigen, AñoFundacion) 
VALUES (1, 'CD Projekt Red', 'Polonia', 1994);

INSERT INTO Desarrolladores (ID, Nombre, PaisOrigen, AñoFundacion) 
VALUES (2, 'Nintendo EPD', 'Japón', 1889);

INSERT INTO Desarrolladores (ID, Nombre, PaisOrigen, AñoFundacion) 
VALUES (3, 'Rockstar Games', 'Estados Unidos', 1998);

INSERT INTO Desarrolladores (ID, Nombre, PaisOrigen, AñoFundacion) 
VALUES (4, 'Mojang Studios', 'Suecia', 2009);

INSERT INTO Desarrolladores (ID, Nombre, PaisOrigen, AñoFundacion) 
VALUES (5, 'Sony Interactive', 'Japón', 1993);

INSERT INTO Desarrolladores (ID, Nombre, PaisOrigen, AñoFundacion) 
VALUES (6, 'Insomniac Games', 'Estados Unidos', 1994);

INSERT INTO Desarrolladores (ID, Nombre, PaisOrigen, AñoFundacion) 
VALUES (7, 'Microsoft', 'Estados Unidos', 1975);


INSERT INTO Videojuegos (ID, Titulo, PEGI, ID_Desarrolladora)
VALUES (1, 'Cyberpunk 2077', '+18', 1);

INSERT INTO Videojuegos (ID, Titulo, PEGI, ID_Desarrolladora)
VALUES (2, 'The Legend of Zelda: Breath of the Wild', '+12', 2);

INSERT INTO Videojuegos (ID, Titulo, PEGI, ID_Desarrolladora)
VALUES (3, 'Red Dead Redemption 2', '+18', 3);

INSERT INTO Videojuegos (ID, Titulo, PEGI, ID_Desarrolladora)
VALUES (4, 'Minecraft', '+7', 4);

INSERT INTO Videojuegos (ID, Titulo, PEGI, ID_Desarrolladora)
VALUES (5, 'Spyro the Dragon', '+3', 6);

INSERT INTO Consolas (ID, Nombre, ID_Fabricante, FechaLanzamiento, Generación)
VALUES (1, 'PlayStation 5', 3, TO_DATE('03/12/1994', 'DD/MM/YYYY'), 5);

INSERT INTO Consolas (ID, Nombre, ID_Fabricante, FechaLanzamiento, Generación)
VALUES (2, 'PlayStation 4', 5, TO_DATE('15/11/2013', 'DD/MM/YYYY'), 8);

INSERT INTO Consolas (ID, Nombre, ID_Fabricante, FechaLanzamiento, Generación)
VALUES (3, 'PlayStation 5', 5, TO_DATE('12/11/2020', 'DD/MM/YYYY'), 9);

INSERT INTO Consolas (ID, Nombre, ID_Fabricante, FechaLanzamiento, Generación)
VALUES (4, 'XBOX Series X', 7, TO_DATE('10/11/2020', 'DD/MM/YYYY'), 9);

INSERT INTO Consolas (ID, Nombre, ID_Fabricante, FechaLanzamiento, Generación)
VALUES (5, 'Nintendo Switch', 2, TO_DATE('03/03/2017', 'DD/MM/YYYY'), 8);


INSERT INTO Generos (ID, Nombre)
VALUES (1, 'RPG');

INSERT INTO Generos (ID, Nombre)
VALUES (2, 'Aventura');

INSERT INTO Generos (ID, Nombre)
VALUES (3, 'Acción');

INSERT INTO Generos (ID, Nombre)
VALUES (4, 'Sandbox');

INSERT INTO Generos (ID, Nombre)
VALUES (5, '3rd Person Shooter');

INSERT INTO Juego_Genero (ID_Juego, ID_Genero)
VALUES (1, 1);

INSERT INTO Juego_Genero (ID_Juego, ID_Genero)
VALUES (1, 3);

INSERT INTO Juego_Genero (ID_Juego, ID_Genero)
VALUES (1, 5);

INSERT INTO Juego_Genero (ID_Juego, ID_Genero)
VALUES (2, 2);

INSERT INTO Juego_Genero (ID_Juego, ID_Genero)
VALUES (2, 3);

INSERT INTO Juego_Genero (ID_Juego, ID_Genero)
VALUES (3, 3);

INSERT INTO Juego_Genero (ID_Juego, ID_Genero)
VALUES (3, 4);

INSERT INTO Juego_Genero (ID_Juego, ID_Genero)
VALUES (3, 5);

INSERT INTO Juego_Genero (ID_Juego, ID_Genero)
VALUES (4, 4);

INSERT INTO Juego_Genero (ID_Juego, ID_Genero)
VALUES (5, 2);

INSERT INTO Juego_Genero (ID_Juego, ID_Genero)
VALUES (5, 3);


INSERT INTO Lanzamientos (ID_Juego, ID_Consola, FechaLanzamiento) 
VALUES (1, 2, '2020/12/10');

INSERT INTO Lanzamientos (ID_Juego, ID_Consola, FechaLanzamiento) 
VALUES (1, 3, '2022-02-14');

INSERT INTO Lanzamientos (ID_Juego, ID_Consola, FechaLanzamiento) 
VALUES (1, 4, '2022-02-14');

INSERT INTO Lanzamientos (ID_Juego, ID_Consola, FechaLanzamiento) 
VALUES (2, 5, '2017-03-03');

INSERT INTO Lanzamientos (ID_Juego, ID_Consola, FechaLanzamiento) 
VALUES (3, 2, '2018-10-26');

INSERT INTO Lanzamientos (ID_Juego, ID_Consola, FechaLanzamiento) 
VALUES (4, 2, '2014-09-04');

INSERT INTO Lanzamientos (ID_Juego, ID_Consola, FechaLanzamiento) 
VALUES (4, 5, '2017-05-12');

INSERT INTO Lanzamientos (ID_Juego, ID_Consola, FechaLanzamiento) 
VALUES (5, 1, '1998-09-09');


-- 1. Muestra los videojuegos desarrollados en Japón.
SELECT * FROM Videojuegos 
WHERE ID_desarrolladora IN (SELECT ID FROM Desarrolladores WHERE PaisOrigen = 'Japón');

-- 2. Obtén los juegos con un PEGI mayor que los juegos desarrollados en Suecia.
SELECT * FROM Videojuegos 
WHERE PEGI > (SELECT MAX(PEGI) FROM Videojuegos 
              WHERE ID_desarrolladora IN (SELECT ID FROM Desarrolladores WHERE PaisOrigen = 'Suecia'));

-- 3. Selecciona las desarrolladoras que hayan lanzado un juego después de 2015.
SELECT * FROM Desarrolladores 
WHERE ID IN (SELECT ID_desarrolladora FROM Videojuegos 
             WHERE ID IN (SELECT ID_Juego FROM Lanzamientos WHERE FechaLanzamiento > '2015-12-31'));

-- 4. Muestra los juegos que estén disponibles en más consolas que Cyberpunk.
SELECT ID, Titulo FROM Videojuegos 
WHERE (SELECT COUNT(*) FROM Lanzamientos WHERE ID_Juego = Videojuegos.ID) >
      (SELECT COUNT(*) FROM Lanzamientos WHERE ID_Juego = 1);

-- 5. Obtén las consolas que se hayan lanzado después de alguna de las consolas de Nintendo.
SELECT * FROM Consolas 
WHERE FechaLanzamiento > (SELECT MIN(FechaLanzamiento) FROM Consolas 
                          WHERE ID_Fabricante IN (SELECT ID FROM Desarrolladores WHERE Nombre = 'Nintendo'));

-- 6. Muestra los géneros que no tengan ningún juego asignado.
SELECT * FROM Generos 
WHERE ID NOT IN (SELECT DISTINCT ID_genero FROM Juego_Genero);

-- 7. Selecciona los juegos que se hayan lanzado en consolas de Sony.
SELECT * FROM Videojuegos 
WHERE ID IN (SELECT ID_Juego FROM Lanzamientos WHERE ID_Consola IN 
             (SELECT ID FROM Consolas WHERE ID_Fabricante IN 
             (SELECT ID FROM Desarrolladores WHERE Nombre LIKE 'Sony%')));

-- 8. Muestra las desarrolladoras más antiguas que las desarrolladoras de Estados Unidos.
SELECT * FROM Desarrolladores 
WHERE AñoFundacion < (SELECT MIN(AñoFundacion) FROM Desarrolladores WHERE PaisOrigen = 'Estados Unidos');

-- 9. Muestra todos los juegos que no sean Shooters en 3ª Persona.
SELECT * FROM Videojuegos 
WHERE ID NOT IN (SELECT ID_juego FROM Juego_Genero WHERE ID_genero = (SELECT ID FROM Generos WHERE Nombre = '3rd Person Shooter'));

-- 10. Obtén los juegos cuyo título empiece por ‘The’
SELECT * FROM Videojuegos WHERE Titulo LIKE 'The%';

-- 11. Muestra los géneros que se escriban con 8 letras.
SELECT * FROM Generos WHERE LENGTH(Nombre) = 8;

-- 12. Muestra todas las desarrolladoras y sus consolas asociadas.
SELECT Nombre, (SELECT GROUP_CONCAT(Nombre) FROM Consolas WHERE ID_Fabricante = Desarrolladores.ID) AS Consolas 
FROM Desarrolladores;

-- 13. Muestra los juegos con más de un género.
SELECT * FROM Videojuegos 
WHERE ID IN (SELECT ID_juego FROM Juego_Genero GROUP BY ID_juego HAVING COUNT(*) > 1);

-- 14. Obtén cuántos juegos tienen asignados cada género.
SELECT ID_genero, COUNT(*) AS Cantidad FROM Juego_Genero GROUP BY ID_genero;

-- 15. Muestra la fecha del último lanzamiento de cada consola.
SELECT ID_Consola, MAX(FechaLanzamiento) FROM Lanzamientos GROUP BY ID_Consola;

-- 16. Elimina la columna de generación de la tabla consolas.
ALTER TABLE Consolas DROP COLUMN Generación;

-- 17. Elimina todos los lanzamientos de la PlayStation 1.
DELETE FROM Lanzamientos WHERE ID_Consola = (SELECT ID FROM Consolas WHERE Nombre = 'PlayStation 1');

-- 18. Muestra los desarrolladores cuyos juegos tienen un PEGI mayor que el promedio de su país.
SELECT * FROM Desarrolladores 
WHERE ID IN (SELECT ID_desarrolladora FROM Videojuegos 
             WHERE PEGI > (SELECT AVG(PEGI) FROM Videojuegos 
                           WHERE ID_desarrolladora IN 
                           (SELECT ID FROM Desarrolladores WHERE PaisOrigen = Desarrolladores.PaisOrigen)));

-- 19. Obtén las desarrolladoras que hayan lanzado al menos un juego en cada género.
SELECT * FROM Desarrolladores 
WHERE ID IN (SELECT ID_desarrolladora FROM Videojuegos 
             WHERE ID IN (SELECT ID_juego FROM Juego_Genero GROUP BY ID_juego HAVING COUNT(DISTINCT ID_genero) = 
                          (SELECT COUNT(*) FROM Generos)));

-- 20. Muestra el género con más juegos lanzados en 9ª generación.
SELECT ID_genero FROM Juego_Genero 
WHERE ID_juego IN (SELECT ID_Juego FROM Lanzamientos WHERE ID_Consola IN 
                   (SELECT ID FROM Consolas WHERE Generación = 9))
GROUP BY ID_genero 
ORDER BY COUNT(*) DESC LIMIT 1;

-- 21. Selecciona las desarrolladoras que hayan lanzado juegos para todos los géneros.
SELECT * FROM Desarrolladores 
WHERE ID IN (SELECT ID_desarrolladora FROM Videojuegos 
             WHERE ID IN (SELECT ID_juego FROM Juego_Genero GROUP BY ID_juego HAVING COUNT(DISTINCT ID_genero) = 
                          (SELECT COUNT(*) FROM Generos)));

-- 22. Muestra los juegos que hayan sido lanzados en 3 generaciones distintas.
SELECT ID, Titulo FROM Videojuegos 
WHERE ID IN (SELECT ID_Juego FROM Lanzamientos WHERE ID_Consola IN 
             (SELECT ID FROM Consolas GROUP BY Generación HAVING COUNT(DISTINCT Generación) >= 3));

-- 23. Muestra los juegos que hayan salido para todas las consolas de Sony.
SELECT ID, Titulo FROM Videojuegos 
WHERE ID IN (SELECT ID_Juego FROM Lanzamientos WHERE ID_Consola IN 
             (SELECT ID FROM Consolas WHERE ID_Fabricante IN 
             (SELECT ID FROM Desarrolladores WHERE Nombre LIKE 'Sony%')))
GROUP BY ID 
HAVING COUNT(DISTINCT ID_Consola) = (SELECT COUNT(*) FROM Consolas WHERE ID_Fabricante IN 
                                     (SELECT ID FROM Desarrolladores WHERE Nombre LIKE 'Sony%'));

-- 24. Calcula el porcentaje de juegos por cada género en cada una de las consolas.
SELECT ID_Consola, ID_genero, 
       COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Lanzamientos WHERE ID_Consola = L.ID_Consola) AS Porcentaje 
FROM Lanzamientos L
JOIN Juego_Genero JG ON L.ID_Juego = JG.ID_juego
GROUP BY ID_Consola, ID_genero;

-- 25. Muestra los juegos que hayan sido lanzados en consolas que ya no reciben soporte.
SELECT ID, Titulo FROM Videojuegos 
WHERE ID IN (SELECT ID_Juego FROM Lanzamientos WHERE ID_Consola IN 
             (SELECT ID FROM Consolas WHERE FechaLanzamiento < '2010-01-01'));

-- 26. Muestra para cuántos géneros se lanzan juegos en el primer año de cada consola.
SELECT ID_Consola, COUNT(DISTINCT ID_genero) 
FROM Juego_genero
JOIN Juego_Genero JG ON L.ID_Juego = JG.ID_juego
WHERE YEAR(FechaLanzamiento) = (SELECT YEAR(FechaLanzamiento) FROM Consolas WHERE ID = L.ID_Consola)
GROUP BY ID_Consola;

