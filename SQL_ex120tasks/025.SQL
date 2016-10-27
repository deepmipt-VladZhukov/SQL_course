SELECT DISTINCT
maker
FROM
Product
WHERE
Product.type = 'Printer' 
AND Product.maker IN (
					  SELECT maker 
					  FROM PC INNER JOIN Product ON Product.model = PC.model 
					  WHERE ram = (SELECT MIN(ram) 
					  				  FROM PC
					 			   )
					  AND 
					  speed = (SELECT MAX(speed)
					  		   FROM PC
					  		   WHERE ram = (SELECT MIN(ram)
					  			   			FROM PC
					  			   			)
					  		  )
					  )
