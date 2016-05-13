USE EMPRESA

--1
--Hallar por departamentos la edad en a�os cumplidos (en el presente a�o) del empleado m�s viejo (el empleado debe tener comisi�n). 
--Ordenar el resultado por edades.
SELECT NOMDE, NOMEM, MAX(YEAR(CURRENT_TIMESTAMP) - YEAR(FECNA)) AS 'EDAD' FROM TDEPTO D, TEMPLE E
WHERE E.COMIS IS NOT NULL AND E.NUMDE = D.NUMDE
GROUP BY D.NOMDE, E.NOMEM
ORDER BY 3

--TAMBIEN SE PUEDE HACER DE ESTE MODO, TENIENDO EN CUENTA LOS DIAS
SELECT NOMDE, NOMEM, MAX(DATEDIFF(DAY, FECNA, GETDATE())/365) AS 'EDAD ACTUAL'
FROM TEMPLE E, TDEPTO D WHERE COMIS IS NOT NULL AND E.NUMDE = D.NUMDE
GROUP BY NOMDE, NOMEM ORDER BY 3

--2
--Agrupando por departamento y n�mero de hijos, hallar cuantos empleados hay en cada grupo.
SELECT NOMDE, NUMHI, COUNT(NUMEM) AS 'NUM EMPLEADOS' FROM TDEPTO D, TEMPLE E
WHERE D.NUMDE = E.NUMDE GROUP BY NOMDE, NUMHI ORDER BY 1

--3
--Para cada extensi�n telef�nica, hallar cuantos empleados la usan y salario medio de estos.
SELECT DISTINCT EXTEL, COUNT(NUMEM) AS 'NUM EMPLE', AVG(SALAR) AS 'SALAR MEDIO'
FROM TEMPLE GROUP BY EXTEL ORDER BY 1

--4
--Para los departamentos cuyo salario medio supera al de la empresa, hallar cu�ntas extensiones
-- telef�nicas tienen. Se debe mostrar el n�mero de departamento (numde) y el n�mero de extensiones 
--telef�nicas distintas que tiene cada uno de ellos.
SELECT D.NUMDE, COUNT(DISTINCT E.EXTEL) AS 'EXTENSI�N' FROM TDEPTO D, TEMPLE E
WHERE E.NUMDE = D.NUMDE GROUP BY D.NUMDE 
HAVING AVG(E.SALAR) > (SELECT AVG(E.SALAR) FROM TEMPLE E) ORDER BY 1

--5