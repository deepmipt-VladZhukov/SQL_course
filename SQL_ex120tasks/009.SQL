SELECT DISTINCT Product.maker
FROM Product, PC
WHERE (Product.model = PC.model) AND (PC.speed >= 450)
