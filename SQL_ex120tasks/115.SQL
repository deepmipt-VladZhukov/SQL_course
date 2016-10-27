select distinct Up=u.b_vol, Down=d.b_vol, Side=s.b_vol, 
Rad=cast(POWER((POWER( s.b_vol,2)-POWER((1.*d.b_vol-1.*u.b_vol)/2, 2)),1./2.)/2 as dec(15,2)) 
  from utB u, utB d, utB s 
  where u.b_vol<d.b_vol AND 1.*u.b_vol+1.*d.b_vol=2.*s.b_vol
