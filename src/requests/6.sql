/*
    Pour chaque canton, ratio moyen de chacun des types d’animaux
 */

SELECT  canton_lib,
        ra_3010_dim2_lib,
        SUM(valeur) AS nb_animaux,
        CAST(SUM(valeur)/(SELECT SUM(valeur)
                          FROM admi_49.cheptels_par_canton
                          WHERE ra_3010_dim2_mod <> 4 AND
                                ra_3010_dim2_mod <> 5 AND
                                ra_3010_dim2_mod <> 6)*100 AS integer) AS pourcentage_animaux
FROM    admi_49.cheptels_par_canton cheptels_par_canton
WHERE   ra_3010_dim2_mod <> 4 AND
        ra_3010_dim2_mod <> 5 AND
        ra_3010_dim2_mod <> 6
GROUP BY CUBE(canton_lib, ra_3010_dim2_lib)