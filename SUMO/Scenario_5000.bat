

FOR /L %%s IN (110,20,190) DO (
  ECHO %%s
  od2trips  --configuration-file .\od2trips\od2trips.config.xml --taz-files .\TAZ\TAZ.taz.xml --od-matrix-files .\Matrice\OD_Montreal_VoitureAM.od.txt --scale 0.2 --seed %%s --output-prefix seed%%s --output-file ./Scenario/5000/od2trips/od_5000.odtrips.xml
  duarouter --configuration-file .\duarouter\duarouter_configuration.xml  --with-taz true --seed %%s  --net-file .\Carte\net\MontrealJointure.net.xml --additional-files ./Vtype/Vtype.xml,.\TAZ\TAZ.taz.xml --route-files ./Scenario/5000/od2trips/seed%%sod_5000.odtrips.xml  --output-prefix seed%%s --output-file ./Scenario/5000/duarouter/od_5000.odtrips.rou.xml
  sumo.exe --seed %%s -c Simulation.sumocfg --net-file .\Carte\net\MontrealJointure.net.xml --route-files ./Scenario/5000/duarouter/seed%%sod_5000.odtrips.rou.xml  --output-prefix seed%%s- --summary ./Scenario/5000/summary/running --no-step-log true
  REM --tripinfo-output tripinfo%%s
  REM python C:\Users\hugue\Sumo\tools\xml\xml2csv.py seed%%s-running%%s  
  REM python C:\Users\hugue\Sumo\tools\xml\xml2csv.py seed%%s-tripinfo%%s
  REM python "C:\Program Files (x86)\Eclipse\Sumo\tools\xml\xml2csv.py" .\seed%%s-lanedata.xml
)