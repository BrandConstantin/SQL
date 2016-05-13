USE EMPRESA
--1
--Hallar por orden alfab�tico los nombres de los departamentos cuyo director lo es en 
--funciones y no en propiedad.
SELECT * FROM TDEPTO

SELECT NOMDE FROM TDEPTO WHERE TIDIR = 'F'
ORDER BY NOMDE ASC

--2
--Obtener un list�n telef�nico de los empleados del departamento 121 incluyendo nombre
--del empleado, n�mero del empleado y extensi�n telef�nica. Por orden alfab�tico descendente.
SELECT NOMEM, EXTEL, NUMEM FROM TEMPLE WHERE NUMDE = 121
ORDER BY EXTEL DESC

--3
--Obtener por orden creciente una relaci�n de todos los n�meros de extensiones telef�nicas de
-- los empleados. (elimina las repeticiones)
SELECT DISTINCT EXTEL FROM TEMPLE

--4
--Hallar la comisi�n, nombre y salario de los empleados con m�s de un hijo, clasificados por 
--comisi�n, y dentro de la comisi�n por orden alfab�tico. (El listado debe incluir tambi�n 
--los empleados con m�s de un hijo aunque no tengan comisi�n)
SELECT NOMEM, SALAR, COMIS, NUMHI FROM TEMPLE WHERE NUMHI > 1
ORDER BY COMIS, NOMEM ASC

--5
--Obtener salario y nombre de los empleados sin hijos por orden decreciente de salario y 
--por orden alfab�tico dentro del salario.
SELECT SALAR, NOMEM FROM TEMPLE WHERE NUMHI < 1 OR NUMHI IS NULL
ORDER BY SALAR DESC, NOMEM

--6
--Obtener el nombre de los empleados cuya comisi�n es superior o igual al 50% de su salario,
-- por orden alfab�tico.
SELECT NOMEM, COMIS FROM TEMPLE WHERE COMIS >= (SALAR * 50 ) / 100
ORDER BY NOMEM

--7
--En una campa�a de ayuda familiar se ha decidido dar a los empleados una paga extra de 30 
--euros por hijo, a partir del tercero inclusive. Obtener por orden alfab�tico para estos
-- empleados: nombre y salario total que van a cobrar incluyendo esta paga extra.
SELECT NOMEM, SALAR, NUMHI, (SALAR + (30 * NUMHI)) AS 'SALAR + EXTRA' FROM TEMPLE
WHERE NUMHI >= 3 ORDER BY NOMEM

--8
--Hallar por orden alfab�tico los nombres de los empleados tales que si se les da una 
--gratificaci�n de 60 euros por hijo, el total de esta gratificaci�n no supera a la 
--d�cima parte de su salario.
SELECT NOMEM FROM TEMPLE WHERE NUMHI * 60 <= SALAR * 0.1
ORDER BY 1