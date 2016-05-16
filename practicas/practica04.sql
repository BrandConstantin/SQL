--PRACTICA ECHA EN PHPMYADMIN

--Desde el phpmyadmin crea una base de datos llamada PRACTICA5.
CREATE DATABASE PRACTICAS05

--Crea la tabla en modo visual. NOMDEP no admite nulos.
CREATE TABLE `PRACTICA05`.`DEP` ( `NUMDEP` INT NULL , `NOMDEP` VARCHAR(15) NOT NULL ) ENGINE = InnoDB;

--Crea la tabla en modo visual. NUMOFI se debe incrementar automáticamente y NOMOFI no admite nulos.
CREATE TABLE `practica05`.`OFI` ( `NUMOFI` SMALLINT NOT NULL AUTO_INCREMENT , `NOMOFI` VARCHAR(15) NOT NULL , 
UNIQUE `INDICE1` (`NUMOFI`)) ENGINE = InnoDB;

--EMP(NUMEMP , NOMEMP, DNIEMP, FECHALT, SALARIO, COMISION, *NUMOFI INT, *NUMDEP INT).
--Crea la tabla utilizando el LDD. Ningún campo admite nulos, excepto COMIS y NUMDEP.
 --DNIEMP debe comprobar que sea DNI correcto y que no se puedan repetir en la tabla. 
 --FECHALT debe tomar por defecto la fecha del día en que se da de alta a un empleado en la empresa. 
 --SALARIO debe admitir un número como máximo de 4 dígitos y dos decimales.
 -- COMIS debe admitir un número como máximo de 3 dígitos y dos decimales.
CREATE TABLE `practica05`.`EMP` ( `NUMEMP` INT NOT NULL , `NOMEMP` INT NOT NULL , `DNIEMP` VARCHAR(9) NOT NULL ,
 `FECHALT` DATE NOT NULL , `SALARIO` DOUBLE(4,2) NOT NULL , `COMISION` DOUBLE(3,2) NULL DEFAULT NULL , 
 `NUMOFI` INT NOT NULL , `NUMDEP` INT NULL DEFAULT NULL , UNIQUE `INDICE2` (`DNIEMP`(9))) ENGINE = InnoDB;

 ALTER TABLE `emp` ADD PRIMARY KEY(`NUMEMP`);
 ALTER TABLE `dep` ADD PRIMARY KEY(`NUMDEP`);
 ALTER TABLE `ofi` ADD PRIMARY KEY(`NUMOFI`);

 --Si se intenta borrar en la tabla de oficios, un oficio (puesto) que ocupa un empleado no se permitirá.
 ALTER TABLE `emp` CHANGE `NUMOFI` `NUMOFI` SMALLINT(6) NOT NULL;
 ALTER TABLE `ofi` CHANGE `NUMOFI` `NUMOFI` INT(11) NOT NULL AUTO_INCREMENT;

 ALTER TABLE `ofi` ADD CONSTRAINT `RES2` FOREIGN KEY (`NUMOFI`) REFERENCES `practica05`.`emp`(`NUMEMP`) 
 ON DELETE RESTRICT ON UPDATE CASCADE;

--Si se borra un departamento que tiene empleados, dichos empleados tendrán el campo NUMDEP con valor 
--nulo hasta nueva reasignación.
