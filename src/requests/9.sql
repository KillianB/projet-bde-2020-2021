/* 
    Consommation d'eau au fil des ans des territoires de projet et cantons
 */

 SELECT volumes_eau.annee, communes_par_territoire.territoire AS territoire_de_projet, communes_par_territoire.canton AS canton, SUM(faits.volume) AS volume_eau
 FROM  admi_49.faits faits,
       admi_49.volumes_eau volumes_eau, 
       admi_49.corresp_canton_territoire corresp_canton_territoire, 
       admi_49.communes_par_territoire communes_par_territoire
 WHERE  faits.id_volume = volumes_eau.id AND
        faits.id_commune = communes_par_territoire.id AND
        volumes_eau.id_territoire = corresp_canton_territoire.id_territoire AND
        communes_par_territoire.canton = corresp_canton_territoire.canton
 GROUP BY ROLLUP(volumes_eau.annee, communes_par_territoire.territoire, communes_par_territoire.canton)