SELECT COALESCE(I.date, O.date),COALESCE(I.code, O.code), I.point, inc, O.point, out
FROM (SELECT (SELECT COUNT(*) FROM Income WHERE date=I.date AND code<=I.code) AS code, point, date, inc
FROM Income I) I FULL JOIN (SELECT (SELECT COUNT(*) FROM Outcome WHERE date=O.date AND code<=O.code)  AS code, point, date, out FROM Outcome O) O ON I.code= O.code AND I.date=O.date
ORDER BY COALESCE(I.date, O.date), COALESCE(I.code, O.code)
