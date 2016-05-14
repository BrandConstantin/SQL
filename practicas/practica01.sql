USE EMPRESA
--1
--Llamaremos presupuesto medio mensual de un departamento al resultado de dividir su presupuesto anual por 12. Supongamos que 
-- se decide aumentar  los presupuestos medios de todos los departamentos en un 10% a partir del mes de octubre inclusive. Para 
-- los departamentos cuyo presupuesto medio   mensual anterior a octubre es de más de 1000 euros. Obtener por orden 
-- alfabético el nombre de departamento y su presupuesto anual total después del incremento. (No queremos modificar la 
-- tabla, solo ver como quedaría).
SELECT NOMDE, 9 *(PRESU / 12) + 3 * (PRESU / 12 + (PRESU / 12) * 0.1) AS 'PRESU MEDIO MENSUAL'
FROM TDEPTO WHERE (PRESU / 12) > 1000 ORDER BY 1

--2
--Suponiendo que en los próximos dos años el coste de vida va a aumentar en un 6% anual y que se suben los salarios en la misma 
--proporción. Hallar para los empleados con más de dos hijos, su nombre y sueldo anual actual (14 pagas y no tener en cuenta la 
--comisión) y para cada uno de los próximos dos años, clasificados por orden alfabético. Utilizar alias. (No modificar la tabla,
-- solo ver como quedaría).
SELECT NOMEM, (SALAR * 14) AS 'SALAR ACTUAL', ((SALAR * 14) * 1.06) AS 'AUMENTO I AÑO', ((SALAR * 14) * 1.12) AS 'AUMENTO II AÑO' 
FROM TEMPLE WHERE NUMHI > 2 ORDER BY 1

--3
--En la fiesta de Reyes se desea realizar un espectáculo para los hijos de los empleados, que se representará en dos días 
--diferentes. El primer día asistirán los empleados cuyo apellido empiece por las letras desde la A hasta la L, ambas inclusive. 
--El segundo día se cursarán invitaciones para el resto. A cada empleado se le asignaran tantas invitaciones como hijos tenga y dos
-- más. Además en la fiesta se entregará a cada empleado un obsequio por hijo. Obtener una lista por orden alfabético de los 
--nombres a quienes hay que invitar el primer día de la representación, incluyendo también cuantas invitaciones corresponden a 
--cada nombre y cuantos regalos hay que preparar para él. Utilizar alias. Hacer dos consultas una utilizando el predicado BETWEEN 
--y otro utilizando el predicado LIKE. Busca que otros caracteres comodines se pueden utilizar además de % y _ .

--CONSULTA ECHA CON LIKE
SELECT NOMEM, (NUMHI + 2) AS 'INVITACIONES', NUMHI AS 'REGALOS' FROM TEMPLE 
WHERE NOMEM LIKE '[A-L]%' AND NUMHI > 0 ORDER BY 1
--CONSULTA ECHA CON BETWEEN
SELECT NOMEM, (NUMHI + 2) AS 'INVITACIONES', NUMHI AS 'REGALOS' FROM TEMPLE 
WHERE NUMHI > 0 AND (NOMEM BETWEEN 'A' AND 'M') AND NOMEM <> 'M' ORDER BY 1

--4
--Hallar el salario medio para cada grupo de empleados con igual comisión y para los que no la tenga.
SELECT COMIS, AVG(SALAR) AS 'SALAR MEDIO' FROM TEMPLE 
GROUP BY COMIS ORDER BY 1

--5
--A los empleados que son directores en funciones se les asignará una gratificación del 5% de su 
-- salario. Hallar por orden alfabético, los nombres de estos empleados y el salario con la gratificación 
-- correspondiente a cada uno. (No queremos modificar la tabla, solo ver como quedaría). Realizar el ejercicio 
--tres veces: con un producto cartesiano, con un join y con un subselect.

--CON PRODUCTO CARTESIANO
SELECT NOMEM, SALAR, (SALAR * 0.05) AS 'GRATIFICACIÓN', (SALAR + SALAR * 0.05) AS 'SALAR+GRATIFIC' FROM TEMPLE E, TDEPTO D
WHERE E.NUMEM = D.DIREC AND TIDIR = 'F' ORDER BY 1
--CON JOIN
SELECT NOMEM, SALAR, (SALAR * 0.05) AS 'GRATIFICACIÓN', (SALAR + SALAR * 0.05) AS 'SALAR+GRATIFIC' FROM
TEMPLE E JOIN TDEPTO D ON (E.NUMEM = D.DIREC) WHERE D.TIDIR = 'F' ORDER BY 1
--CON SUBCONSULTA
SELECT NOMEM, SALAR, (SALAR * 0.05) AS 'GRATIFICACIÓN', (SALAR + SALAR * 0.05) AS 'SALAR+GRATIFIC' FROM TEMPLE
WHERE NUMEM IN (SELECT DIREC FROM TDEPTO WHERE TIDIR = 'F')
ORDER BY 1

--6
--Consultar en la tabla temple los empleados que no son directores de departamentos y cuyo salario
-- (sin incluir comisión) supera al salario medio de los empleados de su departamento. Ordenar por nombre de empleado.
SELECT NOMEM, NUMEM, NUMDE, SALAR FROM TEMPLE
WHERE NOT EXISTS (SELECT * FROM TDEPTO WHERE NUMEM = DIREC) AND SALAR > 
(SELECT AVG(SALAR) FROM TEMPLE E WHERE E.NUMDE = NUMDE)
ORDER BY NUMDE

--7
--Comprobar que no hay empleados cuyo departamento no esté en TDEPTO.
SELECT NUMDE, NUMEM, NOMEM FROM TEMPLE WHERE NOT EXISTS (SELECT NUMDE FROM TDEPTO ) OR NUMDE IS NULL
--TAMBIÉN
SELECT NUMDE, NUMEM, NOMEM FROM TEMPLE WHERE NUMDE NOT IN (SELECT NUMDE FROM TDEPTO ) OR NUMDE IS NULL

--8
--Para los departamentos cuyo director lo es en funciones, hallar el número de empleados y la suma de sus 
--salarios, de sus comisiones. Realizar el ejercicio dos veces: con un producto cartesiano y con un subselect.

--CON UN SUBSELECT
SELECT NOMDE, DIREC, COUNT(NUMEM) AS 'NUMERO EMPLEADOS', SUM(SALAR) AS 'SUMA SALARIOS', SUM(COMIS) AS 'SUMA COMISIONES' 
FROM TEMPLE, TDEPTO WHERE NOMDE IN (SELECT NOMDE FROM TDEPTO WHERE TIDIR = 'F')  GROUP BY NOMDE, DIREC ORDER BY 1

--CON PRODUCTO CARTESIANO
SELECT NOMDE, DIREC, COUNT(NUMEM) AS 'NUMERO EMPLEADOS', SUM(SALAR) AS 'SUMA SALARIOS', SUM(COMIS) AS 'SUMA COMISIONES' 
FROM TDEPTO D LEFT JOIN TEMPLE E ON (E.NUMDE = D.NUMDE) WHERE TIDIR = 'F' GROUP BY NOMDE, DIREC ORDER BY 1

--9
--Obtener, por orden alfabético, los nombres de los empleados cuyo apellido empieza por G y trabajan en un departamento
-- ubicado en algún centro de trabajo de la calle MÁLAGA. Realiza la consulta de tres formas diferentes.

--I FORMA
SELECT NOMEM FROM TEMPLE WHERE NOMEM LIKE 'G%' AND NUMDE IN (
SELECT NUMDE FROM TDEPTO D, TCENTR C WHERE D.NUMCE = C.NUMCE AND SEÑAS LIKE '%MÁLAGA%')

--II FORMA
SELECT E.NOMEM FROM TEMPLE E, TDEPTO D, TCENTR C 
WHERE C.NUMCE = D.NUMCE AND D.NUMDE = E.NUMDE AND C.SEÑAS LIKE '%MÁLAGA%' AND E.NOMEM LIKE 'G%'

--III FORMA 
SELECT NOMEM FROM TEMPLE WHERE NOMEM LIKE 'G%' AND NUMDE IN
(SELECT NUMDE FROM TDEPTO WHERE NUMCE = ANY (SELECT NUMCE FROM TCENTR WHERE SEÑAS LIKE '%MÁLAGA%'))

--9
--Para todos los departamentos que no sean de dirección ni de sectores, obtener un listado con los 
-- números de departamento, sus nombres y extensiones telefónicas, por orden creciente de departamento
-- y, dentro de éste, por número de extensión decreciente.
SELECT DISTINCT D.NUMDE, NOMDE, EXTEL FROM TEMPLE E, TDEPTO D 
WHERE NOMDE NOT LIKE '%DIRECCIÓN%' AND NOMDE NOT LIKE '%SECTOR%' AND D.NUMDE = E.NUMDE
ORDER BY NOMDE ASC, EXTEL DESC