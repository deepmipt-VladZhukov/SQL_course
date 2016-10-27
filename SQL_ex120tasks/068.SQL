WITH trips_cnt AS
(
	SELECT
		town_from, town_to, COUNT(*) AS cnt
	FROM
		Trip
	GROUP BY
		town_from, town_to
),
trips_no_orientir_cnt AS
(
	SELECT
		town_from, town_to, SUM(cnt) AS cnt
	FROM
	(
		SELECT 
			town_from, town_to, cnt
		FROM
			trips_cnt
		UNION ALL
		SELECT
			town_to, town_from, cnt
		FROM
			trips_cnt
	) t
	GROUP BY town_from, town_to
)
SELECT 
	COUNT(*) / 2 AS cnt
FROM
	trips_no_orientir_cnt
WHERE 
	cnt = (SELECT MAX(cnt) FROM trips_no_orientir_cnt)
