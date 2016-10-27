SELECT class
FROM
	Classes
LEFT JOIN
	Outcomes
ON
	Outcomes.ship = Classes.class
WHERE
	Outcomes.result = 'sunk'
UNION
SELECT class
FROM
	Ships
LEFT JOIN
	Outcomes
ON
	Outcomes.ship = Ships.name 
WHERE
	Outcomes.result = 'sunk'
-- WITH all_ships AS (
-- 	SELECT 
-- 		name, class
-- 	FROM 
-- 		Ships
-- 	UNION
-- 	SELECT name, class
-- 	FROM(
-- 		SELECT 
-- 			ship AS name, ship AS class
-- 		FROM
-- 			Outcomes
-- 	) out
-- 	WHERE NOT EXISTS (SELECT * FROM Ships WHERE Ships.name = out.name)
-- )

-- SELECT DISTINCT
-- 	class, name
-- FROM
-- 	all_ships
-- WHERE EXISTS (SELECT * FROM Outcomes WHERE Outcomes.ship = all_ships.name AND Outcomes.result = 'sunk')
