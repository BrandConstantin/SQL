USE ALBARAN

--1
--Crear un trigger para que cuando se introduce una l�nea en DETALBARAN, el precio que se almacene 
--sea el precio que tienen actualmente en la tabla de ARTICULOS.
CREATE TRIGGER TRIG1 ON DETALBARAN FOR INSERT AS BEGIN 
DECLARE @NUMALB INT, @CODART INT, @PRECIO FLOAT

SELECT @NUMALB = NUMALB, @CODART = CODART FROM INSERTED 
SELECT @PRECIO = PRECIO FROM ARTICULO WHERE CODART = @CODART

UPDATE DETALBARAN SET PRECIO = @PRECIO WHERE NUMALB = @NUMALB AND CODART = @CODART

END

--2
--Crear un trigger para controlar que si insertamos en la tabla de DETALBARAN un art�culo y no hay 
--suficiente STOCK no permita la venta, pero si esta se puede realizar, entonces que se disminuya 
--este. Hacer el ejercicio de dos maneras: borrando la fila a�adida a DETALBARAN y deshaciendo la 
--transacci�n. En ambos caso, cuando no haya suficiente stock, el trigger debe mostrar un mensaje 
--indicando cuantas unidades quedan en el almac�n.

--A
CREATE TRIGGER TRIG2 ON DETALBARAN FOR INSERT AS BEGIN 
DECLARE @CODART INT, @CANTIDAD INT, @STOCK INT, @NUMALB INT, @RTD INT 

SELECT @CODART = CODART, @CANTIDAD = CANTIDAD, @NUMALB = NUMALB FROM INSERTED 
SET @RTD = @STOCK - @CANTIDAD

IF(@RTD < 0) 
	BEGIN 
		DELETE DETALBARAN WHERE @NUMALB = NUMALB AND @CODART = CODART 
		PRINT 'NO HAY SUFICIENTE STOCK'
		PRINT 'HAY SOLO ' + CONVERT(VARCHAR(6), @STOCK) + ' UNIDADES EN EL ALMACEN'
	END
ELSE
	UPDATE ARTICULO SET STOCK = STOCK - @CANTIDAD WHERE CODART = @CODART
END

--B
CREATE TRIGGER TRIG3 ON DETALBARAN FOR INSERT AS BEGIN 
DECLARE @CODART INT, @CANTIDAD INT, @STOCK INT, @NUMALB INT, @RTD INT 

SELECT @CODART = CODART, @CANTIDAD = CANTIDAD, @NUMALB = NUMALB FROM INSERTED 
SELECT @STOCK = STOCK FROM ARTICULO WHERE CODART = @CODART
SET @RTD = @STOCK - @CANTIDAD

IF(@RTD < 0) 
	BEGIN 
		DELETE DETALBARAN WHERE @NUMALB = NUMALB AND @CODART = CODART 
		PRINT 'NO HAY SUFICIENTE STOCK'
		PRINT 'HAY SOLO ' + CONVERT(VARCHAR(6), @STOCK) + ' UNIDADES EN EL ALMACEN'
	END
ELSE
	UPDATE ARTICULO SET STOCK = STOCK - @CANTIDAD WHERE CODART = @CODART
END

--3
--Crear un trigger para controlar que cuando el stock de la tabla ARTICULO se pone 
--a 0, se almacene una fila en la tabla AUTOPEDIDO (crea la tabla ejecutando el script 
--CREA_TABLA_PEDIDO). Observa antes de realizar el ejercicio que todos los campos en esta
-- tabla se ponen por defecto menos el c�digo del art�culo.
CREATE TRIGGER TRIG4 ON ARTICULO FOR UPDATE, INSERT AS BEGIN
DECLARE  @CODARTICULO INT, @STOCK INT

SELECT @CODARTICULO = CODART, @STOCK = STOCK FROM INSERTED 
IF(@STOCK = 0)
	BEGIN 
	INSERT INTO AUTOPEDIDO (CODART) VALUES(@CODARTICULO)
	END 
END

--4
--Crear un trigger para que cuando se intente borrar un cliente que no tiene albaranes, no 
--se permita el borrado si el alta de este se realiz� el presente a�o.
CREATE TRIGGER TRIG5 ON CLIENTE FOR DELETE AS BEGIN
DECLARE @FECHAALTA DATE 

SELECT @FECHAALTA = FECHAALTA FROM DELETED

IF(YEAR(GETDATE()) - YEAR(@FECHAALTA)) = 0
	ROLLBACK TRANSACTION
END

--5
--Crear un una nueva tabla en la base de datos llamada GENERO, que nos permita almacenar 
--los g�neros de los art�culos que se venden. La estructura de la tabla es: GENERO 
--(CODGENERO INT, NOMBRE VARCHAR(50) NOT NULL). Utiliza la sentencia SQL correspondiente.
CREATE TABLE GENERO (
CODGENERO INT PRIMARY KEY,
NOMBRE VARCHAR(50) NOT NULL)
--Altera la estructura de la tabla ARTICULO e introduce el atributo CODGENERO de tipo
-- entero (este debe permitir valores nulos). No pongas este campo como foreign key. 
--Utiliza la sentencia SQL correspondiente.
ALTER TABLE ARTICULO ADD CODGENERO INT
--La integridad referencial, de modo que no se permita introducir (INSERT o UPDATE) un c�digo 
--de g�nero en la tabla ARTICULO que no exista. Hacer el ejercicio de dos maneras: la primera, 
--deshaciendo la transacci�n y la segunda, ejecutando una instrucci�n de borrado si el trigger 
--lo desencaden� una sentencia INSERT, o bien ejecutando una instrucci�n de modificaci�n para 
--dejar la tabla en su estado original si este trigger lo provoc� una sentencia UPDATE.

--A
CREATE TRIGGER TRIG6 ON ARTICULO FOR INSERT, UPDATE AS BEGIN
DECLARE  @CODGENERO INT

SELECT @CODGENERO = CODGENERO FROM INSERTED

IF(@CODGENERO IS NOT NULL)
	IF(SELECT COUNT(*) FROM GENERO WHERE CODGENERO = @CODGENERO) = 0
		BEGIN
		ROLLBACK TRANSACTION
			PRINT 'EL C�DIGO NO CORESPONDE CON NING�N GENERO'
	END
END

----------------------
CREATE TRIGGER TRIG7 ON ARTICULO FOR INSERT, UPDATE AS BEGIN
DECLARE @CODGENERO_NUEVO INT, @CODGENERO_ANTIGUO INT, @FILAS INT

SELECT @FILAS = COUNT(*) FROM DELETED
--SI FILA VALE 0 ES UN INSERT, SINO UN UPDATE
SELECT @CODGENERO_NUEVO = CODGENERO FROM INSERTED
SELECT @CODGENERO_ANTIGUO = CODGENERO FROM DELETED 

IF(@CODGENERO_NUEVO IS NOT NULL)
	IF(SELECT COUNT(*) FROM GENERO WHERE CODGENERO = @CODGENERO_NUEVO) = 0
		BEGIN
		--SI ES UN INSERT BORRAMOS, SINO DEJAMOS COMO ANTE
		IF @FILAS = 0
			DELETE FROM ARTICULO WHERE CODGENERO = @CODGENERO_NUEVO
		ELSE 
			UPDATE ARTICULO SET CODGENERO = @CODGENERO_ANTIGUO WHERE CODGENERO = @CODGENERO_NUEVO
		PRINT 'EL C�DIGO NO CORRESPONDE CON NIG�N GENREO'
	END
END

--6
--Que si borramos un g�nero, su correspondiente c�digo en la tabla de ARTICULO se ponga a NULO.
CREATE TRIGGER TRIG8 ON GENERO FOR DELETE AS BEGIN 
DECLARE @CODGENERO INT

SELECT @CODGENERO = CODGENERO FROM DELETED 

IF(SELECT COUNT(*) FROM ARTICULO WHERE CODGENERO = @CODGENERO) > 0
	UPDATE ARTICULO SET CODGENERO = NULL WHERE CODGENERO = @CODGENERO
END

--7
--Que si intentamos modificar el c�digo de un g�nero en la tabla GENERO, se modifique en CASCADA en la tabla ARTICULO.
CREATE TRIGGER TRIG9 ON GENERO FOR UPDATE AS BEGIN 
DECLARE @CODGENERO_NUEVO INT, @CODGENERO_ANTIGUO INT

SELECT @CODGENERO_NUEVO = CODGENERO FROM INSERTED 
SELECT @CODGENERO_ANTIGUO = CODGENERO FROM DELETED 

IF(SELECT COUNT(*) FROM ARTICULO WHERE CODGENERO = @CODGENERO_ANTIGUO) > 0
	UPDATE ARTICULO SET CODGENERO = @CODGENERO_NUEVO WHERE CODGENERO = @CODGENERO_ANTIGUO
END