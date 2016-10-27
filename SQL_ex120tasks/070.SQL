WITH out_ships AS
(
	SELECT DISTINCT
		Outcomes.ship AS name, battle, COALESCE(Ships.class, Ships.name) AS class
	FROM
		Outcomes
	LEFT JOIN
		Ships
	ON
		Outcomes.ship = Ships.name OR Ships.class = Outcomes.ship
	WHERE
		Ships.class IS NOT NULL OR Ships.name IS NOT NULL
),
out_ships_class AS
(
	SELECT 
		name, battle, country
	FROM
		out_ships
	INNER JOIN
		Classes
	ON
		Classes.class = out_ships.class 
)

SELECT DISTINCT
	battle
FROM
	out_ships_class
GROUP BY
	country, battle
HAVING
	COUNT(*) >= 3
