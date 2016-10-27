SELECT name, n
FROm (SELECT DISTINCT Passenger.name, n, Passenger.ID_psg
FROM (SELECT  DISTINCT place, ID_psg, COUNT(*) AS n
FROM Pass_in_trip 
GROUP BY place, ID_psg) Pit JOIN Passenger ON Passenger.ID_psg=Pit.ID_psg 
WHERE n >= All (SELECT COUNT(*) AS n
FROM Pass_in_trip 
GROUP BY place, ID_psg))p
