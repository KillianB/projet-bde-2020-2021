-- ****************** SqlDBM: MySQL ******************;
-- ***************************************************;

-- Suppression avant (re)création

DROP TABLE cheptels_par_canton CASCADE CONSTRAINTS;
DROP TABLE communes_par_territoire CASCADE CONSTRAINTS;
DROP TABLE territoires CASCADE CONSTRAINTS;
DROP TABLE corresp_canton_territoire CASCADE CONSTRAINTS;
DROP TABLE volumes_eau CASCADE CONSTRAINTS;
DROP TABLE faits CASCADE CONSTRAINTS;

-- ************************************** cheptels_par_canton

CREATE TABLE cheptels_par_canton
(
    id               integer      NOT NULL,
    nom              varchar(100) NOT NULL,
    annref           integer      NOT NULL,
    canton           varchar(100) NOT NULL,
    canton_mod       varchar(100) NOT NULL,
    canton_lib       varchar(100) NULL,
    ra_3010_dim2     varchar(100) NULL,
    ra_3010_dim2_mod integer NULL,
    ra_3010_dim2_lib varchar(100) NULL,
    ra_3010_dim3     varchar(100) NULL,
    ra_3010_dim3_mod integer NULL,
    ra_3010_dim3_lib varchar(100) NULL,
    n118             varchar(100) NULL,
    n118_mod         number(10) NULL,
    n118_lib         varchar(100) NULL,
    n027             varchar(100) NULL,
    n027_mod         integer NULL,
    n027_lib         varchar(100) NULL,
    valeur           integer NULL,
    qualite          varchar(3) NULL,

    CONSTRAINT cheptels_par_canton_pk PRIMARY KEY (id)
);

-- ****************** SqlDBM: MySQL ******************;
-- ***************************************************;


-- ************************************** communes_par_territoire

CREATE TABLE communes_par_territoire
(
    id          integer      NOT NULL,
    commune     varchar(100) NOT NULL,
    canton      varchar(100) NOT NULL,
    departement varchar(100) NOT NULL,
    territoire  varchar(100) NOT NULL,

    CONSTRAINT communes_par_territoire_pk PRIMARY KEY (id)
);


-- ****************** SqlDBM: MySQL ******************;
-- ***************************************************;


-- ************************************** territoires

CREATE TABLE territoires
(
    id           integer      NOT NULL,
    territoire_1 varchar(100) NOT NULL,

    CONSTRAINT territoires_pk PRIMARY KEY (id)
);

-- ****************** SqlDBM: MySQL ******************;
-- ***************************************************;


-- ************************************** corresp_canton_territoire

CREATE TABLE corresp_canton_territoire
(
    id            integer      NOT NULL,
    canton        varchar(100) NOT NULL,
    id_territoire integer      NOT NULL,

    CONSTRAINT corresp_canton_territoire_pk PRIMARY KEY (id),
    CONSTRAINT fk_territoires_1 FOREIGN KEY (id_territoire) REFERENCES territoires (id)
);



-- ****************** SqlDBM: MySQL ******************;
-- ***************************************************;


-- ************************************** volumes_eau

CREATE TABLE volumes_eau
(
    id            integer NOT NULL,
    annee         integer NOT NULL,
    volume        integer NOT NULL,
    id_territoire integer NOT NULL,

    CONSTRAINT volumes_eau_pk PRIMARY KEY (id),
    CONSTRAINT fk_territoires_2 FOREIGN KEY (id_territoire) REFERENCES territoires (id)
);

-- ****************** SqlDBM: MySQL ******************;
-- ***************************************************;


-- ************************************** faits

CREATE TABLE faits
(
    id               integer NOT NULL,
    ra_3010_dim2_mod integer NOT NULL,
    ra_3010_dim3_mod integer NOT NULL,
    n118_mod         number(10) NOT NULL,
    n027_mod         integer NOT NULL,
    valeur           integer NOT NULL,
    id_cheptel       integer NOT NULL,
    id_commune       integer NOT NULL,
    id_volume        integer NOT NULL,
    volume           integer NOT NULL,

    CONSTRAINT faits_pk PRIMARY KEY (id),
    CONSTRAINT fk_communes_par_territoire FOREIGN KEY (id_commune) REFERENCES communes_par_territoire (id),
    CONSTRAINT fk_volumes_eau FOREIGN KEY (id_volume) REFERENCES volumes_eau (id),
    CONSTRAINT fk_cheptels_par_canton FOREIGN KEY (id_cheptel) REFERENCES cheptels_par_canton (id)
);






















