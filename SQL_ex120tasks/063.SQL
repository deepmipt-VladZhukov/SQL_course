SELECT
	name
FROM
(
	SELECT DISTINCT
		ID_psg
	FROM
		Pass_in_trip
	GROUP BY
		ID_psg, place
	HAVING
		COUNT(*) > 1
) t
INNER JOIN
	Passenger
ON
	t.ID_psg = Passenger.ID_psg
