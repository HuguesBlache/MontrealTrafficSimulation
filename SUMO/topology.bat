
REM ########################################### TELECHARGEMENT DES ELEMENTS GENERAL #########################################


REM Compilation des cartes et créeation de la carte
wget  -O ".\input\carte\CarteMontreal.osm" --post-file=".\input\Carte\Montreal_Highway.overpass.ql.txt" "https://overpass.kumi.systems/api/interpreter"

REM IMPORTATION GTFS

wget https://www.stm.info/sites/default/files/gtfs/gtfs_stm.zip


REM ########################################### CARTE AVEC RUES RESIDENTIELLES #########################################



REM commande netconvert
netconvert -c .\input\carte\netconvert\config\netconvert.config.xml --osm-files ./input/carte/CarteMontreal.osm -o .\input\Carte\CarteMontreal.net.xml --junctions.join true --no-turnarounds true

REM DISTRICTS 

python ./function/edgesInDistricts.py -n .\input\Carte\CarteMontreal.net.xml -t ./input/TAZ/poly.xml -o ./input/TAZ/districts.taz.xml
 

REM UTILISATION DE GTFS2PT.py

python gtfs/gtfs2pt.py --network input\carte\CarteMontreal.net.xml --gtfs gtfs_stm.zip --date 20210822 --mapperlib MAPPERLIB --repair --vtype-output bus_type.add.xml --route-output ptline.rou.xml --additional-output ptstop.add.xml

REM ########################################### CARTE SANS RUES RESIDENTIELLES #########################################


REM commande netconvert
netconvert -c .\input\carte\netconvert\config\netconvert.config.xml --osm-files ./input/carte/CarteMontreal.osm -o .\input\Carte\CarteMontreal_Sans_Un_Res.net.xml --junctions.join true --no-turnarounds true --remove-edges.by-type highway.unclassified,highway.residential 

REM DISTRICTS 

python ./function/edgesInDistricts.py -n .\input\Carte\CarteMontreal_Sans_Un_Res.net.xml -t ./input/TAZ/poly.xml -o ./input/TAZ/districts_without.taz.xml
 

REM UTILISATION DE GTFS2PT.py

python gtfs/gtfs2pt.py --network input\carte\CarteMontreal_Sans_Un_Res.net.xml --gtfs gtfs_stm.zip --date 20210822 --mapperlib MAPPERLIB --repair --vtype-output bus_type.add.xml --route-output ptline_without.rou.xml --additional-output ptstop_without.add.xml

