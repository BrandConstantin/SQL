USE EMPRESA

--1
--Obtener por orden alfabético los nombres de los empleados cuyos salarios superen la
--mitad del salario del empleado 180.
SELECT NOMEM, SALAR FROM TEMPLE WHERE SALAR > (
SELECT SALAR * 0.5 FROM TEMPLE WHERE NUMEM = 180)
ORDER BY NOMEM 

--2
--Obtener por orden alfabético los nombres de los empleados cuyos salarios superen dos
--veces al mínimo salario de los empleados del departamento 121.
SELECT NOMEM, SALAR FROM TEMPLE WHERE SALAR > 
(SELECT MIN(SALAR) * 2 FROM TEMPLE WHERE NUMDE = 121)
ORDER BY 1

--3
--Obtener por orden alfabético los nombres y los salarios de los empleados cuyo salario es
--inferior a tres veces la comisión más baja existente.
SELECT NOMEM, SALAR FROM TEMPLE WHERE SALAR < 
(SELECT MIN(COMIS) * 3 FROM TEMPLE)
ORDER BY NOMEM, SALAR

--4
--Obtener, utilizando el predicado BETWEEN, por orden alfabético los nombres y los salarios
--de los empleados con hijos cuyo salario dividido por su número de hijos cumpla una, o
--ambas, de las dos condiciones siguientes:
-- Que sea inferior a 1200 Euros.
-- Que sea superior al doble de su comisión.
SELECT NOMEM, SALAR FROM TEMPLE WHERE NUMHI >= 1 AND
(SALAR / NUMHI NOT BETWEEN 1200 AND (COMIS * 2) OR COMIS IS NULL)
ORDER BY NOMEM, SALAR

--5
--Obtener por orden alfabético los nombres de los empleados cuyo primer apellido es Mora o
--empieza por Mora.
SELECT NOMEM FROM TEMPLE WHERE NOMEM LIKE 'ALE' OR NOMEM LIKE 'ALE%'

--6
--Obtener por orden alfabético los nombres de los empleados cuyo primer apellido termina
--en EZ y su nombre de pila termina en O y tiene al menos tres letras.
SELECT NOMEM FROM TEMPLE WHERE NOMEM LIKE '%EZ, %___O'

--7
--Obtener, utilizando el predicado IN, por orden alfabético los nombres de los empleados del
--departamento 111 cuyo salario es igual a alguno de los salarios del departamento 122.
--¿Cómo lo obtendrías con el predicado ANY?.
SELECT NOMEM FROM TEMPLE WHERE NUMDE = 111 AND (SALAR IN 
(SELECT SALAR FROM TEMPLE WHERE NUMDE = 122))
ORDER BY 1

SELECT NOMEM FROM TEMPLE WHERE NUMDE = 111 AND (SALAR = ANY 
(SELECT SALAR FROM TEMPLE WHERE NUMDE = 122))
ORDER BY 1

--8
--Obtener por orden alfabético los nombres y comisiones de los empleados del departamento 110
-- si hay en él algún empleado que tenga comisión.
SELECT NOMEM, COMIS FROM TEMPLE WHERE NUMDE = 110 AND COMIS IS NOT NULL
ORDER BY 1

--9
--Obtener el nombre de cada departamento, junto con el nombre del centro al que pertenece.
SELECT NOMDE, NOMCE FROM TDEPTO D, TCENTR C
WHERE D.NUMCE = C.NUMCE

--10
--Obtener el nombre de cada empleado, el número y el nombre del departamento al que pertenece
-- y el nombre del correspondiente centro.
SELECT NOMEM, NUMEM, NOMDE, NOMCE FROM TEMPLE E, TDEPTO D, TCENTR C
WHERE E.NUMDE = D.NUMDE AND D.NUMCE = C.NUMCE

--11
--Obtener para el departamento 110, su nombre, nombre del centro y la dirección, junto con
-- el nombre del empleado que es el director.
SELECT NOMDE, NOMCE, SEÑAS, NOMEM FROM TDEPTO D, TEMPLE E, TCENTR C
WHERE D.NUMDE = 110 AND (D.NUMCE = C.NUMCE AND D.DIREC = E.NUMEM)