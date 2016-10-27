SELECT 
	name
FROM
	Ships
WHERE
	name LIKE 'R%'
Union
SELECT
	ship
FROM
	Outcomes
WHERE
	ship LIKE 'R%'
