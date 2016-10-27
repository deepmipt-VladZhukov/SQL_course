SELECT
	class
FROM
(
SELECT 
	Classes.class, name
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
) all_ships
INNER JOIN 
	Classes
ON
	Classes.class = all_ships.class
) T
GROUP BY
	T.class
HAVING
	COUNT(T.name) = 1
