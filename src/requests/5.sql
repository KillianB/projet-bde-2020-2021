/*
    Nombre d’animaux différentes par territoire, département
 */

select c.territoire, c.departement, sum(f.valeur) as nbr
from communes_par_territoire c, cheptels_par_canton ch, faits f
where f.id_commune = c.id and f.id_canton = c.id and c.canton = ch.canton and
        f.ra_3010_dim2_mod <> 4 and
        f.ra_3010_dim2_mod <> 5 and
        f.ra_3010_dim2_mod <> 6 and
        f.n118_mod = 0
group by rollup(c.territoire, c.departement)
