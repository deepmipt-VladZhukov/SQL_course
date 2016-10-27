SELECT AVG(PC.speed)
FROM PC INNER JOIN Product
ON PC.model = Product.model AND Product.maker = 'A'
