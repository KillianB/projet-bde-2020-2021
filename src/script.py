import csv



with open('territoires.csv') as csv_file:
    csv_reader = csv.reader(csv_file, delimiter=',')

    cpt = 0
    arrayid = []
    arrayterri = []

    for row in csv_reader:
        arrayid.append(cpt)
        arrayterri.append(row[0])
        cpt +=1

    arrayid.pop(0)
    arrayterri.pop(0)
"""
    for i in range(len(arrayid)):
        print(arrayid[i])
        print(arrayterri[i])
"""

with open('volumes_eau_brute_factures_par_perimetres.csv') as csv_file:
    csv_reader = csv.reader(csv_file, delimiter=',')
    line_count = 0
    index = []

    for row in csv_reader:
        if line_count != 0:

            for i in range(0,len(arrayterri)):
                if(row[1] == arrayterri[i]):
                    #print(row[1])
                    #print("ID : "+ str(arrayid[i]))
                    index.append(arrayid[i])

            #print(f'\t{row[1]} | {row[2]}')
        line_count += 1

for i in range(0,len(index)):
    print(index[i])
