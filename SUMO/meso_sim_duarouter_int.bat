



FOR /L %%s IN (1100,20,2900) DO (
  ECHO %%s
  
	
	sumo.exe --seed %%s -c Simulation.sumocfg --net-file ./input/Carte/CarteMontreal_Sans_Un_Res.net.xml  --route-files ./input/od2trips/result/point_am/seed%%smeso_sim_duarouter_int.odtrips.xml --summary ./output/summary/pointe_am/meso_sim_duarouter_int_running --output-prefix seed%%s 

)

