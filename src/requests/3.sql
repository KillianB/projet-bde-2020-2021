-- Consommation d'eau par animal et par an
SELECT annref,((SUM(f.volume))/(SUM(f.valeur))) as "eau par animal"
FROM admi_49.faits f, ADMI_49.cheptels_par_canton c
WHERE f.id_cheptel = c.id
GROUP BY annref;
