<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<link href="style.css">
</head>
<body>
<h1 align="center">Montréal Traffic Simulation </h1>
	
La construction du modèle de microsimulation fait partie du projet de Maitrise de Hugues Blache pour Polytechnique de Montréal 
 
<h2 align="center">Table des matières</h2>

1. <a href="#doc">Documentation SUMO</a><br>
2. <a href="#doc">Contexte</a><br>
3. <a href="#carte">Génération du reseau de l'ile de Montréal</a><br>
4. <a href="#OD">Création de la demande </a><br>
5. <a href="#autos">Génération de la demande</a><br>
6. <a href="#Simulation">Simulation</a><br>
7. <a href="#Collecte">Collecte de données</a><br>
8. <a href="#Calibration">Analyse des sorties/a><br>
9. <a href="#Discusion">Discusion et reste</a><br>
10. <a href="#Annexe">Annexe</a><br>



<h2 align="center" id="doc">Documentation SUMO</h2>

Ce projet se réfère principalement à la documentation de <a href="https://sumo.dlr.de/docs/SUMO_User_Documentation.html">Sumo</a> et du Professeur Nicolas Saunier pour le cours <a href="https://github.com/nsaunier/CIV8740/blob/master/guide-sumo.md">CIV8740</a>. Les autres sources seront citées à la fin du document.

<h2 align="center" id="doc">Introdution et contexte</h2>

Les nouveaux paradigmes concernant les axes de recherche des villes intelligents, ont pu montrer la necessité d'utilisé les technologies de telecommunication pour sont deployemment et pour optimiser des nombreux services. Comme la gestion des reseaux electrique, la gestion du drénages des eau, les services de santé et bien évidemment la gestion de la circulation et transport (par le prisme des ITS notamment).

  <i> Intelligent Transportation Systems (ITS) is a combination of leading-edge information and communication technologies used in transportation and traffic management systems to improve the safety, efficiency, and sustainability of transportation networks, to reduce traffic congestion and to enhance drivers’ experiences. </i> [<a href="https://www.wsp.com/en-CA/services/intelligent-transportation-systems-its">WSP</a>]
 

Néanmois, pour le bon fonctionnement de ces <i> smart cities </i> et pour la communications de ces services et applications pluridisplinaires, il est necessaire de mettre en place des communications M2M

Les communications Machine-to-Machine (M2M) <i>is a broad label that can be used to describe any technology that enables networked devices to exchange information and perform actions without the manual assistance of humans</i> [<a href="https://internetofthingsagenda.techtarget.com/definition/machine-to-machine-M2M">Sharon</a> Shea]

Par ce biais des communication M2M, les objets integrants des technologies de telecommunications et communicante avec son environnement,appeler <i> smart object</i> formemt un ensemble que l'on nomme Internet of Things (IoT).

Cependant, cette definition des IoT est assez simpliste. La litterature et les acteurs de ce domaines peut donnée des définitions assez varier dans le fond [<a href="https://www.sciencedirect.com/science/article/pii/S1570870516303316#sec0023">Atzori </a> et al.]. Pour notre part il est possible de ce comptanter de celle ci: <i>Group of infrastructures interconnecting connected objects and allowing their management, data mining and the access to the data they generate.</i> [<a href="https://ieeexplore.ieee.org/abstract/document/7373221">Dorsemaine<a> et al.]

AJOUTER DES TRUCS

Financer par Ericsson et le NSERC (National Science and Engineering Research Council of Canada). Le projet de l'équipe de télécommunication du Pr Brunilde <a href="https://www.polymtl.ca/expertises/en/sanso-brunilde">Sanso</a> vise à reproduire, par le prisme d'un modèle, de créer un profil du trafic M2M avec des interaction de multiple domaines et dans un lieu géographique réel.

Actuellement, 2021, l'infrastructure de télécommunication choisie est le réseau réel de LTE de l'ile de Montréal

L'avancement du projet est disponible sur le site <a href="https://www.trafficm2modelling.com/">web</a> de l'équipe

<h2 align="center" id="transport_part">Partie Transport</h2>

De nombreuse piste sont abordé par la mise en place de ITS dans le modèle. Un premier travaux à été de construire une taxonomie des applications communicantes. Cette classification à permis de mettre en évidences les requirement des différents applications de transport en termes de telecommunicant. Puis, ces travaux ont également pu éclairé sur les technologies possible et disponible pour la mise ne place de ces applications.

Suite à cette classification, la suite du projet est de proposé un modèle de circulation qui permettra d'interagire avec la simulation LTE afin de determiner les exigences "totals" des transports pour le traffic M2M.

Pour ce faire, le principale cheminement de la construction du modèle suit le figure XX [Hakim Mellah]:

<p align="center">
  <img  width="650" height="450" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/Sumo_M2M.png">	
</p>

La demarche est la suivantes:

  <ol>
    <li>Urban scénarios: Determination du scénario de circulation a étudier</li>
    <li>SUMO: Construction du modèle à l'aide du logiciel de microsimualtion de la circulation SUMO</li>
    <li>Urban KPIs: Identifier les sorties du modèle utile au modèle de télécommunication</li>
    <li><i> Boucle de rétroaction des telecom KPI afin de changer les entréer du modèle </i></li>
  </ol> 


Selon les sorties choisies, le modèle de circulation servira d'entrée au modèle de LTE, decrit dans la figure XX. 

<p align="center">
  <img  width="650" height="450" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/V2X_App.png">	
</p>

<h2 align="center" id="urban_scenario">Urban scenario</h2>

Ce scenario de circulation progresse en fonction du modèle du traffic M2M, donc l'étude ce portera sur la région métropolitaine de Montréal exclusivement. 

La grande majorité de la simulation ce déroulera sur un point de matin de 5h à 9h du matin pour un journée d'autonme, sauf indication contraire reletif pour l'étude de scénario scécifique.

Même si le modèle tend a être reproduire un circulation multimodale, la plus part des scéanarios ce passera avec des deplacements automobile, voir automobile et bus.

ECT...

<h2 align="center" >Construction du modèle</h2>

Par le prisme du modèle de circulation sur l'ile de Montréal. Les démarches de ce github tentent le plus possible de généraliser la construction d'un 'Large scale metropolitan microscopic simulation'. Notamment dans la prespective de déplacer ce modèle vers les villes de Toronto ou Vancouver par exemple.

<h3 align="center" >Calculateur utilisé</h3>

Dans la suite du projet, differentes notions de temps de calcule seront mentionner. Cependant le temps calcule des differents peuvent diverger selon les ordinateurs utilisées, mais certains informations pouront rester valide, par exemple entre deux scenarios, des temps de rapide plus rapides pour un scénario choises sans mentionner d'aspect unitaire.

ENCORE DU DETAILLE 

<h3 align="center" >Génération du Réseau</h3>

La section presente décrit la premiere étapes de la construction du modèle, à savoir la sélétion et la construction du réseau étudier.

<h4 align="center" id="carte">Topologie du réseau</h4>

Comme expliquer dans les sections précedentes, ;e cadre de cette étude est de prendre la circulation sur l'ile de Montréal. 

Il existe une mutlitude de manière d'importer et de créer un réseaux dans SUMO. Dans le cas de l'étude et afin de reprondre au exigences du reseau, les informations de  l'ile sont importés avec <a href="https://www.openstreetmap.org/">OpenStreetMap (OSM)</a>. 

Néamoins, pour répondre au exigence du simulation LTE et de répresenter au mieux les limites adminsitratives de l'ile de Montréal, il est décider de prendre la relation de OSM de l'<a href="https://fr.wikipedia.org/wiki/fr:Agglom%C3%A9ration%20de%20Montr%C3%A9al?uselang=fr"> Agglomeration </a> de Montréal, qui s'est fait assigner le code <i> <a href="https://www.openstreetmap.org/relation/8508277">Q2826806 </a></i>


 <i> A relations in OpenStreetMap is an ordered set of nodes, routes, and even relation, to be made up of logical or geographic relation. </i> [Wiki <a href="https://wiki.openstreetmap.org/wiki/Relation">.OSM</a>]

 

Ainsi, il est possible de visualisées et comparer les deux topographies, avec d'un coté la relation dans OSM sur la Fig XX et la delimitation topographique du simulateur sur la Fig XX
<p align="center">
  <img  width="800"  src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/capture_BBBike.png">
    <figcaption>Fig.X - Relation de l'ile de Montréal</figcaption>
</p>
<p align="center"> 
  <img  width="800"  src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/capture_M2M.png">
     <figcaption>Fig.X - Delimitateur du simulateur</figcaption>
</p>

<h4 align="center" id="Type de Route">Type de Route</h3>

  <i>
  Les TAG sont des données de bases, comme les noueds, routes et relation qui decrivent des des attribut geograhpiques de chaque entité comme des routes ou des buildings, par exemple avec les Key et Value</i> [Wiki <a href="https://wiki.openstreetmap.org/wiki/Map_features"/>OSM</a>]
 
Les routes dans OSM sont representer par des tags et leurs natures sont parfois mutliple. Il est possible d'extraire de nombreuse informations sur routes variers, comme des routes terrestre, routes maritime ect..

Cependant l'etude pourtant sur la mobilité terrestre et sur les capacités de SUMo, la simulation de compte qu'une certains type de route spécifiques. Dont la liste* ce trouve en <a href="Route_Type"> annexe </a> 

Comme la construction du modèle priorise les deplacements automobiles, par exemple les routes exclusivement pour les velos ont été filter dans un premier temps.

* Information pris dans le <a href="https://wiki.openstreetmap.org/wiki/Key:highway">wiki</a> OSM 

<h4 align="center" id="carte">OverPass API</h4>

<i>
An application programming interface (API) is an interface that defines interactions between multiple software applications or mixed hardware-software intermediaries. It defines the kinds of calls or requests that can be made, how to make them, the data formats that should be used, the conventions to follow, etc.. </i> [<a href="https://en.wikipedia.org/wiki/API">Wikipedia</a>]


L'API Overpass permet d'extraite des zones et des informations diversent de la base de données OSM à l'aide de requette spécifiques. Il est possible pour s'entrainer et/ou visualiser les commandes d'utilisé certaines interface comme <i><a href=https://overpass-turbo.eu/> overpass-turbo </a></i>


Pour extraire les données utile a la construitre le reseau dans SUMO, il a été préconiser de prendre seulement les routes definies dans la section precedentes.

```ql
area[wikidata="Q2826806"]->.montreal;
rel(area.montreal)[highway~"(motorway|primary|secondary|tertiary|motorway_link|primary_link|secondary_link|tertiary_link|trunk|trunk_link|unclassified|residential)"];
node(area.montreal)[highway~"(motorway|primary|secondary|tertiary|motorway_link|primary_link|secondary_link|tertiary_link|trunk|trunk_link|unclassified|residential)"];
way(area.montreal)[highway~"(motorway|primary|secondary|tertiary|motorway_link|primary_link|secondary_link|tertiary_link|trunk|trunk_link|unclassified|residential)"];
(._;>;);
out;
```
Cette commande est disponible dans le fichier batch URL

<h5 align="center" id="carte">WGET</h5>


<i>Wget, or GNU WGET is a computer program that retrieves content from web servers. It supports downloading via HTTP, HTTPS, and FTP. </i> [<a href="https://en.wikipedia.org/wiki/Wget">Wikipedia</a>]

Le telechargemment du contenue topologie du reseau se fait via une commande <a href="https://www.gnu.org/software/wget/">WGET </a> afin d'automatisé un maximun le construction du réseau sans intervantion humaine.

Puis avec un appelle dans netconvert sans commande spécifique, il est possible de relever certaines caractéristiques topologiques des données extraite disponible en <a ref="Description_du_reseau"> annexe </a>

<h4 align="center" id="carte">Filtrage des types de route</h4>

Comme il sera mentionné dans les section suivantes. Selon les données choisies, et notamment les types de routes selectionner, les données de sorties seront totalement differentes. Notamment lors des trajets des voitures. De plus les données OSM sont parfois lourd et impacte les temps de calcules de la simulation et selon le calculateur pris en compte. Ainsi un certains nombre de route du reseau peut être supprimé ou gardé lors de la commande NETCONVERT avec les instructions <i>keeg.egdes-by.types</i> ou <i>remove.egdes-by.types</i>.

Les figures suivant representes les differents filtrages possibles:


<div align="center">
  <img width="600" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/comparaison_net/CarteSumo.png">
<table>	
<tr><th>Entité</th><th>Unité</th> </tr>
<tr><td>Edge Lenght (km)</td><td>7935 </td> </tr>
<tr><td>Pourcentage</td><td>100</td> </tr>
<tr><td>Temps de chargement (s)</td><td>33,7</td> </tr>
<tr><td>Pourcentage</td><td>100</td> </tr>
<tr><td>Taille du Fichier (Ko)</td><td>187697</td> 
</tr>
</table>
<figcaption>Fig.X - Topologie sans filtrage</figcaption>	
</div>

<div align="center">
  <img width="600" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/comparaison_net/CarteSans_UN.png">
<table>	
<tr><th>Entité</th><th>Unité</th> </tr>
<tr><td>Edge Lenght (km)</td><td>7672</td></tr>
<tr><td>Pourcentage</td><td>96,7</td> </tr>
<tr><td>Temps de chargement (s)</td><td>33,1</td> </tr>
<tr><td>Taille du Fichier (Ko)</td><td>183078</td> </tr>
</table>
<figcaption>Fig.X - Topologie sans les underclassified</figcaption>	
</div> 

<div align="center">
  <img width="600" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/comparaison_net/CarteSans_Un_Res.png">
<table>	
<tr><th>Entité</th><th>Unité</th></tr>
<tr> <td>Edge Lenght (km)</td>   <td>2696</td> </tr>
<tr>    <td>Pourcentage</td>    <td>34</td> </tr>
<tr>    <td>Temps de chargement (s)</td>    <td>4.7</td> </tr>
<tr>    <td>Taille du Fichier (Ko)</td>    <td>45515</td> </tr>
</table>
<figcaption>Fig.X - Topologie sans les underclassified et residentielle</figcaption>	
</div> 

<div align="center">
  <img width="600" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/comparaison_net/CarteSans_Un_Res_Ter.png">
<table>	  
<tr>   <th>Entité</th>   <th>Unité</th>  </tr>
<tr>   <td>Edge Lenght (km)</td>    <td>1603</td> </tr>
<tr>   <td>Pourcentage</td>    <td>20</td> </tr>
<tr>   <td>Temps de chargement (s)</td>   <td>3.77</td> </tr>
<tr>   <td>Taille du Fichier (Ko)</td>    <td>27460</td> </tr>
  </table>
<figcaption>Fig.X - Topologie sans les underclassified,residentielle et Tersiary</figcaption>	
</div> 
 
<div align="center">
  <img width="600" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/comparaison_net/CarteSans_Un_Res_Ter_Sec.png">

<table>	<tr> <th>Entité</th>    <th>Unité</th>   </tr>
<tr>   <td>Edge Lenght (km)</td>   <td>675</td> </tr>
<tr>   <td>Pourcentage</td>   <td>8.5</td> </tr>
<tr>   <td>Temps de chargement (s)</td>   <td>2.16</td> </tr>
<tr>   <td>Taille du Fichier (Ko)</td>   <td>8469</td> </tr>
  </table>
<figcaption>Fig.X - Topologie sans les underclassified,residentielle,Tersiary et Secondary</figcaption>	
</div> 

<div align="center">
  <img width="600" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/comparaison_net/CarteSans_Un_Res_Ter_Sec_Pri.png">

<table>	
 <tr>   <th>Entité</th>   <th>Unité</th>  </tr>
<tr>   <td>Edge Lenght (km)</td>   <td>481</td> </tr>
<tr> <td>Pourcentage</td><td>6.1</td> </tr>
<tr>   <td>Temps de chargement (s)</td>   <td>0.74</td> </tr>
<tr>   <td>Taille du Fichier (Ko)</td>   <td>3903</td> </tr>
  </table>
<figcaption>Fig.X - Topologie sans les underclassified,residentielle,Tersiary, Secondary et Primary</figcaption>	
</div> 

<div align="center">
  <img width="600" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/comparaison_net/CarteSans_Un_Res_Ter_Sec_Pri_Trunk.png">

<table>	
<tr><th>Entité</th> <th>Unité</th>  </tr>
<tr> <td>Edge Lenght (km)</td>  <td>466.8</td> </tr>
<tr>   <td>Pourcentage</td>   <td>5.88</td> </tr>
<tr>  <td>Temps de chargement (s)</td>  <td>0.2414</td> </tr>
<tr>  <td>Taille du Fichier (Ko)</td>  <td>3728</td> </tr>
  </table>
<figcaption>Fig.X - Topologie sans les underclassified,residentielle,Tersiary, Secondary,Primary et Trunk</figcaption>	
</div> 

   
Il est donc possible de comparer le temps de charge de la carte avec la taille du reseau:
  
<p align="center">
  <img src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/temp_netconvert.png">
	<figcaption>Fig.X - Comparaison entre taille du reseau et temps de chargement avec netconvert</figcaption>	
</p>


Il est bien de relever qu'il y a une nette difference de chargement lors du filtrage des rues residentielles pour la commande netconvert. Ceci ce traduit par le pourcentage de rues residentielles que representes le reseau, environ 63% du reseau.

Le choix pour la simulation et de ça performance sera donc de selectionner le type de topologie et le temps que cela engendre pour les calcules. Mais aussi de prendre les reseaux qui permettra de representer au mieux la circulation.

Le choix pour la suite de l'étude a été de seulement prendre en compte la topologie englobant l'ensemble des routes et celle ayant enlever les routes residentielles et unclassifieds.

Ce choix est du simplifier le nombreux de scénario à rouler mais aussi pour essayer de se reprocher au mieux de la réalité de la circulation. En effet il est difficilement imaginable, pour notre part, de defendre l'idée que seulement 20% du reseau de l'ile de Montréal suffise à representer un réalité de la circulation. Et ceux même si il existe un sous regime comme il sera mentionner dans les sections suivantes.

<h3 align="center" id="feux">Intersection et feux de circulation</h3>

Cette section enumerer les differents paramettre choisies de bases pour la construction du reseau

<h4 align="center" id="feux">Temps de cycle</h4>

De maniere general, les importations des OSM ne fournisent pas d'information relatif au temps de cycle des feux de ciruclation. Ainsi un problème recurant dans SUMo est que le temps de cycle est difinie par default comme etant à 90s.

N'ayant pas acces au plan de feux de la ville de Montréal, les cycles seront defini par default à 90 secondes, comme la plus part des feux de la ville. [SOURCE]

Il est toute fois possible de changer les temps de cycle avec la commande dans netconvert <i>tls.cycle.time</i>. Et ceux notamement selon les scénarios choisies, par exemple l'etude de la ville de Québéc dont la temps de cycle moyenne vaut 120 secondes [SOURCE]

D'autre commande sont aussi disponible comme:
<ul>
  <li>tls.green.time : Permet d'assignier les valeurs de la durée de phase verte</li>
  <li>tls.yellow.time : Permet d'assignier les valeurs de la durée de phase jaune</li>
  <li>tls.red.time : Permet d'assignier les valeurs de la durée de phase red</li>
</ul>  

<h4 align="center" id="feux">Fusion de jonction</h4>

Un des problemes des encodages des feux de ciruclations, notamment lors des importation des cartes OSM est la problemes de coordinations des feux de circulations 'très' proches. Et ainsi, il est possible de constaté des phases verts et rouge simulatnément pour les feux circulation comme le represente la Fig XX pour l'intersection Avenue du Parc et Avenue des Pins .

<p align="center">
  <img width="400" height="300" src="https://user-images.githubusercontent.com/65184943/86969904-82825700-c13c-11ea-963b-cac24d041739.png">
    <img width="400" height="300" src="https://user-images.githubusercontent.com/65184943/86971270-ddb54900-c13e-11ea-9607-de2aabbc94c1.png">
 
</p>

Si un probleme preciste, ou que de nombreux feux sont simulaire, une des solutions est de "fusionner" les jonctions proche pour en créer une seule jonction, et donc un seul feux de circulation. Pour cela, il existe de nombreux paramètre sur <a href="https://sumo.dlr.de/docs/netconvert.html#junctions">netconvert</a> dont le --junctions.join, qui  permet de joindre deux feux de circulation proche. 

Après avoir lancer la construction du reseau on peut remarquer que le problème est transformer en partie. Car le feux est synchronisé en fonction des voies de circulation, comme le montre l'image si dessous. 

<p align="center">
  <img src="https://user-images.githubusercontent.com/65184943/93613822-59cdd780-f99f-11ea-84a9-460a3d6725dc.png">
</p>


<h5 align="center" >Impacte sur la simualation</h5>

Afin d'étudier l'impacte de ce changement de configuration, il a été choisie de faire un simulation en generant 5000 vehicules identique à l'aide de la fonction Randomtrips.py et en prenant la sortie TripInfo (plus de detaile dans la section collectes de <a href="#tripinfo"> données </a>) et en prenant la topologie sans rue residentielle et unclassified

<h6 align="center" >Temps de parcours</h6>

Il est d'abord possible de regarder la difference au niveau du temps de parcours (duration,WaitingTime,TimeLose) des deux types de cartes produit (feux de circulation fusionner, pas de chagement à l'importation). Ainsi nous trouvons: 

<table  align="center"><a align="center">
<tr><th>Carte</th><th>Temps de parcours moyen (en s)</th> <th>Ecart Type</th>
<th>Temps d'attentes moyen (en s)</th><th>Ecart Type</th><th>Temps perdu (en s)</th><th>Ecart Type</th></tr>
<tr><td>Sans changement</td><td>1305</td><td>998</td><td>697</td><td>751</td><td>308.8</td><td>869</td></tr>
<tr><td>Fusion des jonction</td><td>852</td><td>544</td><td>285</td><td>277</td><td>236</td><td>373</td></tr>
<tr><td>Reduction (en %)</td><td>35%</td><td>...</td><td>59%</td><td>...</td><td>51%</td><td>...</td> </tr>
	</a></table>


En rectifiant cette erreur de synchronisation des feux de circulation, on peut constater que les facteurs temps peuvent être reduit de parfois de moitier. Il est surment imaginable pour la simulation réel de la circulation un changement plus important entre les deux types de topologies. Et sur ce, ce type de choix peut affecteur d'autre modele et decision possible avec ce type de modèle, comme le lien entre temps perdu et impacte sur l'economie ou la polution.

<h6 align="center" >Distribution des vitesses</h6>


Il est possible d'étudier la repartition des vitisse comme sur le boxplot de la Fig XX qui suit.



<p align="center">
  <img width="500" height="400" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/dist_vitess_junct.png">
</p>

Il est possible de voire une difference minime mais visible entre les deux simulation. Où la simualation avec des fusions d'interction traduit une plus grandre 'vitesse' moyenne de véhciules. Toutefois, il est possible des constatés que l'emplitutde des vitesses sans la fusion des jonctions est plus repartient.


<h6 align="center" >Teleportation</h6>

Mise à part le temps de parcours, il faut aussi regarder du cote des vehicules teleporter pour viusaliser un changement. Comme representer sur la figure XX, on peut constater une nette distinguation entre d'un cote beaucoup de teleportation pour les scenarios sans fusion de jonction et de leurs avec peu de teleportation avec une fusion.

<p align="center">
  <img width="560" height="400" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/teleportation.png">
</p>


Au vu de la sensibilité de ses deux scénarios et d'un grand nombre de voiture teleporter dans les scérions sans fuite, pour la suite du projet il a été décider de seulement prendre en compte les topologies avec les fusions des feux de circulation.

<h4 align="center" id="feux">Autres paramètres</h4>

D'autres problematiques subsites lors de l'importation des cartes, notamment le demi-tour autorisé dans les feux de cirucaltion et dans les intersections, qu'il est possible d'enlever avec la commandes <i>no-turnarounds</i>

<h3 align="center" id="TC">Implantation des arrets de bus</h3>

La section suivante enumère les differentes demarches prise en compte pour la créations et l'implanter des Transport en commun sur le reseau construit dans les sections precedentes.

<h4 align="center" id="TC">Topologie des bus</h4>

Après avoir construit notre reseau, il est possible de gréfer à notre modèle des arrets de bus et des informations des trajets. Pour cela, il existe des <a href="https://sumo.dlr.de/docs/Tutorials/PT_from_OpenStreetMap.html"> fonctions </a> qui peuvent directement implanter dans SUMO pour recuper les information des trajets de bus selon les relations dans OpenStreetMap.

Comme pour les cartes, le choix d'importer les données de Bus ce fait par le biais de OverPass à l'aide de la commande:

```ql
area[name="Agglomération de Montréal"]->.montreal;
rel(area.montreal)["network"="STM"];
(._;>;);
out geom;
```
Certains type de routes qui n'ont pas été pris lors de topologies de la carte sont pris en compte, à savoir les routes de services et living_street. Cela permettra à certains bus de pouvoir faire des demis-tours lors des fins trajets. Avec la visualisation dans la figure suivante:

<p align="center">
<img width="500" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/bus_osm.png"> 
</p>

Pour notre simulation nous prendrons les <a href="https://wiki.openstreetmap.org/wiki/Relation"> relations </a>  des lignes de la <a href="https://wiki.openstreetmap.org/wiki/Bus_routes_in_Montr%C3%A9al"> STM </a> (Société de transport de Montréal)



<img width="30" height="30" src="https://user-images.githubusercontent.com/65184943/87172123-bb880c00-c2a1-11ea-8b11-ff689734475f.jpg"> Les <i> ptstop </i> et les <i> ptline </i> peuvent parfois ne pas prendre en compte certaines lignes et arrêts si les <a href="https://wiki.openstreetmap.org/wiki/Relation"> relations </a>  dans OSM ne sont pas bien construites. Comme le renseigne le tableau suivant:

<table  align="center"><a align="center">
<tr><th>Colour</th><th> 	Meaning </th>	<th>To do</th></tr>
<tr><td><img src="https://wiki.openstreetmap.org/w/images/3/3b/State_Routing.svg"><img src="https://wiki.openstreetmap.org/w/images/0/00/State_Stop.svg"></td><td>	The map data is unknown </td><td>	Please verify and/or complete</td></tr>
<tr><td><img src="https://wiki.openstreetmap.org/w/images/f/f4/State_Routing0.svg"><img src="https://wiki.openstreetmap.org/w/images/archive/a/af/20150922051209%21State_Stop0.svg"></td><td> The map contains no or little data </td><td>	Please complete</td></tr>
<tr><td><img src="https://wiki.openstreetmap.org/w/images/1/10/State_Routing1.svg"><img src="https://wiki.openstreetmap.org/w/images/archive/b/b9/20150922051220%21State_Stop1.svg"></td><td>The map contains partial data </td><td>	Please complete</td></tr>
<tr><td><img src="https://wiki.openstreetmap.org/w/images/3/32/State_Routing2.svg"><img src="https://wiki.openstreetmap.org/w/images/archive/0/01/20150922051231%21State_Stop2.svg"> </td><td>The map is largely complete (please describe missing data) </td><td>	Please complete</td></tr>
<tr><td><img src="https://wiki.openstreetmap.org/w/images/a/a1/State_Routing3.svg"><img src="https://wiki.openstreetmap.org/w/images/archive/f/fd/20150922051241%21State_Stop3.svg"></td><td>The map is complete (in the opinion of a mapper) </td><td>	Please check and correct any errors</td></tr>
<tr><td><img src="https://wiki.openstreetmap.org/w/images/e/ea/State_Routing4.svg"><img src="https://wiki.openstreetmap.org/w/images/archive/4/42/20150922051251%21State_Stop4.svg"> </td><td>The map is complete (verified by 2 mappers). Indicate Date when checked </td><td>	Please update as needed</td></tr>
<tr><td><img src="https://wiki.openstreetmap.org/w/images/9/9e/State_RoutingX.svg"><img src="https://wiki.openstreetmap.org/w/images/a/a9/State_StopX.svg"> </td><td>The map data is present, but the route no longer exist. </td><td>	Please remove the route data </td></tr>
</a></table>

Pour le cas de la STM, les differents lignes locals sont definies comme:

<table  align="center"><a align="center">
<tr><th>Type</th><th> Nombre </th>	<th>Pourcentage</th></tr>
<tr><td><img src="https://wiki.openstreetmap.org/w/images/a/a1/State_Routing3.svg"><img src="https://wiki.openstreetmap.org/w/images/archive/f/fd/20150922051241%21State_Stop3.svg"></td><td> 28 </td>	<th>18,5%</td></tr>
<tr><td><img src="https://wiki.openstreetmap.org/w/images/3/32/State_Routing2.svg"><img src="https://wiki.openstreetmap.org/w/images/archive/f/fd/20150922051241%21State_Stop3.svg"></td><td> 2 </td>	<th>1,3%</td></tr>
<tr><td><img src="https://wiki.openstreetmap.org/w/images/1/10/State_Routing1.svg"><img src="https://wiki.openstreetmap.org/w/images/archive/f/fd/20150922051241%21State_Stop3.svg"></td><td> 120 </td>	<th>78,9%</td></tr>
<tr><td><img src="https://wiki.openstreetmap.org/w/images/f/f4/State_Routing0.svg"><img src="https://wiki.openstreetmap.org/w/images/archive/f/fd/20150922051241%21State_Stop3.svg"></td><td>1 </td>	<th>0,66%</td></tr>
<tr><td><img src="https://wiki.openstreetmap.org/w/images/3/3b/State_Routing.svg"><img src="https://wiki.openstreetmap.org/w/images/archive/f/fd/20150922051241%21State_Stop3.svg"></td><td> 1 </td>	<th>0,66%</td></tr>
</a></table>	

Il est relever qu'un bonne partie des données de la STM ne sont pas bienm pris en compte lors de l'importation dans la simulation. En effet, plus de 79% des bus et lignes ne contient que partiellement ou pas de données des lignes se qui peut avoir des consequences lors des implentations dans la simulation
Il est possible de representer le probleme de la mianière suivante.

<h5 align="center" id="mauvaise">Mauvaise relation</h5>

Une mauvaise relation ne sera pas prise en compte par SUMO, pour les raisons suivatnes

- Les arrêts de bus qui ne sont bien placés ou "hors" de la route
- Les chemins (ways) ne sont pas pris en compte dans la relation
<p align="center">
  <img src="https://user-images.githubusercontent.com/65184943/87174223-dc9e2c00-c2a4-11ea-8346-2265984c09c7.png">
    
</p>

<h5 align="center">Bonne relation</h5>

La bonne relation sera contrairement à la <a href="#mauvaise"> mauvaise </a> bien prise en compte par SUMO. Cela se traduit par des bons emplacements des arrets de bus et des chemins reliant ces arrets de bus.

<p align="center">
<img src="https://user-images.githubusercontent.com/65184943/87174266-eaec4800-c2a4-11ea-8869-0ef4552443ed.png">
 </p>


Quelques solutions sont possibles pour les implanter ce manques d'information, notamment implanter les données GTFS directement dans la simulation à l'aide de la fonction GTFS2PT.py

<h5 align="center" id="TC">GTFS2PT</h5>

<i>The General Transit Feed Specification (GTFS) is a data specification that allows public transit agencies to publish their transit data in a format that can be consumed by a wide variety of software applications.</i>[<a href="https://gtfs.org/">GTFS</a>]


Cette fonction permet d'importer des données GTFS dans la simulation apartir de la topologies chosies pour construire des trajets de bus. Cependant, le dossier GTFS pour etre appelle doit être en format .ZIP et doit au minimun contenir les fichiers routes.txt, stops.txt, stop_times.txt, trips.txt, calendar.txt et calendar_dates.txt.

Pour se faire 3 commandes au minimues doit être pris en compte:

<ul  align="center">
  <li  align="center" >network: Ce fichier .net correspond au reseau utiliser pour la simulation</li>
  <li  align="center">gtfs: Correspond au fichier .ZIP des informations des lignes de BUS</li>
  <li  align="center">date: En format YYYYMMDD correspond à la journée que l'on veux prendre en compte dans notre simulation (correspond à un jour dans le calendar.txt)</li>

</ul> 

Ainsi la commande type sera :
```
python tools/import/gtfs/gtfs2pt.py --network <net-file> --gtfs <gtfs-data-file> --date <YYYYMMDD>
 ```
 
La Fig XX represente, de maniere visualer, le cheminement de cette fonction et en representant les sorties des cette fonctions

<p align="center">
<img src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/smart_art/GTFS2PT.png">
 </p>

 Les principales sorties de cette fonctions sont les suivantes:

 <ul  align="center">
  <li  align="center" >StopInfo: Fichier correspondant au differents emplacements des arrets de bus</li>
  <li  align="center">Bus Routes: Fichier .rou qui representer les differents chemin de chaque lignes de bus.</li>
  <li  align="center">Invalid_Osm_Route: Representer l'ensemble des trajets non pris en compte dans la simulation</li>
</ul> 



<h4 align="center" id="mauvaise">Comparaison du nombre d'arret de bus</h4>

Comme le choix de la simulation dependant aussi des choix topologique des reseaux, il est possible de dresser le bilan suivant:

<table  align="center">
<tr><th>Type</th><th>Nombre d'arret</th><th>Pourcentage</th> <th>Nombre d'arret</th><th>Pourcentage</th></tr>
<tr><td>Reseau Réel</td><th>Nombre d'arret</td><td>Pourcentage</td> <th>Nombre d'arret</td><td>Pourcentage</th></tr>
<tr><td>Topologie ensemble des routes</td><th>Nombre d'arret</td><td>Pourcentage</td> <th>Nombre d'arret</td><td>Pourcentage</th></tr>   
<tr><td>Topologie sans rue residentielle et unclassified</td><th>Nombre d'arret</td><td>Pourcentage</td> <th>Nombre d'arret</td><td>Pourcentage</th></tr>      
</table>

Il est possible de voir que : SUITE EN FONCTION DES DONNÉES 

<h3 align="center" id="OD"> Création de la demande</h3>

La section suivante traite de la création de la demande dans le mondele construit.

<h4 align="center" id="quartier" >Enquête Origine Destination</h4>

Tout les 5 ans depuis 1970, l'Autorité régional de transport métropolitain (ARTM) réalisé une enquête, intilé Enquête <a href="https://www.artm.quebec/eod-en-savoir-plus/">Origine-Destination<a>, qui permet d'obtenir de nombreuse information relative au deplacement de personnes. Que se soit des deplacements en modes actifs, en TC, en auto voire mutlimodale dans la grande region métropolitaine de Montréal.

<i> Nous designons ici les deplacement multimodale, comme les deplacements partant d'une Origine i à une Destination j en utilisant au minimun 2 modes de transport </i>

Les données proviennent à la fois de données d'enquête telephonique, d'enquete Web mais aussi des point de comptages, dit <a href="https://www.artm.quebec/enquete-cordon/">enquête-cordons<a>.

Facteur de Ponderation ?

En terme de granularité spaciale, l'enquete OD à de nombreux echellons, partant du agglomeration specifique, par exemple tout Laval, à l'adresse individuelles de chaque personnes enquêter. Dans le cas de cette simulation, le choix de conserver plus où mois certains type de routes, à reprocher conclue pour prendre les decoupages des secteurs municipaux comme plus petite echelles spaciales de notres études. Ces resulats sont de la formes:

<div class="cmath">
 `O_i-D_j=Nb_Deplacement_i_j`   
 </div>

Avec `O_i` l'Origine i du deplacement du trajets et `D_i` la destination j du déplacement.

En terme de granularité temporaire, les plages horraires se reppartise dans un bloques de 24h jusqu'a la plage horraire de la demi-heure (A verifier). Dans le cas de notre simulation, il est convenu de prendre la plage de la pointe du matin, entre 5h et 9h, comme expliquer dans les sections precedentes. Le découpage horraires sera expliquer à la suite.

Puis la création de la demande, deux matrice été accesible pour la construction du modeles

<ul>
  <li>L'enquete Origine-Destination de 2013</li>
  <li>L'enquete Origine-Destination de 2018</li> 
</ul>  

Pour les deplacements des automobiles seulement, dans un premier temps il est resortie que le modele prendrer en compte les deplacements automobile conducteur (c'est à dire sans passager) en comptant les trajets retours.

<h4 align="center" id="quartier" >Lieu d'origine et de destination</h4>

Le lieu des origines et destination de Montréal sont définies pour cette simulation comme les <a href="https://www.donneesquebec.ca/recherche/dataset/artm-secteurs-municipaux-od13">secteur</a> administratifs de l'ARTM qui ont été pris en compte dont on peut representer sur la FigXX

<p align="center">
  <img width="600" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/Taz_ARTM.png">
</p>

<h5 align="center">Importation des TAZ</h5>

Pour importer une matrice Origine-Destination dans SUMO, il faut d'abord renseigner au logiciel les districts ou les traffic assignment zone (<a href="https://sumo.dlr.de/docs/Demand/Importing_O/D_Matrices.html">TAZ</a>) qui serviront d'arriver ou de depart des véhicles.

Ces fichiers contenant permettront de déterminer toutes les sections de routes qui appartiennent à une zone. Dans notre étude de cas nous allons déterminer les routes qui appartiennent à chaque secteur pour ensuite créer les déplacements.

```xml
<tazs>
    <taz id="<TAZ_ID>" edges="<EDGE_ID> <EDGE_ID> ..."/>

    ... further traffic assignment zones (districts) ...

</tazs>
```

Par exemple la carte ci-dessous représente le quartier du Plateau Mont-Royal de Montréal (indicateur 106 de la matrice OD). 

<p align="center">
  <img width="460" height="300" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/plateauTAZ.png">
</p>


 Afin de convertir ces secteur muninipaux dans SUMO, nous allons prendre les fichier shp diponible et les rentrer dans SUMO à l'aide de PolyConvert
 
 <h5 align="center">PolyConvert</h5>
 
 La fonction Polyconvert permet d'importer des shapes geometrique selon differente source, ce qui nous interraisse dans notre cas, c'est d'importer des sources SHP

 
* n: Represente la topograhpie du reseau etudier
* shapefile-prefixe: Reads shapes from shapefiles FILE+
* shapefile.guess-projection: Guesses the shapefile's projection
* shapefile.traditional-axis-mapping : Use traditional axis order (lon, lat)

La commande sera la suivante:

```
polyconvert -n CarteMontreal_Sans_Un_Res.net.xml --shapefile-prefixes SM_OD2018 --layer 111 --shapefile.guess-projection true --shapefile.traditional-axis-mapping true --fill false
```
 
 La carte ci-dessous représente le quartier du Plateau Mont-Royal de Montréal convertie en polygone.
 
 <p align="center">
  <img width="460" height="300" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/Plateau.png">
</p>


<h5 align="center">edgesInDistricts.py</h5>

Après avoir decrit les differents polygones qui traduit la limite de chaque Secteur Municipaux, il reste à reconnaitre les differentes routes existantes dans chaques TAZ. Pour ce faire nous pouvons utiliser la fonction edgesInDistricts.py qui prend comme parametre:

* n: Represente la topograhpie du reseau etudier
* t: represente les limites admministif definies plus haut.

```
python <SUMO_HOME>/tools/edgesInDistricts.py -n Montreal.net.xml -t Quartier.add.xml
```
Neanmois, en fonction de la taille du reseau choisie, il peu avoir une differences de temps de chargement:
  
  A VERIFIER
<table  align="center">
<tr><th>Type</th><th>Pourcentage</th><th>Temps de simulation en (ms)</th><th>Taille du Fichier (ko)</th></tr>
<tr><td>Entier</td><td>100</td><td>417968</td><td>1082</td></tr>
<tr><td>Sans_Un</td><td>96.7</td><td>414060</td><td>1059</td></td>
<tr><td>Sans_Un_Res</td><td>34</td><td>144982</td><td>361</td></tr>
<tr><td>Sans_Un_Res_Te</td> <td>20.2</td><td>79036</td><td>199</td></tr>  
</table>
  
<p align="center">
  <img width="600" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/chargement_TAZ.png">
</p>

Il est relever encore une fois que le temps de chargement different encore entre les differentes types de reseau. CONTINUER A MODIFIER

<h3 align="center">Changement de format de la Matrice OD</h3>

Une premiere étape de l’implantation de la matrice OD à été de modifier la Matrice OD fournis par l’ARTM. Notre modèle, nous oblige à avoir une matrice n*n qui est illisible de manière brute par SUMO. En effet, SUMO ne peut lire que 3 types de Matrice et nous avons choisie de travailler avec un matrice de type "O-Format". Ce type de format est une matrice à n ligne et 3 colones, avec la premier colonne correspont à l’origine, la deuxieme la destination et la derniere le nombre de véhicules generer. Pour ce faire nous avons créer un petit script sur jupyter qui permet de transformer la matrice de cette sorte 


**Format de la matrice OD "classique"**


<table  align="center">
<tr><th>Origine-Destination</th><th>Dest 1</th> <th>Dest 2</th> <th>Dest 3</th></tr>
<tr><td>**Orig1**</td><td>1</td><td>2</td><td>3</td> </tr>
<tr><td>**Orig2**</td><td>4</td><td>5</td><td>6</td> </tr>
<tr><td>**Orig3**</td><td>7</td><td>8</td><td>9</td></tr></table>

**Format de la matrice OD (O-format) sur SUMO**

<table  align="center">
<tr><th>Origine </th><th>Destination</th> <th>Nombre d'auto</th>
 </tr> <tr>  <td>Orig1</td>  <td>Dest1</td>  <td>1</td></tr>  
 <tr><td>Orig1</td><td>Dest2</td>  <td>2</td></tr>
 <tr><td>...</td>  <td>...</td>  <td>...</td></tr>
  <tr>  <td>Orig3</td>  <td>Dest3</td>  <td>9</td></tr>	
</table>

Un exemple de <a href="https://github.com/HuguesBlache/ProjetPoly/blob/master/Transformation%20matrice%20OD%20en%20O-format-checkpoint.ipynb">code</a> sur JupyterNotebook pour la modification de la matrice est disponible dans le repertoire

<h4 align="center">Prise en compte des voitures trajets "exterieur"</h4>

Nous pouvons ne prendre en compte que les déplacements en auto qui se produit à l'intérieur de l'ile de Montreal. Mais si c'est le cas, nous ne comptons pas les déplacements produit de l'ile de Montreal vers l'extérieur (Rive Nord/Sud) qui représente un peu plus de 5% des déplacements. Mais surtout les déplacements venant de l'extérieur qui repésentent un peu plus de 30% des deplacéments venant vers Montreal. Ne pas prendre en compte ces déplacements peuvent engendrer un sous-"régime" des deplacements, et dans ce cas ne pas pouvoir refléter une certaine réalité des déplacements. Pour mieux illustre ces déplacements nous pouvons nous référer au <a href="http://ville.montreal.qc.ca/pls/portal/docs/PAGE/MTL_STATS_FR/MEDIA/DOCUMENTS/PORTAIT%20DES%20D%C9PLACEMENTS%202008%20-%20VILLE%20DE%20MONTR%C9AL.PDF">portrait</a>  des déplacements de 2008 de l'ile de Montréal.

<p align="center">
  <img width="400" height="500" src="https://user-images.githubusercontent.com/65184943/93515262-54688280-f8f6-11ea-90d3-29930c1acd88.png">
  <img width="400" height="500" src="https://user-images.githubusercontent.com/65184943/93515271-55011900-f8f6-11ea-96a8-45c5dc962935.png">
</p>

<h4 align="center">Centroïdes</h4>

Dans la simulation present, seul l'ile de Montreal est pris en compte et non les autres secteur municipaux de la region de Montréal que l'ARTM à définie. Dans le cadre preliminaire de la construction  du modele, l'idée pour palier à ce probleme à été de redeninir les SM venant de l'exterieur. En effet comme le montre la figure XX, l'idée à été de relier les differents centroides des differents SM pour visualisées les lieux ou les lignes entre deux centroides decoupe les SM de l'ile de Montréal. Par ce fait, les premier premier SM touché de l'ile devenait des SM d'origine et les derniers des SM d'arrivées

<p align="center">
  <img width="1000" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/centroide/explication_tranformation.png">
</p>


La figure XX representes les differentes centroïdes de la regions de Montréal définies par l'ARTM:
<p align="center">
  <img width="600" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/centroide/centroide_seul.png">
</p>

Pour la facilité de la construction des nouvelles assignations des Origines et Destinations, il a été choisies de séparer les trajets venant de l'eterieur et venant sur l'ile de Montréal et les trajets ce deplacent de l'exterieur et allant à l'exterieur en passant par l'ile.

<h4 align="center">Trajet Exterieur vers l'interieur</h4>

A fin de mieux visualiser les differents 'trajet' à vol d'oiseau des differents trajets, il est possible de separer en fonction des differents agglomeration
<p align="center">
   <img width="400" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/centroide/longueuil-Montreal.png">
  <img width="400" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/centroide/laval_Montreal.png">
  <img width="400" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/centroide/couronne_sud_montreal.png">
  <img width="400" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/centroide/couronne_nord_montreal.png">
</p>

Ce qui donne en compilant les differentes trajet des aglomeration la Fig XX

<p align="center">
  <img width="600" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/centroide/exterieur_interieur.png">
</p>

Après avoir transformer les differents Origines et destinations comme expliquer plus haute, les nouvelles Origines et Destiniation seront:

<p align="center">
  <img width="600" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/centroide/new_exterieur_interieur.png">
</p>

<h4 align="center">Trajet Exterieur vers l'interieur</h4>

Par la même demarche que la section precedent, ont peut separer les trajet exterieur vers exterieur de la sorte:


<p align="center">
  <img width="400" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/centroide/longueuil-laval.png">
  <img width="400" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/centroide/longueuil-couronne_nord.png">
  <img width="400" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/centroide/laval_couronne_sud.png">
  <img width="400" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/centroide/couronne_nord_sud.png">
</p>

Ce qui donne en compilant les differentes trajet:

<p align="center">
  <img width="600" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/centroide/ext_ext.png">
</p>

Ainsi, les nouvelles Origines et destinations seront:

<p align="center">
  <img width="600" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/centroide/new_exterieur_exterieur.png">
</p>


<h3 align="center">Definition des véhicules</h3>

Pour essayer de representer un simulation de la circulation heterogene, et notamment en ingerant un mutlitude de differents véhicles disponibles dans notre reseau. De plus, la longueur et les types de véhicules ont un impacte directe sur la circulation. Cette section traite donc de la construction de ces differents véhicules.

<h4 align="center" id="type">Catégories automobile</h4>

Les deux matrice de l'enquete OD de Montréal stipule que les trajets automobile correpond à un melanges automobile et Motocyle sans renseignement spécifique de la part des deux "types" de véhicules. Pour spécifier se pourcentage et ainsi distinguer les differentes categories de véhicules, nous nous sommes dériger vers  la <a href="https://saaq.gouv.qc.ca/donnees-ouvertes/vehicules-circulation/vehicules-circulation-documentation.pdf"> SAAQ </a> et des <a href="https://bdso.gouv.qc.ca/pls/ken/ken213_afich_tabl.page_tabl?p_iden_tran=REPERBA6Z3O56149094340058BfZ9c&p_lang=1&p_m_o=SAAQ&p_id_ss_domn=718&p_id_raprt=3628#tri_tertr=00&tri_mun=aaaaa"> stastitique </a> du Quebec pour definir le part de ces vehicules promenade dans le parc automobile de l'ile de Montreal. Pour la quel, il à été possible de distingué 4 grande catégories de véhicules.

<table  align="center">
	<a align="center">
  <tr><th>Type de vehicules</th>  <th>Nombre</th>   <th>Pourcentage</th></tr>
  <tr> <td>Automobile</td>  <td>563880</td>  <td>65%</td></tr>
  <tr> <td>SUV/Camion léger</td> <td>269475</td> <td>32%</td></tr>
  <tr> <td>MOtocyclette</td><td>15203</td><td>2%</td></tr>
	<tr> <td>Cyclomoteyr</td> <td>5607</td> <td>1%</td>
  </tr></a>
</table>

Afin des distinguers au mieux les differentes catégories de véhicules choisies dans la parc automobile de notre réseau, les différentes caétgories seront representer par un véhcules types pour les modèles les plus<a href="https://www.goodcarbadcar.net/canada-30-best-selling-vehicles-in-2013/"> vendu </a> en 2013 avec leur <a href="https://github.com/HuguesBlache/ProjetPoly/blob/master/MatriceOD/Copie%20de%20Tableau.xlsx
"> carateristique</a>  et les valeurs Vclass de SUMO qui sont les suivants:

<table  align="center">
<a align="center">
<tr><th>Modele</th><th>Longueur (m)</th> <th>Hauteur (m)</th><th>vClass </th><th>maxSpeed (m/s) </th></tr>
<tr><td>Toyota Corolla 2013</td><td>4,5</td><td>1,76</td>  <td>private</td><td>55.56</td></tr>
<tr><td>Ford F 150</td><td>5,9</td>  <td>1,9</td>  <td>delivery</td>  <td>55.56</td></tr>
<tr>  <td>Yamaha FZ</td>   <td>2,07</td>  <td>0.8</td>  <td>motorcycle</td> <td>55.56</td></tr>
<tr> <td>Honda Forza 125</td>  <td>2.140</td>  <td>0.78</td>  <td>moped</td>  <td>16.67</td></tr>
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

Il est possible de prendre en considérations les emissions, mais dans notre cas, voir la partie discussion

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
  <tr><th>Modele</th><th>Longueur (m)</th>   <th>Hauteur (m)</th>  <th>vClass </th>  <th>maxSpeed (m/s) </th>  <th>Consomation</th>   <th>Nomre Euro</th>  <th>SUMO</th></tr>
  <tr>  <td>Nova Bus</td>  <td>12,2</td>  <td>3.25</td>  <td>Bus</td>  <td>27.78</td>  <td><a href="http://www.bv.transports.gouv.qc.ca/mono/1018809.pdf"> 45</a></td>  <td>Euro6</td>  <td>PC_G_EU6</td></tr>
</a>
</table>


<h3 align="center" id="autos" >Génération de la demande</h3>


Les sections precedentes, ce focalisié sur la création de la demande et sur la construction topologique du reseau. Cette section se focalise sur la générations de la demande, donc la construction des déplacements dans notre reseau.

Il existe  de nombreuse possibilité dans Sumo pour générer de la demander, dans le cas du modèle de Montréal il a été choisie de prendre et de comparer trois types de génération de la demande. Deux générations avec la fonction od2trips et une génrération avec duarouter.

<h4 align="center">od2trips</h4>

La fonction interne à Sumo <i> <a href="https://sumo.dlr.de/docs/od2trips.html"> od2trips</a></i> permet de de créer des itinaires pour chaque véhicules (trajet Origine-Destination) à partir des matrice OD et des TAZ spécifié dans les sections precedentes. 

Il exite de nombreux parametres possibles pour l'execustion de od2trips, voici la liste utilisé pour la simulation

 <ul  align="center">
  <li  align="center" >Scale: Permet de definir le pourcentage que l'on veut inserer de la matrice OD de notre simulation</li>
  <li  align="center" >Spread.uniform : De generer les trajet de maniere uniforme dans le temps</li>
  <li  align="center" >Prefix : Assigne un prefix de chaque trajet de la simualation</li>
  <li  align="center" >Timeline : Premet de decouper la matrice en tranche horraire et definir des probabilité d'insertion de véhicules pour ces tranche</li>	
</ul> 

Lors de l'exicution de la commande deux choix possible pour la sortie sont possible.

<ul  align="center">
  <li  align="center" >Trips: Od2trips créer des déplacements uniques pour chaques véhicules. En definisant un lien de départ comme un point aléatoire de la zones d'origine (c'est à dire un edge aléatoire dans le TAZ) et de même pour la zones d'arrivé. De plus, selon les paramettres choisies, les instant de départ du trajet sont définies dans les tranches horraires definies.</li>
  <li  align="center" >Flow: Od2trips définies des flues de véhicules, c'est à dire un nombre de véhicules se déplacent d'une origine et un destination pour une date precise. Pour ce cas, le edges ne sont pas spécfier mais seulement le numero du TAZ de l'OD</li>
</ul> 

Ainsi il est possible de créer un fichier xml de la sorte pour la configuration de la commande od2trips:

```xml
<?xml version="1.0" encoding="UTF-8"?>

<configuration>
	<input>
		<taz-files value=<Taz_files>/>
		<od-matrix-files value=<OD_Matrix_Files>/>
	</input>
	
	<output>
		<output-file value=<trips_file>/>
    <flow-output value=<flow_file>/>
	</output>
	
	<processing>
    <scale value=<scale_value>/>
		<prefix value=<String_value> />
		<spread.uniform value="false" />
		<timeline value="<TIME>:<PROB>"/>
	</processing>
</configuration>

```

L'ensemble de c'est parametre peut-être spécifier dans un fichier de configuration que l'on peut nommer <i>od2trips.config.xml</i>. Et pour execter le fihcier od2trips il suffit de prendre suivre la commande suivante:

```
od2trips -c od2trips.config.xml 
```

La demarche de la fonction od2trips est visible sur la Fig XX:

<p align="center">
  <img width="600" height="300" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/od2trips.png"> 
</p>


<h4 align="center" id="duarouter">duarouter</h4>

Après avoir créer des trajets indivuelle a partir de la matrice OD grace à od2Trips, on peut utiliser la fonction <i> <a href="https://sumo.dlr.de/docs/duarouter.html"> duarouter.py </a> </i> qui permet de generer des itiniraires de plus court chemin à l'aide des trajet que nous avons construit. Nous avons pris l'option ignore-error afin de ne pas interroptre les calculs en cas d'erreur de calcule.

<p align="center">
  <img width="600" height="400" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/duarouter.png">
</p>

Nous prendrons les paramètres suivant pour notre simulation

 <ul  align="center">
  <li  align="center" >ignore-error: Permet de continuer le calcul des itenaires en cas d'erreur de calcul pour un trajet individuelle</li>
  <li  align="center">with-taz: Permet d'utiliser les zones OD pour l'entrée et la sortie des trajets, dans notre cas cette configuration est esensielle pour recalculer des alternative de trajet si il y a une erreur de trajet</li>
  <li  align="center">routing-algorithm: Permet de definir l'algorthime de routage, dans notre cas nous prendrons l'alogorithme de dijkstra</li>
  <li  align="center">no-step-log: Permet de désactiver les sortie de la console sur les etapes d'analyse</li>
</ul> 

Il est possible de repartir les trajets de manière uniforme à l'aide de l'utilisation de la commande <i>spread.uniform </i>. Comme le décopage horaire est utilisé (voir plus bas), od2trips permettre de calculer les heures de départ de chaque véhicules dans des tranches de 15 min

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

La section suivante presente énumerer les étapes pour la simulation

<h4 align="center" id="TC">Nombre de simulation à excecuté</h4>

Le logiciel SUMO, comme les autres logiciels de microsmulation de la circulation, prendre un representation de la circualtion de manière stochastique, la question du nombre de simualtions à effectuer pour recuper des données conveneme et acceptables se posent. [Gauthier][HollanderetLiu]
	
<p align="center">
  <img  width="250" src="https://render.githubusercontent.com/render/math?math=N=(t_\alpha_/_2\frac{s}{\overline{x}\epsilon})^2">	
</p>
	
Avec <img width="10" src="https://render.githubusercontent.com/render/math?math=t"/> suivant une loi de student de N-1 degrées de liberté, <img width="10" src="https://render.githubusercontent.com/render/math?math=\alpha"/> le niveau de confiance,  <img width="10" src="https://render.githubusercontent.com/render/math?math=s"/> l'ecart type de l'échantillon étdudier, <img width="10" src="https://render.githubusercontent.com/render/math?math=\overline{x}"/> la valeur moyenne de l'echantillon et <img width="10" src="https://render.githubusercontent.com/render/math?math=\epsilon"/> la tolérance choisie

<h3 align="center">Graine</h3>

Un aspect important dans la simulation du traffic est l'apect stochastiques d'une simulation afin de s'approcher au mieux des phénomes réel de la simulation grâce à la simulation. Or Sumo utilise  un algorithm, <i> <a href="https://sumo.dlr.de/docs/Simulation/Randomness.html">Mersenne Twister </a> </i> qui fixe le nombres aléatoires choisies pour la construction du modèle et de ce fait rend les simulations déterministes. Et ceci impacte de nombreuse valeur:

 <ul  align="center">
  <li  align="center" >Distributions des itinéraires</li>
  <li  align="center">Repartition des types de véhicules</li>
  <li  align="center">Distribution des vitesses</li>
  <li  align="center">Le modèle de suivi des véhicules (Car-Following)</li>
  <li  align="center">Heure de depart et d'arrivée</li>
  <li  align="center">Distribution des flux</li>	
</ul> 

Pour palier le plus possible à ce problemes qui rend l'analyse plus difficile, il est possible des changer ces valeurs fixes en effectuant differentes simulation à l'aide de graine, <i> seed </i> qu'il faut spécifier à chaque nouvelle simulation. 


<h3 align="center">Distribution des graines</h3>

Afin des diversifié au maximun la répartion des graines, nous prennons differentes valeurs de graines dans tout le processus de construction des affectations des iteraire. Nous commencons par le faire avec od2trips, puis avec Duarouter et le lancement de la simulation. Que nous avons construit dans un fichier batch, dont voici un exmple

```batch
FOR /L %%s IN (110,20,190) DO (
  ECHO %%s
  od2trips -c od2trips.config.xml --seed%%s --output-prefix seed%%s
  duarouter -c duarouter_configuration.xml --seed%%s --route-files  seed%%s<od2trips_output>  --output-prefix seed%%s 
  sumo.exe --seed %%s -c Simulation.sumocfg --route-files seed%%s<duarouter_output> 
)

```
Avec le ficher Simulation.sumocfg.xml:

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

Voici quelques differences visible entre chaque simulation pour une simulation avec environ 4000 véhicules:


<p align="center">
  <img width="400" height="300" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/endedvehicles.png">
  <img width="400" height="300" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/runningvehicules.png">
  <img width="400" height="300" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/meanTravelTime.png">
</p>




<h2 align="center" id="Collecte">Collecte de données</h2>

La section suivante traite de la collecte de données utilisées à la fois pour la visualisation des données et pour le LTE simulateur
	
<h3 align="center" >Visualisation des données</h3>
	
<h3 align="center">LTE simulator input</h3>

<h4 align="center">Floating Car Data</h4>

Le principe de FCD dans l'étude du traffic est de collecter les informations indivuellement de chaque véhicles afin d'en retirer les vitesses, les localisations et le sens de circulation [<a href="https://fr.wikipedia.org/wiki/Floating_car_data">Wikipedia</a>]. Dans SUMo, la simulation generer un fichier de sortie sur les informations de chaques vehicules en fonction du pas de temps choisies. Par default, la precission de localisation est de 1cm, mais il est possible de le regler avec la commande <i>precision</i>. Egalement, il est possible de restreindre l'information retirer, ce qui peut être utile lors de simulation avec de nombreux vehicules et un large reseaux.Le fichier de sortie sera de la sorte:

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

Pour appeler cette fonction, il faut precesier dans la simulation la commande <i> fcd-output</i> comme decrit ci dessous:
	
```
sumo -c Montreal.sumocfg --fcd-output FCD.xml
```

Après la simulation,les données brute du FCD peuvent être traitées avec <a href="https://sumo.dlr.de/docs/Tools/TraceExporter.html"> TraceExporter </a> ou bien avec différent graphique. Dans le cas de la co-simulation, se seront en partie ces données qui servirons d'entrer à la simulation.


	
<h2 align="center" id="Calibration">Analyse des sorties</h2>


<h3 align="center" id="TC">Heure de pointe</h3>

Nous n'avons pas calibrer les données de la matrice OD à la "realité", ce qui donne dans la <a href="#courbe"> courbe </a> un maximun de vehicules au depart de la simualtion. Or nous devrions voire une courbe decouper et avec un pic à l'heure de pointe. Qui est representer dans les figure suivante: 

<p align="center">
<img width="400" height="300" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/uniforme.png">
<img width="400" height="300" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/decoupage.png">
</p>


Le choix s'est egalement tourner en prennant en compte les comptages des véhciules au interesection, dont voici quelques representation pour des passage de voiture et de camion leger en heure de pointe:

	
<p align="center">
<img width="600" height="300" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/compatage_voiture.png">
<img width="600" height="300" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/vehicules_cumul%C3%A9.png">
</p>

Étant donnéer que les decoupage sont en tranche de 15 min, il à etait choisie de faire de meme pour le decoupage de la matrice OD, dont les valeurs sont dispoblible en annexe du document



Pour ce faire, la commande --timeline à été priviligé comme enoncer dans les explications de la méthodologie

```xml
 <timeline value="18000:0.2,18900:0.2,19800:0.2,20700:0.2,21600:0.4,22500:0.8,23400:5.2,24300:6.1,25200:6.9,26100:7.8,27000:9.8,27900:10.1,28800:11.3,29700:11.5,30600:10.8,31500:9.3,32400:7.2"/>
```
Pour ce faire on utilisera la commande --scale dans od2trips

<h4 align="center" id="TC">Decalage de la courbe</h4>

<h4 align="center" id="TC">Vitesse de calcul</h4>
<p align="center">
<img width="400" height="300" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/Summary/ended_vehicules_sans.png">
</p>


<h4 align="center" id="TC">Vitesse de calcul</h4>
<p align="center">
<img width="400" height="300" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/Summary/courbe_vehicules_decalage.png">
<img width="400" height="300" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/Summary/ended_vehicules_decalage.png">
>
</p>




<h4 align="center" id="TC">Mean Travel Time</h4>

Dans le cas de cette simulation et de la construction du modèle, pour identifier la performance de cette dernieres, il est possible de mesurer le temps de trajet moyens

Pour ce faire et comparer avec les données "reel", il est possible de prendre le profil de <a href="https://www12.statcan.gc.ca/census-recensement/2016/dp-pd/prof/details/page.cfm?Lang=F&Geo1=CMACA&Code1=462&Geo2=PR&Code2=24&SearchText=Montreal&SearchType=Begins&SearchPR=01&B1=All&GeoLevel=PR&GeoCode=462&TABID=1&type=0">recensement</a> qui donne les données suivante pour les temps de parcours de dans la Region métropolitaine de montréal sans la distinction de sexe

<table  align="center"><a align="center">
<tr><th>Caractéristique</th><th>Nombre de deplacement</th><th>Pourcentage</th></tr>
<tr><td>Moins de 15 min</td><td>18%</td><td></td></tr> 
<tr><td>15-29 min</td><td>601 250</td><td>32%</td></tr>
<tr><td>30-44 min</td><td>489 215</td><td>26%</td></tr>
<tr><td>45-59 min</td><td>235 360</td><td>12,5%</td></tr>
<tr><td>plus de 60 min</td><td>216 110</td><td>11,5%</td></tr>
</a></table>

Avec comme données <a href="https://www150.statcan.gc.ca/n1/daily-quotidien/171129/t002c-fra.htm">moyenne</a>

<table  align="center"><a align="center">
<tr><th>Caractéristique</th><th>Total – Main mode of commuting</th><th>Car, truck or van</th><th>Public transit</th><th>Active transport</th><th>Other method</th></tr>
<tr><td>Montréal</td><td>30</td><td>26.8</td><td>44.4</td><td>16.3</td><td>26.0</td> </tr>
</a></table>

<h3 align="center" id="TC">Originie et destination dans l'île et reseau simplifier</h3>

La section precente, presente les differentes simulation ne prennnans en compte que les deplacements 'interne' à l'ile de Montréal. C'est à dire les deplacements dont l'origine et la destination provienne des secteurs municipales de l'ile de Montréal definie plus haut. Mais aussi avec une topologie simplifier, c'est à dire sans les rue residentielles et les rues unclassifier

<h4 align="center" id="TC">Vitesse de calcul initialisation</h4>
	
Selon les stratégies choisies et dans la prespective d'une cosimulation entre le simulation de circulation et le lte simulator, il est utile de se pencher sur le temps de calcul des differents programme executer. Apres avoir tourner XX simulation pour les commandes duarouter et od2trips, il est possible de voir la vitesse de calcul sur la Fig XX
<p align="center">
<img width="700" height="300" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/Summary/meso_od2trips/od2trip_computation_int.png">
<img width="700" height="300" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/Summary/meso_duarouter/duarouter_computation.png">
</p>

Il n'est pas surprennant de constater difference notoire entre les od2trips et les duarouter. En effet, le calcul sous duarouter n'assige que des points de depart et des points d'arriver pour les differents trips pris en comptes. Tandis que pour duarouter, l'algorithme, notamment celui de Dikjstra, prendre en compte l'ensemble du parcours de chaque trajets pris indivuelles pour une entrées Trips, et ceux pour l'ensemble des trajets pour atteindre un equilibre de la circulation. L'enjeux du temps de calcule reside plus lors de la simulation sur SUMO comme mentionner dans les sections suivantes.
	

<h5 align="center" id="TC">Simulation Microscopoque</h5>

Cette section traite de la simualtion des trois options, od2trips, flow et duarouter lors du simulation microscopique pour les parametre énumer plus haut

	
<h4 align="center" id="TC">Mesoscopic</h4>

	
Au vu des resultats des temps assez grandes vu dans la sections, notamment lors des simulations et au vu du nombre de vehicules injecter dans le reseau, il est possible de faire des simulation mésocopique de la circulation.

Le modèle proposé par SUMO sur les travaux de Eissfeldt, Nils Gustaf [<a href="https://kups.ub.uni-koeln.de/1274/1/thesis_nils_eissfeldt.pdf">ref<a> AJOUT
	
Plusieurs impacte sont possible du au choix de cette configuration, notamment le calcule sont possiblement moins precis sur les interesection, notamment au feux de circualation, mais aussi les vitesses de l'ensemble des véhicules et les changement de voies.

Par exemple en utilisant les parametres spécifier plus haute, et en utilisant le paramètre --mesosim dans le fichier.

<h4 align="center" id="TC">Vitesse de calcul</h4>
	
Comme dans la section precedentes, il est possible des retirer les temps de calcules de chaque scénarios choises dans la simulation.
<p align="center">
<img width="700" height="300" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/Summary/meso_od2trips/sumo_comput_int.png">
<img width="700" height="300" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/Summary/meso_flow/sumo_comput_int.png">
<img width="700" height="300" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/Summary/meso_duarouter/sumo_comput_int.png">
</p>
	
Comme le stipule la documenation de SUMO, le choix de l'option de prendre une simulation mésocopique reduit drastriquement le temps de calcule pour une simulation. Il est remarque de constater que chaque scénario, od2trips, flow ou duarouter est netemment plus rapide que les scénarios microscopique. As ce stade, les simulations mésocopique pour des simulations avec des trajets interieurs pour une reseau simplifier sont envisagable en terme de co-simulation
	

<h4 align="center" id="TC">Mean-Travel_Time</h4>


Comme vu plus haut, il est choisie de prendre les temps de parcours pour voir la represenation avec la réalité. ainsi apres avoir rouler XX simulations pour les differentes parametre od2trips, flow, duarouter. Il est possible de representer les temps moyennes:

<p align="center">
<img width="700" height="300" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/Summary/meso_od2trips/Mean_travel_int.png">
<img width="700" height="300" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/Summary/meso_flow/Mean_travel_int.png">
<img width="700" height="300" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/Summary/meso_duarouter/Mean_travel_int.png">
</p>

Il est fort de constater que les temps de trajets moyennes ne depassent pas les 12 minutes, contrairement au données du recensement du Canada qui avancer un temps moyennes parcours de 26.8 min pour les autos. Il semblerait qu'il y est une sensibilité assez forte dans le choix du parametre mesosime. Comme dit plus haut, le modèle simplifier la circulation car le modele est baser sur les edges et non sur les lanes.
	
ANOVA

<h4 align="center" id="TC">Running</h4>

Comme pour la simulation microscopique, il est possible de visalisées les differentes courbe de running vehicules et de vehiucles cummulé.
<p align="center">
<img width="400" height="300" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/Summary/meso_od2trips/running_od_int.png">
<img width="400" height="300" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/Summary/meso_od2trips/ended_od_int.png">
</p>
<p align="center">
<img width="400" height="300" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/Summary/meso_flow/running_flow_int.png">
<img width="400" height="300" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/Summary/meso_flow/ended_flow_int.png">
</p>
<p align="center">
<img width="400" height="300" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/Summary/meso_duarouter/running_duarouter_int.png">
<img width="400" height="300" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/Summary/meso_duarouter/ended_duarouter_int.png">
</p>


Si nous faisons la moyennes de chaques simulations:

<p align="center">
<img width="400" height="300" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/Summary/runningvehicules_meso_mean.png">
<img width="400" height="300" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/Summary/endedvehicules_meso_mean.png">
</p>

Comme pour la simulation precedentes, il est constaté qu'il y a également une difference assez remarquable entre chaque simulation. Cette fois le od2trips à premieres vu semble suivre un courbe de comptage presenter dans la section presente, ainsi que les flow. À noter également, que même si la "pointe" de la courbe de duarouter est legerment décaler avec les autres courbe, la courbes n'est pas arrete nette mais d'autres véhcules sans encore inserer comme on peut le voir sur la figure des ended vehicules.

La comparaison avec la courbe esperer est presente sur la Fig XX
<p align="center">
<img width="400" height="300" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/Summary/reel_int_meso.png">
<img width="400" height="300" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/Summary/ended_vehicules.png">
</p>

Il est assez remarcable de voir un assez grande difference entre les courbes simulées et la courbes esperée. Cependant la courbe de la simulation od2trips semble devoir suivre la tendance de la courbe esperer. Neamoins il est constaté que l'ensemble de ces simulation soit en "sous" regime des non prise en compte de trajet dans les calculs des differentes fonctions.

<h4 align="center" id="TC">DataLane</h4>

<h4 align="center" id="TC">Impacte sur la simulation</h4>

<h3 align="center" id="TC">Données Bluetooth</h3>

La taxonomie des applications communicantes a relevé que la technologies Bluetooth sont difficlement deployable et envisagable pour la mise en place des ITS. Néamoins, cette technologie est utilisée aujourd'hui pour de la collecte de données. Même si l'interer dans les transport n'est que recentes, les premieres apparation academique date de 2010 [<a href="https://link.springer.com/article/10.1007/s13177-014-0092-1">Friesen</a> and McLeaod], les capteurs bluetooths ont eu un interet grandissant dans la collecte de données de la circulation ces 10 dernières années.

Le principe actuelle et general de cette collecte repose sur de la communication V2I, avec un recepeteur (les bornes bluetooth) et un emeteur (generalement un cellulaire). Le principe de la collecte est le suivant: Le capteur Bluetooth cherche des appareils Bluetooth dans son rayon de communication (de l'ordre du 100 m). Lorsqu'il detecte un appareil, le capteur recuper l'addresse MAC, unique pour chaque apareil, pour en recolter quelques informations
relative à l'emetteur, comme sont emplacement, la date d'arrivées et de sorties de la zones de detection, et par deduction sa vitesse.
Pour la circulation, les données de transport sont generalement pris pour une section routier comportant deux capteurs bluetooth, une capteur en amont et un en aval à distance fixe. Cette strategie permet au permer capteurs de tirer les information d'une addresse MAC à l'instant t0 puis le deuxieme capteur tire les information t1. Comme d'ecrit sur l'image suivante:

<p align="center">
  <img width="600" src="https://www.libelium.com/libelium-images/generico2/bluetooth_speed_big.png">
</p>
Source: libelium 2011

Grace a cette stratégie,les données collectées par les capteurs sont de maniere general des débits, temps de parcours et des données d'origine-destination.L'avantage de ces capteurs le prix faible que les autres collecte de données, comme les enregistrements vidéo avec les lectures de plaques [Alizadeh H. (2020) Circulation]. 

Néamoins, les données resorties et sur la qualité notamment dependant grandement des utilisateurs. Car pour que le capteur puisse lire l'adresse MAC d'un émetteur, souvent un cellulaire, le mode bluetooth d'autre activé. Cependant, l'explication de l'interer de cette technolgie peut avoir un liens avec le nombre grandissant de smartphone dans la population, 34 Millions d'abonnement mobile au Canada en 2019 [<a href="https://www.ceicdata.com/en/indicator/canada/number-of-subscriber-mobile">Ceicdata </a>]

C'est ainsi qu'afin de mieux comprendre certain phénomes de la circulation sur l'ile, la ville de Montréal à déployer des capteurs communicant équipé de technologies Bluetooth  dans des segments routiers stratégiques. [Ville de <a href="https://donnees.montreal.ca/ville-de-montreal/temps-de-parcours-sur-des-segments-routiers-historique">Montréal</a>]. Ces données, en libre d'accées, resortre certaines cartéristiques de la circulation, comme les temps de parcours, les vitesse moyennes et la longueur du segments, et ceux sur une paire de capteur données. La ville à mise sur un deployement de 114 capteurs reparties dans un ensemble spacial definie dont les territoires sont definies en annexes.

Pour l'impentation de ces capteurs, la ville de Montréal a fais appelle à l'entreprise Québecoise Orange Traffic spécialisé dans le "domaine de la technologie de la signalisation et des feux de circulation". Entreprise tres présente dans la signalisation Montréalaise, propose pour système de détection Bluetooth un detecteurs BTM-232, qui à une porter de maximal de 125 mètres [<a href="https://www.orangetraffic.com/fr/product/unite-de-detection-bluetooth-btm-232/?pdf=1050">Fiche technique</a>].

Il est possible de simulé des appareils embarqués, comme le Bluetooth [<a href="https://sumo.dlr.de/docs/Simulation/Bluetooth.html">Bluetooth<a>], dans sumo. Pour cela, il possible d'"implanter" à chaque véhicule un capateur qui reprendre la dectection sur les signaux radio (comme le Bluetooth)  afin qu'il puisse émettre (btsender) ou recevoir (btreceiver) des informations diverse sur son état. Néamoins, il est actuellement imposible d'implanter des RSU pour recrer de la communication V2I comme decrit dans la figure XX

<p align="center">
  <img width="600" src="https://www.researchgate.net/profile/Mukhtar-Sofi/publication/315689107/figure/fig1/AS:669020269326348@1536518270511/The-Bluetooth-detection-principle.jpg">
</p>

Pour remedier à ce problème, il est possible de placer un véhicule à l'arret sur un parking au lieu de l'emplacement choisie pour le detecteur bluetooth et lui arribuer un fonction receiver.

<h4 align="center" id="TC">Modélisation dans Sumo</h4>

Pour modéliser la communication Bluetooth dans Sumo, la stratégie adopté dans le modèle de Montréal à été de créer des parkings sur la bordure de routes pour y placer des véhicules immobiles communicant avec le reste du traffic routier.

Les aires de stationnements dans SUMO peut être definie dans un fihcier additionnel à l'aide de la balise `<parkingArea>`, dont-il faut renseigner au minumun l'identifier, la voie en bordure et la position de départ sur la voies [<a href="https://sumo.dlr.de/docs/Simulation/ParkingArea.html">ParkingArea</a>]. De plus dans le cas de la simulation le `roadsideCapacity` vaut 1 pour y placer une voiture à l'arret et `endPos` pour definir la longueur du station en combinaison avec `startPos`

Afin de positionner les differents Parking, les données ouvert de la ville de Montréal, concernant le positionnement des bornes Bluetooth, ont été prises. De plus, pour implanter et traduire les possitionnement des bornes en coordonnées géometrique en données local du réseau dans SUMO, les diffrentes fonctions de Sumolib [<a href="https://sumo.dlr.de/docs/Tools/Sumolib.html">Sumolib<a>] ont été choisies. Pour ce faire, la conversion des cordonnées ont été faite grâce à la fonction `convertLonLat2XY`. Puis la fonction `getNeighboringEdges` est utilisé pour trouver les `Edges` les plus proches des coordonnées dans un rayon données, qu'y vaut  métres dans le cas de la modélisation. 
Cependant, les `Edges` ne donne aucun information du noeud le plus proches des coordonnées choises. En effet, lors de l'asignation de la position initial du parking, il est necessaire de savoir qu'elle est la jonction la plus proche de cette position pour ne pas assigné un parking trop "loin de la réalité. Pour resoudre ce probleme, la fonction `getEdge` à été pris en compte pour trouver les deux noeuds du egdes, noeuds du debut et noeud de fin. Et une fonction de distance cartesiennes à été pris en compte à fin de trouver la plus courtes distances entre les deux noeuds et les coordonées choises, ainsi la distance la plus courtes est dfinies comme le point le plus proches du parking. Cette demarche permet ensuite de definir le point de depart du parking. Ainsi, si le noeud le plus proche correspond au debut de la ligne la startPos se verra assigner la valeur 0 et au contraire si le noeud le plus proche se citue à la fin de la ligne, c'est la endPos qui se verra assigner la valeur de la longueur de la ligne, relever grâce à la fonction `getLength`. Le choix d'un parking le plus ponctuelle possible et sans dependre du type de route à ammener a fixer comme longueur du parking une valeur de 2 métres, comme le montre la figure XX du croissement Jean-Talon/Papineau.

<p align="center">
 <img width="600" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/Bluetooth/Capteur_Jean_Talon_Papipeau.png">
</p>

L'étape de suivante est d'implanter à chaque parking des véhicules à l'arrer. Pour ce faire, il est possible de créer des fichiers .rou qui renseigne les arrets de chaques véhicules grace à la balise `stop` et en reseignement de l'emplacement du parking grâce à la valeur de `parkingArea` et de la durée de stationnement avec `duration`. Néamoins, un default actuelle dans Sumo et que les routes de chaques véhciules ne peuvent contenir seulement des stops et doivent au minimun avoir un trajet. Pour remedier à cela, le stratégie adopter à été de faire partir, 5 min avant les autres véhicules (modéliser plus), les véhicules qui seront assigner comme "borne bluetooth" sur la ligne du parking afin de minimeser les deplacements, puis faire attendre le véhicule sur le parking jusqu'a la fin de la simulation. De plus pour des raisons de praticité, les id de chaques véhicules correspond au id des capteurs fixer par la ville de Montréal. Puis l'implentation de capteur type "receiver" à chaque véhicule c'est faite grâce à la commande `device.btreceiver.explicit`. Et comme les capteurs bluetooth de l'ile de Montréal ont une portée de l'ordre du 100 m, il a été choisie de prendre en compte la commande `device.btreceiver.range` pour assigner à chaque capteur une portée égale à 10 mètres.

<h4 align="center">Paramètre Bluetooth</h4>

Concernant les véhicules `sender`, pour des questions de stratégie, notammenet de la grandeur des données de sortie, le nombre de voiture porteur d'un capteur bluetooth correspond à 5% de la flotte.

Au vu du nombre de paire (trajet) disponible dans les données de la ville de Montréal, une filtrage du nombre de données et de paires de capteurs à été priviliger à fin de limité le nombre d'analyse. Pour ce faire, un choix de filtrage spacialé et de la longueur des segments à été pris en compte. Il a été décider de prendre les 40 premieres paires dont les segements sont les plus longs. Ce qui donne un repartition spaciale visible sur la figure XX

<p align="center">
  <img width="600" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/Bluetooth/39_capteur.png">
</p>

<h2 align="center" id="Discussion">Discussion ou reste</h2>


- Prise en compte des données Bluetooth (Corelation avec spearman ?), temps de parcours,speed mean
- Convergence des valeurs avec plusieurs simulation

- Comparaison matrice od 2013 - 2018 
- Comparaison pas de Temps
- Comparaison des simulations misosim et sans
- Difference au niveau macro et miccro
- Difference 24h et AM
- Carte à Puce

Discuter de la calibration et insertitudes



<h3 align="center" id="Feux de circulation">Feux de circulation</h3>

Definition du temps de cycle de chaque feux de circulation

<h3 align="center" id="PartieModale">Partie Multimodale</h3>

Dans la poursuite d'une simulations multimodale, la prise en compte des modes actifs peut-être envisage et peut faire partie d'une études à part entiere

<h3 align="center">Vélo</h3>

Selon l'estimation de l'entquete Origine Destination, en 2013 sur l'ile de montréal 2.5\% des deplacements sont du au <a href="https://raw.githubusercontent.com/HuguesBlache/ProjetPoly/master/MatriceOD/Velo/etat_velo_2015.pdf?token=APRKJL4HPHP5WFIJC7LPXW3AQA3OS}">vélo</a>. Et peuvent atteindre un part modele de 10.8\% dans le secteur du plateau Mont-real representer dans la Fig. XX

<p align="center">
  <img width="600" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/part_mod_velo.png">
</p>

Il nous été donc tres important que dans notre simulation de prendre en compte ces deplacement, notamment si nous avons integrer le vélo dans les communication V2P des véhicules communicants.

Pour implanter les modes actifs vélo dans notres modèle, les choix sera en plus d'importer les routes "automobiles", de prendre en compte les routes suivantes.

<table  align="center"><a align="center">
<tr><th>Key</th><th>Value</th><th>Comment</th></tr>
<tr><td>Highway</td><td>cycleway</td><td>For designated cycleways. Add foot=*, though it may be avoided if default-access-restrictions do apply. </td></tr>
	</a></table>
	
Mais aussi en utilisant les differentes <a href="https://wiki.openstreetmap.org/wiki/Key:highway">configuration </a> et relations des reseaux expresse de l'ile de Montréal avec par exemple la commande:
	
```ql
area[wikidata="Q2826806"]->.montreal;
rel(area.montreal)[route="bicycle"];
(._;>;);
out;
```

Le choix de véhicules sera pris en fonction des vélos et pour aller plus lons en prennent en compte les plages des differentes types de véhicules (éléctrique, route, de ville ...)

<p align="center">
  <img src="https://user-images.githubusercontent.com/65184943/88848400-6fe8c400-d1b6-11ea-8e7c-98ca7cbf0b7b.png">
</p>
	
POur le verifier, nous pouvons visualiser les données ouvertes de <a href="https://www.bixi.com/fr/page-27"> Bixi </a> qui permetra de voire la tendance sur la plage horraire 5h-9h.

Apres exploitation des <a href="https://github.com/HuguesBlache/MontrealTrafficSimulation/tree/master/Data/Bixi">données</a> nous avons des courbes du type.

<p align="center">
<img width="400" height="300" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/Pointe5%4010.png">
<img width="400" height="300" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/PointeJourn%C3%A9e.png">
</p>


https://www.artm.quebec/eod/2013/
https://github.com/HuguesBlache/ProjetPoly/blob/master/MatriceOD/Velo/etat_velo_2015.pdf
Puis la suite <a href="#duarouter"> duarouter </a>.



<h3 align="center">Marche</h3>

Pour le mode actif marche, la construction du modèle requirer quelques modification du reseau. Car dans ce cas, SUMO ne considère pas les pietons comme des vehicules. Pour cela il faut donc contruires des voies pietonnes pour pouvoir ensuire implanter la matrice OD


Il existe dans SUMO plusieures manières pour integrer des trotoires dans le modèle. Soit il sont deja present dans le la carte OSM à traver les differentes routes ou l'on peut les integrer sur les bords des routes du reseau.

Pour cela il suffit de rajouter quelques lignes dans la construiction de la <a href="#carte"> carte </a> : ``` --sidewalks.guess``` permet de creer les trotoire ``` --crossings.guess``` creer les passage pietons ``` --walkingareas``` creer les zones de marches sans croisement.

<h3 align="center">Deplacement multimodale</h3>


<h5 align="center">Emissions</h5>


https://theicct.org/sites/default/files/info-tools/One%20table%20to%20rule%20them%20all%20v1.pdf

<table  align="center">
	<a align="center">
  <tr><th>Modele</th><th>Consomation</th> <th>Nomre Euro</th><th>SUMO</th></tr>
  <tr>  <td>Toyota Corolla 2013</td>  <td>7,6</td>  <td>Euro5</td>  <td>PC_G_EU5</td></tr>
  <tr>  <td>Ford F 150</td>  <td>13</td>  <td>Euro3</td>  <td>PC_G_EU3</td></tr>
  <tr> <td>Yamaha FZ</td>  <td>5,6</td>  <td>Euro6</td>  <td>PC_G_EU6</td></tr>
	<tr>  <td>Honda Forza 125</td>  <td>2,3</td>  <td>Euro6</td>  <td>PC_G_EU6</td>
  </tr>	</a>
</table>
<h2 align="center" id="Annexe">Annexe</h2>

<h3 align="center" id="Road_Type">Type de Route</h3>

<table  align="center"><a align="center">
<tr><th>Key</th><th>Value</th><th>Comment</th></tr>
<tr><td>Highway</td><td>motorway</td><td>A restricted access major divided highway, normally with 2 or more running lanes plus emergency hard shoulder. Equivalent to the Freeway, Autobahn, etc.. </td></tr>
<tr><td>Highway</td><td>motorway_link</td><td>The link roads (sliproads/ramps) leading to/from a motorway from/to a motorway or lower class highway. Normally with the same motorway restrictions.</td></tr>
<tr><td>Highway</td><td>trunk</td><td>The most important roads in a country's system that aren't motorways. (Need not necessarily be a divided highway.) </td></tr>
<tr><td>Highway</td><td>trunk_link</td><td>The link roads (sliproads/ramps) leading to/from a trunk road from/to a trunk road or lower class highway. </td></tr>
<tr><td>Highway</td><td>primary</td><td>The next most important roads in a country's system. (Often link larger towns.)  </td></tr>
<tr><td>Highway</td><td>primary_link</td><td>The link roads (sliproads/ramps) leading to/from a primary road from/to a primary road or lower class highway. </td></tr>
<tr><td>Highway</td> <td>secondary</td><td>The next most important roads in a country's system. (Often link towns.) </td></tr>
<tr><td>Highway</td><td>secondary_link</td><td>The link roads (sliproads/ramps) leading to/from a secondary road from/to a secondary road or lower class highway.</td></tr>
<tr><td>Highway</td><td>tertiary</td><td>The next most important roads in a country's system. (Often link smaller towns and villages) </td></tr>
<tr><td>Highway</td><td>Tertiary_link</td><td>The link roads (sliproads/ramps) leading to/from a tertiary road from/to a tertiary road or lower class highway. </td></tr>
<tr><td>Highway</td><td>Unclassified</td><td>The least important through roads in a country's system – i.e. minor roads of a lower classification than tertiary, but which serve a purpose other than access to properties. (Often link villages and hamlets.)The word 'unclassified' is a historical artefact of the UK road system and does not mean that the classification is unknown; you can use highway=road for that. </td></tr>
<tr><td>Highway</td><td>residential</td><td>Roads which serve as an access to housing, without function of connecting settlements. Often lined with housing. </td></tr>
</a></table>

<h3 align="center" id="Description_du_reseau">Description du reseau</h3>

<table  align="center">
<tr><th>Entité</th><th>Unité</th></tr>
<tr><td>Area</td><td>Unité</td> </tr>
<tr><td>Edges Lenght</td> <td>7934</td></tr>
<tr><td>Edges avec 1 Lines Lenght/td><td>6695</td> </tr>
<tr><td>Edges  avec 2 Lines Lenght</td><td>800</td></tr>
<tr><td>Edges  avec 3 Lines Lenght</td><td>382</td> </tr>
<tr><td>MotorWay Lenght (Km)</td> <td>466,8</td> </tr>
<tr><td>Trunk Lenght (Km)</td><td>14,4</td> </tr>
<tr><td>Primary Lenght (Km)</td><td>194</td> </tr> 
<tr><td>Secondary Lenght (Km)</td><td>927</td> </tr>
<tr><td>Terciary Lenght (Km)</td><td>1092</td> </tr>
<tr><td>Residential Lenght (Km)</td><td>4976</td> </tr>
<tr><td>Unclassified Lenght (Km)</td><td>263</td> </tr></table>

<h3 align="center" id="Description_SM">Description des SM</h3>

Description des differents limitations administratifs utiliser dans le modèle
<table  align="center">
<tr><th>ARTM_ID</th><th>TAZ</th><th>Name</th><th>Aire [km2]</th></tr>
<tr><td>122</td><td>197561</td><td>Westmount</td><td>4,36250012974578</td></tr>
<tr><td>130</td><td>197562</td><td>Dorval</td><td>39,0593228540409</td></tr>
<tr><td>120</td><td>197567</td><td>Mont-Royal</td><td>10,8008968444416</td></tr>
<tr><td>123</td><td>197569</td><td>Hampstead</td><td>1,8849887211046</td></tr>
<tr><td>131</td><td>197576</td><td>Pointe-Claire</td><td>38,6473614658978</td></tr>
<tr><td>137</td><td>197577</td><td>Kirkland</td><td>12,5171922380251</td></tr>
<tr><td>138</td><td>197578</td><td>Beaconsfield</td><td>22,4031783524039</td></tr>
<tr><td>139</td><td>197579</td><td>Baie-D'Urfé</td><td>7,65684655205541</td></tr>
<tr><td>140</td><td>197580</td><td>Sainte-Anne-de-Bellevue</td><td>14,5322558976101</td></tr>
<tr><td>141</td><td>197583</td><td>Senneville</td><td>22,2903473207173</td></tr>
<tr><td>132</td><td>197601</td><td>Dollard-Des-Ormeaux</td><td>17,9511405853573</td></tr>
<tr><td>101,102</td><td>1572820</td><td>Ville-Marie</td><td>29,2208827294673</td></tr>
<tr><td>115</td><td>1634159</td><td>Montréal-Est</td><td>15,7508467246033</td></tr>
<tr><td>106</td><td>1878503</td><td>Plateau Mont-Royal</td><td>9,24304323608709</td></tr>
<tr><td>124</td><td>5361655</td><td>Côte-Saint-Luc</td><td>9,77951784329642</td></tr>
<tr><td>126,129</td><td>5363262</td><td>Arrondissement de Lachine</td><td>23,2106883296288</td></tr>
<tr><td>125</td><td>7022381</td><td>Montréal-Ouest</td><td>1,61060606785383</td></tr>
<tr><td>113,114</td><td>8802299</td><td>Rivière-des-Prairies–Pointe-aux-Trembles</td><td>68,8772235520387</td></tr>
<tr><td>116</td><td>8803286</td><td>Anjou</td><td>15,1656834642695</td></tr>
<tr><td>111,112</td><td>8803356</td><td>Mercier–Hochelaga-Maisonneuve</td><td>38,0635773039326</td></tr>
<tr><td>118</td><td>8803462</td><td>Montréal-Nord</td><td>13,8329359420784</td></tr>
<tr><td>108</td><td>8803535</td><td>Ahuntsic-Cartierville</td><td>39,2945996582235</td></tr>
<tr><td>107,109</td><td>8803536</td><td>Villeray–Saint-Michel–Parc-Extension</td><td>20,6190943767103</td></tr>
<tr><td>117</td><td>8803537</td><td>Saint-Léonard</td><td>14,78885877074</td></tr>
<tr><td>110</td><td>8803540</td><td>Rosemont–La Petite-Patrie</td><td>18,6757551362398</td></tr>
<tr><td>121</td><td>8803553</td><td>Outremont</td><td>4,99210671977815</td></tr>
<tr><td>128</td><td>8805426</td><td>LaSalle</td><td>34,1193239432363</td></tr>
<tr><td>127</td><td>8805573</td><td>Verdun</td><td>25,7808089039482</td></tr>
<tr><td>103</td><td>8805747</td><td>Le Sud-Ouest</td><td>29,9708966584688</td></tr>
<tr><td>119</td><td>8806186</td><td>Saint-Laurent</td><td>54,9279755735267</td></tr>
<tr><td>104,105</td><td>8806187</td><td>Côte-des-Neiges–Notre-Dame-de-Grâce</td><td>32,6900583956751</td></tr>
<tr><td>133,135,136</td><td>8806364</td><td>Pierrefonds-Roxboro</td><td>68,9451595215531</td></tr>
<tr><td>134</td><td>8806483</td><td>L'Île-Bizard–Sainte-Geneviève</td><td>41,697710545267</td></tr>
</table>

<h3 align="center" id="Description_SM">Decoupage de la matriceOD</h3>
<table  align="center"><a align="center">
<tr><th>Periode</th><th>Pourcentage</th><tr>
<tr><td>18000</td><td>0,2</td></tr>
<tr><td>18900</td><td>0,2</td></tr>
<tr><td>19800</td><td>0,2</td></tr>
<tr><td>20700</td><td>0,2</td></tr>
<tr><td>21600</td><td>0,4</td></tr>
<tr><td>22500</td><td>0,8</td></tr>
<tr><td>23400</td><td>5,2</td></tr>
<tr><td>24300</td><td>6,1</td></tr>
<tr><td>25200</td><td>6,9</td></tr>
<tr><td>26100</td><td>7,8</td></tr>
<tr><td>27000</td><td>9,8</td></tr>
<tr><td>27900</td><td>10,1</td></tr>
<tr><td>28800</td><td>11,3</td></tr>
<tr><td>29700</td><td>11,5</td></tr>
<tr><td>30600</td><td>10,8</td></tr>
<tr><td>31500</td><td>9,3</td></tr>
<tr><td>32400</td><td>7,2</td></tr>
</a></table>

<h3 align="center" id="Road_Type">Secteur des capteurs <a href="">Bluetooth</a></h3>

<table  align="center"><a align="center">
<tr><th>Nom du secteur</th><th>Nombre de capteur</th><tr>
  <tr><td>Artère Pie-IX</td><td>7,2</td></tr>
  <tr><td>Artère Sherbrooke</td><td>7,2</td></tr>
  <tr><td>Artère Saint-Michel</td><td>7,2</td></tr>
  <tr><td>Artère Saint-Denis (en partie)</td><td>7,2</td></tr>
  <tr><td>Artère Parc</td><td>7,2</td></tr>
  <tr><td>Artère De Lorimier (en partie)</td><td>7,2</td></tr>
   <tr><td> Artère Rosemont (en partie)</td><td>7,2</td></tr>
   <tr><td> Artère Saint-Joseph (en partie)</td><td>7,2</td></tr>
    <tr><td>Artère Jean-Talon (en partie)</td><td>7,2</td></tr>
    <tr><td>Artère Crémazie (en partie)</td><td>7,2</td></tr>
   <tr><td> Secteur Quartier des spectacles</td><td>7,2</td></tr>
</a></table>


# SUITE
# NON
# MODIFIÉ
# POUR
# LE
# MOMENT
 








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


<h4 align="center" id="TC">AUTRE</h4>

Pour prendre en compte les arrets de bus en fonctions des types de topologies choisies de notre simulation, une solution est de le compiler directement à l'aide de Netconvert avec les commandes suivante:

 <ul  align="center">
  <li  align="center" >osm.stop-output.length : Cette fonction permet de difinire des longueur des arrets de bus par default, nous prendrons 20 metres</li>
  <li  align="center">ptstop-output : Cette fonction permet de renseigner sur les emplacements des arrets des bus sur notre carte</li>
  <li  align="center">ptline-output: Cette fonction permet de renseigner sur les trajets des lignes de bus</li>
</ul> 

Ce qui donnes comme instructions à SUM

```
netconvert --osm-files <Files> -o <Files> --osm.stop-output.length 20 --ptstop-output ptstop.add.xml --ptline-output ptlines.xml

```
Pour visualiser la emplacement dans la simulation, il faut ajouter un fichier additionnel dans le .sumocfg qui porte le nom où ce situe le fihcier des arrets, ici ```ptstop.add.xml```

<p align="center">
  <img width="500" height="400" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/arret_bus.png">
</p>
<h4 align="center">Construction des trajets de bus</h4>

La construction des itenairaises de bus sont legerement differents que celle des voitures, il faut faire faire suivre un chemin special au bus pour qu'il s'arrete à tout les arret desiser. Pour ce faire la fonction <i> <a href="https://github.com/eclipse/sumo/tree/master/tests/tools/public_transport/ptlines2flows"> ptlines2flows.py </a> </i>. peut faire ces trajets.



<p align="center">
  <img width="600" height="300" src="https://github.com/HuguesBlache/MontrealTrafficSimulation/blob/master/Image/ptlines2flow.png">
  
</p>

Voici par exemple la commande que nous pouvons faire à notre reseau
```
ptlines2flows.py -n Montreal.net.xml -s ptstop.add.xml -l ptlines.xml -o flows.rou.xml -p 600 --use-osm-routes
```
La partie ```-p 600``` correspond, en secondes, à l'intervalle de temps entres chaques bus d'une même ligne sur un même arret. A ce moment de la simulation les bus tourne à "vide", pourons par la suite faire des trajets intermodaux 


</body>
</html>
