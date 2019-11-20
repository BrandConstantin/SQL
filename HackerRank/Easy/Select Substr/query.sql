/* Query the list of CITY names from STATION which have vowels (i.e., a, e, i, o, and u) as last characters. Your result cannot contain duplicates. */

SELECT DISTINCT CITY FROM STATION WHERE SUBSTR(CITY, LENGTH(CITY), LENGTH(CITY)) IN ('a','i','e','o','u');

/* which not have vowls */
SELECT DISTINCT CITY FROM STATION WHERE SUBSTR(CITY, LENGTH(CITY), LENGTH(CITY)) NOT IN ('a','i','e','o','u');