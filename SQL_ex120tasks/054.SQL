WITH all_ships AS (
	SELECT 
		name, class
	FROM 
		Ships
	UNION
	SELECT name, class
	FROM(
		SELECT 
			ship AS name, ship AS class
		FROM
			Outcomes
	) out
	WHERE NOT EXISTS (SELECT * FROM Ships WHERE Ships.name = out.name)
) 
SELECT 
	CAST(AVG(numGuns * 1.0) AS NUMERIC(5, 2))
FROM
	all_ships
INNER JOIN
	Classes
ON
	all_ships.class = Classes.class
WHERE
	type = 'bb'
