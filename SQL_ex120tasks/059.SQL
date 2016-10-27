SELECT
	point, 
	CASE
		WHEN inc IS NULL THEN 0 
		ELSE inc 
	END
	-
	CASE
		WHEN out IS NULL THEN 0
		ELSE out
	END
FROM
(
	SELECT t1.point AS point, t1.inc AS inc, t2.out AS out
	FROM
	(
		SELECT 
			point, SUM(inc) AS inc
		FROM
			Income_o
		GROUP BY point
	) t1
	FULL JOIN
	(
		SELECT
			point, SUM(out) AS out
		FROM
			Outcome_o
		GROUP BY point
	) t2
	ON	t1.point = t2.point
) t
