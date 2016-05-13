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