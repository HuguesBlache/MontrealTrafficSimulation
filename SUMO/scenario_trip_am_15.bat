REM od2trips sans flow
od2trips --configuration-file .\input\od2trips\config\pointe_am\od2trips_5_9_15min.config.xml --taz-files ./input/TAZ/districts.taz.xml --od-matrix-files ./input/Matrice_OD\trajet_interieur_interieur\OD_Int_Int_Sans_SM.txt,./input/Matrice_OD\trajet_exterieur_exterieur\OD_Ext_Ext_Sans_SM.txt,./input/Matrice_OD\trajet_interieur_exterieur\OD_Int_Ext_Sans_SM.txt --seed 50  --output-file .\input\od2trips\result\point_am\trip_am_15.odtrips.xml --scale 0.8
REM duarouter
duarouter --configuration-file .\input\duarouter\config\duarouter_configuration.xml --seed 50 -n .\input\Carte\CarteMontreal_Sans_Un_Res.net.xml --additional-files ./input/Vtype/Vtype.xml,./input/TAZ/districts.taz.xml --route-files .\input\od2trips\result\point_am\trip_am_15.odtrips.xml --output-file ./input/duarouter/result/pointe_am/trip_am_15.rou.xml --max-alternatives 10
REM Simulation sur SUMO
sumo.exe --seed 50 -c Simulation.sumocfg --net-file .\input\Carte\CarteMontreal_Sans_Un_Res.net.xml --mesosim true --route-files ./input/duarouter/result/pointe_am/trip_am_15.rou.xml --summary .\output\summary\pointe_am\running_trips --additional-files output\edge_data\pointe_am\edgeData_trips.add.xml




REM python C:\Users\hugue\Sumo\tools\visualization\plot_net_dump.py  -n CarteMontreal_Sans_Un_Res.net.xml --measures density,density --xlabel [m] --ylabel [m] --default-width 1 --colormap #0:#00c000,.25:#408040,.5:#808080,.75:#804040,1:#c00000 -i seed50-edgesdensity.xml,seed50-edgesdensity.xml --min-color-value 0 --max-color-value 20  -o test.png
