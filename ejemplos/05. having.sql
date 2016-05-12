USE EMPRESA

--Listar para los departamentos con m�s de dos empleados, su n�mero (numde) y el m�ximo salario. 
SELECT NUMDE, MAX(SALAR) AS 'SALARIO MAXIMO' 
FROM TEMPLE GROUP BY NUMDE
HAVING COUNT(*) > 2
ORDER BY NUMDE

--Listar para cada departamento distinto del 112, su n�mero (numde) y el m�ximo salario que se gana dentro de �l.
--Teniendo en cuenta que el departamento debe tener m�s de dos empleados.
SELECT NUMDE, MAX(SALAR) AS 'SALRIO MAXIMO'
FROM TEMPLE WHERE NUMDE <> 112
GROUP BY NUMDE HAVING COUNT(*) > 2
ORDER BY NUMDE

--Aqu� estamos agrupando por n�mero de departamento y dentro de cada grupo (cada departamento), por n�mero de hijos 
--(igual n�mero de hijos) 
SELECT NUMDE, NUMHI
FROM TEMPLE GROUP BY NUMDE, NUMHI