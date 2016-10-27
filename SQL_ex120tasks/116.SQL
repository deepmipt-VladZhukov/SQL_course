SELECT DISTINCT min (dateti) over (partition by d)mn, DATEADD(ss, 1, max(dateti)over(partition by d))mx from(
SELECT *, row_number()over(partition by d ORDER BY dateti)r FROM(
SELECT dateti, sum(iif(d=1,0,1))over(ORDER BY dateti)d from(
SELECT dateti, datediff(ss,dateti, lead(dateti)over(ORDER BY dateti))d FROM (
SELECT distinct b_datetime dateti from utb
)a
)b
)c
)d where r > 1
