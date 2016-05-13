USE EMPRESA

--1
--Hallar el nombre de los empleados que no tienen comisión, clasificados de
--manera que aparezca primero aquellos nombres que son más cortos.
SELECT NOMEM FROM TEMPLE WHERE COMIS IS NULL
ORDER BY LEN(NOMEM)

--2
--Hallar, por orden alfabético, los nombres de los empleados suprimiendo las
--dos últimas letras. Mirar en la ayuda el funcionamiento de las funciones
--escalares de manejo de cadena: substring y len.
SELECT SUBSTRING(NOMEM, 1, (LEN(NOMEM) - 2)) AS 'NOMBRES CORTOS' FROM TEMPLE
ORDER BY NOMEM ASC

--3
--Hallar cuántos departamentos hay y el presupuesto anual medio de ellos.
SELECT COUNT(NUMDE) AS 'NÚMERO DEPARTAMENTOS', AVG(PRESU) AS 'PRESUPUETO MEDIO ANUAL' FROM TDEPTO

--4
--Hallar la masa salarial anual (salario más comisión) de la empresa (se
--suponen 14 pagas anuales).
SELECT (SUM(SALAR) + SUM(COMIS)) * 14 AS ' MASA SALARIAL' FROM TEMPLE

--5
--Hallar cuántos empleados han ingresado en el año actual. Utiliza la función year.
SELECT * FROM TEMPLE WHERE YEAR(FECIN) = YEAR(CURRENT_TIMESTAMP) OR FECIN IS NULL

--6
--Hallar la diferencia entre el salario más alto y el salario más bajo.
SELECT (MAX(SALAR) - MIN(SALAR)) AS 'DIFERENCIA SALARIAL' FROM TEMPLE