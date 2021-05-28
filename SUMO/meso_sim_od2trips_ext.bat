

@echo off
setlocal enabledelayedexpansion


echo function,seed,time> meso_sim_od2trips_ext.txt

FOR /L %%s IN (1100,200,2900)  DO (
  ECHO %%s
  
  
	@set /p "=od2trips,seed%%s,=-(!time:~0,2!*3600+!time:~3,1!*10*60+!time:~4,1!*60+!time:~6,1!*10+!time:~7,1!)" <nul >> meso_sim_duarouter_ext.txt
	od2trips  --configuration-file ./input/od2trips/config/pointe_am/od2trips_5_9_15min.config.xml --taz-files ./input/TAZ/districts.taz.xml --od-matrix-files ./input/Matrice_OD/trajet_interieur_interieur/OD_Int_Int_Sans_SM.txt,./input/Matrice_OD/trajet_exterieur_exterieur/OD_Ext_Ext_Sans_SM.txt,./input/Matrice_OD/trajet_interieur_exterieur/OD_Int_Ext_Sans_SM.txt --seed %%s  --output-prefix seed%%s --output-file ./input/od2trips/result/point_am/meso_sim_duarouter_ext.odtrips.xml --log  ./input/od2trips/result/point_am/log_meso_od_int
	echo +!time:~0,2!*3600+!time:~3,1!*10*60+!time:~4,1!*60+!time:~6,1!*10+!time:~7,1!  >>meso_sim_duarouter_ext.txt
	@set /p "=sumo,seed%%s,=-(!time:~0,2!*3600+!time:~3,1!*10*60+!time:~4,1!*60+!time:~6,1!*10+!time:~7,1!)" <nul >> meso_sim_duarouter_ext.txt
	sumo.exe --seed %%s -c Simulation.sumocfg --net-file ./input/Carte/CarteMontreal_Sans_Un_Res.net.xml --mesosim true --route-files ./input/od2trips/result/point_am/seed%%smeso_sim_duarouter_ext.odtrips.xml --summary ./output/summary/pointe_am/meso_sim_duarouter_ext_running --additional-files ./input/Vtype/Vtype.xml,./input/TAZ/districts.taz.xml  --output-prefix seed%%s 
	echo +!time:~0,2!*3600+!time:~3,1!*10*60+!time:~4,1!*60+!time:~6,1!*10+!time:~7,1!  >>meso_sim_duarouter_ext.txt


)