USE PROBANDO

--CREAR INDICE
SELECT * FROM JUGADOR1
CREATE INDEX INDICE1 ON JUGADOR1 (NOMBRE)

--BORRAR INICE
DROP INDEX INDICE1 ON JUGADOR1

--SI HAY VARIOS INDICES ESTOS SE SE SEPARAN POR COMA
--DROP INDEX INDICE1, INDICE2, INDICE3 FROM TABLA1