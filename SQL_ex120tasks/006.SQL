SELECT DISTINCT  maker, speed
FROM Laptop, Product
WHERE (Laptop.hd >= 10) AND (Laptop.model = Product.model)
