FOR /L %%s IN (1100,200,4900)  DO (


REM ########################################ODTRIPS###########################
	od2trips --configuration-file .\input\od2trips\config\pointe_am\od2trips_5_9_15min.config.xml --taz-files ./input/TAZ/districts_without.taz.xml --od-matrix-files ./input/Matrice_OD\trajet_interieur_interieur\OD_Int_Int_Sans_SM.txt --seed %%s  --output-prefix seed%%s --output-file .\input\od2trips\result\point_am\scenario_1.odtrips.xml --log  .\input\od2trips\result\point_am\scenario_1_od2trips --flow-output .\input\flow\scenario_1_flow.xml

REM ######################################## Duarouter##########################################

	duarouter --configuration-file ./input/duarouter/config/duarouter_configuration.xml --seed %%s -n ./input/Carte/CarteMontreal_Sans_Un_Res.net.xml --additional-files ./input/Vtype/Vtype.xml,./input/TAZ/districts_without.taz.xml --route-files .\input\od2trips\result\point_am\seed%%sscenario_1.odtrips.xml --output-file ./input/duarouter/result/pointe_am/scenario_1.rou.xml --max-alternatives 10 --output-prefix seed%%s --log .\input\duarouter\result\pointe_am/log_scenario_1
	
REM ###################################### OD2TRIPS SIMULATION########################################

	sumo.exe --seed %%s -c simulation_sans.sumocfg  --route-files .\input\od2trips\result\point_am\seed%%sscenario_1.odtrips.xml --summary .\scenario_1\output\summary\pointe_am\scenario_1_od2trips --additional-files ./input/Vtype/Vtype.xml --output-prefix seed%%s    --log ./scenario_1/log/scenario_1_od2trips  --bt-output ./scenario_1/Bluetooth/bluetooth_scenario_1_od2trips.xml --tripinfo-output ./scenario_1/tripinfo/tripsinfo_scenario_1_od2trips.xml

REM ######################################3## Flow SIMULATION##########################

 sumo.exe --seed %%s -c simulation_sans.sumocfg  --route-files .\input\flow\seed%%sscenario_1_flow.xml --summary .\scenario_1\output\summary\pointe_am\scenario_1_flow --additional-files ./input/Vtype/Vtype.xml --output-prefix seed%%s    --log ./scenario_1/log/scenario_1_flow  --bt-output ./scenario_1/Bluetooth/bluetooth_scenario_1_flow.xml --tripinfo-output ./scenario_1/tripinfo/tripsinfo_scenario_1_flow.xml
REM ######################################### OD2TRIPS SIMULATION############################

	sumo.exe --seed %%s -c simulation_sans.sumocfg  --route-files ./input/duarouter/result/pointe_am/seed%%sscenario_1.rou.xml --log ./scenario_1/log/scenario_1_duarouter --summary .\scenario_1\output\summary\pointe_am\scenario_1_duarouter  --output-prefix seed%%s    --bt-output ./scenario_1/Bluetooth/bluetooth_scenario_1_duarouter.xml --tripinfo-output ./scenario_1/tripinfo/tripsinfo_scenario_1_duarouter.xml	

)