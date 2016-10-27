SELECT DISTINCT maker, AVG(hd)
FROM Product INNER JOIN PC ON PC.model = Product.model
WHERE 
Product.maker IN (SELECT DISTINCT maker
		  		  FROM Product
		  		  WHERE type = 'Printer'
		 		 )
GROUP BY maker
