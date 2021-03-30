# [projet-bde-2020-2021](Projet.pdf)
- [Sujets Groupes](https://docs.google.com/spreadsheets/d/1ZX-CswW1NIFWn9s-gV5DKwBchOjpcDQpqhAQjUIiJ6s/edit#gid=1291344684)
- [Rapport](https://docs.google.com/document/d/1qAs2G86XRVnyUBwupNOVJjpUF4rhMmKwZRzcSbrI0rE/edit?usp=sharing)

## BDD (Base De Données)
- [Cheptels selon la taille du troupeau par commune (Recensement agricole 2000 et 2010)](https://data.opendatasoft.com/explore/dataset/cheptels%40datacorsica/table/)
    - Deprecated
- [Volumes d'eau brute facturés par territoire de 2003 à 2017 par OEHC](https://data.opendatasoft.com/explore/dataset/volumeseaubrutefacturesparperimetres%40datacorsica/table/?sort=date)
- [Communes par territoire de projet de la Collectivité Territoriale de Corse](https://www.data.corsica/explore/dataset/communes-par-territoire-de-projet-de-la-collectivite-territoriale-de-corse/table/)
- [Cheptels selon la taille du troupeau par canton](https://agreste.agriculture.gouv.fr/agreste-web/disaron/RA_3010/detail/)
    - L'encodage des deux tables ont un encodage UTF-8 particulier (UTF-8 with BOM selon Visual Studio Code) donc on a utilisé Visual Studio Code pour réencoder dans le format UTF-8 standart pour régler les problèmes d'encodage dans le script R. Ces fichiers réencodés sont disponibles [ici](https://drive.google.com/file/d/1Hy-TajWp3s0kbFpUukYEd4NO9NADgHA0/view?usp=sharing)

## Installation du projet

- Récupérer le dépot git
- Pour les csv: (Déjà disponibles dans ./CSVFINAL mais si vous voulez reproduire le processus avec une réduction différentes (50 par table à l'heure actuelle) ou sans réduction, il y a les constantes de réductions individusMax à modifier)
    - Télécharger le 4ème dataset avec le bon format UTF-8 [ici](https://drive.google.com/file/d/1Hy-TajWp3s0kbFpUukYEd4NO9NADgHA0/view?usp=sharing)
    - Executer le script R dans ./src/Main.R (src.Rproj si vous utilisez RStudio):
        - Les scripts sont a sélectionner dans l'ordre suivant:
            - 4ème dataset version 2000 (téléchargé précédemment)
            - 4ème dataset version 2010 (téléchargé précédemment)
            - 3ème dataset: ./csv_volEau_&_communes/communes-par-territoire-de-projet-de-la-collectivite-territoriale-de-corse
            - 2ème dataset: ./csv_volEau_&_communes/volumeseaubrutefacturesparperimetres
        - ./CSVFINAL contient le résultat des modifications sur les datasets 3 et 4
        - ./csv_volEau_&_communes contient le résultat des modifications sur les datasets 2
    - Utiliser le script python pour faire la dernière modification sur ./csv_volEau_&_communes/volumes_eau_brute_factures_par_perimetres dont le résultat sera dans ./CSVFINAL
- Importation dans la BDD:
    - Executer le script ./src/db.sql pour créer les tables dans la BDD
    - Importer les csv dans la BDD dans l'ordre suivant pour remplir les tables:
        - ./CSVFINAL/cheptels_par_cantons.csv
        - ./CSVFINAL/communes_par_territoire_de_projet_de_la_collectivite_territoriale_de_corse.csv
        - ./CSVFINAL/territoires.csv
        - ./CSVFINAL/correspondance_territoire_vol_eau_et_cantons_cheptels.csv
        - ./CSVFINAL/volumes_eau_brute_factures_par_perimetres.csv
        - ./CSVFINAL/faits.csv
- Execution des requêtes que vous souhaitez parmit celles proposées dans ./src/requests sachant que la requête 2 ne fonctionne pas