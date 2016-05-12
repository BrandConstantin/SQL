USE EMPRESA

--Listar para los departamentos con más de dos empleados, su número (numde) y el máximo salario. 
SELECT NUMDE, MAX(SALAR) AS 'SALARIO MAXIMO' 
FROM TEMPLE GROUP BY NUMDE
HAVING COUNT(*) > 2
ORDER BY NUMDE

--Listar para cada departamento distinto del 112, su número (numde) y el máximo salario que se gana dentro de él.
--Teniendo en cuenta que el departamento debe tener más de dos empleados.
SELECT NUMDE, MAX(SALAR) AS 'SALRIO MAXIMO'
FROM TEMPLE WHERE NUMDE <> 112
GROUP BY NUMDE HAVING COUNT(*) > 2
ORDER BY NUMDE

--Aquí estamos agrupando por número de departamento y dentro de cada grupo (cada departamento), por número de hijos 
--(igual número de hijos) 
SELECT NUMDE, NUMHI
FROM TEMPLE GROUP BY NUMDE, NUMHI