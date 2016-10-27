WITH tmp AS
(
	SELECT
		ID_psg, town_from, town_to, [time_out]
	FROM
		Trip
	INNER JOIN
		Pass_in_trip
	ON
		Trip.trip_no = Pass_in_trip.trip_no
),
tmp_first_fly AS
(
	SELECT
		ID_psg, town_from
	FROM
		tmp AS t
	WHERE
		[time_out] = (
					SELECT
						MIN([time_out])
					FROM
						tmp
					WHERE
						tmp.ID_psg = t.ID_psg
				)
)

SELECT 
	MAX(name), COUNT(*)
FROM
	tmp
INNER JOIN
	Passenger
ON
	Passenger.ID_psg = tmp.ID_psg
WHERE
	town_to = 'Moscow' AND 
	Passenger.ID_psg NOT IN
	(
		SELECT DISTINCT pip.id_psg
		FROM pass_in_trip pip
		WHERE
		 (SELECT TOP 1 t2.town_from
		  FROM trip t2, pass_in_trip pip2
		  WHERE pip.id_psg = pip2.id_psg
		  AND pip2.trip_no = t2.trip_no
		  ORDER BY pip2.date, t2.time_out) = 'moscow'		
	) 
GROUP BY
	Passenger.ID_psg
HAVING
	COUNT(*) > 1
