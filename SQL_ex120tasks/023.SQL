SELECT DISTINCT
maker
FROM
Product
INNER JOIN
PC
ON
PC.model = Product.model
WHERE
PC.speed >= 750

INTERSECT

SELECT DISTINCT
maker
FROM
Product
INNER JOIN
Laptop
ON
Laptop.model = Product.model
WHERE
Laptop.speed >= 750
