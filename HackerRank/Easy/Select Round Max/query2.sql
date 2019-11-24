/*
Query the Western Longitude (LONG_W) for the largest Northern Latitude (LAT_N) in STATION that is less than 137.2345.
 Round your answer to 4 decimal places.
 */

SELECT ROUND(LONG_W, 4) FROM STATION WHERE LAT_N = (SELECT MAX(LAT_N) FROM STATION WHERE LAT_N  < 137.2345); 

/*
Query the smallest Northern Latitude (LAT_N) from STATION that is greater than 38.7780 . Round your answer to  
4 decimal places.
*/
SELECT ROUND(LAT_N, 4) FROM STATION WHERE LAT_N = (SELECT MIN(LAT_N) FROM STATION WHERE LAT_N  > 38.7780);