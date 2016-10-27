SELECT DISTINCT
	maker
FROM
	Product Pr1
WHERE
	NOT EXISTS 
	(
		SELECT * FROM Product 
		WHERE Product.maker = Pr1.maker AND Product.type != 'PC'
	)
AND
	type = 'PC'
GROUP BY
	maker
HAVING
	COUNT(*) >= 3

UNION ALL
	
SELECT DISTINCT
	maker
FROM
	Product AS PR1
WHERE
	NOT EXISTS
	(
		SELECT * FROM Product
		WHERE Pr1.maker = Product.maker AND Product.type != 'Printer'
	)
