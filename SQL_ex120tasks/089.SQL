WITH mk_c AS
(
	SELECT DISTINCT
		maker, COUNT(*) AS cnt
	FROM
		Product
	GROUP BY
		maker
)
SELECT DISTINCT
	maker, cnt
FROM
	mk_c AS m
WHERE
	cnt = 
	(
		SELECT
			MAX(cnt)
		FROM
			mk_c
	)
UNION 
SELECT DISTINCT
	maker, cnt
FROM
	mk_c AS m
WHERE
	cnt = 
	(
		SELECT
			MIN(cnt)
		FROM
			mk_c
	)
