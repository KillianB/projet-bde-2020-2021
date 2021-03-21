/*  Indice d'élevage par canton  */

SELECT C.canton_mod AS CANTON, SUM(C.valeur) AS Indice
FROM cheptels_par_canton C, faits F
WHERE C.id = F.id_cheptel
GROUP BY C.canton_mod
