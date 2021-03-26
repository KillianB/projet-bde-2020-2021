/*  Nombre d'animaux par canton  */

SELECT C.canton_mod AS CANTON, SUM(C.valeur) AS Indice
FROM admi_49.cheptels_par_canton C, admi_49.faits F
WHERE C.id = F.id_cheptel
GROUP BY C.canton_mod;
