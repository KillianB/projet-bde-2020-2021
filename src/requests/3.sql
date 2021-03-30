-- Consommation d'eau par année et nombre d'animaux
SELECT  c.annref,
  (SUM(v.volume)/(SUM(c.valeur))) AS eau_par_animal
FROM admi_49.faits f, admi_49.volumes_eau v, admi_49.cheptels_par_canton c
WHERE f.id_volume = v.id 
    AND f.id_cheptel = c.id
    AND c.annref = v.annee
GROUP BY ROLLUP(c.annref);
