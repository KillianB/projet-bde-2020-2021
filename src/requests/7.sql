-- Nombre d'animaux par taille des exploitations et cheptels
SELECT SUM(c.valeur), C.ra_3010_dim3_mod, C.n118_mod
FROM admi_49.cheptels_par_canton C
GROUP BY ROLLUP(C.ra_3010_dim3_mod, C.n118_mod);
