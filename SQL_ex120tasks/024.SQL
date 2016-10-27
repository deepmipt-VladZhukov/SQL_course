WITH allTypes(model, price) AS (
	SELECT 
		model, 
		price
	FROM
		PC
	UNION ALL
	SELECT 
		model, 
		price
	FROM
		Laptop
	UNION ALL
	SELECT 
		model, 
		price
	FROM
		Printer
)
SELECT DISTINCT
	model
FROM
	allTypes
WHERE
	price = (SELECT MAX(price) FROM allTypes)
