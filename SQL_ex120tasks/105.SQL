select maker, model,
row_number() over (order by maker, model),
dense_rank() over (order by maker),
rank() over (order by maker),
count(*) over (order by maker)
from product
