/*
Query the Manhattan Distance between points p1 and p2 and round it to a scale of 4 decimal places.
*/

select round(max(lat_n)- min(lat_n) + max(long_w)-min(long_w),4) from station;