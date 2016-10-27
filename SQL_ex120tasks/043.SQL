SELECT name
FROM(
SELECT name, date
FROM
	Battles
) bttls
WHERE NOT EXISTS (SELECT * FROM Ships WHERE year(bttls.date) = Ships.launched)
