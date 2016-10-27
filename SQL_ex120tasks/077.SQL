WITH tr AS
(
	SELECT DISTINCT
		[date], Trip.trip_no
	FROM
		Trip
	INNER JOIN
		Pass_in_trip
	ON
		Trip.trip_no = Pass_in_trip.trip_no
	WHERE
		town_from = 'Rostov'
),
tmp AS
(
	SELECT COUNT(*) AS cnt, [date]
	FROM tr
	GROUP BY [date]
)
SELECT 
	cnt, [date]
FROM
	tmp
WHERE tmp.cnt = (SELECT MAX(cnt) FROM tmp)
