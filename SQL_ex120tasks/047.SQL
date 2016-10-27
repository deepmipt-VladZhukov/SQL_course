WITH makers AS (
SELECT
	maker, model, cnt
FROM
	Product
INNER JOIN
(SELECT count(model) cnt, maker m
FROM Product
GROUP BY maker)  m_cnt
ON maker = m_cnt.m
)

SELECT COUNT(*) numb, M2.maker, M2.model
FROM
	makers M1 
INNER JOIN 
	makers M2 
ON 
	M1.cnt > M2.cnt OR 
	(M1.cnt = M2.cnt AND M1.maker < M2.maker) OR
	(M1.cnt = M2.cnt AND M1.maker = M2.maker AND M1.model <= M2.model)
GROUP BY 
	M2.maker, M2.model, M2.cnt
