# 20250711 - [DeveloppeurPascal](https://github.com/DeveloppeurPascal)

* mise à jour du site web pour ajouter une page d'infos légales et de confidentialité des données : https://lognpass.fr/page/_0-politique-de-confidentialite-et-donnees-personnelles.html

* mise à jour des dépendances du projet existant
* ajout des sous modules nécessaires pour basculer l'application sur le starter kit FMX
* mise à jour des docs fr/en
* mise à jour des paramètres de C2PP
* mise à jour des signatures d'entête de codes sources
* ajout des paramètres pour DocInsight
* changement des infos sur l'ancien projet pour pouvoir l'ouvrir en même temps que la version 2.0
* création du nouveau projet par copie du modèle de projet FMX du starter kit et changement de son ProjectGUID pour Delphi
* regénération de l'icone pour iOS et Android
* création d'une icone avec fond transparent pour Windows, Mac et Linux
* copie ou renommage des images à utiliser sur le site web (favicon, ascreen, 130x110)
* correction des chemins d'accès dans les paramètres du projet et ses sources
* mise en place des nouvelles icones dans les paramètres du projet
* mise à jour du package name dans les options de projet
* copie des paramètres depuis l'ancienne version MS pour le déploiement sur Microsoft Store
* paramétrage du certificat de signature Android et de son magasin de clé pour déploiement Android 32 et 64 bits
* ajout des styles d'affichage de l'exemple du starter kit
* ajout des styles d'affichage Polar et Impressive (non disponibles en public)
* copie et personnalisation des fichiers de base du starter kit pour ce projet : icone pour la boite de dialogue "à propos", textes de la licence et de la description du projet, fiche principale, constantes (= paramétrages du programme et du starter kit)
* ajout d'une fenêtre pour les paramétrges du programme (tools / options)
* implémentation de l'option Tools/Options du menu
* ajout des paramètres du projets aux options de configuration
* ajout du paramètre (non stocké) permettant l'affichage ou le masquage des phrases clés et mots de passe
* finalisation de la boite de dialogue pour Outils / Options

* interlude : modification de LogNPass4Delphi pour retirer les dépendances à u_md5 et u_ajax

* création du fichier de stockage des données en JSON (escendant de TJSONDocument du starter kit)
* création d'un module de données utiliser pour migrer les informations des versions précédentes vers la nouvelle au démarrage du programme

* pause repas

* finalisation de la classe de stockage (en mémoire et sur disque) de la nouvelle base de données
* finalisation de la gestion des données de la v1.x
* finalisation du module d'import des anciennes données dans la nouvelle base
* copie et adaptations de l'interface de la version 1.x vers la version 2.x pour avoir des fonctionnalités à l'identique
* vérification des permissions, droits et exceptions d'accès aux URL en http/s

* au démarrage demander à l'utilisateur s'il veut importer les données précédentes si on détecte une base en v1.x
* migration de la base de données SQLite vers un stockage binaire chiffré
* tests du projet pour desktop

* export de la doc développeur avec DocInsight


## à suivre...

* une fois l'import des données effectué demander à l'utilisateur s'il veut supprimer les données précédentes

* ajouter une barre d'outils pour l'utiliser sous iOS et Android
* tests du projet pour mobiles
* captures d'écran pour desktop
* captures d'écran pour mobiles
* mise à jour des fiches de Log'n Pass sur les magasins d'applications
* déploiement et soumission de la version 2.0 - 20250711
