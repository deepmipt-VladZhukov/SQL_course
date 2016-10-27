SELECT
	MIN(t1.trip_no) AS min1,
	MIN(t2.trip_no) AS min2,
	MIN(t3.trip_no) AS min3,
	MAX(t1.trip_no) AS max1,
	MAX(t2.trip_no) AS max2,
	MAX(t3.trip_no) AS max3
FROM
	Trip t1, Trip t2, Trip t3
WHERE
	t1.trip_no < t2.trip_no AND t2.trip_no < t3.trip_no
