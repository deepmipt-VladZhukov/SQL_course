WITH 
by_month AS
(
	SELECT
		code, [point], [date], out, MONTH(date) AS [month], YEAR(date) AS [year]
	FROM
		Outcome
),
sum_month AS
(
	SELECT 
		month, year, SUM(out) AS [sum]
	FROM
		by_month
	GROUP BY
		month, year
)
SELECT
	*
FROM
	Outcome
WHERE
	(MONTH([date]) + YEAR([date]) * 13) IN 
	(
		SELECT
			month + year * 13 AS hash
		FROM
			sum_month
		WHERE [sum]  = (SELECT MAX([sum]) FROM sum_month)
	)
