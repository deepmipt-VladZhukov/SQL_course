Select top 1 with ties country, x, n 
 from classes 
cross apply(values(numguns*5000,'numguns') 
                  ,(bore*3000,'bore') 
                  ,(displacement,'displacement'))V(x,n) 
group by country, x, n 
order by rank()over(partition by country order by x desc)
