SELECT * FROM TEMPLE

--BORRAR AQUELLAS FILAS QUE TIENEN LOS NUMEROS DE HIJOS A 0
DELETE FROM TEMPLE WHERE NUMHI = 0

--BORRAR TODAS AQUELLAS FILAS DONDE NOMBRE DE DEPARTAMENTO ES 'NUEVO'
DELETE FROM TEMPLE WHERE NUMDE IN (SELECT NUMDE FROM TDEPTO WHERE NOMDE LIKE 'NUEVO')