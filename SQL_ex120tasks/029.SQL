SELECT
	Income_o.point, Income_o.date, inc, out
FROM
	Income_o 
INNER JOIN
	Outcome_o
ON 
	Income_o.point = Outcome_o.point 
	AND Income_o.date = Outcome_o.date
	AND Income_o.point IS NOT NULL 
	AND Income_o.date IS NOT NULL
UNION
SELECT
	Income_o.point, Income_o.date, inc, out
FROM
	Income_o 
LEFT JOIN
	Outcome_o
ON 
	Income_o.point = Outcome_o.point 
	AND Income_o.date = Outcome_o.date
	AND Income_o.point IS NOT NULL 
	AND Income_o.date IS NOT NULL
UNION
SELECT
	Outcome_o.point, Outcome_o.date, inc, out
FROM
	Income_o 
RIGHT JOIN
	Outcome_o
ON 
	Income_o.point = Outcome_o.point 
	AND Income_o.date = Outcome_o.date
	AND Income_o.point IS NOT NULL 
	AND Income_o.date IS NOT NULL
