SELECT
	MIN(class) AS class, MIN(launched) AS  year
FROM
(
	SELECT
		Classes.class, Ships.launched
	FROM
		Ships
	RIGHT JOIN
		Classes
	ON
		Classes.class = Ships.class
) class_launch
GROUP BY	
	class_launch.class
