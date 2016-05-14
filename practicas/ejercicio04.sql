USE EMPRESA

--1
--Hallar por departamentos la edad en años cumplidos (en el presente año) del empleado más viejo 
-- (el empleado debe tener comisión). Ordenar el resultado por edades.
SELECT NOMDE, NOMEM, MAX(YEAR(CURRENT_TIMESTAMP) - YEAR(FECNA)) AS 'EDAD' FROM TDEPTO D, TEMPLE E
WHERE E.COMIS IS NOT NULL AND E.NUMDE = D.NUMDE
GROUP BY D.NOMDE, E.NOMEM
ORDER BY 3

--TAMBIEN SE PUEDE HACER DE ESTE MODO, TENIENDO EN CUENTA LOS DIAS
SELECT NOMDE, NOMEM, MAX(DATEDIFF(DAY, FECNA, GETDATE())/365) AS 'EDAD ACTUAL'
FROM TEMPLE E, TDEPTO D WHERE COMIS IS NOT NULL AND E.NUMDE = D.NUMDE
GROUP BY NOMDE, NOMEM ORDER BY 3

--2
--Agrupando por departamento y número de hijos, hallar cuantos empleados hay en cada grupo.
SELECT NOMDE, NUMHI, COUNT(NUMEM) AS 'NUM EMPLEADOS' FROM TDEPTO D, TEMPLE E
WHERE D.NUMDE = E.NUMDE GROUP BY NOMDE, NUMHI ORDER BY 1

--3
--Para cada extensión telefónica, hallar cuantos empleados la usan y salario medio de estos.
SELECT DISTINCT EXTEL, COUNT(NUMEM) AS 'NUM EMPLE', AVG(SALAR) AS 'SALAR MEDIO'
FROM TEMPLE GROUP BY EXTEL ORDER BY 1

--4
--Para los departamentos cuyo salario medio supera al de la empresa, hallar cuántas extensiones
-- telefónicas tienen. Se debe mostrar el número de departamento (numde) y el número de extensiones 
--telefónicas distintas que tiene cada uno de ellos.
SELECT D.NUMDE, COUNT(DISTINCT E.EXTEL) AS 'EXTENSIÓN' FROM TDEPTO D, TEMPLE E
WHERE E.NUMDE = D.NUMDE GROUP BY D.NUMDE 
HAVING AVG(E.SALAR) > (SELECT AVG(E.SALAR) FROM TEMPLE E) ORDER BY 1

--5
--Hallar el máximo valor de la suma de los salarios de los departamentos. Queremos obtener 
-- número de departamento (numde) y la suma de sus salarios, pero del departamento cuya 
-- suma de salarios es la  mayor de todas.
SELECT NUMDE, SUM(SALAR) AS 'SUMA SALARIO' FROM TEMPLE 
GROUP BY NUMDE
HAVING SUM(SALAR) >= ALL (SELECT SUM(SALAR) FROM TEMPLE GROUP BY NUMDE)
ORDER BY 1

--6
--Para cada departamento con presupuesto inferior a 10000 euros hallar el nombre del centro donde
-- está ubicado y el máximo salario de sus empleados, si éste excede de 2000 euros. Clasificar 
--alfabéticamente por nombre de departamento. Hacer el ejercicio de dos maneras: con producto 
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
--Hallar por orden alfabético los nombres de los departamentos que dependen de los que tienen un 
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
--Obtener por orden alfabético los nombres de los departamentos cuyo presupuesto es inferior al 
--10 % de la suma de los salarios anuales (14 pagas) de sus empleados.
SELECT NOMDE, PRESU FROM TDEPTO
WHERE PRESU < (SELECT SUM(SALAR * 14) * 0.1 FROM TEMPLE 
WHERE NUMDE = TDEPTO.NUMDE)
ORDER BY 1