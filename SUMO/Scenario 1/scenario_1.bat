
FOR /L %%s IN (1100,200,4900)  DO (

REM ###################ODTRIPS
	od2trips --scale 0.01 --configuration-file .\input\od2trips\config\pointe_am\od2trips_5_9_15min.config.xml --taz-files ./input/TAZ/districts.taz.xml --od-matrix-files ./input/Matrice_OD\trajet_interieur_interieur\OD_Int_Int_Sans_SM.txt --seed %%s  --output-prefix seed%%s --output-file .\input\od2trips\result\point_am\scenario_1.odtrips.xml --log  .\input\od2trips\result\point_am\scenario_1_od2trips --flow-output .\input\flow\scenario_1_flow.xml

REM ################### Duarouter

	duarouter --configuration-file ./input/duarouter/config/duarouter_configuration.xml --seed %%s -n ./input/Carte/CarteMontreal_Sans_Un_Res.net.xml --additional-files ./input/Vtype/Vtype.xml,./input/TAZ/districts.taz.xml --route-files .\input\od2trips\result\point_am\seed%%sscenario_1.odtrips.xml --output-file ./input/duarouter/result/pointe_am/scenario_1.rou.xml --max-alternatives 10 --output-prefix seed%%s --log .\input\duarouter\result\pointe_am/log_scenario_1
	
REM ################### OD2TRIPS SIMULATION

	sumo.exe --seed %%s -c Simulation.sumocfg --net-file .\input\Carte\CarteMontreal_Sans_Un_Res.net.xml --route-files .\input\od2trips\result\point_am\seed%%sscenario_1.odtrips.xml,bluetooth_car.rou.xml --summary .\output\summary\pointe_am\scenario_1_od2trips  --output-prefix seed%%s  --additional-files ./input/Vtype/Vtype.xml,./input/TAZ/districts.taz.xml,parking_bluetooth.add.xml  --log log\scenario_1_od2trips  --bt-output ./fcd_int/bluetooth_scenario_1_od2trips.xml --tripinfo-output ./tripinfo/tripsinfo_scenario_1_od2trips.xml

REM ################### Flow SIMULATION

	sumo.exe --seed %%s -c Simulation.sumocfg --net-file .\input\Carte\CarteMontreal_Sans_Un_Res.net.xml --route-files .\input\flow\seed%%sscenario_1_flow.xml,bluetooth_car.rou.xml --summary .\output\summary\pointe_am\scenario_1_flow  --output-prefix seed%%s  --additional-files ./input/Vtype/Vtype.xml,./input/TAZ/districts.taz.xml,parking_bluetooth.add.xml  --log log\scenario_1_flow  --bt-output ./fcd_int/bluetooth_scenario_1_flow.xml --tripinfo-output ./tripinfo/tripsinfo_scenario_1_flow.xml
REM ################### OD2TRIPS SIMULATION

	sumo.exe --seed %%s -c Simulation.sumocfg --net-file .\input\Carte\CarteMontreal_Sans_Un_Res.net.xml --route-files .\input\duarouter\result\pointe_am\seed%%sscenario_1.rou.xml.odtrips.xml,bluetooth_car.rou.xml --summary .\output\summary\pointe_am\scenario_1_duarouter  --output-prefix seed%%s  --additional-files ./input/Vtype/Vtype.xml,./input/TAZ/districts.taz.xml,parking_bluetooth.add.xml  --log log\scenario_1_duarouter  --bt-output ./fcd_int/bluetooth_scenario_1_duarouter.xml --tripinfo-output ./tripinfo/tripsinfo_scenario_1_duarouter.xml	

)