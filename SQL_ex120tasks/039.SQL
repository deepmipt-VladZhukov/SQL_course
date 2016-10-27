SELECT DISTINCT
	ship
FROM
(
	SELECT DISTINCT
		ship, Battles.name, Battles.date
	FROM
		Outcomes, Battles	
	WHERE
		result = 'damaged' AND Battles.name = Outcomes.battle
) damaged_o
WHERE EXISTS (
	SELECT battle FROM Outcomes WHERE damaged_o.ship = ship AND damaged_o.name != battle 
	INTERSECT
	SELECT name FROM Battles WHERE Battles.date > damaged_o.date
	)
