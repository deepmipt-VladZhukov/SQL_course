SELECT 
	all_stat.mk, all_stat.type, CAST(100.0 * all_stat.cnt_tp / all_stat.cnt_mk AS NUMERIC(5, 2))
FROM
(
	SELECT t.mk mk, t.tp AS type, t.cnt_tp AS cnt_tp, maker_cnt.cnt_mk AS cnt_mk
	FROM
	(
		SELECT tmp_.mk AS mk, tmp_.tp AS tp, MAX(tmp_.cnt_tp) AS cnt_tp
		FROM(
			SELECT DISTINCT maker AS mk, 'PC' tp, 0 cnt_tp FROM Product
			union all
			SELECT DISTINCT maker AS mk, 'Laptop' tp, 0 cnt_tp FROM Product
			union all
			SELECT DISTINCT maker AS mk, 'Printer' tp, 0 cnt_tp FROM Product
			union all
			SELECT Product.maker AS mk, Product.type AS tp, COUNT(*) AS cnt_tp
			FROM
				Product
			GROUP BY
			Product.maker, Product.type
		) tmp_
		GROUP BY mk, tp
	) t
	INNER JOIN
		(
			SELECT 
				Product.maker AS mk, COUNT(*) AS cnt_mk
			FROM
				Product
			GROUP BY Product.maker
		) maker_cnt
	ON 
		t.mk = maker_cnt.mk
) all_stat
