SELECT DISTINCT
	maker
FROM
	Product pr1
WHERE 
	0 = 
	(
		SELECT 
			COUNT(*) 
		FROM
		(
			SELECT 
				model
			FROM
				Product
			WHERE
				pr1.maker = Product.maker AND type = 'PC'
			EXCEPT
			SELECT
				model
			FROM
				PC
		)tt
	) 
	AND type = 'PC'
