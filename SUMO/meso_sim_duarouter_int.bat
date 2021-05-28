@echo off
setlocal enabledelayedexpansion


echo function,seed,time> meso_sim_duarouter_int.txt




FOR /L %%s IN (1100,20,2900) DO (
  ECHO %%s
  
	@set /p "=od2trips,seed%%s,=-(!time:~0,2!*3600+!time:~3,1!*10*60+!time:~4,1!*60+!time:~6,1!*10+!time:~7,1!)" <nul >> meso_sim_duarouter_int.txt
	od2trips --scale 0.01 --configuration-file ./input/od2trips/config/pointe_am/od2trips_5_9_15min.config.xml --taz-files ./input/TAZ/districts.taz.xml --od-matrix-files ./input/Matrice_OD/trajet_interieur_interieur/OD_Int_Int_Sans_SM.txt --seed %%s  --output-prefix seed%%s --output-file ./input/od2trips/result/point_am/meso_sim_duarouter_int.odtrips.xml
	echo +!time:~0,2!*3600+!time:~3,1!*10*60+!time:~4,1!*60+!time:~6,1!*10+!time:~7,1!  >>meso_sim_duarouter_int.txt
	@set /p "=duarouter,seed%%s,=-(!time:~0,2!*3600+!time:~3,1!*10*60+!time:~4,1!*60+!time:~6,1!*10+!time:~7,1!)" <nul >> meso_sim_duarouter_int.txt
	duarouter --configuration-file ./input/duarouter/config/duarouter_configuration.xml --seed %%s -n ./input/Carte/CarteMontreal_Sans_Un_Res.net.xml --additional-files ./input/Vtype/Vtype.xml,./input/TAZ/districts.taz.xml --route-files ./input/od2trips/result/point_am/seed%%smeso_sim_duarouter_int.odtrips.xml --output-file ./input/duarouter/result/pointe_am/meso_sim_duarouter_int.rou.xml --max-alternatives 10 --output-prefix seed%%s --log
	echo +!time:~0,2!*3600+!time:~3,1!*10*60+!time:~4,1!*60+!time:~6,1!*10+!time:~7,1!  >>meso_sim_duarouter_int.txt
	@set /p "=sumo,seed%%s,=-(!time:~0,2!*3600+!time:~3,1!*10*60+!time:~4,1!*60+!time:~6,1!*10+!time:~7,1!)" <nul >> meso_sim_duarouter_int.txt
	sumo.exe --seed %%s -c Simulation.sumocfg --net-file ./input/Carte/CarteMontreal_Sans_Un_Res.net.xml  --route-files ./input/od2trips/result/point_am/seed%%smeso_sim_duarouter_int.odtrips.xml --summary ./output/summary/pointe_am/meso_sim_duarouter_int_running --output-prefix seed%%s 
	echo +!time:~0,2!*3600+!time:~3,1!*10*60+!time:~4,1!*60+!time:~6,1!*10+!time:~7,1!  >>meso_sim_duarouter_int.txt
)

