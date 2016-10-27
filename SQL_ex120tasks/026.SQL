WITH allTypes(price) AS (
SELECT price
FROM PC INNER JOIN Product ON Product.model = PC.model
WHERE Product.maker = 'A'
UNION ALL
SELECT price
FROM Laptop INNER JOIN Product ON Product.model = Laptop.model
WHERE Product.maker = 'A'
)
SELECT AVG(price)
FROM allTypes
