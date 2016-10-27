WITH come AS
(
	SELECT
		point, date, SUM([add]) AS [add]
	FROM
	(	
		SELECT 
			point, date, inc AS [add]
		FROM
			Income
		union all
		SELECT 
			point, date, -out AS [add]
		FROM
			Outcome
	) t
	GROUP BY
		point, date
)

SELECT
	point, CONVERT (char(30), date, 103),
	(
		SELECT 
			SUM([add])
		FROM 
			come 
		WHERE
			come.point = come2.point AND
			come.date <= come2.date
	)
FROM
	come AS come2

	--CONVERT (char(30), date, 103)
