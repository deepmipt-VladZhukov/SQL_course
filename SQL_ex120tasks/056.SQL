WITH all_ships AS (
	SELECT
		name, Classes.class
	FROM (
		SELECT 
			name, class
		FROM 
			Ships
		UNION
		SELECT name, class
		FROM(
			SELECT 
				ship AS name, ship AS class
			FROM
				Outcomes
		) out
		WHERE NOT EXISTS (SELECT * FROM Ships WHERE Ships.name = out.name)
	) sh_cl
	RIGHT JOIN
		Classes
	ON
		sh_cl.class = Classes.class
) 
SELECT class, sum(cast(cnt_sunks as numeric(7))) AS Sunks
FROM
(
	SELECT 
		class, 
		CASE WHEN result = 'sunk' then '1' else '0'
		end as cnt_sunks
	FROM
	(
		SELECT
			class, name, result
		FROM
			all_ships
		LEFT JOIN
			Outcomes
		ON
			Outcomes.ship = all_ships.name
	) tmp
) Sunks
GROUP BY class
