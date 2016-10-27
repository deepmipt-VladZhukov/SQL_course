WITH town_cnt AS
(
	SELECT
		town_from, [date], COUNT(trip_no) AS cnt
	FROM
	(
		SELECT DISTINCT
			town_from, [date], Trip.trip_no
		FROM
			Trip
		INNER JOIN
			Pass_in_trip
		ON
			Trip.trip_no = Pass_in_trip.trip_no
	) t
	GROUP BY
		town_from, [date]
),
dates AS
(
	SELECT 
		(
			DATEADD
			(
				day,
				Num - 1, 
				(SELECT
					MIN([date])
				FROM
					town_cnt
				WHERE
					town_cnt.town_from = 'Rostov' AND
					town_cnt.cnt = 
					(
						SELECT
						 	MAX(cnt)
						 FROM
						 	town_cnt
						 WHERE
						 	town_from = 'Rostov'
					)
				)
			)
		) as [date] 
	FROM
	(
		SELECT 1 as Num
		UNION ALL
		SELECT 2 as Num
		UNION ALL
		SELECT 3 as Num
		UNION ALL
		SELECT 4 as Num
		UNION ALL
		SELECT 5 as Num
		UNION ALL
		SELECT 6 as Num
		UNION ALL
		SELECT 7 as Num
	) t
),
rostov_cnt AS
(
	SELECT
		[date], cnt
	FROM
		town_cnt
	WHERE
		town_from = 'Rostov'
)
SELECT
	dates.[date], COALESCE(cnt, 0)
FROM
	dates
LEFT JOIN
	rostov_cnt
ON
	rostov_cnt.[date] = dates.[date]
