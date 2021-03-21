/*
    Consommation d’eau par canton, département, territoire
 */

select c.canton, c.departement, c.territoire, f.volume
from communes_par_territoire c, faits f, volumes_eau v, corresp_canton_territoire ct
where f.id_volume = v.id and v.id_territoire = ct.id_territoire and ct.canton = c.canton
group by rollup(c.canton, c.departement, c.territoire)
