SELECT 
	name, displacement, numGuns
FROM
	(
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
LEFT JOIN 
	Classes
ON 
	all_ships.class = Classes.class
WHERE
	EXISTS (SELECT * FROM Outcomes WHERE Outcomes.ship = all_ships.name AND Outcomes.battle = 'Guadalcanal')
