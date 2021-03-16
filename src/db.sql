-- ****************** SqlDBM: MySQL ******************;
-- ***************************************************;


-- ************************************** `cheptels_par_canton`

CREATE TABLE `cheptels_par_canton`
(
 `id`               int NOT NULL ,
 `nom`              varchar(45) NOT NULL ,
 `annref`           date NOT NULL ,
 `canton`           varchar(45) NOT NULL ,
 `canton_mod`       varchar(45) NOT NULL ,
 `canton_lib`       varchar(45) NULL ,
 `ra_3010_dim2`     varchar(45) NULL ,
 `ra_3010_dim2_mod` integer NULL ,
 `ra_3010_dim2_lib` varchar(45) NULL ,
 `ra_3010_dim3`     varchar(45) NULL ,
 `ra_3010_dim3_mod` integer NULL ,
 `ra_3010_dim3_lib` varchar(45) NULL ,
 `n118`             varchar(45) NULL ,
 `n118_mod`         double NULL ,
 `n118_lib`         varchar(45) NULL ,
 `n027`             varchar(45) NULL ,
 `n027_mod`         double NULL ,
 `n027_lib`         varchar(45) NULL ,
 `valeur`           integer NULL ,
 `qualite`          binary NULL ,

PRIMARY KEY (`id`)
);

-- ****************** SqlDBM: MySQL ******************;
-- ***************************************************;


-- ************************************** `communes_par_territoire`

CREATE TABLE `communes_par_territoire`
(
 `id`          int NOT NULL ,
 `commune`     varchar(45) NOT NULL ,
 `canton`      varchar(45) NOT NULL ,
 `departement` varchar(45) NOT NULL ,
 `territoire`  varchar(45) NOT NULL ,

PRIMARY KEY (`id`)
);


-- ****************** SqlDBM: MySQL ******************;
-- ***************************************************;


-- ************************************** `territoires`

CREATE TABLE `territoires`
(
 `id`            NOT NULL ,
 `territoire_1` varchar(45) NOT NULL ,

PRIMARY KEY (`id`)
);

-- ****************** SqlDBM: MySQL ******************;
-- ***************************************************;


-- ************************************** `corresp_canton_territoire`

CREATE TABLE `corresp_canton_territoire`
(
 `id`            int NOT NULL ,
 `canton`        varchar(45) NOT NULL ,
 `id_territoire`  NOT NULL ,

PRIMARY KEY (`id`),
KEY `fkIdx_155` (`id_territoire`),
CONSTRAINT `FK_154` FOREIGN KEY `fkIdx_155` (`id_territoire`) REFERENCES `territoires` (`id`),
 CONSTRAINT `check_126` CHECK (  )
);



-- ****************** SqlDBM: MySQL ******************;
-- ***************************************************;


-- ************************************** `volumes_eau`

CREATE TABLE `volumes_eau`
(
 `id`            int NOT NULL ,
 `date`          year NOT NULL ,
 `volume`        bigint NOT NULL ,
 `id_territoire`  NOT NULL ,

PRIMARY KEY (`id`),
KEY `fkIdx_150` (`id_territoire`),
CONSTRAINT `FK_149` FOREIGN KEY `fkIdx_150` (`id_territoire`) REFERENCES `territoires` (`id`)
);

-- ****************** SqlDBM: MySQL ******************;
-- ***************************************************;


-- ************************************** `faits`

CREATE TABLE `faits`
(
 `id`               int NOT NULL ,
 `ra_3010_dim2_mod` integer NOT NULL ,
 `ra_3010_dim3_mod` integer NOT NULL ,
 `n118_mod`         integer NOT NULL ,
 `n027_mod`         integer NOT NULL ,
 `valeur`           binary NOT NULL ,
 `id_cheptel`       int NOT NULL ,
 `id_commune`       int NOT NULL ,
 `id_volume`        int NOT NULL ,
 `volume`           bigint NOT NULL ,

PRIMARY KEY (`id`),
KEY `fkIdx_62` (`id_commune`),
CONSTRAINT `FK_61` FOREIGN KEY `fkIdx_62` (`id_commune`) REFERENCES `communes_par_territoire` (`id`),
KEY `fkIdx_69` (`id_volume`),
CONSTRAINT `FK_68` FOREIGN KEY `fkIdx_69` (`id_volume`) REFERENCES `volumes_eau` (`id`),
KEY `fkIdx_76` (`id_cheptel`),
CONSTRAINT `FK_75` FOREIGN KEY `fkIdx_76` (`id_cheptel`) REFERENCES `cheptels_par_canton` (`id`),
 CONSTRAINT `check_41` CHECK ( communes_par_territoire.id )
);






















