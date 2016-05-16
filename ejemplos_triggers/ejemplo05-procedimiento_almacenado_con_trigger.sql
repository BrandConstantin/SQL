/*Tenemos definido un trigger que realiza un rollback o un commit sobre una tabla para una operaci�n
(INSERT, DELETE, UPDATE). Si esa operaci�n sobre la tabla se realiza dentro de una transacci�n,
entoces el rollback o commit afecta a la transacci�n en la que est� incluida */

USE FORMACION

CREATE PROCEDURE PROC1 AS BEGIN TRANSACTION 

--BAJAMOS LOS SALARIOS
UPDATE TRABAJADOR SET SALARIO = SALARIO - 100 

--SUBIMOS LAS COMISIONES 
UPDATE TRABAJADOR SET COMIS = ISNULL(COMIS, 0) + 100 

COMMIT 

CREATE TRIGGER TRIG7 ON TRABAJADOR FOR UPDATE AS BEGIN
--Si nos salimos del presupuesto asignado para comisiones lo dejamos todo como estaba
IF(SELECT SUM(COMIS) FROM TRABAJADOR) > 3000
	ROLLBACK TRANSACTION
END

SELECT SUM(COMIS) FROM TRABAJADOR

PROC1

SELECT * FROM TRABAJADOR