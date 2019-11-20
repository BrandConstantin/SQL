/* Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result cannot contain duplicates. */

/*SELECT DISTINCT(CITY ) FROM STATION WHERE lower(substr(CITY,1,1)) in ('a','e','i','o','u') ;*/
SELECT DISTINCT CITY FROM STATION WHERE CITY REGEXP "^[aeiou].*";

/* fon not contins */
SELECT DISTINCT CITY FROM STATION WHERE CITY NOT REGEXP "^[aeiou].*";
SELECT DISTINCT CITY FROM STATION WHERE CITY REGEXP '^[^aeiou]';