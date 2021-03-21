/*
    Consommation d’eau par cheptels et nombre d’animaux
 */
 
SELECT canton, id_cheptel, SUM(faits.valeur) AS total_animaux, ((SUM(faits.valeur)/AC.total_animaux_canton)*EC.volume_eau) AS volume_eau
FROM faits, cheptels_par_canton,
    (SELECT canton, SUM(faits.valeur) AS total_animaux_canton
    FROM faits, cheptels_par_canton
    WHERE   faits.id = cheptels_par_canton.id_cheptel AND
            ra_3010_dim2_mod <> 4 AND
            ra_3010_dim2_mod <> 5 AND
            ra_3010_dim2_mod <> 6
    GROUP BY canton) AS AC,
    (SELECT communes_par_territoire.canton AS canton, SUM(faits.volume) AS volume_eau
    FROM faits, communes_par_territoire, volumes_eau, corresp_canton_territoire
    WHERE   faits.id_commune = communes_par_territoire.id AND
            faits.id_volume = volumes_eau.id AND
            volumes_eau.id_territoire = corresp_canton_territoire.id_territoire AND
            communes_par_territoire.canton = corresp_canton_territoire.canton AND
            volumes_eau.date IN (SELECT DISTINCT annref
                                FROM cheptels_par_canton)
    GROUP BY communes_par_territoire.canton) AS EC
WHERE   faits.id = cheptels_par_canton.id_cheptel AND
        AC.canton = cheptels_par_canton.canton AND
        AC.canton = EC.canton AND
        ra_3010_dim2_mod <> 4 AND
        ra_3010_dim2_mod <> 5 AND
        ra_3010_dim2_mod <> 6 AND
        cheptels_par_canton.annref = volume_eau.date
GROUP BY ROLLUP(canton, id_cheptel)