WITH out_pc AS
(
	SELECT
		maker
	FROM
		Product
	WHERE
		type = 'PC' AND model NOT IN (SELECT model FROM PC)
)
SELECT DISTINCT
	maker
FROM
	Product
WHERE
	maker NOT IN (SELECT * FROM out_pc)
