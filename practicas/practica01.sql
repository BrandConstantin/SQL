USE EMPRESA
--1
--Llamaremos presupuesto medio mensual de un departamento al resultado de dividir su presupuesto anual por 12. Supongamos que 
-- se decide aumentar  los presupuestos medios de todos los departamentos en un 10% a partir del mes de octubre inclusive. Para 
-- los departamentos cuyo presupuesto medio   mensual anterior a octubre es de m�s de 1000 euros. Obtener por orden 
-- alfab�tico el nombre de departamento y su presupuesto anual total despu�s del incremento. (No queremos modificar la 
-- tabla, solo ver como quedar�a).
SELECT NOMDE, 9 *(PRESU / 12) + 3 * (PRESU / 12 + (PRESU / 12) * 0.1) AS 'PRESU MEDIO MENSUAL'
FROM TDEPTO WHERE (PRESU / 12) > 1000 ORDER BY 1

--2
--Suponiendo que en los pr�ximos dos a�os el coste de vida va a aumentar en un 6% anual y que se suben los salarios en la misma 
--proporci�n. Hallar para los empleados con m�s de dos hijos, su nombre y sueldo anual actual (14 pagas y no tener en cuenta la 
--comisi�n) y para cada uno de los pr�ximos dos a�os, clasificados por orden alfab�tico. Utilizar alias. (No modificar la tabla,
-- solo ver como quedar�a).
SELECT NOMEM, (SALAR * 14) AS 'SALAR ACTUAL', ((SALAR * 14) * 1.06) AS 'AUMENTO I A�O', ((SALAR * 14) * 1.12) AS 'AUMENTO II A�O' 
FROM TEMPLE WHERE NUMHI > 2 ORDER BY 1

--3
--En la fiesta de Reyes se desea realizar un espect�culo para los hijos de los empleados, que se representar� en dos d�as 
--diferentes. El primer d�a asistir�n los empleados cuyo apellido empiece por las letras desde la A hasta la L, ambas inclusive. 
--El segundo d�a se cursar�n invitaciones para el resto. A cada empleado se le asignaran tantas invitaciones como hijos tenga y dos
-- m�s. Adem�s en la fiesta se entregar� a cada empleado un obsequio por hijo. Obtener una lista por orden alfab�tico de los 
--nombres a quienes hay que invitar el primer d�a de la representaci�n, incluyendo tambi�n cuantas invitaciones corresponden a 
--cada nombre y cuantos regalos hay que preparar para �l. Utilizar alias. Hacer dos consultas una utilizando el predicado BETWEEN 
--y otro utilizando el predicado LIKE. Busca que otros caracteres comodines se pueden utilizar adem�s de % y _ .

--CONSULTA ECHA CON LIKE
SELECT NOMEM, (NUMHI + 2) AS 'INVITACIONES', NUMHI AS 'REGALOS' FROM TEMPLE 
WHERE NOMEM LIKE '[A-L]%' AND NUMHI > 0 ORDER BY 1
--CONSULTA ECHA CON BETWEEN
SELECT NOMEM, (NUMHI + 2) AS 'INVITACIONES', NUMHI AS 'REGALOS' FROM TEMPLE 
WHERE NUMHI > 0 AND (NOMEM BETWEEN 'A' AND 'M') AND NOMEM <> 'M' ORDER BY 1

--4
--Hallar el salario medio para cada grupo de empleados con igual comisi�n y para los que no la tenga.
SELECT COMIS, AVG(SALAR) AS 'SALAR MEDIO' FROM TEMPLE 
GROUP BY COMIS ORDER BY 1

--5
--A los empleados que son directores en funciones se les asignar� una gratificaci�n del 5% de su 
-- salario. Hallar por orden alfab�tico, los nombres de estos empleados y el salario con la gratificaci�n 
-- correspondiente a cada uno. (No queremos modificar la tabla, solo ver como quedar�a). Realizar el ejercicio 
--tres veces: con un producto cartesiano, con un join y con un subselect.

--CON PRODUCTO CARTESIANO
SELECT NOMEM, SALAR, (SALAR * 0.05) AS 'GRATIFICACI�N', (SALAR + SALAR * 0.05) AS 'SALAR+GRATIFIC' FROM TEMPLE E, TDEPTO D
WHERE E.NUMEM = D.DIREC AND TIDIR = 'F' ORDER BY 1
--CON JOIN
SELECT NOMEM, SALAR, (SALAR * 0.05) AS 'GRATIFICACI�N', (SALAR + SALAR * 0.05) AS 'SALAR+GRATIFIC' FROM
TEMPLE E JOIN TDEPTO D ON (E.NUMEM = D.DIREC) WHERE D.TIDIR = 'F' ORDER BY 1
--CON SUBCONSULTA
SELECT NOMEM, SALAR, (SALAR * 0.05) AS 'GRATIFICACI�N', (SALAR + SALAR * 0.05) AS 'SALAR+GRATIFIC' FROM TEMPLE
WHERE NUMEM IN (SELECT DIREC FROM TDEPTO WHERE TIDIR = 'F')
ORDER BY 1

--6
--Consultar en la tabla temple los empleados que no son directores de departamentos y cuyo salario
-- (sin incluir comisi�n) supera al salario medio de los empleados de su departamento. Ordenar por nombre de empleado.
SELECT NOMEM, NUMEM, NUMDE, SALAR FROM TEMPLE
WHERE NOT EXISTS (SELECT * FROM TDEPTO WHERE NUMEM = DIREC) AND SALAR > 
(SELECT AVG(SALAR) FROM TEMPLE E WHERE E.NUMDE = NUMDE)
ORDER BY NUMDE

--7
--Comprobar que no hay empleados cuyo departamento no est� en TDEPTO.
SELECT NUMDE, NUMEM, NOMEM FROM TEMPLE WHERE NOT EXISTS (SELECT NUMDE FROM TDEPTO ) OR NUMDE IS NULL
--TAMBI�N
SELECT NUMDE, NUMEM, NOMEM FROM TEMPLE WHERE NUMDE NOT IN (SELECT NUMDE FROM TDEPTO ) OR NUMDE IS NULL

--8
--Para los departamentos cuyo director lo es en funciones, hallar el n�mero de empleados y la suma de sus 
--salarios, de sus comisiones. Realizar el ejercicio dos veces: con un producto cartesiano y con un subselect.

--CON UN SUBSELECT
SELECT NOMDE, DIREC, COUNT(NUMEM) AS 'NUMERO EMPLEADOS', SUM(SALAR) AS 'SUMA SALARIOS', SUM(COMIS) AS 'SUMA COMISIONES' 
FROM TEMPLE, TDEPTO WHERE NOMDE IN (SELECT NOMDE FROM TDEPTO WHERE TIDIR = 'F')  GROUP BY NOMDE, DIREC ORDER BY 1

--CON PRODUCTO CARTESIANO
SELECT NOMDE, DIREC, COUNT(NUMEM) AS 'NUMERO EMPLEADOS', SUM(SALAR) AS 'SUMA SALARIOS', SUM(COMIS) AS 'SUMA COMISIONES' 
FROM TDEPTO D LEFT JOIN TEMPLE E ON (E.NUMDE = D.NUMDE) WHERE TIDIR = 'F' GROUP BY NOMDE, DIREC ORDER BY 1

--9
--Obtener, por orden alfab�tico, los nombres de los empleados cuyo apellido empieza por G y trabajan en un departamento
-- ubicado en alg�n centro de trabajo de la calle M�LAGA. Realiza la consulta de tres formas diferentes.

--I FORMA
SELECT NOMEM FROM TEMPLE WHERE NOMEM LIKE 'G%' AND NUMDE IN (
SELECT NUMDE FROM TDEPTO D, TCENTR C WHERE D.NUMCE = C.NUMCE AND SE�AS LIKE '%M�LAGA%')

--II FORMA
SELECT E.NOMEM FROM TEMPLE E, TDEPTO D, TCENTR C 
WHERE C.NUMCE = D.NUMCE AND D.NUMDE = E.NUMDE AND C.SE�AS LIKE '%M�LAGA%' AND E.NOMEM LIKE 'G%'

--III FORMA 
SELECT NOMEM FROM TEMPLE WHERE NOMEM LIKE 'G%' AND NUMDE IN
(SELECT NUMDE FROM TDEPTO WHERE NUMCE = ANY (SELECT NUMCE FROM TCENTR WHERE SE�AS LIKE '%M�LAGA%'))

--9
--Para todos los departamentos que no sean de direcci�n ni de sectores, obtener un listado con los 
-- n�meros de departamento, sus nombres y extensiones telef�nicas, por orden creciente de departamento
-- y, dentro de �ste, por n�mero de extensi�n decreciente.
SELECT DISTINCT D.NUMDE, NOMDE, EXTEL FROM TEMPLE E, TDEPTO D 
WHERE NOMDE NOT LIKE '%DIRECCI�N%' AND NOMDE NOT LIKE '%SECTOR%' AND D.NUMDE = E.NUMDE
ORDER BY NOMDE ASC, EXTEL DESC