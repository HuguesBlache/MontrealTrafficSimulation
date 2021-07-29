
FOR /L %%s IN (1100,200,4900)  DO (

REM ###################ODTRIPS
	od2trips  --configuration-file .\input\od2trips\config\pointe_am\od2trips_5_9_15min.config.xml --taz-files ./input/TAZ/districts.taz.xml --od-matrix-files ./input/Matrice_OD\trajet_interieur_interieur\OD_Int_Int.txt,./input/Matrice_OD\trajet_exterieur_exterieur\OD_Ext_Ext.txt,./input/Matrice_OD\trajet_interieur_exterieur\OD_Int_Ext.txt --seed %%s  --output-prefix seed%%s --output-file .\input\od2trips\result\point_am\scenario_3.odtrips.xml --log  .\input\od2trips\result\point_am\scenario_3_od2trips --flow-output .\input\flow\scenario_3_flow.xml

REM ################### Duarouter

	duarouter --configuration-file ./input/duarouter/config/duarouter_configuration.xml --seed %%s -n ./input/Carte/CarteMontreal_Sans_Un_Res.net.xml --additional-files ./input/Vtype/Vtype.xml,./input/TAZ/districts.taz.xml --route-files .\input\od2trips\result\point_am\seed%%sscenario_3.odtrips.xml --output-file ./input/duarouter/result/pointe_am/scenario_3.rou.xml --max-alternatives 10 --output-prefix seed%%s --log .\input\duarouter\result\pointe_am/log_scenario_3
	
REM ################### OD2TRIPS SIMULATION

	sumo.exe --seed %%s -c Simulation.sumocfg --mesosim true --net-file .\input\Carte\CarteMontreal_Sans_Un_Res.net.xml --route-files .\input\od2trips\result\point_am\seed%%sscenario_3.odtrips.xml,route.rou.xml --summary .\output\summary\pointe_am\scenario_3_od2trips  --output-prefix seed%%s  --additional-files ./input/Vtype/Vtype.xml,./input/TAZ/districts.taz.xml,parking.xml  --log log\scenario_3_od2trips  --bt-output ./fcd_int/bluetooth_scenario_3_od2trips.xml --tripinfo-output ./tripinfo/tripsinfo_scenario_3_od2trips.xml

REM ################### Flow SIMULATION

	sumo.exe --seed %%s -c Simulation.sumocfg --mesosim true --net-file .\input\Carte\CarteMontreal_Sans_Un_Res.net.xml --route-files .\input\flow\seed%%sscenario_3_flow.xml,route.rou.xml --summary .\output\summary\pointe_am\scenario_3_flow  --output-prefix seed%%s  --additional-files ./input/Vtype/Vtype.xml,./input/TAZ/districts.taz.xml,parking.xml  --log log\scenario_3_flow  --bt-output ./fcd_int/bluetooth_scenario_3_flow.xml --tripinfo-output ./tripinfo/tripsinfo_scenario_3_flow.xml
REM ################### OD2TRIPS SIMULATION

	sumo.exe --seed %%s -c Simulation.sumocfg --mesosim true --net-file .\input\Carte\CarteMontreal_Sans_Un_Res.net.xml --route-files .\input\duarouter\result\pointe_am\seed%%sscenario_3.rou.xml.odtrips.xml,route.rou.xml --summary .\output\summary\pointe_am\scenario_3_duarouter  --output-prefix seed%%s  --additional-files ./input/Vtype/Vtype.xml,./input/TAZ/districts.taz.xml,parking.xml  --log log\scenario_3_duarouter  --bt-output ./fcd_int/bluetooth_scenario_3_duarouter.xml --tripinfo-output ./tripinfo/tripsinfo_scenario_3_duarouter.xml	

)