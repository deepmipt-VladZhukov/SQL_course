with TEMP (n,B_DATETIME,B_Q_ID,B_V_ID,B_VOL) as
(
   select row_number() over (ORDER BY B_DATETIME,B_Q_ID, B_V_ID) as n,
   B_DATETIME,B_Q_ID, B_V_ID, (cast(B_VOL as float)) as B_VOL
   from utB

)

SELECT B_DATETIME,B_Q_ID,B_V_ID,format(B_VOL,'0') as B_VOL,
format(
 ( select 
   EXP
   ( 
        SUM
        (
            CASE
            WHEN n%2 > 0
            THEN LOG(B_VOL)
            ELSE -LOG(B_VOL)
            END
        ) 
   )
   from  TEMP where TEMP.n <= T.n
 )
,'.00000000')
as  sv

FROM TEMP as T