/*
Query the Euclidean Distance between points p1 and p2 and format your answer to display 4 decimal digits.
*/

select round(sqrt(power(min(lat_n)-max(lat_n),2) + power(min(long_w)-max(long_w),2)),4) from station;