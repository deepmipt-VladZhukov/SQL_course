select L.code,speed,ram,price,screen from Laptop L
CROSS APPLY
(
   SELECT code,[Num1],[Num2],[Num3],[Num4]
   from (

   SELECT code,('Num'+CAST(num as CHAR(1)))  as N,valure  from (
   SELECT code,row_number() over(ORDER BY valure desc) num,valure
     FROM
     (
       select code,CAST(speed as MONEY) speed,CAST(ram as MONEY) ram,CAST(price as MONEY) price,CAST(screen as MONEY)  screen from Laptop
       where code=L.code

     ) pvt
     UNPIVOT (valure FOR spec IN(speed,ram,price,screen)

     ) unpvt
   )Z


   )X
   PIVOT 
   (
     sum(valure) 
     FOR N
     IN([Num1], [Num2], [Num3],[Num4]) 
   ) as pvt
) Piv
WHERE L.code=Piv.code
AND Num1>=2*Num2 AND Num2>=2*Num3 AND Num3>=2*Num4