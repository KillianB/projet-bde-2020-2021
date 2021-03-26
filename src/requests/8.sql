/*  Consommation d’eau par taille des exploitations et cheptels */

SELECT V.volume AS ConsoEau, C.ra_3010_dim3_mod AS tailleCheptel, C.n118_mod AS tailleExploitation
FROM admi_49.volumes_eau V, admi_49.cheptels_par_canton C, admi_49.faits F
WHERE C.id = F.id_cheptel, V.id = F.id_volume
GROUP BY ROLLUP(V.volume, C.ra_3010_dim3_mod, C.n118_mod);
