import csv

#Recuperation des noms de territoires et de leurs id
with open('../../CSVFINAL/territoires.csv') as csv_file:
    csv_reader = csv.reader(csv_file, delimiter=',')

    cpt = 0
    arrayid = []
    arrayterri = []

    for row in csv_reader:
        arrayid.append(cpt)
        arrayterri.append(row[1])
        cpt +=1

    #Suppression des nom de colonnes (ligne 0)
    arrayid.pop(0)
    arrayterri.pop(0)

#Ouverture du fichier CSV a modifier
with open('../../csv_volEau_&_communes/volumes_eau_brute_factures_par_perimetres.csv') as csv_file:
    csv_reader = csv.reader(csv_file, delimiter=',')
    line_count = 0

    #Indexs correspondant aux noms de territoires
    index = []
    #Rows du nouveau csv
    new_rows = []

    #On parcourt toutes les rows du fichier a modifier
    for row in csv_reader:
        if line_count != 0:     #Si la row n'est pas un nom de colonne

            #Recuperation de l'index correspondant au nom de territoire de la row
            for i in range(0,len(arrayterri)):
                if(row[2] == arrayterri[i]):
                    index.append(arrayid[i])

            #Ajout de la row contenant un id_terrioire au lieu d'un nom_territoire
            size = len(index)
            new_rows.append([str(row[0]),str(row[1]),str(index[size-1]),str(row[3])])
        line_count += 1


    #Affichage des nouvelles rows
    #for i in range(0,len(new_rows)):
        #print(new_rows[i])

#Construction du nouveau fichier
with open('../../CSVFINAL/volumes_eau_brute_factures_par_perimetres.csv','w') as csv_file:
    csv_writer = csv.writer(csv_file, delimiter=',')
    csv_writer.writerows([['id', 'date', 'territoire', 'volume_eau_brute']])
    csv_writer.writerows(new_rows)
