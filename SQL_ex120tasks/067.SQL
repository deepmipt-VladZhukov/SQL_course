WITH trips_cnt AS
(
	SELECT
		town_from, town_to, COUNT(*) AS cnt
	FROM
		Trip
	GROUP BY
		town_from, town_to
)
SELECT 
	COUNT(*) AS cnt
FROM
	trips_cnt
WHERE 
	cnt = (SELECT MAX(cnt) FROM trips_cnt)
