WITH full_trips AS
(
	SELECT
		ID_psg, Trip.trip_no, town_from, town_to
	FROM
		Pass_in_trip
	INNER JOIN
		Trip
	ON
		Trip.trip_no = Pass_in_trip.trip_no
)
SELECT
	Passenger.name
FROM
(
	SELECT DISTINCT
		ID_psg
	FROM
		full_trips AS tmp
	WHERE
		NOT EXISTS
		(
			SELECT
				*
			FROM
				full_trips
			WHERE
				full_trips.ID_psg = tmp.ID_psg
				AND
				(
				(full_trips.town_from != tmp.town_from AND
				full_trips.town_to != tmp.town_from) 
				OR
				(full_trips.town_from != tmp.town_to AND
				full_trips.town_to != tmp.town_to))
		)
)t
INNER JOIN
	Passenger
ON
	Passenger.ID_psg = t.ID_psg
