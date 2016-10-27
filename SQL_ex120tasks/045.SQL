SELECT
	name
FROM
	(
	SELECT
		name
	FROM
		Ships
	UNION
	SELECT
		ship AS name
	FROM
		Outcomes
	) o
WHERE
	o.name LIKE '% % %'
