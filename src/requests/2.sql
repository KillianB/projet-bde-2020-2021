/*
    Consommation d’eau par cheptels et nombre d’animaux
 */
 
SELECT EC.canton, id_cheptel, SUM(faits.valeur) AS total_animaux, (SUM(faits.valeur)/AC.total_animaux_canton)*EC.volume_eau AS volume_eau
FROM admi_49.faits faits,
     admi_49.cheptels_par_canton cheptels_par_canton,
     admi_49.volumes_eau volumes_eau,
    (SELECT corresp.canton, SUM(volumes.volume) AS volume_eau
      FROM admi_49.faits faits,
           admi_49.communes_par_territoire communes, 
           admi_49.volumes_eau volumes,
           admi_49.corresp_canton_territoire corresp
      WHERE   faits.id_commune = communes.id AND
              faits.id_volume = volumes.id AND
              volumes.id_territoire = corresp.id_territoire AND
              communes.canton = corresp.canton AND
              volumes.annee IN (SELECT annref
                                FROM admi_49.cheptels_par_canton)
      GROUP BY corresp.canton) EC,
    (SELECT canton_lib, SUM(valeur) AS total_animaux_canton
      FROM admi_49.cheptels_par_canton
      WHERE   ra_3010_dim2_mod <> 4 AND
              ra_3010_dim2_mod <> 5 AND
              ra_3010_dim2_mod <> 6
      GROUP BY canton_lib) AC
WHERE   faits.id_cheptel = cheptels_par_canton.id AND
        faits.id_volume = volumes_eau.id AND
        AC.canton_lib = cheptels_par_canton.canton_lib AND
        AC.canton_lib = EC.canton AND
        faits.ra_3010_dim2_mod <> 4 AND
        faits.ra_3010_dim2_mod <> 5 AND
        faits.ra_3010_dim2_mod <> 6 AND
        cheptels_par_canton.annref = admi_49.volumes_eau.annee
GROUP BY ROLLUP(EC.canton, faits.id_cheptel)
