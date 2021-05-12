
REM Compilation des cartes et créeation de la carte

wget  -O ".\Carte\CarteMontreal.osm" --post-file=".\Carte\Montreal_Highway.overpass.ql.txt" "https://overpass.nchc.org.tw/api/interpreter"
netconvert --osm-files ./Carte/CarteMontreal.osm -o ./Carte/MontrealJointure.net.xml 


REM Compilation des Taz et créeation de Taz

wget  -O ".\Taz\Taz.osm" --post-file=".\Taz\nomquartier.xml" "https://overpass.nchc.org.tw/api/interpreter"
python .\function\generateTAZBuildingsFromOSM.py --osm ./Taz/Taz.osm --net ./Carte/MontrealJointure.net.xml --taz-output .\Taz\Taz.xml  --poly-output .\Taz\poly.xml --weight-output .\Taz\test.xml


FOR /L %%s IN (110,20,190) DO (
  ECHO %%s
  od2trips --configuration-file .\od2trips\od2trips.config.xml --taz-files .\TAZ\Taz.xml --od-matrix-files .\Matrice\OD_Montreal_5000.od.txt --seed %%s --output-prefix seed%%s --output-file ./Scenario/5000/od2trips/od_5000.odtrips.xml
  duarouter --configuration-file .\duarouter\duarouter_configuration.xml --seed %%s  --net-file .\Carte\MontrealJointure.net.xml --additional-files ./Vtype/Vtype.xml,.\TAZ\Taz.xml --route-files ./Scenario/5000/od2trips/seed%%sod_5000.odtrips.xml  --output-prefix seed%%s --output-file ./Scenario/5000/duarouter/od_5000.odtrips.rou.xml
  sumo.exe --seed %%s -c Simulation.sumocfg --net-file .\Carte\MontrealJointure.net.xml --route-files ./Scenario/5000/duarouter/seed%%sod_5000.odtrips.rou.xml  --output-prefix seed%%s- --summary ./Scenario/5000/summary/running
  REM --tripinfo-output tripinfo%%s
  REM python C:\Users\hugue\Sumo\tools\xml\xml2csv.py seed%%s-running%%s  
  REM python C:\Users\hugue\Sumo\tools\xml\xml2csv.py seed%%s-tripinfo%%s
  REM python "C:\Program Files (x86)\Eclipse\Sumo\tools\xml\xml2csv.py" .\seed%%s-lanedata.xml
)