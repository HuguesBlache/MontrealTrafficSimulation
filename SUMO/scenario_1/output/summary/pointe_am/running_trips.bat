

python C:\Users\hugue\Sumo\tools\visualization\plot_summary.py -i running_trips -m running -l seed110 --xtime1  --ylabel "running vehicles [#]" --xlabel "time [hh:mm:ss]" --title "running vehicles over time 80%  uniformise 5-9h 15min" -o runningvehicules.png 

rem netconvert --osm-files MontrealTest.osm --remove-edges.by-type highway.residential,railway.rail,highway.footway,highway.path,highway.unclassified,highway.service,highway.track,highway.steps,highway.pedestrian,highway.living_street,highway.raceway --plain.extend-edge-shape true --edges.join true -o Montreal3.net.xml