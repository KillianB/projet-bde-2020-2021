/*
    Pour chaque canton, ratio moyen de chacun des types d’animaux
 */

SELECT  canton_lib,
        ra_3010_dim2_lib,
        SUM(valeur) AS nb_animaux,
        CAST(SUM(valeur)/(SELECT COUNT(*) AS total_cheptels FROM cheptels_par_canton)*100 AS integer) AS pourcentage_animaux
FROM    admi_49.cheptels_par_canton cheptels_par_canton
GROUP BY CUBE(canton_lib, ra_3010_dim2_lib)