USE PROBANDO

CREATE TABLE ATLETA2(
NUMERO INT,
NOMBRE VARCHAR (20),
DNI VARCHAR (9),
CONSTRAINT RESTRIC1 PRIMARY KEY(NUMERO),
CONSTRAINT RESTRIC2 FOREIGN KEY (NUMERO) REFERENCES ATLETA (NUMERO))

--DECLARAR QUE CUANDO SE ACTUALIZA LA TABLA QUE SE ACTUALIZE TODO LO QUE ESTA RELACIONADO CON UPDATE CASCADE
CREATE TABLE ATLETA3(
NUMERO INT,
NOMBRE VARCHAR (20),
DNI VARCHAR (9),
CONSTRAINT RESTRIC3 PRIMARY KEY(NUMERO),
CONSTRAINT RESTRIC4 FOREIGN KEY (NUMERO) REFERENCES ATLETA2 (NUMERO)
ON UPDATE CASCADE)

SELECT * FROM ATLETA3


--DECLARAR QUE CUANDO SE BORRAN COLUMNA QUE SE LES PONGA EL VALOR EN NULL CON DELETE SET NULL
CREATE TABLE ATLETA4(
NUMERO INT, 
NOMBRE VARCHAR(20), 
CONSTRAINT RESTRIC5 FOREIGN KEY(NUMERO) REFERENCES ATLETA3(NUMERO)
ON DELETE SET NULL)

SELECT * FROM ATLETA4