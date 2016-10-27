select distinct code,speed,ram from PC
,
(  
select distinct 15*Z1.T1*Z2.T2*Z3.T3 as T  from (
  select T1 from 
  (
    select 1 T1
    union all
    select 2 
    union all
    select 4 
    union all
    select 8
    union all
    select 16
    union all
    select 32
    union all
    select 64
    union all
    select 128

    
  )x
  
)Z1
,
 (
   select T2 from 
  (
   select 1 T2
    union all
    select 2 
    union all
    select 4 
    union all
    select 8
    union all
    select 16
    union all
    select 32
    union all
    select 64
    union all
    select 128

  )x
)Z2
,

 (
   select T3 from 
  (
   select 1 T3
    union all
    select 2 
    union all
    select 4 
    union all
    select 8
    union all
    select 16
    union all
    select 32
    union all
    select 64
    union all
    select 128

  )x
)Z3

)Z
where   ((speed | ram)) & Z.T=Z.T

