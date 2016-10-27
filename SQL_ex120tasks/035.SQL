SELECT 
	model, type
FROM 
	product
WHERE 	
	model NOT LIKE '%[^A-Za-z]%' OR
	model NOT LIKE '%[^0-9]%'
