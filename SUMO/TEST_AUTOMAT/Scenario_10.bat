
REM Compilation des cartes et créeation de la carte

 REM wget  -O ".\Carte\CarteMontreal.osm" --post-file=".\Carte\Montreal_Highway.overpass.ql.txt" "https://overpass.nchc.org.tw/api/interpreter"

Rem Net convert
 REM netconvert --osm-files ./Carte/CarteMontreal.osm,.\Carte\CarteMontrealBus.osm -o ./Carte/MontrealJointure.net.xml  --ptstop-output ./Bus/ptstop.xml --ptline-output ./Bus/ptlines.xml --no-warnings true --remove-edges.by-type highway.unclassified,highway.residential


REM CREATION DES TAZ\Taz

REM polyconvert -n CarteMontreal_Sans_Un_Res.net.xml --shapefile-prefixes SM_OD2018 --layer 111 --shapefile.guess-projection true --shapefile.traditional-axis-mapping true --fill false -o Polygone.add.xml
REM SUMO_HOME>/tools/edgesInDistricts.py -n CarteMontreal_Sans_Un_Res.net.xml -t Polygone.add.xml

REM Importation des lignes de Bus

REM python tools/import/gtfs/gtfs2pt.py --network CarteMontreal_Sans_Un_Res.net.xml --gtfs gtfs_STM --date 20200901 -b 18000 -e 32400 


FOR /L %%s IN (110,20,190) DO (
  ECHO %%s
  od2trips --configuration-file .\od2trips\od2trips.config.xml --taz-files .\TAZ\Taz.xml --od-matrix-files .\Matrice\OD_Montreal_5000.od.txt --seed %%s --output-prefix seed%%s --output-file ./Scenario/5000/od2trips/od_5000.odtrips.xml --scale 0.01
  duarouter --configuration-file .\duarouter\duarouter_configuration.xml --seed %%s  --net-file .\Carte\MontrealJointure.net.xml --additional-files ./Vtype/Vtype.xml,.\TAZ\Taz.xml --route-files ./Scenario/5000/od2trips/seed%%sod_5000.odtrips.xml  --output-prefix seed%%s --output-file ./Scenario/5000/duarouter/od_5000.odtrips.rou.xml
  sumo.exe --seed %%s -c Simulation.sumocfg --net-file .\Carte\MontrealJointure.net.xml --route-files ./Scenario/5000/duarouter/seed%%sod_5000.odtrips.rou.xml,./Bus/flowspt.rou.xml -a ./Bus/ptstop.xml --output-prefix seed%%s- --summary ./Scenario/5000/summary/running
  REM --tripinfo-output tripinfo%%s
  REM python C:\Users\hugue\Sumo\tools\xml\xml2csv.py seed%%s-running%%s  
  REM python C:\Users\hugue\Sumo\tools\xml\xml2csv.py seed%%s-tripinfo%%s
  REM python "C:\Program Files (x86)\Eclipse\Sumo\tools\xml\xml2csv.py" .\seed%%s-lanedata.xml
)