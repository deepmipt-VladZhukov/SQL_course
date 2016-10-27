WITH all_ships AS (
	SELECT
		name, Classes.class
	FROM (
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
	) sh_cl
	RIGHT JOIN
		Classes
	ON
		sh_cl.class = Classes.class
) 

SELECT class, COUNT(result) AS sunk
FROM (
	SELECT class, Outcomes.result
	FROM
		all_ships
	LEFT JOIN
		Outcomes
	ON
		all_ships.name = Outcomes.ship AND Outcomes.result = 'sunk'
) T
GROUP BY class
HAVING 
	COUNT(class) > 2 AND
	COUNT(result) > 0
