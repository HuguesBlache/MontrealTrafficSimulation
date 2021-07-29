REM Compilation des cartes et créeation de la carte
wget  -O ".\input\carte\CarteMontreal.osm" --post-file=".\input\Carte\Montreal_Highway.overpass.ql.txt" "https://overpass.kumi.systems/api/interpreter"
REM commande netconvert
netconvert -c .\input\carte\netconvert\config\netconvert.config.xml --osm-files ./input/carte/CarteMontreal.osm -o .\input\Carte\CarteMontreal_Sans_Un_Res.net.xml --junctions.join true --no-turnarounds true --remove-edges.by-type highway.unclassified,highway.residential 

REM DISTRICTS 

python ./function/edgesInDistricts.py -n .\input\Carte\CarteMontreal_Sans_Un_Res.net.xml -t ./input/TAZ/poly_sans_residence.xml -o ./input/TAZ/districts.taz.xml
 


REM IMPORTATION GTFS

wget https://www.stm.info/sites/default/files/gtfs/gtfs_stm.zip

REM UTILISATION DE GTFS2PT.py

python gtfs/gtfs2pt.py --network input\carte\CarteMontreal_Sans_Un_Res.net.xml --gtfs gtfs_stm.zip --date 20210822 --mapperlib MAPPERLIB --repair --vtype-output bus_type.add.xml
 