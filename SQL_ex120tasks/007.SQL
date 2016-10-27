SELECT PC.model, PC.price
FROM PC, Product
WHERE (PC.model = Product.model) AND (Product.maker = 'B')

UNION
SELECT Laptop.model, Laptop.price
FROM Laptop, Product
WHERE (Laptop.model = Product.model) AND (Product.maker = 'B')

UNION
SELECT Printer.model, Printer.price
FROM Printer, Product
WHERE (Printer.model = Product.model) AND (Product.maker = 'B')
