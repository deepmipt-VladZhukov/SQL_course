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
			inc_on.point AS point, SUM(inc_on.inc) AS inc
		FROM
			(
				SELECT point, inc
				FROM
					Income_o
				WHERE
					(YEAR(date) < 2001) OR 
					(YEAR(date) = 2001 AND MONTH(date) < 4) OR
					(YEAR(date) = 2001 AND MONTH(date) = 4 AND DAY(date) < 15) 
			) inc_on
		GROUP BY point
	) t1
	FULL JOIN
	(
		SELECT
			point, SUM(out) AS out
		FROM
			(
				SELECT point, out
				FROM
					Outcome_o
				WHERE
					(YEAR(date) < 2001) OR 
					(YEAR(date) = 2001 AND MONTH(date) < 4) OR
					(YEAR(date) = 2001 AND MONTH(date) = 4 AND DAY(date) < 15) 
			) out_on
		GROUP BY point
	) t2
	ON	t1.point = t2.point
) t
