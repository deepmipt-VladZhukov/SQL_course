Select name, trip_no, date
from(
select row_number() over(order by date+time_out,ID_psg) rn,name,Trip.trip_no,date
from Company,Pass_in_trip,Trip
where Company.ID_comp=Trip.ID_comp and Trip.trip_no=Pass_in_trip.trip_no
and town_from='Rostov' and year(date)=2003 and month(date)=4)_
where rn=5
