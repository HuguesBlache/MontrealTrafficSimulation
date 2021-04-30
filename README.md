<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<link href="style.css">
</head>
<body>
<h1 align="center">Montréal Traffic Simulation </h1>
	
 Projet de Maitrise de Hugues Blache 
 
<h2 align="center">Table des matières</h2>

1. <a href="#doc">Documentation SUMO</a><br>
2. <a href="#doc">Contexte</a><br>
3. <a href="#carte">Génération du reseau de l'ile de Montréal</a><br>
4. <a href="#OD">Création de la demande </a><br>
5. <a href="#autos">Génération de la demande</a><br>
6. <a href="#Simulation">Simulation</a><br>
7. <a href="#actifs">Prise en compte des modes actifs</a><br>
8. <a href="#fusion">Fusion des modes</a><br>
9. <a href="#feux">Feux de circulation</a><br>
10. <a href="#données">Collectes de données</a><br>
11. <a href="#visualisation">Visualisation</a><br>
12. <a href="#simulation">Simulation</a><br>

<h2 align="center" id="doc">Documentation SUMO</h2>

Ce projet se réfère principalement à la documentation de <a href="https://sumo.dlr.de/docs/SUMO_User_Documentation.html">Sumo</a> et du Professeur Nicolas Saunier pour le cours <a href="https://github.com/nsaunier/CIV8740/blob/master/guide-sumo.md">CIV8740</a>. Les autres sources seront citées à la fin du document.

<h2 align="center" id="doc">Contexte</h2>

<p align="center">
  <img  width="650" height="450" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/Sumo_M2M.png">	
</p>

<p align="center">
  <img  width="650" height="450" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/V2X_App.png">	
</p>

<h2 align="center" >Génération du reseau de l'ile de Montréal</h2>

<h3 align="center" id="carte">Topologie de l'ile de Montréal</h3>

Le cadre de cette étude est de prendre la circulation sur l'ile de Montréal. Afin de reprondre au exigences du reseau, les informations concernant l'ile sont importé avec <a href="https://www.openstreetmap.org/">OpenStreetMap (OSM)</a>. Neanmoins, comme le simulateur est une entrée du logiciel <a href="https://www.trafficm2modelling.com/"> M2M</a> et que les données topologiques et que une certaines formes de l'ile est necessaire, le site <a href="https://extract.bbbike.org/">BBbike</a> en est une solution comme le montre la figure suivante :

<p align="center">
  <img  width="450" height="350" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/capture_BBBike.png">
  <img  width="450" height="350" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/capture_M2M.png">	
</p>

Comme les données OSM sont trop lourd pour les temps de calcule de la simulation, un certain nombre de route ont été supprimé du reseau avec la commande NETCONVERT. Le route presente dans le reseau seront les <em>highway.motorway, highway.primary, highway.secondary, highway.tertiary, highway.cycleway, railway.subway, highway.motorway_link, highway.primary_link, highway.secondary_link, highway.tertiary_link</em>

Ce qui donne comme reseau sur SUMO:

<p align="center">
  <img src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/capture_SUMO.png">
</p>


Le tableau suivant represente la compraison entre l'importation brute et le filtrage de route de la carte de l'ile de Montréal pour des entites jugé utile par la suite.

|Entité | Sans reduction | Avec prise en compte | Reduction| 
| ------------- | ------------- |------------- |------------- |
| Nodes | 82354  |21919 | 73,4% |
| Edges | 186732  |35866 | 80,7% |
| Dead-end junctions | 14368 |149  | 99%|
| Priority junctions | 50194 |18335 | 63,5%|
| Right-before-left junctions  | 14178  |410 | 97%|
| Traffic light junctions | 3397  |3025 | 11% |


<h3 align="center" id="feux">Intersection et feux de circulation</h3>


<h4 align="center" id="feux">Temps de cycle</h4>


Un des probleme recurant dans SUMO est le temps de cycle des feux de circulation qui parfois ne correspondes pas à la valeurs des villes etudier. Or n'ayant pas acces au plan de feux de la ville de Montréal, les cycles seront defini par default à 90 secondes  


<h4 align="center" id="feux">Paramètres</h4>

No turn

<h4 align="center" id="feux">Fusion de jonction</h4>

Un des problèmes qui peut subvenir lors du téléchargement de certains secteurs : parfois les feux de circulation d'un carrefour à plusieurs branches passent au vert simultanément. 

<p align="center">
  <img width="460" height="300" src="https://user-images.githubusercontent.com/65184943/86969904-82825700-c13c-11ea-963b-cac24d041739.png">
    <img width="460" height="300" src="https://user-images.githubusercontent.com/65184943/86971270-ddb54900-c13e-11ea-9607-de2aabbc94c1.png">
 
</p>

Si un probleme preciste, comme vu plus haut, une des solutions est de "fusionner" les jonction proche pour en créer un seul, et donc un seul feux de circulation. Pour cela, il existe de nombreux paramètre sur <a href="https://sumo.dlr.de/docs/netconvert.html#junctions">netconvert</a> dont le --junctions.join, qui  permet de joindre deux feux de circulation proche. 

Après avoir lancer la construction du reseau on peut remarquer que le problème est "resolu" en partie. Car le feux est synchronisé en fonction des voies de circulation, comme le montre l'image si dessous. 

<p align="center">
  <img src="https://user-images.githubusercontent.com/65184943/93613822-59cdd780-f99f-11ea-84a9-460a3d6725dc.png">
</p>


<h5 align="center" >Impacte sur la simualation</h5>

<h6 align="center" >Temps de parcours</h6>

Nous pouvons d'abord regarder la differance au niveau du temps de parcours (duration,WaitingTime,TimeLose) des deux types de cartes que nous avons produit (feux de circulation fusionner, pas de chagement à l'importation). Pour cela nous allons prendre une base d'un peu plus de 5000 vehicules identique, et nous allons vusaliser les données du TripInfo (expliqué dans la section collectes de <a href="#tripinfo"> données </a>). Ainsi nous trouvons: 
<table  align="center">
	<a align="center">
  <tr>
    <th>Carte</th>
    <th>Temps de parcours moyen (en s)</th> 
    <th>Ecart Type</th>
    <th>Temps d'attentes moyen (en s)</th>
    <th>Ecart Type</th>
    <th>Temps perdu (en s)</th>
    <th>Ecart Type</th>
  </tr>
  <tr>
    <td>Sans changement</td>
    <td>1305</td>
     <td>998</td>
    <td>697</td>
     <td>751</td>
    <td>308.8</td>
     <td>869</td>
  </tr>
  <tr>
    <td>Fusion des jonction</td>
    <td>852</td>
    <td>544</td>
    <td>285</td>
    <td>277</td>
    <td>236</td>
    <td>373</td>
  </tr>
   <tr>
    <td>Reduction (en %)</td>
    <td>35%</td>
    <td>...</td>
    <td>59%</td>
    <td>...</td>
    <td>51%</td>
    <td>...</td>
  </tr>
		</a>
</table>

Donc en rectifiant cette erreur de synchronisation des feux de circulation, on peut voir que les facteurs temps peuvent être reduit de parfois de moitier. Il est donc important de prendre en compte ce genre de detaille, car il peut affecter les decisions que l'on peut avoir qvec ce type de modèle (exemple: Lien entre temps perdu et economie perdu...)

On peut aussi le voir sur la repartition des vitesses comme sur le boxplot qui suit, oû l'on constate que la vitesse est relativement plus grades avec une simulation avec fusion 


<p align="center">
  <img width="560" height="400" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/dist_vitess_junct.png">
</p>



<h6 align="center" >Teleportation</h6>

Mise à part le temps de parcours, il faut aussi regarder du cote des vehicules teleporter pour viusaliser un changement. Comme representer sur la figure XX, on peut constater une nette distinguation entre d'un cote beaucoup de teleportation pour les scenarios sans fusion de jonction et de leurs avec peu de teleportation avec une fusion.

<p align="center">
  <img width="560" height="400" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/teleportation.png">
</p>

Au vu de la sensibilité de ses deux scénariosn, dans la suite du projet nous prendrons pour la simulation les reseaux avec des fusions des jonctions

<h3 align="center" id="TC">Implantation des arrets de bus</h3>

Après avoir construit notre reseau, il est possible de gréfer à notre modèle des arrets de bus et des informations des trajets. Pour cela, il existe des <a href="https://sumo.dlr.de/docs/Tutorials/PT_from_OpenStreetMap.html"> fonctions </a> qui peuvent directement implanter dans SUMO pour recuper les information des trajets de bus selon les relations dans OpenStreetMap. C'est commande sont:

 <ul  align="center">
  <li  align="center" >osm.stop-output.length : Cette fonction permet de difinire des longueur des arrets de bus par default, nous prendrons 20 metres</li>
  <li  align="center">ptstop-output : Cette fonction permet de renseigner sur les emplacements des arrets des bus sur notre carte</li>
  <li  align="center">ptline-output: Cette fonction permet de renseigner sur les trajets des lignes de bus</li>
</ul> 

Ce qui nous donnes la commandes suivante:


```
netconvert --osm-files <Files> -o <Files> --osm.stop-output.length 20 --ptstop-output ptstop.add.xml --ptline-output ptlines.xml

```
Pour visualiser la emplacement dans la simulation, il faut ajouter un fichier additionnel dans le .sumocfg qui porte le nom où ce situe le fihcier des arrets, ici ```ptstop.add.xml```

<p align="center">
  <img width="500" height="400" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/arret_bus.png">
    
</p>



Pour notre simulation nous prendrons les <a href="https://wiki.openstreetmap.org/wiki/Relation"> relations </a>  des lignes de la <a href="https://wiki.openstreetmap.org/wiki/Bus_routes_in_Montr%C3%A9al"> STM </a> (Société de transport de Montréal)



<img width="30" height="30" src="https://user-images.githubusercontent.com/65184943/87172123-bb880c00-c2a1-11ea-8b11-ff689734475f.jpg"> Les <i> ptstop </i> et les <i> ptline </i> peuvent parfois ne pas prendre en compte certaines lignes et arrêts si les <a href="https://wiki.openstreetmap.org/wiki/Relation"> relations </a>  dans OSM ne sont pas bien construites.



<h4 align="center" id="mauvaise">Mauvaise relation</h4>

Une mauvaise relation ne sera pas prise en compte par SUMO. Il peut y avoir plusieurs raisons:

- Les arrêts de bus qui ne sont bien placés ou "hors" de la route
- Les chemins (ways) ne sont pas pris en compte dans la relation
<p align="center">
  <img src="https://user-images.githubusercontent.com/65184943/87174223-dc9e2c00-c2a4-11ea-8346-2265984c09c7.png">
    
</p>

<h4 align="center">Bonne relation</h4>

La bonne relation sera contrairement à la <a href="#mauvaise"> mauvaise </a> bien prise en compte par SUMO

<p align="center">
<img src="https://user-images.githubusercontent.com/65184943/87174266-eaec4800-c2a4-11ea-8869-0ef4552443ed.png">
 </p>


Quelques solutions sont possibles pour les implanter ce manques ...



<h4 align="center" id="mauvaise">Comparaison du nombre d'arret de bus</h4>

Voici une comparaison du nombre d'arret de bus avec la réalité et notre resea:

<table  align="center">
	
  <tr>
    <th>Entité</th>
    <th>Réalité</th> 
    <th>Simulation</th>
    <th>Difference</th>
  </tr>
  <tr>
    <td>Nombre d'arret</td>
    <td>8788</td>
     <td>2074</td>
    <td>76,4%</td>
  </tr>
  <tr>
    <td>Nombre de lignes</td>
    <td>216</td>
    <td>104</td>
    <td>51,8%</td>
  </tr>
   
</table>


<h2 align="center" id="OD"> Création de la demande</h2>

Pour la création de la demande, le choix s'est tournée vers la matrice Origine-Destination de l'ARTM datant de 2013. Cette matrice contient de nombreuses informations utile pour la simulation de la circulation. Donc cette étude, l'heure de pointe du matin, comprise entre 5h et 9h sera pris en compte. 

<h3 align="center" id="quartier" >Lieu d'origine et de destination</h3>

Pour importer une matrice Origine-Destination dans SUMO, il faut d'abord renseigner au logiciel les districts ou les traffic assignment zone (<a href="https://sumo.dlr.de/docs/Demand/Importing_O/D_Matrices.html">TAZ</a>) qui serviront d'arriver ou de depart des véhicles.

La premiere etape consite à determiner le limite administratifs de ces fichiers TAZ, pour cette simulation se sont les limites administratifs de l'ARTM qui ont été pris en compte et la ville de Montréal des <a href="http://donnees.ville.montreal.qc.ca/dataset/polygones-arrondissements">limites</a> des arrondissements.


Les fichiers  permettront de déterminer toutes les sections de routes qui appartiennent à une zone. Dans notre étude de cas nous allons déterminer les routes qui appartiennent à chaque secteur pour ensuite créer les déplacements.

```xml
<tazs>
    <taz id="<TAZ_ID>" edges="<EDGE_ID> <EDGE_ID> ..."/>

    ... further traffic assignment zones (districts) ...

</tazs>
```

La carte ci-dessous représente le quartier du Plateau Mont-Royal de Montréal (indicateur 106 de la matrice OD). Lors que la simulation toutes les voitures seront générées aléatoirement dans cette zone rouge d'origine.

<p align="center">
  <img width="460" height="300" src="https://user-images.githubusercontent.com/65184943/86967899-41d50e80-c139-11ea-907e-d64b432a1c0a.png">
</p>


<h4 align="center">Route dans les TAZ</h4>

L'etape vu plus haut ne renseigner seulement des limites de chaques ORiginie et Destination sans prendre en consideration les routes à l'interieur de cette dernièreé. Appliquer la fonction <i><a href="https://sumo.dlr.de/docs/Tools/District.html"> edgesInDistricts.py </a></i> aux polygonnes créés dans la section <i>Définition des <a href="#quartier">secteurs </a></i>. Ceci permet ainsi de créer dans un fichier <a href="https://github.com/HuguesBlache/ProjetPoly/blob/master/CarteMontreal/districts.taz.xml">TAZ</a>  les limites administratives, est ainsi créer les routes. Voici un exemple de code

  ```
  <SUMO_HOME>/tools/edgesInDistricts.py -n Montreal.net.xml -t Quartier.add.xml
  ```

<h3 align="center">Changement de format de la Matrice OD</h3>

Une premiere étape de l’implantation de la matrice OD à été de modifier la Matrice OD fournis par l’ARTM. Notre modèle, nous oblige à avoir une matrice n*n qui est illisible de manière brute par SUMO. En effet, SUMO ne peut lire que 3 types de Matrice et nous avons choisie de travailler avec un matrice de type "O-Format". Ce type de format est une matrice à n ligne et 3 colones, avec la premier colonne correspont à l’origine, la deuxieme la destination et la derniere le nombre de véhicules generer. Pour ce faire nous avons créer un petit script sur jupyter qui permet de transformer la matrice de cette sorte 


Format de la matrice OD "classique"


<table  align="center">
	
  <tr>
    <th>Origine-Destination</th>
    <th>Dest 1</th> 
    <th>Dest 2</th>
    <th>Dest 3</th>
  </tr>
  <tr>
    <td>**Orig1**</td>
    <td>1</td>
    <td>2</td>
    <td>3</td>
  </tr>
    <tr>
    <td>**Orig2**</td>
    <td>4</td>
    <td>5</td>
    <td>6</td>
  </tr>
    <tr>
    <td>**Orig3**</td>
    <td>7</td>
    <td>8</td>
    <td>9</td>
  </tr>
		
	
</table>

Format de la matrice OD (O-format) sur SUMO

<table  align="center">
	
  <tr>
    <th>Origine </th>
    <th>Destination</th> 
    <th>Nombre d'auto</th>
 
  </tr>
  <tr>
    <td>Orig1</td>
    <td>Dest1</td>
    <td>1</td>
  </tr>
    <tr>
    <td>Orig1</td>
    <td>Dest2</td>
    <td>2</td>
  </tr>
   <tr>
    <td>...</td>
    <td>...</td>
    <td>...</td>
  </tr>
    <tr>
    <td>Orig3</td>
    <td>Dest3</td>
    <td>9</td>
  </tr>
		
	
</table>

Un exemple de <a href="https://github.com/HuguesBlache/ProjetPoly/blob/master/Transformation%20matrice%20OD%20en%20O-format-checkpoint.ipynb">code</a> sur JupyterNotebook pour la modification de la matrice.

<h4 align="center">Prise en compte des voitures trajets "exterieur"</h4>

Nous pouvons ne prendre en compte que les déplacements en auto qui se produit à l'intérieur de l'ile de Montreal. Mais si c'est le cas, nous ne comptons pas les déplacements produit de l'ile de Montreal vers l'extérieur (Rive Nord/Sud) qui représente un peu plus de 5% des déplacements. Mais surtout les déplacements venant de l'extérieur qui repésentent un peu plus de 30% des deplacéments venant vers Montreal. Ne pas prendre en compte ces déplacements peuvent engendrer un sous-"régime" des deplacements, et dans ce cas ne pas pouvoir refléter une certaine réalité des déplacements. Pour mieux illustre ces déplacements nous pouvons nous référer au <a href="http://ville.montreal.qc.ca/pls/portal/docs/PAGE/MTL_STATS_FR/MEDIA/DOCUMENTS/PORTAIT%20DES%20D%C9PLACEMENTS%202008%20-%20VILLE%20DE%20MONTR%C9AL.PDF">portrait</a>  des déplacements de 2008 de l'ile de Montréal.

<p align="center">
  <img width="400" height="500" src="https://user-images.githubusercontent.com/65184943/93515262-54688280-f8f6-11ea-90d3-29930c1acd88.png">
  <img width="400" height="500" src="https://user-images.githubusercontent.com/65184943/93515271-55011900-f8f6-11ea-96a8-45c5dc962935.png">
</p>

<h3 align="center">Definition des véhicules</h3>

Pour essayer de representer un simulation de la circulation heterogene, nous nous avons decidé de prendre en compte plusieurs type de véhicules dans notre simulation.

<h4 align="center" id="type">Catégories automobile</h4>

Il est spécifié dans la matrice OD que nous utilisons dans notre simulation que les trajets automobile correponds à un melanges Automobile et Moto sans renseignement du pourcentages. Pour spécifier se pourcentage et ainsi distinguer les differentes categories de véhicules, nous nous sommes dériger vers  la <a href="https://saaq.gouv.qc.ca/donnees-ouvertes/vehicules-circulation/vehicules-circulation-documentation.pdf"> SAAQ </a> et des <a href="https://bdso.gouv.qc.ca/pls/ken/ken213_afich_tabl.page_tabl?p_iden_tran=REPERBA6Z3O56149094340058BfZ9c&p_lang=1&p_m_o=SAAQ&p_id_ss_domn=718&p_id_raprt=3628#tri_tertr=00&tri_mun=aaaaa"> stastitique </a> du Quebec pour definir le part de ces vehicules promenade dans le parc automobile de l'ile de Montreal :


<table  align="center">
	<a align="center">
  <tr>
    <th>Type de vehicules</th>
    <th>Nombre</th> 
    <th>Pourcentage</th>
  </tr>
  <tr>
    <td>Automobile</td>
    <td>563880</td>
    <td>65%</td>
  </tr>
  <tr>
    <td>SUV/Camion léger</td>
    <td>269475</td>
    <td>32%</td>
  </tr>
  <tr>
    <td>MOtocyclette</td>
    <td>15203</td>
    <td>2%</td>
  </tr>
	<tr>
    <td>Cyclomoteyr</td>
    <td>5607</td>
    <td>1%</td>
  </tr>
		</a>
</table>


Puis, pour prendre des modèle type <a href="https://journalmetro.com/automobile/419357/les-vehicules-les-plus-vendus-en-2013/"> vendu </a> en 2013 avec leur <a href="https://github.com/HuguesBlache/ProjetPoly/blob/master/MatriceOD/Copie%20de%20Tableau.xlsx
"> carateristique</a>  et les valeurs Vclass de SUMO qui sont les suivants:


<table  align="center">
	<a align="center">
  <tr>
    <th>Modele</th>
    <th>Longueur (m)</th> 
    <th>Hauteur (m)</th>
    <th>vClass </th>
    <th>maxSpeed (m/s) </th>
  </tr>
  <tr>
    <td>Toyota Corolla 2013</td>
    <td>4,5</td>
    <td>1,76</td>
    <td>private</td>
    <td>55.56</td>
  </tr>
  <tr>
    <td>Ford F 150</td>
    <td>5,9</td>
    <td>1,9</td>
    <td>delivery</td>
    <td>55.56</td>
  </tr>
  <tr>
    <td>Yamaha FZ</td>
    <td>2,07</td>
    <td>0.8</td>
    <td>motorcycle</td>
    <td>55.56</td>
  </tr>
	<tr>
    <td>Honda Forza 125</td>
    <td>2.140</td>
    <td>0.78</td>
    <td>moped</td>
    <td>16.67</td>
  </tr>
		</a>
</table>

Comme les vitesses entre chaques véhicules n'est identiques dans la réalité, nous decidons que les differentes vitesses des véhicules suivront une distribtion normal à l'aide de la commande <i> speedFactor </i> et en spécifiant <i>normc (moyenne, dev, min, max) </i>. Et dans notre cas nous prendons: 

 <ul  align="center">
  <li  align="center" >moyen = 1</li>
  <li  align="center">dev = 0.1</li>
  <li  align="center">min = 0.60</li>
  <li  align="center">max = 1.3</li>
</ul> 

Ce qui signifie que 90% des véhicules roules entres roules entres 60% et 130% de la vitesse autorisé sur une route specifiques.

<h5 align="center">Car-Following Model</h5>

Par default nous utiliserons le modèle de poursuite de SUMO, celui de Krauss, qui à pour caratéristique

 <ul  align="center">
  <li  align="center" >accel = 2.60</li>
  <li  align="center">decel = 4.50</li>
  <li  align="center">sigma = 0.50</li>
  <li  align="center">tau = 1</li>
</ul> 

<h5 align="center">Emissions</h5>


https://theicct.org/sites/default/files/info-tools/One%20table%20to%20rule%20them%20all%20v1.pdf

<table  align="center">
	<a align="center">
  <tr>
    <th>Modele</th>
    <th>Consomation</th> 
    <th>Nomre Euro</th>
    <th>SUMO</th>
  </tr>
  <tr>
    <td>Toyota Corolla 2013</td>
    <td>7,6</td>
    <td>Euro5</td>
    <td>PC_G_EU5</td>
  </tr>
  <tr>
    <td>Ford F 150</td>
    <td>13</td>
    <td>Euro3</td>
    <td>PC_G_EU3</td>
  </tr>
  <tr>
    <td>Yamaha FZ</td>
    <td>5,6</td>
    <td>Euro6</td>
    <td>PC_G_EU6</td>
  </tr>
	<tr>
    <td>Honda Forza 125</td>
    <td>2,3</td>
    <td>Euro6</td>
    <td>PC_G_EU6</td>
  </tr>
		</a>
</table>



<h5 align="center">Commande Vtype</h5>

Il existe plusieur <a href="https://sumo.dlr.de/docs/Definition_of_Vehicles,_Vehicle_Types,_and_Routes.html#abstract_vehicle_class"> Class </a>, qui pernent encompte certaines carateristiques par default. Ci dessous nous envons creer 4 type de vehicules different pour notre simulation: 

```xml
 <vType id="Car" color="0,255,255" length="4.5" vClass="private" emissionClass="HBEFA3/PC_G_EU5" probability="0.65" accel="2.6" decel="4.5" sigma="0.5"  speedFactor="normc(1.0,0.1,0.6,1.3)" maxSpeed="55.56"/>
<vType id="SUV" color="255,0,255" length="5,9" vClass="delivery" emissionClass="HBEFA3/PC_G_EU3" probability="0.32" accel="2.6" decel="4.5" sigma="0.5"  speedFactor="normc(1.0,0.1,0.6,1.3)" maxSpeed="55.56"/>
<vType id="motorcycle" color="0,0,255" length="2,07" vClass="motorcycle" emissionClass="HBEFA3/PC_G_EU6" probability="0.02" accel="2.6" decel="4.5" sigma="0.5"  speedFactor="normc(1.0,0.1,0.6,1.3)" maxSpeed="55.56"/>
<vType id="cyclomotor" color="0,255,0" length="2.14" vClass="moped" emissionClass="HBEFA3/PC_G_EU6"  probability="0.01" accel="2.6" decel="4.5" sigma="0.5"  speedFactor="normc(1.0,0.1,0.6,1.3)" maxSpeed="16.67"/>
 
```

<h4 align="center" id="type">Catégories bus</h4>

La demarche est la même que pour la definition des véhicules, mais pour simplifier la simulation, nous ne prendrons qu'un seul type de <a href="https://www.stm.info/sites/default/files/affairespubliques/Communiques/Annexes/annexe_2_fiche_tech._lfs_nova.pdf">bus </a>.

<table  align="center">
	<a align="center">
  <tr>
    <th>Modele</th>
    <th>Longueur (m)</th> 
    <th>Hauteur (m)</th>
    <th>vClass </th>
    <th>maxSpeed (m/s) </th>
    <th>Consomation</th> 
    <th>Nomre Euro</th>
    <th>SUMO</th>
  </tr>
  <tr>
    <td>Nova Bus</td>
    <td>12,2</td>
    <td>3.25</td>
    <td>Bus</td>
    <td>27.78</td>
    <td><a href="http://www.bv.transports.gouv.qc.ca/mono/1018809.pdf"> 45</a></td>
    <td>Euro6</td>
    <td>PC_G_EU6</td>
  </tr>
	</a>
</table>


<h2 align="center" id="autos" >Génération de la demande</h2>


<h3 align="center">Affectation des parcours dans SUMO</h3>


<h4 align="center">od2trips</h4>




Après avoir construit le fichier TAZ et créé la Matrice OD, nous pouvons maintenant construire les déplacements sur notre modèle. La fonction <i> <a href="https://sumo.dlr.de/docs/od2trips.html"> od2trips.py </a> </i> permet d'affecter les voyages de chaques véhicules (traject Origine jusqu'à la destination) dans un nouveau fichier à partir de la matrice OD et des TAZ que nous avons definies. Pour notre simulation, nous voulons que la repartitions des trajets soit uniforme, on peut l'utiliser avec la commande <i>spread.uniform </i>


<p align="center">
  <img width="600" height="300" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/od2trips.png">
  
</p>


On peut créer un fichier des different paramettre enoncer plus haute ainsi qu'un prefix des véhciles afin de construire les types véhicles. Nous nommerons ce fichier <i> od2trips.config.xml</i>

```xml
<?xml version="1.0" encoding="UTF-8"?>

<configuration>
	<input>
		<taz-files value=<Taz_files>/>
		<od-matrix-files value=<OD_Matrix_Files>/>
	</input>
	
	<output>
		<output-file value=<Name_file>/>
	</output>
	
	<processing>
		<prefix value=<String_value> />
		<spread.uniform value="true" />
	</processing>
</configuration>

```
Pour execter le fihcier od2trips il suffit de prendre suivre la commande suivante:

```
od2trips -c od2trips.config.xml 

```

<h4 align="center" id="duarouter">duarouter</h4>

Après avoir créer des trajets indivuelle a partir de la matrice OD grace à od2Trips, on peut utiliser la fonction <i> <a href="https://sumo.dlr.de/docs/duarouter.html"> duarouter.py </a> </i> qui permet de generer des itiniraires de plus court chemin à l'aide des trajet que nous avons construit. Nous avons pris l'option ignore-error afin de ne pas interroptre les calculs en cas d'erreur de calcule.

<p align="center">
  <img width="600" height="400" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/duarouter.png">
  
</p>

On peut créer un fichier des different paramettre enoncer plus haute. Nous nommerons ce fichier <i> duarouter_configuration.xml</i>

```xml


<?xml version="1.0" encoding="UTF-8"?>


<configuration>
	<input>
		<net-file value=<Network_files/>
		<route-files value=<od2trips_output_files>/>
		<additional value=<Vtype_Files> />
	</input>
	
	<output>
		<output-file value=<Name_file>/>
	</output>

	<report>
		<xml-validation value="never"/>
		<no-step-log value="true"/>
		<ignore-error value="true"/>
	</report>
</configuration>
```

Pour execter le fihcier avec duarouter il suffit de prendre suivre la commande suivante:


```
duarouter -c duarouter_configuration.xml
```

<h4 align="center" id="duarouter">Resumer de la generation de la demande</h4>

En resumer, voici la demarche de la generation de trajet dans notre simulation


<p align="center">
  <img src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/Generation_OD.png">
  
</p>





<h2 align="center" id="Simulation">Simulation</h2>

<h3 align="center">Graine</h3>

```batch
FOR /L %%s IN (110,20,190) DO (
  ECHO %%s
  od2trips -c od2trips.config.xml --output-prefix seed%%s
  duarouter -c VoitureAM.trips2routes.duarcfg.xml  --route-files  seed%%sod_ileVoitureAM.odtrips.xml  --output-prefix seed%%s --ignore-errors true 
  sumo.exe --seed %%s -c C:\Users\hugue\ProjetPoly\Scenario\Jointure_Etude_Retard\Avec_Jointure\Graine.sumocfg --route-files seed%%stripsvoiture.odtrips.rou.xml  
)

```

```xml
<configuration xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://sumo.dlr.de/xsd/sumoConfiguration.xsd">
  <input>
    <net-file value="carte/MontrealAvecJoin.net.xml"/>
  </input>
  <time>
    <begin value="18000"/>
    <end value="36000"/>
    <step-length value="1"/>
  </time>
</configuration>
```


# PAS MODIFIÉ









Arrivé à cette étape, nous pouvons déja commencer à simuler notre modèle avec les trajets d'autos dans SUMO.

Par étapes:

- Création sur fichier <i><a href="https://github.com/HuguesBlache/ProjetPoly/blob/master/CarteMontreal/Montreal.sumocfg"> Montreal.sumocfg </a> </i>

- Visualation directe sur SUMO GUI

  - Circulation 
  
  
<p align="center">
  <img  src="https://user-images.githubusercontent.com/65184943/87171442-ae1e5200-c2a0-11ea-82bf-ec953620d907.png">
   
 
</p>


<p align="center">
  <img  src="https://user-images.githubusercontent.com/65184943/87171434-ab236180-c2a0-11ea-8db3-253d1d4b64ea.png">
   
 
</p>

   - Données
  
 <p align="center" id="courbe">
  <img img width="300" height="500" src="https://user-images.githubusercontent.com/65184943/87579863-9da51780-c6a4-11ea-9d93-669ea1eb4d63.png">
   <img img width="700" height="500" src="https://user-images.githubusercontent.com/65184943/87579877-a269cb80-c6a4-11ea-9548-455758dad1a9.png">
  </p>
  
  <p align="center">
  
 
  
  </p>
  Dans cette exemple on prendre les données d'insertion des vehicules dans notre modèle, qui peut être sortie en format <a href="https://github.com/HuguesBlache/ProjetPoly/blob/master/CarteMontreal/insertion.csv">CSV </a>
 
<h4 align="center" id="TC">Heure de pointe</h4>

Nous n'avons pas calibrer les données de la matrice OD à la "realité", ce qui donne dans la <a href="#courbe"> courbe </a> un maximun de vehicules au depart de la simualtion. Or nous devrions voire une courbe en "cloche". POur le verifier, nous pouvons visualiser les données ouvertes de <a href="https://www.bixi.com/fr/page-27"> Bixi </a> qui permetra de voire la tendance sur la plage horraire 5h-9h.

Apres exploitation des <a href="https://github.com/HuguesBlache/ProjetPoly/blob/master/MatriceOD/OD_2014-09%20(version%201).csv">données</a> nous avons des courbes du type.

<p align="center">
<img width="400" height="300" src="https://user-images.githubusercontent.com/65184943/93345446-d24a6200-f800-11ea-9ae6-fdac7f205252.png">
<img width="400" height="300" src="https://user-images.githubusercontent.com/65184943/93345464-d7a7ac80-f800-11ea-82cb-50edfda9a1a2.png">
</p>

Ci on prend en compte le pourcentage par tranche horraire, nous aurons 

<table  align="center">
	<a align="center">
  <tr>
    <th>Tranche horraire</th>
    <th>Nombre de velo</th> 
    <th>Pourcentage</th>
  </tr>
  <tr>
    <td>5h-6h</td>
    <td>436</td>
    <td>10%</td>
  </tr>
  <tr>
    <td>6h-7h</td>
    <td>854</td>
    <td>19%</td>
  </tr>
  <tr>
    <td>7h-8h</td>
    <td>2037</td>
    <td>45%</td>
  </tr>
	<tr>
    <td>8h-9h</td>
    <td>1179</td>
    <td>26%</td>
  </tr>
		</a>
</table>


Nous allons donc prendre ce pourcentage pour le mettre à niveau le nombre de voiture sur la simulation


<h3 align="center">Implentation des trajets</h3>

Tout d'abord, on peut créer des trajets de bus grâce à la fonction <i> <a href="https://github.com/eclipse/sumo/tree/master/tests/tools/public_transport/ptlines2flows"> ptlines2flows.py </a> </i>.
2
```
ptlines2flows.py -n Montreal.net.xml -s ptstop.add.xml -l ptlines.xml 
    -o flows.rou.xml -p 600 --use-osm-routes

```
La partie ```-p 600``` correspond, en secondes, à l'intervalle de temps entres chaques bus d'une même ligne sur un même arret. A ce moment de la simulation les bus tourne à "vide", pourons par la suite faire des trajets intermodaux 


<p align="center">
<img src="https://user-images.githubusercontent.com/65184943/89458733-88685980-d735-11ea-8628-0b614b5bb6ff.png">
 </p>



Nous pouvons aussi choisir par type de mode pour ce concentrer sur un seul  

```
--types bus,subway,train

```
<h3 align="center">Type de vehicules</h3>

Comme dans la section <a href="#type"> choix </a> de l'automobile, nous pouvons modifier les carateristique du bus. Cela permettra par la suite de modifier l'offre de transport en commun en augmentant par exemple le nombre de place par bus.

<h3 align="center">Demande des Transports en commun</h3>

La partie de la matrice <a href="#OD"> OD </a> est similaire à la section des <a href="#autos"> autos </a>.

<h4 align="center">Type de vehicules</h4>

Comme dans la section <a href="#type"> choix </a> de l'automobile, nous pouvons modifier les carateristique du bus. Cela permettra par la suite de modifier l'offre de transport en commun en augmentant par exemple le nombre de place par bus.






<h2 align="center" id="actifs">Prise en compte des modes actifs</h2>
<h3 align="center">Vélo</h3>

Pour implanter les modes actifs dans notres modèle, nous devons proceder en deux étapes.

<h4 align="center">Construction</h4>

Contrairement à l'exemple vue la construction de la <a href="#carte"> carte <a/>, nous devons prendre en compte les voies cyclable qui peuvent être un chemin pour les velos dans Sumo 
	<p align="center">
  <img src="https://user-images.githubusercontent.com/65184943/88848143-0c5e9680-d1b6-11ea-921b-91c1cfe70d66.png">
</p>


<h4 align="center">Changmeent du type de vehicule</h4>

 

Cette partie est très proche de la section des <a href="#autos"> autos </a>. Il suffit de changer d'ajouter le types de vehicules  ``` --- vtype ``` . Pour cela nous suivrons la commande:

```
od2trips -c od2trips.config.xml -n districts.taz.xml -d OD_Montreal_Velo.od -o od_ileVelo.odtrips.xml

```

https://www.artm.quebec/eod/2013/
https://github.com/HuguesBlache/ProjetPoly/blob/master/MatriceOD/Velo/etat_velo_2015.pdf
Puis la suite <a href="#duarouter"> duarouter </a>.

<p align="center">
  <img src="https://user-images.githubusercontent.com/65184943/88848400-6fe8c400-d1b6-11ea-8e7c-98ca7cbf0b7b.png">
</p>
	

<h3 align="center">Marche</h3>

Pour le mode actif marche, la construction du modèle requirer quelques modification du reseau. Car dans ce cas, SUMO ne considère pas les pietons comme des vehicules. Pour cela il faut donc contruires des voies pietonnes pour pouvoir ensuire implanter la matrice OD


<h4 align="center">Trotoire et passage pieton</h4>

Il existe dans SUMO plusieures manières pour integrer des trotoires dans le modèle. Soit il sont deja present dans le la carte OSM, est dans ce cas rien est a faire, sinon il suffit de les construire.

Pour cela il suffit de rajouter quelques lignes dans la construiction de la <a href="#carte"> carte </a> : ``` --sidewalks.guess``` permet de creer les trotoire ``` --crossings.guess``` creer les passage pietons ``` --walkingareas``` creer les zones de marches sans croisement 

```
netconvert --osm-files Montreal.osm --remove-edges.by-type railway.rail,highway.tertiary,highway.tertiary_link,highway.residential,highway.unclassified,highway.trunk,highway.trunk_link,highway.service,highway.footway,highway.path,highway.pedestrian,highway.steps,highway.track  --sidewalks.guess --crossings.guess  --lefthand -o Montreal.net.xml
```


<p align="center">
  <img src="https://user-images.githubusercontent.com/65184943/88960887-2e1d5380-d272-11ea-989e-64770015d3bf.png">
</p>
<h2 align="center" id="fusion">Fusion des modes</h2>
<p align="center">
  <img src="https://user-images.githubusercontent.com/65184943/88939297-5ac27280-d254-11ea-99d3-6c183e3b8a5f.png">
</p>

<p align="center">
  <img src="https://user-images.githubusercontent.com/65184943/89328322-3bb05000-d65b-11ea-9543-331e1e4b808c.png">
</p>




<h2 align="center" id="données">Collectes de données</h2>

<h3 align="center">Capteur</h3>

<h4 align="center">Floating Car Data</h4>

Cette fonction de sumo permet de tracer chaques véhicules en fonction de pas de temps choisie préalablement. Il en resort de la simulation la position du vehicules (geometry local) ainsi que sa vitesse comme decrit si dessous.

```xml
<fcd-export>

  <timestep time="<TIME_STEP>">
      <vehicle id="<VEHICLE_ID>" x="<VEHICLE_POS_X>" y="<VEHICLE_POS_Y>" angle="<VEHICLE_ANGLE>" type="<VEHICLE_TYPE>"
      speed="<VEHICLE_SPEED>"/>

      ... more vehicles ...

  </timestep>

 
  ... next timestep ...

</fcd-export>
```

Dans les lignes de commandes, il suffit de taper dans un premier temps

```
sumo -c Montreal.sumocfg --fcd-output FCD.xml
```

Dans un premier temps, on prend une simulation de 20 <a href="https://github.com/HuguesBlache/ProjetPoly/blob/master/Capteur/FCD.xml"> étapes </a>. (Trop gros sinon sur GitHub...) 

Après la simulation,les données brute du FCD peuvent être traitées avec <a href="https://sumo.dlr.de/docs/Tools/TraceExporter.html"> TraceExporter </a> ou bien avec différent <a href="#visualisation"> graphique </a> 


<h5 align="center">Autres fonction du FCD</h5>

<h6 align="center">Coordonnées de sortie en WGS84</h6>

Comme les coordonnées sont propres à la simulation, il est possible de sortire les positions des autos en <a href="https://github.com/HuguesBlache/ProjetPoly/blob/master/Capteur/FCDgeo.xml"> WGS84 </a>

```
sumo -c Montreal.sumocfg --fcd-output.geo --fcd-output  FCDgeo.xml
```

<h6 align="center">Distances</h6>

On peut aussi avoir l'information de la <a href="https://github.com/HuguesBlache/ProjetPoly/blob/master/Capteur/FCDdistances.xml"> distance </a> parcouru de chaque vehicule. Disponible aussi sur le capteur <a href="#tripinfo"> Trip.info </a>

```
sumo -c Montreal.sumocfg --fcd-output.distance --fcd-output  FCDdistance.xml
```

<h4 align="center">Capteur d'emission</h4>

Il est possible dans SUMO d'enclencher un capteur permettant de visualiser les emissions emit par chaque véhicules en fonction du pas de temps choisie. L'ensemble des resultats est semblable au capteur FCD, mais avec en plus les polutions admosphériques (Rejet CO2, CO, HC ...), les polutions sonores ...

``` xml
<emission-export>

 <timestep time="<TIME_STEP>">

  <vehicle id="<VEHICLE_ID>" eclass="<VEHICLE_EMISSION_CLASS>" CO2="<VEHICLE_CO2>" CO="<VEHICLE_CO>"
    HC="<VEHICLE_HC>" NOx="<VEHICLE_NOX>" PMx="<VEHICLE_PMX>" fuel="<VEHICLE_FUEL>" electricity="<VEHICLE_ELECTRICITY>" noise="<VEHICLE_NOISE>" \
    route="<VEHICLE_ROUTE>" type="<VEHICLE_TYPE>" waiting="<VEHICLE_WAITING>" lane="<VEHICLE_LANE>" \
    pos="<VEHICLE_POS>" speed="<VEHICLE_SPEED>" angle="<VEHICLE_ANGLE>" x="<VEHICLE_POS_X>" y="<VEHICLE_POS_Y>"/>

   ... more vehicles ...

  </timestep>

... the next timestep ...

</emission-export>
```
Il suffit de faire la commande suivante 
```
sumo -c Montreal.sumocfg --emission-output emission.xml
```
Et il en ressortira deux fichiers : <a href="https://github.com/HuguesBlache/ProjetPoly/blob/master/CarteMontreal/trip.info.xml"> trip.info </a> et <a href="https://github.com/HuguesBlache/ProjetPoly/blob/master/CarteMontreal/emission.xml"> emission </a>

<h4 align="center" id="tripinfo">TripInfo</h4>

Ce capteur permet d'avoir une visualisation plus <a href="https://github.com/HuguesBlache/ProjetPoly/blob/master/CarteMontreal/tripinfo.xml"> synthétique </a> d'un véhicule. Il permet de connaitre le point de depart et le point de destination, puis d'autres critères donnés ci dessous


```xml
<tripinfos>
    <tripinfo id="<VEHICLE_ID>" \
            depart="<DEPARTURE_TIME>" departLane="<DEPARTURE_LANE_ID>" \
            departPos="<DEPARTURE_POSITION>" departSpeed="<DEPARTURE_SPEED>" \
            departDelay="<DEPARTURE_DELAY>" \
            arrival="<ARRIVAL_TIME>" arrivalLane="<DEPARTURE_LANE_ID>" \
            arrivalPos="<ARRIVAL_POSITION>" arrivalSpeed="<ARRIVAL_SPEED>" \
            duration="<TRAVEL_TIME>" routeLength="<ROUTE_LENGTH>" \
            waitingTime="<SECONDS_WAITING_FOR_TRAFFIC>"
            waitingCount="<NUMBER_OF_WAITING_EPISODES>" \
            rerouteNo="<REROUTE_NUMBER>" \
            devices="<DEVICE_LIST>" vtype="<VEHICLE_TYPE_ID>"/>

    ... information about further vehicles ...

</tripinfos>
```

Que l'on peut convertir en fichier <a href="https://github.com/HuguesBlache/ProjetPoly/blob/master/Capteur/TripInfo/tripinfo.csv"> CSV </a> pour une meilleure visibilité

Ce qui peut donnée comme ci :


<table align="left" border="2">
  <colgroup span="3"></colgroup>
  <tr>
	<th>Unité </th>
    <th>Mean duration</th>
    <th>Mean timeLoss</th>
    
  </tr>
  <tr>
    <td>Seconde</td>
    <td>1242</td>
    <td>685</td>
  </tr>
  <tr>
    <td>Minutes</td>
    <td>20,7</td>
    <td>11,4</td>
    
  </tr>
</table>

<table align="center right" border="2">
  <colgroup span="2"></colgroup>
  <tr>
	<th>Unité </th>
<th>Mean routeLength</th>

    
  </tr>
  <tr>
    <td>Metre</td>
    <td>8177</td>
    
  </tr>
  <tr>
    <td>Kilomètre</td>
    <td>8,2</td>
   
    
  </tr>
</table>
    
  

<h4 align="center">Induction Loops detectors (E1) </h4>

C'est tous simplement l'implantation d'un capteur à induction qui permet de determiner le nombre de voiture passant sur un point donné sur une periode donné

Qui prend en entrée 
```xml
<additional>
   <inductionLoop id="<ID>" lane="<LANE_ID>" pos="<POSITION_ON_LANE>" freq="<AGGREGATION_TIME>"
   file="<OUTPUT_FILE>" friendlyPos="true"/>
</additional>
```

Et en sortie 

```xml
 <interval begin="''<BEGIN_TIME>''" end="''<END_TIME>''" id="''<DETECTOR_ID>''" \
      nVehContrib="''<MEASURED_VEHICLES>''" flow="''<FLOW>''" occupancy="''<OCCUPANCY>''" \
      speed="''<MEAN_SPEED>''" harmonicMeanSpeed="''<HARM_MEAN_SPEED>''" length="''<MEAN_LENGTH>''" nVehEntered="''<ENTERED_VEHICLES>''"/>
   ... further intervals ...
```

<p align="center">
  <img src="https://user-images.githubusercontent.com/65184943/92278935-3a757b80-eec4-11ea-9c1c-cdffbb71c82e.png">
</p>

Il est donc important de bien parametrer le capteurs pour avoir des sorties exploitable et claire. Car selon la frequence choisie par exemple, les resultats donnerons une autres interpretation comme les graphiques ci dessous

<img width="30" height="30" src="https://user-images.githubusercontent.com/65184943/87172123-bb880c00-c2a1-11ea-8b11-ff689734475f.jpg"> Les donnees presents ci dessous ne sont pas la representation de la realité du traffic au vu de l'avancement du projet. Il faut donc retenir la demarche plus que les resultats
<p align="center">
  <img width="400" height="300" src="https://user-images.githubusercontent.com/65184943/92493922-174c1400-f1c3-11ea-9e91-87b4c668d05b.png">
  <img width="400" height="300" src="https://user-images.githubusercontent.com/65184943/92493884-0ac7bb80-f1c3-11ea-9140-5056e47c3b69.png">
</p>


<p align="center">
  <img width="400" height="300" src="https://user-images.githubusercontent.com/65184943/92493905-10bd9c80-f1c3-11ea-8c13-67f9b825e977.png">
  <img width="400" height="300" src="https://user-images.githubusercontent.com/65184943/92493912-13b88d00-f1c3-11ea-9b9c-c50170a2f312.png">
</p>
On peut donc déjà remarquer le lissement de la courbe au fur et à mesure que la fréquence des capteurs augmentent. Ceci permet d'avoir une appréhension de l'heure d'occupation de la route est le plus élevée, ici nous sommes sur la ligne <i> 465401964_1 </i>


<h4 align="center">Lanearea Detectors (E2) </h4>

Contrairement au capteur precedent, ce capteur permet de tirer les donnees (comme une camera de surveillance) les donnees au long d'un voie et non ponctuellement sur une voie

Nous aurons donc en entrée

```xml
<additional>
   <laneAreaDetector id="<ID>" lanes="<LANE_ID1> <LANE_ID2> ... <LANE_IDN>" 
   pos="<START_POSITION_ON_FIRST_LANE>" endPos="<END_POSITION_ON_LAST_LANE>" 
   friendlyPos="<BOOL>" freq="<AGGREGATION_TIME>" file="<OUTPUT_FILE>" 
   timeThreshold="<FLOAT>" speedThreshold="<FLOAT>" jamThreshold="<FLOAT>"
   tl="<TRAFFIC_LIGHT_ID>"  to="<LANE_ID>"/>  
</additional>
```
Puis en sortie 
```xml
<interval begin="<BEGIN_TIME>" end="<END_TIME>" id="<DETECTOR_ID>" sampledSeconds="<DATA_SAMPLES>" \
    nVehEntered="<VAL>" nVehLeft="<VAL>" nVehSeen="<VAL>" meanSpeed="<MEAN_SPEED>"  meanTimeLoss="<MEAN_TIMELOSS>" \
    meanOccupancy="<MEAN_OCCUPANCY>" maxOccupancy="<MAX_OCCUPANCY>" meanMaxJamLengthInVehicles="<VAL>" meanMaxJamLengthInMeters="<VAL>" \
    maxJamLengthInVehicles="<VAL>" maxJamLengthInMeters="<VAL>" jamLengthInVehiclesSum="<VAL>" jamLengthInMetersSum="<VAL>" \
    meanHaltingDuration="<VAL>" maxHaltingDuration="<VAL>" haltingDurationSum="<VAL>" meanIntervalHaltingDuration="<VAL>" \
    maxIntervalHaltingDuration="<VAL>" intervalHaltingDurationSum="<VAL>" startedHalts="<VAL>" meanVehicleNumber="<VAL>" maxVehicleNumber="<VAL>"
/>
```
Ce qui donne visuellement
<p align="center">
  <img src="https://user-images.githubusercontent.com/65184943/92512626-0d370f00-f1dd-11ea-8664-61ff061ba6cc.png">
</p>

On peut par exemple visualiser la longueur de la congestion en fonction du temps avec une frequence de 300 s
<p align="center">
  <img width="400" height="300" src="https://user-images.githubusercontent.com/65184943/92514446-ec23ed80-f1df-11ea-9658-12235c4362f1.png">

</p>
<p align="center">
  <img src="https://user-images.githubusercontent.com/65184943/92514453-f0e8a180-f1df-11ea-9887-c92db41e0ca9.png">
  </p>
  
  <h4 align="center">Multi-Entry-Exit Detectors (E3)</h4>
  
 Le capteurs <a href="https://sumo.dlr.de/docs/Simulation/Output/Multi-Entry-Exit_Detectors_(E3).html">Multi-Entry-Exit </a>,comme son nom l'indique, permet de mettre des plusieurs capteurs en entrée et sortie, d'une voie, carrefour, quartier... comme le fichier additionnel indique: 
  
 ```xml
 <additional>
   <entryExitDetector id="<ID>" freq="<AGGREGATION_TIME>" file="<OUTPUT_XMLFILE>" 
   timeThreshold="<FLOAT>" speedThreshold="<FLOAT>">
      <detEntry lane="<LANE_ID1>" pos="<POSITION_ON_LANE>" friendlyPos="<BOOL>"/>
      <detEntry lane="<LANE_ID2>" pos="<POSITION_ON_LANE>" friendlyPos="<BOOL>"/>
      <detExit lane="<LANE_ID1>" pos="<POSITION_ON_LANE>" friendlyPos="<BOOL>"/>
      <detExit lane="<LANE_ID3>" pos="<POSITION_ON_LANE>" friendlyPos="<BOOL>"/>

      ... further entries ...

   </entryExitDetector>
</additional>
 ```

Ce qui donne visuelement par exemple, 

<p align="center">
  <img src="https://user-images.githubusercontent.com/65184943/92744801-cb7aa580-f34f-11ea-8fe2-28ee8c2e7579.png">
	 
  </p>

Ce qui donne en <a href="https://sumo.dlr.de/docs/Simulation/Output/Multi-Entry-Exit_Detectors_(E3).html#generated_output">sortie</a>: 
 ```xml
<interval begin="<BEGIN_TIME>" end="<END_TIME>" id="<ID>" meanTravelTime="<MEAN_TT>" 
meanOverlapTravelTime="<MEAN_OVERLAP_TT>" meanSpeed="<MEAN_SPEED>" 
meanHaltsPerVehicle="<MEAN_HALT_NUMBER>" vehicleSum="<#VEHICLES>" meanSpeedWithin="<MEAN_SPEED>" 
meanHaltsPerVehicleWithin="<MEAN_HALT_NUMBER>" meanDurationWithin="<MEAN_HALT_DURATION>" 
vehicleSumWithin="<#VEHICLES>" meanIntervalSpeedWithin="<MEAN_SPEED>" 
meanIntervalHaltsPerVehicleWithin="<MEAN_HALT_NUMBER>" meanIntervalDurationWithin="<MEAN_HALT_DURATION>"/>
 ```
<p align="center">
  <img width="400" height="300"src="https://user-images.githubusercontent.com/65184943/92518399-4d4ebf80-f1e6-11ea-8498-71922b5fce9d.png">
	<img width="400" height="300" src="https://user-images.githubusercontent.com/65184943/92747554-4f359180-f352-11ea-86f1-67a76d24a88c.png">
  </p>
  
  
<h4 align="center">Nuissances sonores</h4>

Note : Cette sortie des nuissances sonores que SUMO propose reposse sur le modèle du projet EC <a href="http://www.imagine-project.org/">Imagine </a> et de leurs rapport <a href="http://www.imagine-project.org/bestanden/D18_WP3_HAR32TR-040922-DGMR20.pdf">technique</a>

Tous commes les emissions polluante (CO2,PMx ...) il est possible de detecter et de relever les nuissances sonores engendrer par le traffic et par des voies particulières. On peut donc avoir de choix de point, soit nous regardons les nuissances selon un point fixe soit sur une voie entière. Nous allons etudier dans un premier temps la sonorité emis par un point, qui est decrit dans un fichier additionel comme ci :

 ```xml
 <additional>
<edgeData id="<DETECTOR_ID>" type="harmonoise" freq="<FREQUENCY>" file="<OUTPUT_FILE>" [excludeEmpty="true"]/>
 </additional>
 ```


  
<h4 align="center">Autres Capteurs</h4>

-Capteur de zone de voie 

<h2 align="center" id="visualisation">Visualisation</h2>

Avant de continuer dans cette section, assurez vous d'avoir installé <a href="https://matplotlib.org/users/installing.html"> matplotlib </a>

<h3 align="center" >Limite de vitesse</h3>

Pour une première visualisation, nous pouvons regarder les diffèrentes limites de vitesses sur l'ile de Montreal. Pour cela, nous utiliserons la fonction <a href="https://sumo.dlr.de/docs/Tools/Visualization.html#plot_net_speedspy"> <i> plot_net_speedspy.py </i> </a>

<p align="center">
  <img src="https://github.com/HuguesBlache/ProjetPoly/blob/master/Visualisation/LimiteVitesse.png">
</p>


<h3 align="center" id="visualisation">Densité</h3>

Grace au donnée de simulation, nous pouvons effectuer des visualisation de tous type, comme la densité.

Pour cela nous devons avant la simulation créer un fichier additionnel du type
 
 ```xml
 <additional>

	<edgeData id="1" file="edgesdensity.xml" />
	
</additional>
 ```
Puis à la fin de la simulation il en sort un fichier du type 

 ```xml

<meandata>
    <interval begin="<INTERVAL_BEGIN>" end="<INTERVAL_END>" id="<DETECTOR_ID>">
      <edge id="<EDGE_ID>">
          <lane id="<LANE_ID>" sampledSeconds="<COLLECTED_VEHICLE_SECONDS>" \
                traveltime="<MEAN_TRAVEL_TIME>" \
                density="<MEAN_DENSITY>" occupancy="<MEAN_OCCUPANCY>" \
                waitingTime="<TOTAL_WAITING_TIME>" speed="<MEAN_SPEED>" \
                departed="<EMITTED_VEH_NUMBER>" arrived="<ARRIVED_VEH_NUMBER>" \
                entered="<ENTERED_VEH_NUMBER>" left="<LEFT_VEH_NUMBER>" \
                laneChangedFrom="NUMBER_OF_LANE_LEAVERS" laneChangedTo="NUMBER_OF_LANE_ENTERER"/>

          ... more lanes...

      </edge>

      ... more edges ...

    </interval>

    ... further intervals ...

</meandata>

 ```
 
 Ensuite pour visualiser la densité on peut ecrire une commande :
 
 ```
python C:\Users\hugue\Sumo\tools\visualization\plot_net_dump.py  -v -n Montreal.net.xml --measures density,density --xlabel [m] --ylabel [m] --default-width 1 --colormap #0:#00c000,.25:#408040,.5:#808080,.75:#804040,1:#c00000 -i edgesdensity.xml,edgesdensity.xml --min-color-value 0 --max-color-value 50  -o test.png
```

<h4 align="center" >Densité</h4>


<p align="center">
  <img width="400" height="300" src="https://github.com/HuguesBlache/ProjetPoly/blob/master/Visualisation/5min.png">
  <img width="400" height="300" src="https://github.com/HuguesBlache/ProjetPoly/blob/master/Visualisation/5min%20Centreville.png">
</p>


<p align="center">
  <img width="400" height="300" src="https://github.com/HuguesBlache/ProjetPoly/blob/master/Visualisation/10min.png">
  <img width="400" height="300" src="https://github.com/HuguesBlache/ProjetPoly/blob/master/Visualisation/10min%20centreville.png">
</p>

<p align="center">
  <img width="400" height="300" src="https://github.com/HuguesBlache/ProjetPoly/blob/master/Visualisation/15min.png">
  <img width="400" height="300" src="https://github.com/HuguesBlache/ProjetPoly/blob/master/Visualisation/15min%20centreville.png">
</p>
 
 
<h3 align="center" >Emissions</h3>

Pour les emissions, il existe deux choix de visualisation:

 - Emissions par <a href="https://sumo.dlr.de/docs/Simulation/Output/Lane-_or_Edge-based_Emissions_Measures.html#edge-based_emission_output"> edge </a>
 - Emissions par <a href="https://sumo.dlr.de/docs/Simulation/Output/Lane-_or_Edge-based_Emissions_Measures.html#Lane-based_emission_output"> lane </a>
 
Dans cette partie, nous allons d'abord travailler sur les lignes. Pour cela nous devons avant la simulation créer un fichier additionnel du type
 
 ```xml
 <additional>

	<edgeData id="1" type="emissions" file="edgesemissions.xml" />
	
</additional>
 ```
Puis après la fin de la simulation il sort un fichier qui détermine en fonction du pas de temps les émissions basée sur les lignes. Il faut noter que les émissions dépendant naturellement du type de véhicules, du nombre etc..

Pour acceder à la visualtion par exemple de PMx, nous patirons un code du type:

 ```
python plot_net_dump.py  -v -n Montreal.net.xml --measures PMx_normed,PMx_normed --xlabel [m] --ylabel [m] --default-width 1 -i emissionstest.xml,emissionstest.xml --xlim 29000,33200 --ylim 9000,14000 --default-width .5 --default-color #606060 --min-color-value 0 --max-color-value 40 --max-width-value .1  --max-width 3 --min-width .5 --colormap #0:#00c000,.25:#408040,.5:#808080,.75:#804040,1:#c00000 --legend-position mg --title "Concentration de PMx en centre ville (mg)" -o PMx.png
 ```


<h4 align="center" >Emissions</h4>

<p align="center">
  <img width="400" height="300" src="https://github.com/HuguesBlache/ProjetPoly/blob/master/Visualisation/CO2.png">
  <img width="400" height="300" src="https://github.com/HuguesBlache/ProjetPoly/blob/master/Visualisation/CO.png">
</p>


<p align="center">
  <img width="400" height="300" src="https://github.com/HuguesBlache/ProjetPoly/blob/master/Visualisation/PMx.png">
  <img width="400" height="300" src="https://github.com/HuguesBlache/ProjetPoly/blob/master/Visualisation/NOx.png">
</p>

https://sumo.dlr.de/docs/Tools/Visualization.html

<h3 align="center" id="simulation">Simulation</h3>
</body>
</html>
