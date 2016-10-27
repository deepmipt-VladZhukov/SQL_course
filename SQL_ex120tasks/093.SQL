SELECT
	MAX(Company.name), SUM(dif)
FROM
(
	SELECT DISTINCT
		ID_comp, [date], Trip.trip_no, town_from, town_to, time_out, time_in, (DATEDIFF(mi, time_out, time_in + 1440) % 1440) AS dif
	FROM
		Trip
	INNER JOIN
		Pass_in_trip
	ON
		Trip.trip_no = Pass_in_trip.trip_no 
) t
INNER JOIN
	Company
ON
	Company.ID_comp = t.ID_comp
GROUP BY
	Company.ID_comp
