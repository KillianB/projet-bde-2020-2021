-- ****************** SqlDBM: MySQL ******************;
-- ***************************************************;


-- ************************************** `cheptels_par_commune`

CREATE TABLE `cheptels_par_commune`
(
 `id`               int NOT NULL ,
 `NOM`              varchar(45) NOT NULL ,
 `ANNREF`           date NOT NULL ,
 `CANTON`           varchar(45) NOT NULL ,
 `CANTON_MOD`       varchar(45) NOT NULL ,
 `CANTON_LIB`       varchar(45) NULL ,
 `RA_3010_DIM2`     varchar(45) NULL ,
 `RA_3010_DIM2_MOD` integer NULL ,
 `RA_3010_DIM2_LIB` varchar(45) NULL ,
 `RA_3010_DIM3`     varchar(45) NULL ,
 `RA_3010_DIM3_MOD` integer NULL ,
 `RA_3010_DIM3_LIB` varchar(45) NULL ,
 `N118`             varchar(45) NULL ,
 `N118_MOD`         double NULL ,
 `N118_LIB`         varchar(45) NULL ,
 `N027`             varchar(45) NULL ,
 `N027_MOD`         double NULL ,
 `N027_LIB`         varchar(45) NULL ,
 `VALEUR`           integer NULL ,
 `QUALITE`          binary NULL ,

PRIMARY KEY (`id`)
);

-- ****************** SqlDBM: MySQL ******************;
-- ***************************************************;


-- ************************************** `communes_par_territoire`

CREATE TABLE `communes_par_territoire`
(
 `id`          int NOT NULL ,
 `commune`     linestring NOT NULL ,
 `canton`      linestring NOT NULL ,
 `departement` linestring NOT NULL ,
 `territoire`  linestring NOT NULL ,

PRIMARY KEY (`id`)
);

-- ****************** SqlDBM: MySQL ******************;
-- ***************************************************;


-- ************************************** `volumes_eau`

CREATE TABLE `volumes_eau`
(
 `id`         int NOT NULL ,
 `date`       year NOT NULL ,
 `territoire` linestring NOT NULL ,
 `volume`     bigint NOT NULL ,

PRIMARY KEY (`id`)
);

-- ****************** SqlDBM: MySQL ******************;
-- ***************************************************;


-- ************************************** `faits`

CREATE TABLE `faits`
(
 `id`               int NOT NULL ,
 `RA_3010_DIM2_MOD` integer NOT NULL ,
 `RA_3010_DIM3_MOD` integer NOT NULL ,
 `N118_MOD`         integer NOT NULL ,
 `N027_MOD`         integer NOT NULL ,
 `VALEUR`           binary NOT NULL ,
 `cheptels`         int NOT NULL ,
 `communes`         int NOT NULL ,
 `volumes`          int NOT NULL ,
 `volume`           bigint NOT NULL ,

PRIMARY KEY (`id`),
KEY `fkIdx_62` (`communes`),
CONSTRAINT `FK_61` FOREIGN KEY `fkIdx_62` (`communes`) REFERENCES `communes_par_territoire` (`id`),
KEY `fkIdx_69` (`volumes`),
CONSTRAINT `FK_68` FOREIGN KEY `fkIdx_69` (`volumes`) REFERENCES `volumes_eau` (`id`),
KEY `fkIdx_76` (`cheptels`),
CONSTRAINT `FK_75` FOREIGN KEY `fkIdx_76` (`cheptels`) REFERENCES `cheptels_par_commune` (`id`),
 CONSTRAINT `check_41` CHECK ( communes_par_territoire.id )
);


