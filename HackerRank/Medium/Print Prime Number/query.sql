/*
Write a query to print all prime numbers less than or equal to 1000. Print your result on a single line, 
and use the ampersand (&) character as your separator (instead of a space).
*/

SELECT GROUP_CONCAT(NUMB SEPARATOR '&')
FROM (
    SELECT @num:=@num+1 as NUMB FROM
    information_schema.tables t1,
    information_schema.tables t2,
    (SELECT @num:=1) tmp
) tempNum
WHERE NUMB<=1000 AND NOT EXISTS(
    SELECT * FROM (
        SELECT @nu:=@nu+1 as NUMA FROM
            information_schema.tables t1,
            information_schema.tables t2,
            (SELECT @nu:=1) tmp1
            LIMIT 1000
        ) tatata
    WHERE FLOOR(NUMB/NUMA)=(NUMB/NUMA) AND NUMA<NUMB AND NUMA>1
)

/*
I think we can break the query in 3 parts, just for understanding purpose.

Generate all the numbers from 1 to 1000.
For every number i in {1..1000}, find whether a number j such that j < i and i % j = 0 exists. If it does then
 it implies i is prime.
At last, all the primes are combined to form the string of type "prime1&prime2&...".
Now the details of every step is as follows.

1. Generate numbers from 1 to 1000

The inner query in the first FROM clause gives a table with only one column NUMB which contains numbers from
 2 to (no_of_rows(information_schema.tables) * no_of_rows(information_schema.tables)) + 1.

SELECT @num:=@num+1 as NUMB FROM
    information_schema.tables t1,
    information_schema.tables t2,
    (SELECT @num:=1) tmp
The information_schema.tables is kind of a default table. It is used here just to increment the @num variable
 enough number of times(at least 1000 times). This table has 63 rows(if I remember correctly), so it can only 
 execute the statement in the SELECT clause 63 times(thus we can only increment @num to 64). Therefore the cross
  join is used to get 63* 63 rows(> 1000) and this is the reason query is using information_schema.tables 2 
  times.

2. Find the prime numbers

The inner query inside the EXISTS is a correlated query because it is referencing the NUMB column which is 
outside of it(a correlated query is an inner query which is evaluated for every row of the outer table).

SELECT * FROM (
			SELECT @nu:=@nu+1 as NUMA FROM
			    information_schema.tables t1,
			    information_schema.tables t2,
			    (SELECT @nu:=1) tmp1
			    LIMIT 1000
			) tatata
		WHERE FLOOR(NUMB/NUMA)=(NUMB/NUMA) AND NUMA<NUMB AND NUMA>1
This inner query is again using the same trick to generate all the integer j from 1 to 1000 that are less 
than the current NUMB and divides NUMB(which implies that current value of NUMB is a prime number). The 
execution of this query is stopped as soon as first such j is found because it is inside of EXISTS.

3. Generating the string "prime1&prime2&..."

The GROUP_CONCAT(NUMB SEPARATOR '&') function is used to concat all the primes(which are present in select 
clause under the column name NUMB) separated by '&'.
*/