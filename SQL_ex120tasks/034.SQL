SELECT DISTINCT
	name
FROM
	Ships, Classes
WHERE
	(Ships.class = Classes.class) 
	AND Ships.launched >= 1922 
	AND Classes.displacement > 35000 
	AND Classes.type = 'bb'
