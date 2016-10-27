SELECT
	CAST(AVG(numGuns * 1.0) AS NUMERIC(5, 2))
FROM
	Classes
WHERE
	type = 'bb'
