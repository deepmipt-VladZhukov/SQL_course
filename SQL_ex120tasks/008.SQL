SELECT Product.maker
FROM Product
WHERE Product.type = 'PC'
EXCEPT 
SELECT Product.maker
FROM Product
WHERE Product.type = 'Laptop'
