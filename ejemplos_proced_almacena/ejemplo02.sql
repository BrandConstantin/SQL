--Deseamos saber cuales son los empleados de un departamento
USE EMPRESA

CREATE PROCEDURE P2 @NOMBREDEPARTAMENTO VARCHAR (30) AS
SELECT NUMEM, NOMEM FROM TEMPLE E, TDEPTO D
WHERE D.NUMDE = E.NUMDE AND D.NOMDE = @NOMBREDEPARTAMENTO 

--EJECUCUCIÓN
P2 'NOMINAS'
P2 @NOMBREDEPARTAMENTO = 'PERSONAL'