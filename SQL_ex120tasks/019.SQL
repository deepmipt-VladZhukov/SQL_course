SELECT 
Product.maker, 
AVG(Laptop.screen)
FROM
Product 
INNER JOIN 
Laptop 
ON
Laptop.model = Product.model
GROUP BY
Product.maker
