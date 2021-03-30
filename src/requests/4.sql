/*  Nombre moyen d'animaux par cheptel par canton  */

SELECT canton_lib AS CANTON, SUM(valeur) / COUNT(*) AS Moyenne
FROM admi_49.cheptels_par_canton
GROUP BY (canton_lib);
