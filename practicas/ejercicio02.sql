USE EMPRESA

--1
--Hallar el nombre de los empleados que no tienen comisi�n, clasificados de
--manera que aparezca primero aquellos nombres que son m�s cortos.
SELECT NOMEM FROM TEMPLE WHERE COMIS IS NULL
ORDER BY LEN(NOMEM)

--2
--Hallar, por orden alfab�tico, los nombres de los empleados suprimiendo las
--dos �ltimas letras. Mirar en la ayuda el funcionamiento de las funciones
--escalares de manejo de cadena: substring y len.
SELECT SUBSTRING(NOMEM, 1, (LEN(NOMEM) - 2)) AS 'NOMBRES CORTOS' FROM TEMPLE
ORDER BY NOMEM ASC

--3
--Hallar cu�ntos departamentos hay y el presupuesto anual medio de ellos.
SELECT COUNT(NUMDE) AS 'N�MERO DEPARTAMENTOS', AVG(PRESU) AS 'PRESUPUETO MEDIO ANUAL' FROM TDEPTO

--4
--Hallar la masa salarial anual (salario m�s comisi�n) de la empresa (se
--suponen 14 pagas anuales).
SELECT (SUM(SALAR) + SUM(COMIS)) * 14 AS ' MASA SALARIAL' FROM TEMPLE

--5
--Hallar cu�ntos empleados han ingresado en el a�o actual. Utiliza la funci�n year.
SELECT * FROM TEMPLE WHERE YEAR(FECIN) = YEAR(CURRENT_TIMESTAMP) OR FECIN IS NULL

--6
--Hallar la diferencia entre el salario m�s alto y el salario m�s bajo.
SELECT (MAX(SALAR) - MIN(SALAR)) AS 'DIFERENCIA SALARIAL' FROM TEMPLE