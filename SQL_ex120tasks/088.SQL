WITH one_comp AS
(
	SELECT DISTINCT
		ID_psg, MAX(ID_comp) AS ID_comp
	FROM
		Pass_in_trip
	INNER JOIN
		Trip
	ON
		Trip.trip_no = Pass_in_trip.trip_no
	GROUP BY
		ID_psg
	HAVING
		COUNT(DISTINCT ID_comp) = 1
)
SELECT
	Passenger.name, cnt, Company.name
FROM
(
	SELECT
		one_comp.ID_psg, COUNT(*) AS cnt, MAX(one_comp.ID_comp) AS ID_comp
	FROM
		one_comp
	INNER JOIN
		Pass_in_trip
	ON
		Pass_in_trip.ID_psg = one_comp.ID_psg
	GROUP BY
		one_comp.ID_psg
	HAVING
		COUNT(*) = 
		(
			SELECT
				MAX(cnt)
			FROM
			(
				SELECT
					COUNT(*) AS cnt
				FROM
					one_comp
				INNER JOIN
					Pass_in_trip
				ON
					Pass_in_trip.ID_psg = one_comp.ID_psg
				GROUP BY
					one_comp.ID_psg
			) ttt		
		)
) ts
INNER JOIN
	Passenger
ON
	ts.ID_psg = Passenger.ID_psg
INNER JOIN
	Company
ON
	ts.ID_comp = Company.ID_comp
