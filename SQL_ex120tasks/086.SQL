SELECT
	maker, 
	CASE 
			WHEN types LIKE '/%'
		THEN
			SUBSTRING(types, 2 , 20)
		ELSE
			types
	END
FROM
(
	SELECT DISTINCT
	maker,
	CASE
		WHEN EXISTS 
		(
			SELECT
				*
			FROM
				Product
			WHERE
				Product.maker = Pr1.maker AND Product.type = 'Laptop'
		)
		THEN
			'Laptop'
		ELSE
			''
	END
	+
	CASE
		WHEN EXISTS
		(
			SELECT
				*
			FROM
				Product
			WHERE
				Product.maker = Pr1.maker AND Product.type = 'PC'
		)
		THEN
			'/PC'
		ELSE
			''
	END
	+
	CASE
		WHEN EXISTS
		(
			SELECT
				*
			FROM
				Product
			WHERE
				Product.maker = Pr1.maker AND Product.type = 'Printer'
		)
		THEN
			'/Printer'
		ELSE
			''
	END
	AS types
	FROM
		Product Pr1
) t
