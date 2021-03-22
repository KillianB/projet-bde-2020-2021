-- Nombre d'animaux par taille des exploitations et cheptels

SELECT f.valeur AS animaux, c.ra_3010_dim3_mod AS tailleCheptel, c.n118_mod AS tailleExploitation
FROM faits f, cheptels_par_canton c 
WHERE c.id = f.id_cheptel
GROUP BY ROLLUP(tailleCheptel, tailleExploitation)
