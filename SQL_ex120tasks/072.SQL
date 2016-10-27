WITH psg_ AS 
(
	SELECT
		ID_psg, ID_comp, Pass_in_trip.trip_no, date
	FROM
		Pass_in_trip
	INNER JOIN
		Trip
	ON
		Trip.trip_no = Pass_in_trip.trip_no
),
pst_one AS
(
	SELECT
		ID_psg, COUNT(date) AS cnt
	FROM
		psg_
	GROUP BY
		ID_psg
	HAVING
		COUNT(DISTINCT ID_comp) = 1
)
SELECT
	name, cnt
FROM
	pst_one
INNER JOIN
	Passenger
ON
	pst_one.ID_psg = Passenger.ID_psg
WHERE
	cnt >= ALL (SELECT cnt FROM pst_one)
