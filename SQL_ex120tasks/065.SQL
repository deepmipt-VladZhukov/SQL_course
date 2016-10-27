WITH prep AS
(
	SELECT 
		maker, type,
		CASE
			WHEN type = 'PC'
			THEN 1
			WHEN type = 'Laptop'
			THEN 2
			WHEN type = 'Printer'
			THEN 3
		END AS type_ord,
		CASE
			WHEN type = 'Laptop' AND
			maker IN (SELECT maker FROM Product WHERE type = 'PC')
			THEN ''
			WHEN type = 'Printer' AND (maker IN (SELECT maker FROM Product WHERE type = 'PC')
			OR maker IN (SELECT maker FROM Product WHERE type = 'Laptop'))
			THEN ''
			ELSE maker
		END AS maker_fill
	FROM
		Product
	GROUP BY
		maker, type
)

SELECT
	ROW_NUMBER() OVER(ORDER BY maker, type_ord), maker_fill, type
FROM
	prep
ORDER BY maker, type_ord
