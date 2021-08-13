FOR /L %%s IN (1100,200,4900)  DO (

REM ########################################ODTRIPS###########################
 od2trips  --configuration-file .\input\od2trips\config\pointe_am\od2trips_5_9_15min.config.xml --taz-files ./input/TAZ/districts.taz.xml --od-matrix-files ./input/Matrice_OD\trajet_interieur_interieur\OD_Int_Int_Sans_SM.txt,./input/Matrice_OD\trajet_exterieur_exterieur\OD_Ext_Ext_Sans_SM.txt,./input/Matrice_OD\trajet_interieur_exterieur\OD_Int_Ext_Sans_SM.txt --seed %%s  --output-prefix seed%%s --output-file .\input\od2trips\result\point_am\scenario_2.odtrips.xml --log  .\input\od2trips\result\point_am\scenario_2_od2trips --flow-output .\input\flow\scenario_2_flow.xml

REM ######################################## Duarouter##########################################

 duarouter --configuration-file ./input/duarouter/config/duarouter_configuration.xml --seed %%s -n ./input/Carte/CarteMontreal.net.xml --additional-files ./input/Vtype/Vtype.xml,./input/TAZ/districts.taz.xml --route-files .\input\od2trips\result\point_am\seed%%sscenario_2.odtrips.xml --output-file ./input/duarouter/result/pointe_am/scenario_2.rou.xml --max-alternatives 10 --output-prefix seed%%s --log .\input\duarouter\result\pointe_am/log_scenario_2
	
REM ###################################### OD2TRIPS SIMULATION########################################

sumo.exe --seed %%s -c simulation_avec.sumocfg --net-file .\input\Carte\CarteMontreal.net.xml  --route-files .\input\od2trips\result\point_am\seed%%sscenario_2.odtrips.xml --summary .\scenario_2\output\summary\pointe_am\scenario_2_od2trips  --output-prefix seed%%s  --additional-files ./input/Vtype/Vtype.xml,./input/TAZ/districts.taz.xml  --log ./scenario_2/log/scenario_2_od2trips  --bt-output ./scenario_2/Bluetooth/bluetooth_scenario_2_od2trips.xml --tripinfo-output ./scenario_2/tripinfo/tripsinfo_scenario_2_od2trips.xml

REM ######################################3## Flow SIMULATION##########################

 sumo.exe --seed %%s -c simulation_avec.sumocfg --net-file .\input\Carte\CarteMontreal.net.xml --route-files .\input\flow\seed%%sscenario_2_flow.xml --summary .\scenario_2\output\summary\pointe_am\scenario_2_flow  --output-prefix seed%%s  --additional-files ./input/Vtype/Vtype.xml,./input/TAZ/districts.taz.xml  --log ./scenario_2/log/scenario_2_flow  --bt-output ./scenario_2/Bluetooth/bluetooth_scenario_2_flow.xml --tripinfo-output ./scenario_2/tripinfo/tripsinfo_scenario_2_flow.xml
REM ######################################### OD2TRIPS SIMULATION############################

	sumo.exe --seed %%s -c simulation_avec.sumocfg --net-file .\input\Carte\CarteMontreal.net.xml  --route-files .\input\duarouter\result\pointe_am\seed%%sscenario_2.rou.xml --summary .\scenario_2\output\summary\pointe_am\scenario_2_duarouter  --output-prefix seed%%s   --log ./scenario_2/log/scenario_2_duarouter  --bt-output ./scenario_2/Bluetooth/bluetooth_scenario_2_duarouter.xml --tripinfo-output ./scenario_2/tripinfo/tripsinfo_scenario_2_duarouter.xml	

)