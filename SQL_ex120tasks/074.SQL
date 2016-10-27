SELECT DISTINCT
	country, Classes.class
FROM
	Classes
WHERE
	country = 'Russia'
UNION ALL
SELECT DISTINCT
	country, class
FROM
	Classes
WHERE
	NOT EXISTS 
	(
		SELECT DISTINCT
			country, Classes.class
		FROM
			Classes
		WHERE
			country = 'Russia'
	)
