with Pos(P) as(
select P FROM
(
SELECT 1 P UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7
UNION ALL SELECT 8 UNION ALL SELECT 9
) Pos
)
select name,
datename(year,battle_dt)+'-'+
case
when Month(battle_dt)>=10
then cast(Month(battle_dt) as char(2))
else '0'+cast(Month(battle_dt) as char(1))
end+
case
when day(battle_dt)>=10
then '-'+cast(day(battle_dt) as char(2))
else '-0'+cast(day(battle_dt) as char(1))
end
as battle_dt,

datename(year,election_dt)+'-'+
case
when Month(election_dt)>=10
then cast(Month(election_dt) as char(2))
else '0'+cast(Month(election_dt) as char(1))
end+
case
when day(election_dt)>=10
then '-'+cast(day(election_dt) as char(2))
else '-0'+cast(day(election_dt) as char(1))
end
as election_dt

from
(
select name,date as battle_dt,
(
select MIN(DATEADD(dd,P,nY_date)) as min_P_date from (

select distinct
case
when P-1=0 and Month(date)>4
then
DATEADD(year,1,(cast((datename(year,date)+'-04-01') as datetime)))

when P-1=0 and Month(date)<4
then
(cast((datename(year,date)+'-04-01') as datetime))

when P-1=0 and Month(date)=4
then date
else DATEADD(year,P-1,(cast((datename(year,date)+'-04-01') as datetime)))
end
as nY_date from
(
select distinct date from Battles where date=B.date

)z ,Pos
)z2 ,Pos
where
((DATEPART(year,DATEADD(dd,P,nY_date))%4=0 and
DATEPART(year,DATEADD(dd,P,nY_date))%100>0 ) OR
(DATEPART(year,DATEADD(dd,P,nY_date))%100=0 and
DATEPART(year,DATEADD(dd,P,nY_date))%400=0 ))
and MONTH (DATEADD(dd,P,nY_date))=4
and DATEPART(dw,DATEADD(dd,P,nY_date)) =2+(8-@@DATEFIRST) % 7
and MONTH (DATEADD(dd,P-1,nY_date))=4
and DAY(DATEADD(dd,P-1,nY_date))<=8
)
election_dt
from Battles B
)z
