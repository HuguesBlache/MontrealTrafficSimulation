

FOR /L %%s IN (110,20,190) DO (
  ECHO %%s
  od2trips  --configuration-file .\od2trips\od2trips.config.xml --taz-files .\TAZ\taz_simulation.taz.xml --od-matrix-files .\Matrice\trajet_interieur\matrice_interieur.txt,.\Matrice\trajet_exterieur\matrice_exterieur.txt --scale 0.01 --seed %%s --output-prefix seed%%s --output-file ./Scenario/Copie/od2trips/od_Copie.odtrips.xml
  duarouter --configuration-file .\duarouter\duarouter_configuration.xml  --with-taz true --seed %%s  --net-file .\Carte\Carte_Simulation.net.xml --additional-files ./Vtype/Vtype.xml,.\TAZ\taz_simulation.taz.xml --route-files ./Scenario/Copie/od2trips/seed%%sod_Copie.odtrips.xml  --output-prefix seed%%s --output-file ./Scenario/Copie/duarouter/od_Copie.odtrips.rou.xml
  sumo.exe --seed %%s -c Simulation.sumocfg --net-file .\Carte\Carte_Simulation.net.xml --route-files ./Scenario/Copie/duarouter/seed%%sod_Copie.odtrips.rou.xml  --output-prefix seed%%s- --summary ./Scenario/Copie/summary/running 
  REM --tripinfo-output tripinfo%%s
  REM python C:\Users\hugue\Sumo\tools\xml\xml2csv.py seed%%s-running%%s  
  REM python C:\Users\hugue\Sumo\tools\xml\xml2csv.py seed%%s-tripinfo%%s
  REM python "C:\Program Files (x86)\Eclipse\Sumo\tools\xml\xml2csv.py" .\seed%%s-lanedata.xml
)