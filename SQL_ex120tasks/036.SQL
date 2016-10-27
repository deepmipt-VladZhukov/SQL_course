SELECT 
	name
FROM (
	SELECT 
		name
	FROM 
		Ships
	UNION
	SELECT 
		ship AS name
	FROM
		Outcomes
) all_ships
INNER JOIN 
	Classes
ON
	Classes.class = all_ships.name
