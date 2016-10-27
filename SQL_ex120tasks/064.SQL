SELECT
	point, date, 'inc' AS operation, SUM(inc)
FROM
(
	SELECT 
		point, date, 'inc' AS operation, inc
	FROM
		Income
) t
WHERE 
	NOT EXISTS(SELECT date FROM Outcome WHERE Outcome.date = t.date AND Outcome.point = t.point)
GROUP BY
	point, date

union all

SELECT
	point, date, 'out' AS operation, SUM(out)
FROM
(
	SELECT 
		point, date, 'out' AS operation, out
	FROM
		Outcome
) t
WHERE 
	NOT EXISTS(SELECT date FROM Income WHERE Income.date = t.date AND Income.point = t.point)
GROUP BY
	point, date
