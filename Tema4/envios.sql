CREATE TABLE PROVEEDORES (
    P VARCHAR2(10) PRIMARY KEY,
    pNOMBRE VARCHAR2(50),
    CATEGORIA NUMBER(4),
    CIUDAD VARCHAR2(50)
);

CREATE TABLE COMPONENTES (
    C VARCHAR2(10) PRIMARY KEY,
    CNOMBRE VARCHAR2(50),
    COLOR VARCHAR2(50),
    PESO NUMBER(4),
    CIUDAD VARCHAR2(50)
);

CREATE TABLE ARTICULOS (
    T VARCHAR2(10) PRIMARY KEY,
    TNOMBRE VARCHAR2(50),
    CIUDAD VARCHAR2(50)
);

CREATE TABLE ENVIOS (
    P VARCHAR2(10),
    C VARCHAR2(10),
    T VARCHAR2(10),
    CANTIDAD NUMBER,
    PRIMARY KEY (P, C, T),
    FOREIGN KEY (P) REFERENCES PROVEEDORES(P),
    FOREIGN KEY (C) REFERENCES COMPONENTES(C),
    FOREIGN KEY (T) REFERENCES ARTICULOS(T)
);

INSERT INTO PROVEEDORES VALUES ('p1', 'Carlos', 20, 'Sevilla');
INSERT INTO PROVEEDORES VALUES ('p2', 'Juan', 10, 'Madrid');
INSERT INTO PROVEEDORES VALUES ('p3', 'Jose', 30, 'Sevilla');
INSERT INTO PROVEEDORES VALUES ('p4', 'Inma', 20, 'Sevilla');
INSERT INTO PROVEEDORES VALUES ('p5', 'Eva', 30, 'Cáceres');

INSERT INTO COMPONENTES VALUES ('c1', 'X3A', 'Rojo', 12, 'Sevilla');
INSERT INTO COMPONENTES VALUES ('c2', 'B85', 'Verde', 17, 'Madrid');
INSERT INTO COMPONENTES VALUES ('c3', 'C4B', 'Azul', 17, 'Málaga');
INSERT INTO COMPONENTES VALUES ('c4', 'C4B', 'Rojo', 14, 'Sevilla');
INSERT INTO COMPONENTES VALUES ('c5', 'VT8', 'Azul', 12, 'Madrid');
INSERT INTO COMPONENTES VALUES ('c6', 'C30', 'Rojo', 19, 'Sevilla');

INSERT INTO ARTICULOS VALUES ('t1', 'Clasificadora', 'Madrid');
INSERT INTO ARTICULOS VALUES ('t2', 'Perforadora', 'Málaga');
INSERT INTO ARTICULOS VALUES ('t3', 'Lectora', 'Cáceres');
INSERT INTO ARTICULOS VALUES ('t4', 'Consola', 'Cáceres');
INSERT INTO ARTICULOS VALUES ('t5', 'Mezcladora', 'Sevilla');
INSERT INTO ARTICULOS VALUES ('t6', 'Terminal', 'Barcelona');
INSERT INTO ARTICULOS VALUES ('t7', 'Cinta', 'Sevilla');

INSERT INTO ENVIOS VALUES ('p1', 'c1', 't1', 200);
INSERT INTO ENVIOS VALUES ('p1', 'c1', 't4', 700);
INSERT INTO ENVIOS VALUES ('p2', 'c3', 't1', 400);
INSERT INTO ENVIOS VALUES ('p2', 'c3', 't2', 200);
INSERT INTO ENVIOS VALUES ('p2', 'c3', 't3', 200);
INSERT INTO ENVIOS VALUES ('p2', 'c3', 't4', 500);
INSERT INTO ENVIOS VALUES ('p2', 'c3', 't5', 600);
INSERT INTO ENVIOS VALUES ('p2', 'c3', 't6', 400);
INSERT INTO ENVIOS VALUES ('p2', 'c3', 't7', 800);
INSERT INTO ENVIOS VALUES ('p2', 'c5', 't2', 100);
INSERT INTO ENVIOS VALUES ('p3', 'c3', 't1', 200);
INSERT INTO ENVIOS VALUES ('p3', 'c4', 't2', 500);
INSERT INTO ENVIOS VALUES ('p4', 'c6', 't3', 300);
INSERT INTO ENVIOS VALUES ('p4', 'c6', 't7', 300);
INSERT INTO ENVIOS VALUES ('p5', 'c2', 't2', 200);
INSERT INTO ENVIOS VALUES ('p5', 'c2', 't4', 100);
INSERT INTO ENVIOS VALUES ('p5', 'c5', 't4', 500);
INSERT INTO ENVIOS VALUES ('p5', 'c5', 't7', 100);
INSERT INTO ENVIOS VALUES ('p5', 'c6', 't2', 200);
INSERT INTO ENVIOS VALUES ('p5', 'c1', 't4', 100);
INSERT INTO ENVIOS VALUES ('p5', 'c3', 't4', 200);
INSERT INTO ENVIOS VALUES ('p5', 'c4', 't4', 800);
INSERT INTO ENVIOS VALUES ('p5', 'c5', 't5', 400);
INSERT INTO ENVIOS VALUES ('p5', 'c6', 't4', 500);

--1
SELECT * FROM articulos WHERE ciudad='Cáceres';

--2
SELECT DISTINCT p FROM envios WHERE t='t1';

--3
SELECT DISTINCT color, ciudad FROM componentes; 

--4
SELECT t, ciudad FROM articulos WHERE ciudad LIKE '%d' OR ciudad LIKE '%e%';

--5
SELECT p FROM envios WHERE t='t1' AND c='c1';

--6
SELECT * FROM componentes WHERE ciudad LIKE 'M%';

--7
SELECT tnombre FROM articulos ar, envios en 
WHERE ar.t=en.t AND en.p='p1' ORDER BY tnombre;

--8
SELECT DISTINCT c FROM envios en, articulos ar
WHERE ar.t=en.t AND ar.ciudad='Madrid';

--9
SELECT p FROM envios en, articulos ar, componentes co
WHERE ar.t=en.t AND en.c=co.c AND (ar.ciudad='Madrid' OR ar.ciudad='Sevilla') 
        AND co.color='Rojo';

--10
SELECT c FROM envios WHERE 
p IN (SELECT p FROM proveedores WHERE ciudad='Sevilla') AND
t IN (SELECT t FROM articulos WHERE ciudad='Sevilla');

--11
SELECT t FROM envios WHERE p='p1';

--12
SELECT pr.ciudad AS ciudadProveedor, c, ar.ciudad AS ciudadArticulo 
FROM envios en, proveedores pr, articulos ar
WHERE en.p=pr.p AND ar.t=en.t ORDER BY c;

--13
SELECT pr.ciudad AS ciudadProveedor, c, ar.ciudad AS ciudadArticulo 
FROM envios en, proveedores pr, articulos ar
WHERE en.p=pr.p AND ar.t=en.t AND pr.ciudad!=ar.ciudad ORDER BY c;

--14
SELECT en.* FROM envios en, articulos ar
WHERE ar.t=en.t AND ar.tnombre LIKE '%ora';

--15
SELECT tnombre FROM articulos a WHERE t IN
    (SELECT t FROM envios WHERE p IN 
        (SELECT p FROM proveedores p WHERE p.ciudad!='Madrid' 
        AND p.ciudad!=a.ciudad));

--16
SELECT c FROM envios 
WHERE t='t2' AND p='p2';

--17
SELECT en.* FROM envios en, componentes co
WHERE en.c=co.c AND co.color!='Rojo';

--18
SELECT p FROM envios 
WHERE t='t3' AND cantidad>250;

--19
SELECT * FROM proveedores
WHERE categoria>20 AND ciudad='Sevilla';

--20
SELECT en.* FROM envios en, componentes co
WHERE en.c=co.c AND co.peso>15 AND en.cantidad<200;

--21
SELECT DISTINCT color FROM envios en, componentes co
WHERE en.c=co.c AND en.p='p1';

--22
SELECT DISTINCt peso FROM envios en, componentes co, proveedores pr
WHERE en.c=co.c AND en.p=pr.p AND pnombre='Juan';

--23
SELECT en.*, co.ciudad FROM envios en, componentes co, proveedores pr, articulos ar
WHERE en.c=co.c AND en.p=pr.p AND en.t=ar.t AND co.ciudad=pr.ciudad AND pr.ciudad=ar.ciudad;

--24
SELECT DISTINCT cantidad, pr.categoria FROM envios en, proveedores pr, articulos ar
WHERE en.p=pr.p AND en.t=ar.t AND ar.ciudad='Málaga';
       
--25
SELECT pnombre FROM proveedores WHERE p NOT IN 
    (SELECT p FROM envios, componentes WHERE envios.c=componentes.c 
                                AND cnombre LIKE '%4%'); 
        
--26
ALTER TABLE proveedores ADD edad NUMERIC(3) CHECK (edad>0);

--27
ALTER TABLE envios ADD(
    fecha_env DATE,
    precio NUMBER(8,2) CHECK (precio > 0)
);

--28
ALTER TABLE componentes RENAME COLUMN cnombre TO nombre_componentes;

--29
ALTER TABLE articulos MODIFY tnombre VARCHAR2(100);

--30
UPDATE proveedores SET ciudad='Cáceres' WHERE pnombre='Juan';

--31
UPDATE proveedores SET categoria=categoria+10 WHERE pnombre='Eva';

--32
DELETE FROM envios WHERE p = (SELECT p FROM proveedores WHERE pnombre='Inma'); 

--33
DELETE FROM envios WHERE p IN (SELECT p FROM proveedores WHERE ciudad='Sevilla');
DELETE FROM proveedores WHERE ciudad='Sevilla';






