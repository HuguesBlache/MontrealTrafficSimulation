

python C:\Users\hugue\Sumo\tools\visualization\plot_summary.py -i seed110-running110,seed130-running130,seed150-running150,seed170-running170,seed190-running190 -m meanTravelTime -l seed110,seed130,seed150,seed170,seed190 --xtime1  --ylabel "meanTraveltime (s)" --xlabel "time [hh:mm:ss]" --title "meanTravelTime over time" -o meanTravelTime.png 

rem netconvert --osm-files MontrealTest.osm --remove-edges.by-type highway.residential,railway.rail,highway.footway,highway.path,highway.unclassified,highway.service,highway.track,highway.steps,highway.pedestrian,highway.living_street,highway.raceway --plain.extend-edge-shape true --edges.join true -o Montreal3.net.xml