/* Query the list of CITY names from STATION which have vowels (i.e., a, e, i, o, and u) as both their first and last characters.
 Your result cannot contain duplicates. */

SELECT DISTINCT CITY FROM STATION 
    WHERE LEFT(CITY, 1) IN ('a','i','e','o','u')
    AND RIGHT(CITY, 1) IN ('a','i','e','o','u'); 

/* WICH NOT HAVE */
SELECT DISTINCT CITY FROM STATION 
    WHERE LEFT(CITY, 1) NOT IN ('a','i','e','o','u')
    OR RIGHT(CITY, 1) NOT IN ('a','i','e','o','u');     

/* dont have first and last letter */
select distinct city from station where (left(city,1) not in ('a','e','i','o','u') and  right(city,1) not in ('a','e','i','o','u'));