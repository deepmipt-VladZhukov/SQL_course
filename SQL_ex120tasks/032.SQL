SELECT
	cl.country, CAST(AVG(cl.bore * cl.bore * cl.bore * 0.5) AS NUMERIC(6, 2))
FROM
(
	SELECT
		S.class, S.name
	FROM
		Ships S
	UNION
	SELECT
		'' AS class, O.Ship
	FROM
		Outcomes O
	WHERE 
		NOT EXISTS 
		(
			SELECT * 
			FROM 
				Ships 
			WHERE 
				Ships.name = O.ship
			)
) fr
LEFT JOIN
	Classes cl
ON
	cl.class = fr.class OR cl.class = fr.name
WHERE
	cl.country IS NOT NULL
GROUP BY
	cl.country
