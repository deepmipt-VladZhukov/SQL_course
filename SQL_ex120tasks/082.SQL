WITH Ordered AS
(
	SELECT 
		PC.code AS code,
		PC.price AS price, 
		number = ROW_NUMBER() OVER (ORDER BY PC.code) 
	FROM 
		PC
)
SELECT
	(
		SELECT
			code
		FROM
			Ordered
		WHERE
			 O.number - Ordered.number < 6 AND O.number - Ordered.number >= 0 AND
			number = 
			(
				SELECT MIN(number)
				FROM
					Ordered
				WHERE
					O.number - Ordered.number < 6 AND O.number - Ordered.number >= 0
			)	
	) AS code
	,
	(
		SELECT AVG(price)
		FROM
			Ordered
		WHERE
			O.number - Ordered.number < 6 AND O.number - Ordered.number >= 0
	) AS avgprc
FROM
	Ordered O
WHERE
	O.number > 5
