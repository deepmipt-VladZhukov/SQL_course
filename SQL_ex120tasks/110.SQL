select name from (
Select distinct P.ID_psg,name from Trip T
JOIN Pass_in_trip PT
ON T.trip_no=PT.trip_no
JOIN Passenger P
ON P.ID_psg=PT.ID_psg
where DATEPART(dw,date)=6 and @@DATEFIRST=1
OR DATEPART(dw,date)=7 and @@DATEFIRST=7
AND time_in < time_out
)z
