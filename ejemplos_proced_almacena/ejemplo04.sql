USE EMPRESA
--Este procedimiento almacenado devuelve un 1 si la media de los salarios de un 
-- departamento pasado por parámetro supera los 2000 euros, en caso contrario 
--devuelve un 2.

CREATE PROCEDURE P4 @NOMBREDEPARTAMENTO VARCHAR(20) AS BEGIN 
IF (SELECT AVG(SALAR) FROM TDEPTO D JOIN TEMPLE E ON (D.NUMDE = E.NUMDE)
    WHERE NOMDE LIKE @NOMBREDEPARTAMENTO) > 2000
RETURN 1
ELSE 
RETURN 2 
END 

--DROP PROCEDURE P4

--EJECUCIÓN 
declare @VALOR INT 
EXECUTE @VALOR = P4 'NOMINAS'
print @VALOR

DECLARE @VALOR INT 
EXECUTE @VALOR = P4 'SECTOR%'
PRINT @VALOR