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
SELECT DISTINCT
	name
FROM
	(SELECT
		name, numGuns, displacement
	FROM
		all_ships
	INNER JOIN
		Classes
	ON
		all_ships.class = Classes.class
	) displ_ships_
WHERE
	numGuns = (
				SELECT 
					MAX(numGuns)
				FROM
					(SELECT
						name, numGuns, displacement
					FROM
						all_ships
					INNER JOIN
						Classes
					ON
						all_ships.class = Classes.class
					) AS D
				WHERE
					D.displacement = displ_ships_.displacement
				)
