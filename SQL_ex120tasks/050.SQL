SELECT DISTINCT battle 
FROM(
SELECT
	battle, ship
FROM
	Outcomes
) btl
WHERE
	EXISTS (SELECT * FROM Ships WHERE btl.ship = Ships.name AND Ships.class = 'Kongo')
