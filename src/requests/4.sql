/*  Indice du taux d'élevage par canton  */

SELECT C.canton_mod AS CANTON, SUM(C.ra_3010_dim3_mod) / COUNT(*) AS Taux
FROM cheptels_par_canton C, faits F
WHERE C.id = F.id_cheptel
GROUP BY C.canton_mod
