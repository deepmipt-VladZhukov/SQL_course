SELECT
	COALESCE(first.point, second.point), 
	COALESCE(first.date, second.date), 
	out_sum, 
	inc_sum
FROM
(
	SELECT
		MAX(Income.point) AS point, 
		MAX(Income.date) AS date, 
		SUM(Income.inc) AS inc_sum
	FROM
		Income
	GROUP BY
		Income.point, Income.date
)
first
FULL JOIN
(
	SELECT
		MAX(Outcome.point) AS point, 
		MAX(Outcome.date) AS date, 
		SUM(Outcome.out) AS out_sum
	FROM
		Outcome
	GROUP BY
		Outcome.point, Outcome.date
)
second
ON
	first.point = second.point AND first.date = second.date
