SELECT 
maker, 
MIN(type)
FROM
Product
GROUP BY maker
HAVING COUNT(DISTINCT type) = 1 AND COUNT(*) > 1
