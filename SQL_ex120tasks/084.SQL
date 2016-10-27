WITH help AS
(
	SELECT
		ID_comp, Trip.trip_no AS trip_no, ID_psg, [date]
	FROM
		Pass_in_trip
	INNER JOIN
		Trip
	ON
		Trip.trip_no = Pass_in_trip.trip_no
	WHERE
		YEAR([date]) = 2003 AND MONTH([date]) = 4 
),
help2 AS
(
	SELECT
		Company.name,
		CASE
			WHEN DAY([date]) < 11
			THEN 1
			ELSE 0
		END AS first,
		CASE
			WHEN DAY([date]) > 10 AND DAY([date]) < 21
			THEN 1
			ELSE 0
		END AS second,
		CASE
			WHEN DAY([date]) > 20
			THEN 1
			ELSE 0
		END AS third
	FROM
		help
	INNER JOIN
		Company
	ON
		Company.ID_comp = help.ID_comp
)
SELECT
	name, SUM(first), SUM(second), SUM(third)
FROM
	help2
GROUP BY
	name
