SELECT DISTINCT b1.B_VOL, b2.b_vol, b3.b_vol FROM utb b1, utb b2, utb b3
WHERE b1.B_VOL < b2.B_VOL AND b2.B_VOL < b3.B_VOL
AND NOT ( b3.B_VOL > SQRT( SQUARE(b1.B_VOL) + SQUARE(b2.B_VOL)))
