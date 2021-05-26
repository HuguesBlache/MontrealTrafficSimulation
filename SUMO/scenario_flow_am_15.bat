REM od2trips sans flow
od2trips --configuration-file .\input\od2trips\config\pointe_am\od2trips_5_9_15min.config.xml --taz-files ./input/TAZ/districts.taz.xml --od-matrix-files ./input/Matrice_OD\trajet_interieur_interieur\OD_Int_Int_Sans_SM.txt,./input/Matrice_OD\trajet_exterieur_exterieur\OD_Ext_Ext_Sans_SM.txt,./input/Matrice_OD\trajet_interieur_exterieur\OD_Int_Ext_Sans_SM.txt --seed 50  --flow-output .\input\flow\flow50.xml --scale 0.8
REM duarouter
duarouter --configuration-file .\input\duarouter\config\duarouter_configuration.xml --seed 50 -n .\input\Carte\CarteMontreal_Sans_Un_Res.net.xml --additional-files ./input/Vtype/Vtype.xml,./input/TAZ/districts.taz.xml --route-files .\input\flow\flow50.xml --output-file ./input/duarouter/result/pointe_am/flow_am_15.rou.xml --max-alternatives 10
REM Simulation sur SUMO
sumo.exe --seed 50 -c Simulation.sumocfg --net-file .\input\Carte\CarteMontreal_Sans_Un_Res.net.xml --mesosim true --route-files ./input/duarouter/result/pointe_am/flow_am_15.rou.xml  --summary .\output\summary\pointe_am\running_flow --additional-files output\edge_data\pointe_am\edgeData_flow.add.xml








 .\Flow\seed50flow50.xml
 --additional-files edgeData.add.xml,./Vtype/Vtype.xml,districts.taz.xml