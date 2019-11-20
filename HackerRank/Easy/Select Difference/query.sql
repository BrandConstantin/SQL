/* Find the difference between the total number of CITY entries in the table and the number of distinct CITY entries in the table. */

SELECT COUNT(CITY) - COUNT(DISTINCT(CITY)) AS N FROM STATION;

/* Query the difference between the maximum and minimum populations in CITY. */

SELECT (MAX(POPULATION) - MIN(POPULATION)) FROM CITY;