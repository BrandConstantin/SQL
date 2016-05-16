USE CURSOS

--1
--Crear un procedimiento almacenado llamado PROC1 que muestre los apellidos,
--nombres y salarios de los trabajadores nacidos antes de 1970.
CREATE PROCEDURE PROC1 AS
SELECT NOMTRAB, APETRAB, SALARIO FROM TRABAJADOR WHERE YEAR(FECHANAC) =< 1970

DROP PROCEDURE PROC1
PROC1

--2
--Crear un procedimiento almacenado llamado PROC2, este debe llamar a PROC1 y
--dar un mensaje de finalizaci�n.

CREATE PROCEDURE PROC2 AS
EXEC PROC1 PRINT 'PROCESO FINALIZADO'

PROC2

--3
--Crear un procedimiento almacenado llamado PROC3 que muestre para cada curso
--realizado el nombre del curso, nombre y apellidos del trabajador y si es apto o no.
CREATE PROCEDURE PROC3 AS
SELECT NOMCURSO, NOMTRAB, APETRAB, APTO FROM CURSADO C,CURSO CE,TRABAJADOR T 
WHERE C.CODCURSO = CE.CODCURSO AND T.CODTRAB = C.CODTRAB 

EXEC PROC3

--4
--Crear un procedimiento almacenado llamado PROC4 que reciba el nombre de un
--curso como par�metro e indique en un mensaje de texto cuantas personas lo han
--realizado. (El mensaje tendr� la siguiente forma: �El curso NOMBRE_CURSO ha sido
--realizado por X trabajadores�). Tendr�s que utilizar la funci�n CONVERT.
CREATE PROCEDURE PROC4 @CURSO VARCHAR(10) AS
DECLARE @NUMTRAB INT

SELECT @NUMTRAB = COUNT(*) FROM CURSADO CS, CURSO C 
WHERE CS.CODCURSO = C.CODCURSO AND C.NOMCURSO = @CURSO 

PRINT 'EL CURSO ' + @CURSO + 'HA SIDO REALIZADO POR ' + CONVERT(VARCHAR(10), @NUMTRAB) + ' TRABAJADORES' 
--DROP PROCEDURE PROC4

EXEC PROC4 'OFIM�TICA 1'

--SELECT NOMCURSO FROM CURSO

--5
--Crear un procedimiento almacenado llamado PROC5 que reciba como par�metro de
--entrada el c�digo de un trabajador y deposite en un par�metro de salida cuantos
--curso ha realizado que hayan sido aptos.
CREATE PROCEDURE PROC5 @CODTRABAJADOR INT, @CUANTOS INT OUTPUT AS

SELECT @CUANTOS = COUNT(*) FROM CURSADO WHERE CODTRAB = @CODTRABAJADOR 
AND APTO = 'S'

DECLARE @NUM INT
EXEC PROC5 3, @NUM OUTPUT
PRINT @NUM

--6
--Crear un procedimiento almacenado llamado PROC6 que devuelva utilizando la
--instrucci�n RETURN el valor 1 si existe alg�n curso que no tenga fecha, en caso
--contrario devolver 2.
CREATE PROCEDURE PROC6 AS
IF(SELECT COUNT(*) FROM CURSO WHERE FECHA IS NULL) > 0
	RETURN 1
ELSE 
	RETURN 2

DECLARE @VALOR INT 
EXEC @VALOR = PROC6
PRINT @VALOR

--7
--Hacer un procedimiento almacenado que indique mediante un texto, si existe un determinado 
--curso cuyo nombre se le pasa como par�metro. Hacer el ejercicio de tres maneras:
-- ? Con la instrucci�n PRINT dentro del procedimiento almacenado. (PROC7A)
-- ? Con la instrucci�n RETURN dentro del procedimiento almacenado, de modo que si se devuelve
-- 1 indicar� que el curso existe y si devuelve 2 indicar� que no. Cuando ejecutes el
-- procedimiento almacenado, utiliza la instrucci�n PRINT para mostrar el mensaje correspondiente
-- dependiendo del valor devuelto. (PROC7B)
--? Utilizando un par�metro de salida donde depositamos el mensaje y en la ejecuci�n mostramos el 
--par�metro de salida. (PROC7C)

--A
CREATE PROCEDURE PROC7 @NOMBRECURSO VARCHAR (20) AS BEGIN
IF (SELECT COUNT(*) FROM CURSO WHERE NOMCURSO =  @NOMBRECURSO) >0
	PRINT 'EL CURSO ' +  @NOMBRECURSO + ' EXISTE'
ELSE 
	PRINT 'CURSO INEXISTENTE'
END

EXEC PROC7 'SISTEMAS'
EXEC PROC7 'LINUX AVANZADO'

--B
CREATE PROCEDURE PROC8 @NOMBRECURSO VARCHAR (20) AS BEGIN
IF (SELECT COUNT(*) FROM CURSO WHERE NOMCURSO =  @NOMBRECURSO) >0
	RETURN 1
ELSE 
	RETURN 2
END

DECLARE @VALOR INT 
EXEC @VALOR = PROC8 'SISTEMAS'
PRINT @VALOR
IF (@VALOR=1) PRINT 'EL CURSO EXISTE'
ELSE PRINT 'EL CURSO NO EXISTE'
--
DECLARE @VALOR INT 
EXEC @VALOR = PROC8 'LINUX AVANZADO'
PRINT @VALOR
IF (@VALOR=1) PRINT 'EL CURSO EXISTE'
ELSE PRINT 'CURSO INEXISTENTE'

--C
CREATE PROCEDURE PROC9 @NOMBRECURSO VARCHAR (20), @EXISTE VARCHAR(30) OUTPUT AS
IF (SELECT COUNT(*) FROM CURSO WHERE NOMCURSO =  @NOMBRECURSO) >0
	SET @EXISTE = 'EL CURSO EXISTE'
ELSE 
	SET @EXISTE = 'CURSO INEXISTENTE'

DECLARE @VALOR VARCHAR(30)
EXEC PROC9 'SISTEMAS', @VALOR OUTPUT
PRINT @VALOR

DECLARE @VALOR VARCHAR(30)
EXEC PROC9'LINUX AVANZADO',@VALOR output
PRINT @VALOR