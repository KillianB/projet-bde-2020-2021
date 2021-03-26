/*  Consommation d’eau par taille des exploitations et cheptels */

SELECT SUM(F.volume), C.ra_3010_dim3_mod, C.n118_mod
FROM admi_49.volumes_eau V, admi_49.cheptels_par_canton C, admi_49.faits F, admi_49.corresp_canton_territoire CT
WHERE V.id = F.id_volume AND V.id_territoire = CT.id_territoire AND CT.canton = C.canton
GROUP BY ROLLUP(C.ra_3010_dim3_mod, C.n118_mod);
