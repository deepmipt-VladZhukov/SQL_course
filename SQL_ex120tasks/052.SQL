SELECT
	name
FROM
	Ships
LEFT JOIN
	Classes
ON
	Ships.class = Classes.class
WHERE
	(type IS NULL OR type = 'bb') AND
	(country IS NULL OR country = 'Japan') AND
	(numGuns IS NULL OR numGuns  >= 9) AND
	(bore IS NULL OR bore < 19) AND
	(displacement IS NULL OR displacement <= 65000)
