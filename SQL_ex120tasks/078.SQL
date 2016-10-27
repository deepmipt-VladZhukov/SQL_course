SELECT
	name,
	REPLACE
	(
		CONVERT(
			CHAR(12), 
			DATEADD(m, DATEDIFF(m,0,date),0), 102
		),
		'.', 
		'-'
	),
	REPLACE(CONVERT(CHAR(12), DATEADD(s, -1,DATEADD(m, DATEDIFF(m, 0, date) + 1,0)), 102), '.', '-') 
FROM
	Battles
