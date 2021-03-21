/* 
    Consommation d'eau au fil des ans des territoires de projet et cantons
 */

 SELECT communes_par_territoire.territoire AS territoire_de_projet, communes_par_territoire.canton AS canton, GROUPING(volumes_eau.date), SUM(faits.volume) AS volume_eau
 FROM faits, volumes_eau, corresp_canton_territoire, communes_par_territoire
 WHERE  faits.id_volume = volumes_eau.id AND
        faits.id_commune = communes_par_territoire.id AND
        volumes_eau.id_territoire = corresp_canton_territoire.id_territoire AND
        communes_par_territoire.canton = corresp_canton_territoire.canton
 GROUP BY ROLLUP(communes_par_territoire.territoire, communes_par_territoire.canton)