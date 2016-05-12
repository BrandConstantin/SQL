USE EMPRESA

SELECT * FROM TEMPLE

--SACAMOS TODOS LOS EMPLEADOS QUE TENGAN EL SUELDO MAYOR QUE ALGUNO DE LOS EMPLEADOS DE 110, QUITANDO A LOS QUE ESTAN EN DEPARTAMENTO 110
SELECT * FROM TEMPLE WHERE (SALAR > ANY
(SELECT SALAR FROM TEMPLE WHERE NUMDE = 110)) AND NUMDE <> 110

--LA MISMA CONSULTA PERO BUSCANDO EL MENOR SUELDO DE 110, YA QUE SI SERA MENOR QUE ESTE, LO SER�N PARA TODOS DE 110
SELECT * FROM TEMPLE WHERE (SALAR >
(SELECT MIN(SALAR) FROM TEMPLE WHERE NUMDE = 110)) AND NUMDE <> 110

--DE OTRO M�DO
SELECT DISTINCT E1.NUMEM, E1.NOMEM, E1.SALAR FROM TEMPLE E1, TEMPLE E2
WHERE (E1.SALAR > E2.SALAR) AND E2.NUMDE = 110 AND E1.NUMDE <> 110