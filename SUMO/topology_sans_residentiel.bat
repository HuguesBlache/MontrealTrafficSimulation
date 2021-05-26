REM Compilation des cartes et créeation de la carte
wget  -O ".\input\carte\CarteMontreal.osm" --post-file=".\input\Carte\Montreal_Highway.overpass.ql.txt" "https://overpass.nchc.org.tw/api/interpreter"
REM commande netconvert
netconvert -c .\input\carte\netconvert\config\netconvert.config.xml --osm-files ./input/carte/CarteMontreal.osm -o .\input\Carte\CarteMontreal_Sans_Un_Res.net.xml --remove-edges.by-type highway.unclassified,highway.residential 
REM CREATION DES TAZ\Taz
python ./function/edgesInDistricts.py -n .\input\Carte\CarteMontreal_Sans_Un_Res.net.xml -t ./input/TAZ/poly_sans_residence.xml -o ./input/TAZ/districts.taz.xml
