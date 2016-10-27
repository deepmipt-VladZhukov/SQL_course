WITH cnt_flying AS
(
	SELECT
		ID_comp, COUNT(*) AS cnt
	FROM
	(
		SELECT
			ID_comp, [time_out], Trip.trip_no, plane, town_from
		FROM
			Pass_in_trip
		INNER JOIN
			Trip
		ON
			Trip.trip_no = Pass_in_trip.trip_no
		GROUP BY
			ID_comp, [date], [time_out], Trip.trip_no, plane, town_from
	) t
	GROUP BY
		ID_comp
),
types AS
(
	SELECT
		ID_comp, COUNT(*) AS cnt
	FROM
	(
		SELECT
			ID_comp, plane AS cnt
		FROM
			Trip
		INNER JOIN
			Pass_in_trip
		ON
			Trip.trip_no = Pass_in_trip.trip_no
		GROUP BY
			ID_comp, plane
	) t
	GROUP BY
		ID_comp
),
diff_psg AS
(
	SELECT
		ID_comp, COUNT(*) AS cnt
	FROM
	(
		SELECT
			ID_comp, ID_psg
		FROM
			Trip
		INNER JOIN
			Pass_in_trip
		ON
			Trip.trip_no = Pass_in_trip.trip_no
		GROUP BY
			ID_comp, ID_psg
	) t
	GROUP BY
		ID_comp
),
all_psg AS
(
	SELECT
		ID_comp, COUNT(*) AS cnt
	FROM
		Trip
	INNER JOIN
		Pass_in_trip
	ON
		Trip.trip_no = Pass_in_trip.trip_no
	GROUP BY
		ID_comp
)

SELECT
	Company.name AS company_name, cnt_flying.cnt AS flights, types.cnt AS planes, diff_psg.cnt AS diff_psngrs, all_psg.cnt AS total_psngrs

FROM
	cnt_flying, types, diff_psg, all_psg, Company
WHERE
	Company.ID_comp = cnt_flying.ID_comp AND
	cnt_flying.ID_comp = types.ID_comp AND
	types.ID_comp = diff_psg.ID_comp AND
	diff_psg.ID_comp = all_psg.ID_comp
