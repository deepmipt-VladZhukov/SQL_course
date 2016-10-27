WITH num(n) AS(/* с помощью рекурсивного CTE создаем таблицу со столбцом n
                     и значени€ми от 1 до 7 */
SELECT 1
UNION ALL
SELECT n+1 FROM num
WHERE n < 30
)
/*-----------------------------------*/


select point, 
date as DP,
CASE
    WHEN date NOT IN (select date from Outcome_o
               where Income_o.point = Outcome_o.point)
    THEN date
    ELSE 
    (  
          select MIN(D_dayte) as Min_Date from 
          (
            /* создаем таблицу с датами */
             SELECT DATEADD(dd,n, Income_o.date) AS D_dayte FROM num
          ) as dat
          where D_dayte NOT IN (select date from Outcome_o
               where Outcome_o.point=Income_o.point)
          AND (  
              DATEPART(dw,D_dayte) != 1 AND @@DATEFIRST=7
              OR
              DATEPART(dw,D_dayte) != 7 AND @@DATEFIRST=1
              )
    )

END DI
from Income_o
