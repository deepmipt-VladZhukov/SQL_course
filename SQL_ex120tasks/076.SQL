WITH psg_not_const AS
(
	SELECT
		ID_psg
	FROM
		Pass_in_trip
	GROUP BY
		ID_psg
	HAVING COUNT(DISTINCT place) = COUNT(place)
),
psg_times AS
(	
	SELECT
		psg_not_const.ID_psg, 
		CASE
		WHEN
			DATEDIFF(mi, time_out, time_in) <= 0
		THEN
			DATEDIFF(mi, time_out, time_in) + 1440
		ELSE
			DATEDIFF(mi, time_out, time_in)
		END fly_time
	FROM
		psg_not_const
	INNER JOIN
		Pass_in_trip
	ON
		psg_not_const.ID_psg = Pass_in_trip.ID_psg
	INNER JOIN
		Trip
	ON
		Pass_in_trip.trip_no = Trip.trip_no
)
SELECT
	MAX(Passenger.name), SUM(fly_time)
FROM
	psg_times
INNER JOIN
	Passenger
ON
	Passenger.ID_psg = psg_times.ID_psg
GROUP BY
	Passenger.ID_psg
