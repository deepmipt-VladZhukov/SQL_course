SELECT [R] as Red,[G] as Green,[B] as Blue
FROM
(
select A.V_COLOR,
sum(coalesce(255-sum_b_vol,255)) as sum_vol
from
(
select Q_ID,V_COLOR from utQ,(select distinct V_COLOR from utV) V
)A
left join
(
select B_Q_ID,V_COLOR,sum(B_VOL) as sum_b_vol from utB
join utV
on utV.V_ID=utB.B_V_ID
group by B_Q_ID,V_COLOR
)B
ON A.Q_ID=B.B_Q_ID and A.V_COLOR=B.V_COLOR
group by A.V_COLOR

)z
PIVOT
(
max(sum_vol)
FOR V_COLOR
IN([R], [G], [B])
) pvt
