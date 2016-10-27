SELECT DISTINCT
	country, name
FROM
	Battles, Classes
EXCEPT
SELECT
	country, battle
FROM
	Outcomes out
LEFT JOIN
	Ships sh
ON
	sh.name = out.ship
LEFT JOIN
	Classes cl
ON
	(out.ship = cl.class OR sh.class = cl.class)
WHERE 
	country IS NOT NULL
