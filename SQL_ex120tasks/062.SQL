SELECT
COALESCE(
	(
		SELECT 
			SUM(inc) 
		FROM 
			Income_o 
		WHERE 
			inc IS NOT NULL AND 
			point is not null AND
			((YEAR(date) < 2001) OR 
			(YEAR(date) = 2001 AND MONTH(date) < 4) OR
			(YEAR(date) = 2001 AND MONTH(date) = 4 AND DAY(date) < 15)) 
	), 0

) - 
COALESCE(
	(
		SELECT 
			SUM(out) 
		FROM Outcome_o 
		WHERE 
			out IS NOT NULL 
			and point is not null
			AND
			(					(YEAR(date) < 2001) OR 
					(YEAR(date) = 2001 AND MONTH(date) < 4) OR
					(YEAR(date) = 2001 AND MONTH(date) = 4 AND DAY(date) < 15) )
	), 0
)  AS SUM
