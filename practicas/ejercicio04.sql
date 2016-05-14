USE EMPRESA

--1
--Hallar por departamentos la edad en a�os cumplidos (en el presente a�o) del empleado m�s viejo 
-- (el empleado debe tener comisi�n). Ordenar el resultado por edades.
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
--Hallar el m�ximo valor de la suma de los salarios de los departamentos. Queremos obtener 
-- n�mero de departamento (numde) y la suma de sus salarios, pero del departamento cuya 
-- suma de salarios es la  mayor de todas.
SELECT NUMDE, SUM(SALAR) AS 'SUMA SALARIO' FROM TEMPLE 
GROUP BY NUMDE
HAVING SUM(SALAR) >= ALL (SELECT SUM(SALAR) FROM TEMPLE GROUP BY NUMDE)
ORDER BY 1

--6
--Para cada departamento con presupuesto inferior a 10000 euros hallar el nombre del centro donde
-- est� ubicado y el m�ximo salario de sus empleados, si �ste excede de 2000 euros. Clasificar 
--alfab�ticamente por nombre de departamento. Hacer el ejercicio de dos maneras: con producto 
--cartesiano y con join.

--CON PRODUCTO CARTESIANO
SELECT D.NOMDE, D.PRESU, C.NOMCE, MAX(SALAR) 'SALARIO MAXIMO' FROM TDEPTO D, TCENTR C, TEMPLE E
WHERE E.NUMDE = D.NUMDE AND D.NUMCE = C.NUMCE
GROUP BY D.NOMDE, D.PRESU, C.NOMCE 
HAVING D.PRESU < 1000 AND MAX(SALAR) > 2000
ORDER BY 1

--CON JOIN
SELECT D.NOMDE, D.PRESU, C.NOMCE, MAX(SALAR) 'SALARIO MAXIMO'
FROM (TCENTR C RIGHT JOIN TDEPTO D ON (C.NUMCE = D.NUMCE))
JOIN TEMPLE E ON (D.NUMDE = E.NUMDE)
GROUP BY D.NOMDE, D.PRESU, C.NOMCE 
HAVING D.PRESU < 1000 AND MAX(SALAR) > 2000
ORDER BY 1

--7
--Hallar por orden alfab�tico los nombres de los departamentos que dependen de los que tienen un 
--presupuesto inferior a 10000 euros. Realizar la consulta de cuatro formas distintas: con predicado 
--IN, con predicado ANY, con producto cartesiano y con join.

--CON IN
SELECT NOMDE, DEPDE FROM TDEPTO 
WHERE DEPDE IN (SELECT NUMDE FROM TDEPTO
WHERE PRESU < 10000 )
ORDER BY 1

--CON ANY
SELECT NOMDE, DEPDE FROM TDEPTO 
WHERE DEPDE = ANY (SELECT NUMDE FROM TDEPTO
WHERE PRESU < 10000 )
ORDER BY 1

--CON PRODUCTO CARTESIANO
SELECT D1.NOMDE, D2.NOMDE 
FROM TDEPTO D1, TDEPTO D2
WHERE D1.DEPDE = D2.NUMDE AND D2.PRESU < 10000
ORDER BY 1

--CON JOIN
SELECT D1.NOMDE, D2.NOMDE
FROM TDEPTO D1 JOIN TDEPTO D2 ON D1.DEPDE = D2.NUMDE
WHERE D2.PRESU < 10000
ORDER BY 1

--8
--Obtener por orden alfab�tico los nombres de los departamentos cuyo presupuesto es inferior al 
--10 % de la suma de los salarios anuales (14 pagas) de sus empleados.
SELECT NOMDE, PRESU FROM TDEPTO
WHERE PRESU < (SELECT SUM(SALAR * 14) * 0.1 FROM TEMPLE 
WHERE NUMDE = TDEPTO.NUMDE)
ORDER BY 1