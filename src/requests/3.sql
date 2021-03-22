-- Consommation d'eau par année et nombre d'animaux
SELECT f.volume, v.date, SUM(faits.valeur) as total_animaux
FROM faits f, volumes_eau v, cheptels_par_canton c
WHERE f.id_volume = v.id 
    AND f.id_cheptel = c.id
    AND c.annref = v.date
GROUP BY ROLLUP(v.daten, total_animaux);