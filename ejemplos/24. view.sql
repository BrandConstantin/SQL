USE EMPRESA

--CREACI�N DE UNA VISTA
CREATE VIEW VISTA AS
SELECT * FROM TEMPLE WHERE SALAR > 800

SELECT * FROM VISTA

--CUANDO SE UTILIZA UNA FUNCI�N ES NECESARIO DE QUE SE LE ASIGNE UN NOMBRE
CREATE VIEW VISTA1 AS
SELECT NUMDE, AVG(SALAR) 'SALAR MEDIO POR DEPART'
FROM TEMPLE GROUP BY NUMDE

SELECT * FROM VISTA1

--CREAR VISTA CON JOIN
CREATE VIEW VISTA3 AS
SELECT NUMEM, NOMEM, NOMDE, SALAR FROM TEMPLE E
JOIN TDEPTO D ON E.NUMDE = D.NUMDE

SELECT * FROM VISTA3

--INSERTAR DATOS EN UNA VISTA DE UNA TABLA 
--NO SE PUEDE INSERTAR DATOS EN UNA VISTA QUE AFECTA VARIAS TABLAS
SELECT * FROM VISTA

INSERT INTO VISTA (NUMEM, NUMDE, EXTEL, SALAR, COMIS, NOMEM)
VALUES (100, 90, 65, 1280, 100, 'OLIVER HESDELKI')

--ACTUALIZAR UNA VISTA
SELECT * FROM VISTA3
UPDATE VISTA3 SET SALAR = 1300 WHERE NUMEM = 100

--BORRAR VISTAS
DROP VIEW VISTA, VISTA1, VISTA3

--BORRAR DE UNA VISTA
DELETE FROM VISTA3 WHERE NUMEM = 103

/* Si borramos la vista y la creamos de nuevo se pierden los permisos que se se le hayan otorgado a la vista*/

--MODIFICAR UNA VISTA (DESPUES DE HABERLA CREADO OTRA VEZ)
SELECT * FROM VISTA3 
ALTER VIEW VISTA3 AS
SELECT * FROM TEMPLE WHERE SALAR > 2000