/*
Enter your query here.
Please append a semicolon ";" at the end of the query and enter your query in a single line to avoid error.
*/
SELECT A.myid,A.age,A.coins_needed,A.power from 
    (SELECT w1.id as myid,age,coins_needed,power,
    row_number() OVER(PARTITION BY age,power 
    ORDER BY coins_needed asc) as rn
        FROM wands w1 inner join 
    wands_property w2 on w1.code = w2.code
where is_evil = 0) A
where A.rn = 1
order by power desc, age desc;