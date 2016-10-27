SELECT 
MAX(maker), MAX(PC.price)
FROM
PC 
INNER JOIN 
Product 
ON PC.model = Product.model
GROUP BY
Product.maker
