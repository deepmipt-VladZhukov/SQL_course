select code, model, color, type, price,
(
  select MAX(model) from Printer
  where 
  code >= 
  COALESCE((select MAX(code) from Printer where code <=P.code  and color='n'),(select MIN(code) from Printer))
  AND
  code < 
  COALESCE((select MIN(code) from Printer where code >P.code  and  color='n'),(select MAX(code)+1 from Printer))
    
) max_model,

(
  select count(distinct type) from Printer
  where 
  code >= 
  COALESCE((select MAX(code) from Printer where code <=P.code  and color='n'),(select MIN(code) from Printer))
  AND
  code < 
  COALESCE((select MIN(code) from Printer where code >P.code  and  color='n'),(select MAX(code)+1 from Printer))
    
) distinct_types_cou,

(
  select avg(price) from Printer
  where 
  code >= 
  COALESCE((select MAX(code) from Printer where code <=P.code  and color='n'),(select MIN(code) from Printer))
  AND
  code < 
  COALESCE((select MIN(code) from Printer where code >P.code  and  color='n'),(select MAX(code)+1 from Printer))
    
) avg_price


from Printer as P
order by code