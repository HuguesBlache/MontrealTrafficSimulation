

python C:\Users\hugue\Sumo\tools\visualization\plot_summary.py -i seed110-running,seed130-running,seed150-running,seed170-running,seed190-running -m ended -l seed110,seed130,seed150,seed170,seed190 --xtime1  --ylabel "running vehicles [#]" --xlabel "time [hh:mm:ss]" --title "running vehicles over time" -o runningvehicules.png 

rem netconvert --osm-files MontrealTest.osm --remove-edges.by-type highway.residential,railway.rail,highway.footway,highway.path,highway.unclassified,highway.service,highway.track,highway.steps,highway.pedestrian,highway.living_street,highway.raceway --plain.extend-edge-shape true --edges.join true -o Montreal3.net.xml