CREATE TABLE sala
(
    s VARCHAR2(3) PRIMARY KEY,
    nombre VARCHAR2(30) UNIQUE,
    capacidad NUMBER(3) CHECK (capacidad BETWEEN 80 AND 300),
    fila NUMBER(2) NOT NULL
);

CREATE TABLE pelicula
(
    p VARCHAR2(5) PRIMARY KEY,
    nombre VARCHAR2(50) NOT NULL,
    calificacion VARCHAR2(2) CHECK (calificacion IN ('TP', 7, 18)),
    nacionalidad VARCHAR2(30)
);

CREATE TABLE proyeccion
(
    sala VARCHAR2(3),
    pelicula VARCHAR2(5),
    hora VARCHAR2(5),
    ocupacion NUMBER(3) CHECK (ocupacion >= 0),
    
    CONSTRAINT pk_proyeccion PRIMARY KEY (sala, pelicula, hora),
    CONSTRAINT fk_sala_proyeccion FOREIGN KEY (sala) REFERENCES sala(s),
    CONSTRAINT fk_pelicula_proyeccion FOREIGN KEY (pelicula) REFERENCES pelicula(p)
);

INSERT INTO sala VALUES ('S1', 'África', 125, 10);
INSERT INTO sala VALUES ('S2', 'América', 255, 24);
INSERT INTO sala VALUES ('S3', 'Europa', 136, 14);
INSERT INTO sala VALUES ('S4', 'Asia', 85, 7);
INSERT INTO sala VALUES ('S5', 'Oceanía', 100, 10);
INSERT INTO sala VALUES ('S6', 'Antártida', 150, 15);
INSERT INTO sala VALUES ('S7', 'Atlántida', 300, 30);

INSERT INTO pelicula VALUES ('P1', 'Minions: el origen de Gru', 'TP', 'EEUU');
INSERT INTO pelicula VALUES ('P2', 'Black Panther: Wakanda forever', '18', 'EEUU');
INSERT INTO pelicula VALUES ('P3', 'Astérix y Obélix: el reino medio', '7', 'Francia');
INSERT INTO pelicula VALUES ('P4', 'El autor', NULL, 'España');
INSERT INTO pelicula VALUES ('P5', 'Perfectos desconocidos', '18', 'España');
INSERT INTO pelicula VALUES ('P6', 'ResidentEvil', '18', NULL);
INSERT INTO pelicula VALUES ('P7', 'Tadeo Jones 3', 'TP', 'España');
INSERT INTO pelicula VALUES ('P8', 'Eiffel', '7', 'Francia');
INSERT INTO pelicula VALUES ('P9', 'Puñales por la espalda 2', '18', 'EEUU');
INSERT INTO pelicula VALUES ('P10', 'La abuela', NULL, 'España');

INSERT INTO proyeccion VALUES ('S1', 'P1', '12.00', 75);
INSERT INTO proyeccion VALUES ('S1', 'P1', '18.00', 84);
INSERT INTO proyeccion VALUES ('S1', 'P2', '23.00', 100);
INSERT INTO proyeccion VALUES ('S2', 'P3', '12.00', 89);
INSERT INTO proyeccion VALUES ('S2', 'P3', '18.00', 104);
INSERT INTO proyeccion VALUES ('S2', 'P3', '23.00', 200);
INSERT INTO proyeccion VALUES ('S3', 'P2', '17.00', 100);
INSERT INTO proyeccion VALUES ('S3', 'P2', '20.00', 120);
INSERT INTO proyeccion VALUES ('S4', 'P4', '12.00', 14);
INSERT INTO proyeccion VALUES ('S4', 'P4', '17.00', 60);
INSERT INTO proyeccion VALUES ('S4', 'P4', '20.00', 78);
INSERT INTO proyeccion VALUES ('S4', 'P6', '23.00', 80);
INSERT INTO proyeccion VALUES ('S1', 'P1', '23.00', 35);
INSERT INTO proyeccion VALUES ('S5', 'P4', '20.00', 16);
INSERT INTO proyeccion VALUES ('S3', 'P4', '12.00', 25);
INSERT INTO proyeccion VALUES ('S5', 'P1', '12.00', 100);
INSERT INTO proyeccion VALUES ('S5', 'P8', '12.00', 152);
INSERT INTO proyeccion VALUES ('S5', 'P4', '13.00', 250);
INSERT INTO proyeccion VALUES ('S6', 'P2', '20.00', 120);
INSERT INTO proyeccion VALUES ('S6', 'P10', '23.00', 68);
INSERT INTO proyeccion VALUES ('S6', 'P9', '23.00', 50);
INSERT INTO proyeccion VALUES ('S4', 'P8', '12.00', 36);


SELECT pelicula, sala, hora, ocupacion FROM proyeccion pro
WHERE pelicula = (SELECT pelicula FROM proyeccion
                        GROUP BY pelicula
                      HAVING SUM(ocupacion) >= ALL 
                                                (SELECT SUM(ocupacion) 
                                                        FROM proyeccion 
                                                        GROUP BY pelicula));
     AND ocupacion >= ALL (SELECT ocupacion 
                                FROM proyeccion pro2 
                                WHERE pro2.pelicula=pro.pelicula);
                                
SELECT nombre, sala, SUM(ocupacion) FROM pelicula JOIN proyeccion pro ON p=pelicula
GROUP BY nombre, sala
HAVING SUM(ocupacion) <= ALL (SELECT SUM(ocupacion) 
                        FROM proyeccion pro2 
                        WHERE pro.sala=pro2.sala
                        GROUP BY pelicula, sala);
                        
DECLARE
    titulo_pel pelicula.nombre%TYPE;
BEGIN
    SELECT nombre INTO titulo_pel FROM pelicula JOIN proyeccion ON p=pelicula
    WHERE sala='S2' AND hora='23.00';
    
    DBMS_OUTPUT.put_line('Nombre de la pelicula: '||titulo_pel);
END;

DECLARE
    fila_sala sala%ROWTYPE;
BEGIN
    SELECT s, nombre INTO fila_sala FROM sala
    WHERE nombre='Oceanía';
    
    DBMS_OUTPUT.put_line('Codigo de la sala: '||fila_sala.s);
    DBMS_OUTPUT.put_line('Nombre de la sala: '||fila_sala.nombre);
END;

DECLARE
    d_peli pelicula%ROWTYPE;
BEGIN
    SELECT p.* INTO d_peli 
    FROM pelicula p JOIN proyeccion pr ON pelicula=p
    WHERE sala='S4' AND hora='20.00';
    
    DBMS_OUTPUT.put_line('Codigo de la pelicula: '||d_peli.p);
    DBMS_OUTPUT.put_line('Nombre de la pelicula: '||d_peli.nombre);
    DBMS_OUTPUT.put_line('Calificación de la pelicula: '||d_peli.calificacion);
    DBMS_OUTPUT.put_line('Nacionalidad de la pelicula: '||d_peli.nacionalidad);
END;
                        
DECLARE
    d_sala sala%ROWTYPE;
BEGIN
    SELECT * INTO d_sala 
    FROM sala
    WHERE capacidad >= ALL (SELECT capacidad FROM sala);
    
    DBMS_OUTPUT.put_line('Codigo de la sala: '||d_sala.s);
    DBMS_OUTPUT.put_line('Nombre de la sala: '||d_sala.nombre);
    DBMS_OUTPUT.put_line('Capacidad de la sala: '||d_sala.capacidad);
    DBMS_OUTPUT.put_line('Numero de filas de la sala: '||d_sala.fila);
END; 

DECLARE
    d_sala sala%ROWTYPE;
BEGIN
    SELECT s.* INTO d_sala 
    FROM pelicula p JOIN proyeccion pr ON pelicula=p
    JOIN sala s ON s=sala
    WHERE p.nombre='El autor' AND hora='17.00';
    
    DBMS_OUTPUT.put_line('Codigo de la sala: '||d_sala.s);
    DBMS_OUTPUT.put_line('Nombre de la sala: '||d_sala.nombre);
    DBMS_OUTPUT.put_line('Capacidad de la sala: '||d_sala.capacidad);
    DBMS_OUTPUT.put_line('Numero de filas de la sala: '||d_sala.fila);
END;

DECLARE
    d_sesion proyeccion%ROWTYPE;
BEGIN
    SELECT * INTO d_sesion 
    FROM proyeccion
    WHERE ocupacion >= ALL (SELECT ocupacion FROM proyeccion);
    
    DBMS_OUTPUT.put_line('Codigo de la sala: '||d_sesion.sala);
    DBMS_OUTPUT.put_line('Codigo de la pelicula: '||d_sesion.pelicula);
    DBMS_OUTPUT.put_line('Hora de la sesion: '||d_sesion.hora);
    DBMS_OUTPUT.put_line('Ocupacion de la sala: '||d_sesion.ocupacion);
END;

DECLARE
    nom pelicula.nombre%TYPE;
BEGIN
    SELECT nombre INTO nom
    FROM pelicula
    WHERE p = (SELECT pelicula FROM proyeccion
                        GROUP BY pelicula
                        HAVING SUM(ocupacion) >= ALL 
                                                (SELECT SUM(ocupacion) 
                                                        FROM proyeccion 
                                                        GROUP BY pelicula));
    
    DBMS_OUTPUT.put_line('Titulo de la película más taquillera: '||nom);
END;

DECLARE
    nacion pelicula.nacionalidad%TYPE;
BEGIN
    SELECT nacionalidad INTO nacion 
    FROM proyeccion JOIN pelicula ON p=pelicula
    WHERE ocupacion >= ALL (SELECT ocupacion FROM proyeccion);
    
    DBMS_OUTPUT.put_line('Nacionalidad de la película más vista: '||nacion);
END;

ACCEPT n_sala PROMPT 'Indica el nombre de la sala';

DECLARE
    fila_sala sala%ROWTYPE;
BEGIN
    SELECT * INTO fila_sala FROM sala
    WHERE nombre='&n_sala';
    
    DBMS_OUTPUT.put_line('Codigo de la sala: '||fila_sala.s);
    DBMS_OUTPUT.put_line('Nombre de la sala: '||fila_sala.nombre);
END;

ACCEPT nom_peli PROMPT 'Introduce el titulo de la pelicula';

DECLARE
    d_peli pelicula%ROWTYPE;
    cadena pelicula.nombre%TYPE := '%'||'&nom_peli'||'%';
BEGIN
    SELECT p.* INTO d_peli 
    FROM pelicula p
    WHERE nombre LIKE cadena;
    
    DBMS_OUTPUT.put_line('Codigo de la pelicula: '||d_peli.p);
    DBMS_OUTPUT.put_line('Nombre de la pelicula: '||d_peli.nombre);
    DBMS_OUTPUT.put_line('Calificación de la pelicula: '||d_peli.calificacion);
    DBMS_OUTPUT.put_line('Nacionalidad de la pelicula: '||d_peli.nacionalidad);
END;

ACCEPT capacidad PROMPT 'Introduce la capacidad de la sala';

DECLARE
    d_sala sala%ROWTYPE;
BEGIN
    SELECT * INTO d_sala 
    FROM sala
    WHERE capacidad = &capacidad;
    
    DBMS_OUTPUT.put_line('Codigo de la sala: '||d_sala.s);
    DBMS_OUTPUT.put_line('Nombre de la sala: '||d_sala.nombre);
    DBMS_OUTPUT.put_line('Capacidad de la sala: '||d_sala.capacidad);
    DBMS_OUTPUT.put_line('Numero de filas de la sala: '||d_sala.fila);
END;

ACCEPT n_sala PROMPT 'Introduce el código de la sala';
ACCEPT hora PROMPT 'Introduce la hora de la sesion';

DECLARE
    titulo pelicula.nombre%TYPE;
BEGIN
    SELECT nombre INTO titulo 
    FROM proyeccion JOIN pelicula ON p=pelicula
    WHERE sala='&n_sala' AND hora='&hora';
    
    DBMS_OUTPUT.put_line('Titulo de la película '||titulo);
END;



ACCEPT nom_peli PROMPT 'Introduce el titulo de la película';

DECLARE
    cadena pelicula.nombre%TYPE := '%'||'&nom_peli'||'%';
    nacio pelicula.nacionalidad%TYPE;
    datos pelicula%ROWTYPE;
BEGIN
    SELECT nacionalidad into nacio
    FROM pelicula WHEN nombre LIKE cadena;
    
    IF (naico = 'España')
    THEN 
        DBMS_OUTPUT.put_line('La pelicula es nacional');
    
        SELECT * INTO datos
        FROM pelicula WHERE nombre LIKE cadena;
        
        datos.nombre;
    END IF;
END;

DECLARE
    cont INT :=0;
BEGIN
    WHILE(cont <= 10) LOOP
        DBMS_OUTPUT.put_line(cont);
        cont := cont +1;
    END LOOP;
END;
        
DECLARE
    cont INT :=10;
BEGIN
    WHILE(cont >= 0) LOOP
        DBMS_OUTPUT.put_line(cont);
        cont := cont -1;
    END LOOP;
END;     


ACCEPT n_1 PROMPT 'Introduce un número';
ACCEPT n_2 PROMPT 'Introduce otro número';
DECLARE
    n1 INT := &n_1;
    n2 INT := &n_2;

BEGIN
    IF (n1 > n2) THEN
        
        cont := &n1;
        
        WHILE(cont >= n2) LOOP
            DBMS_OUTPUT.put_line(cont);
            cont := cont -1;
        END LOOP;
        
    ELSE
        cont := &n2;
        
        WHILE(cont >= n1) LOOP
            DBMS_OUTPUT.put_line(cont);
            cont := cont -1;
        END LOOP;
    END IF;
END; 


