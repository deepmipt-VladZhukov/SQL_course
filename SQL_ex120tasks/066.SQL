WITH allDates AS 
(
	SELECT t.date, COUNT(*) AS cnt
	FROM 
	(
		SELECT
			date, COUNT(*) AS cnt
		FROM
			Trip
		INNER JOIN
			Pass_in_trip
		ON
			Trip.trip_no = Pass_in_trip.trip_no AND
			YEAR(date) = 2003 AND 
			MONTH(date) = 4 AND
			(DAY(date) <= 7 AND DAY(date) >= 1) AND
			town_from = 'Rostov'
		GROUP BY 
			Trip.trip_no, date
	) t
	GROUP BY
		t.date
	union all
		SELECT CAST('20030401' AS DATE) AS date, 0 AS cnt
	union all
		SELECT CAST('20030402' AS DATE) AS date, 0 AS cnt
	union all
		SELECT CAST('20030403' AS DATE) AS date, 0 AS cnt
	union all
		SELECT CAST('20030404' AS DATE) AS date, 0 AS cnt
	union all
		SELECT CAST('20030405' AS DATE) AS date, 0 AS cnt
	union all
		SELECT CAST('20030406' AS DATE) AS date, 0 AS cnt
	union all
		SELECT CAST('20030407' AS DATE) AS date, 0 AS cnt
)
SELECT 
	date, MAX(cnt)
FROM
	allDates
GROUP BY
	date
