USE EMPRESA
--1
--Hallar por orden alfabético los nombres de los departamentos cuyo director lo es en 
--funciones y no en propiedad.
SELECT * FROM TDEPTO

SELECT NOMDE FROM TDEPTO WHERE TIDIR = 'F'
ORDER BY NOMDE ASC

--2
--Obtener un listín telefónico de los empleados del departamento 121 incluyendo nombre
--del empleado, número del empleado y extensión telefónica. Por orden alfabético descendente.
SELECT NOMEM, EXTEL, NUMEM FROM TEMPLE WHERE NUMDE = 121
ORDER BY EXTEL DESC

--3
--Obtener por orden creciente una relación de todos los números de extensiones telefónicas de
-- los empleados. (elimina las repeticiones)
SELECT DISTINCT EXTEL FROM TEMPLE

--4
--Hallar la comisión, nombre y salario de los empleados con más de un hijo, clasificados por 
--comisión, y dentro de la comisión por orden alfabético. (El listado debe incluir también 
--los empleados con más de un hijo aunque no tengan comisión)
SELECT NOMEM, SALAR, COMIS, NUMHI FROM TEMPLE WHERE NUMHI > 1
ORDER BY COMIS, NOMEM ASC

--5
--Obtener salario y nombre de los empleados sin hijos por orden decreciente de salario y 
--por orden alfabético dentro del salario.
SELECT SALAR, NOMEM FROM TEMPLE WHERE NUMHI < 1 OR NUMHI IS NULL
ORDER BY SALAR DESC, NOMEM

--6
--Obtener el nombre de los empleados cuya comisión es superior o igual al 50% de su salario,
-- por orden alfabético.
SELECT NOMEM, COMIS FROM TEMPLE WHERE COMIS >= (SALAR * 50 ) / 100
ORDER BY NOMEM

--7
--En una campaña de ayuda familiar se ha decidido dar a los empleados una paga extra de 30 
--euros por hijo, a partir del tercero inclusive. Obtener por orden alfabético para estos
-- empleados: nombre y salario total que van a cobrar incluyendo esta paga extra.
SELECT NOMEM, SALAR, NUMHI, (SALAR + (30 * NUMHI)) AS 'SALAR + EXTRA' FROM TEMPLE
WHERE NUMHI >= 3 ORDER BY NOMEM

--8
--Hallar por orden alfabético los nombres de los empleados tales que si se les da una 
--gratificación de 60 euros por hijo, el total de esta gratificación no supera a la 
--décima parte de su salario.
SELECT NOMEM FROM TEMPLE WHERE NUMHI * 60 <= SALAR * 0.1
ORDER BY 1