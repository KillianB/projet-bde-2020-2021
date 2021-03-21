/*
    Pour chaque canton, ratio moyen de chacun des types d’animaux
 */

SELECT canton, ra_3010_dim2_mod, ra_3010_dim2_lib, SUM(valeur) AS nb_animaux, SUM(valeur)/total_cheptels AS ratio_animaux
FROM    cheptels_par_canton,
        (SELECT COUNT(*) AS total_cheptels
        FROM cheptels_par_canton)
GROUP BY CUBE(canton, ra_3010_dim2_mod)