WITH max_ AS
(
	SELECT TOP 3 WITH TIES 
		model
	FROM
		Product
	ORDER BY model
),
min_ AS
(
	SELECT TOP 3 WITH TIES
		model
	FROM
		Product
	ORDER BY model DESC
)
SELECT
	maker, model, type
FROM
	Product
WHERE
	model NOT IN (SELECT * FROM max_) AND 
	model NOT IN (SELECT * FROM min_)
