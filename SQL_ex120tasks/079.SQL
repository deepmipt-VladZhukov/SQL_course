WITH psg_fly_time AS
(
	SELECT
		ID_psg, SUM((DATEDIFF(minute, time_out, time_in) + 1440) % 1440) AS time_fly
	FROM
		Pass_in_trip
	INNER JOIN
		Trip
	ON
		Pass_in_trip.trip_no = Trip.trip_no
	GROUP BY
		ID_psg
)
SELECT
	name, time_fly
FROM
	psg_fly_time
INNER JOIN
	Passenger
ON
	Passenger.ID_psg = psg_fly_time.ID_psg
WHERE
	time_fly = (SELECT MAX(time_fly) FROM psg_fly_time)
