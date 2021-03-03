-- ****************** SqlDBM: MySQL ******************;
-- ***************************************************;


-- ************************************** `cheptels_par_commune`

CREATE TABLE `cheptels_par_commune`
(
 `id`                  int NOT NULL ,
 `departement`         linestring NOT NULL ,
 `commune`             linestring NOT NULL ,
 `date`                year NOT NULL ,
 `classement`          linestring NOT NULL ,
 `total_bovins`        int NULL ,
 `total_vaches`        int NULL ,
 `vaches_laitieres`    int NULL ,
 `vaches_allaitantes`  int NULL ,
 `bovins_plus_un_an`   int NULL ,
 `bovins_moins_un_an`  int NULL ,
 `chevres`             int NULL ,
 `brebis_nourrices`    int NULL ,
 `brebis_laitieres`    int NULL ,
 `total_porcins`       int NULL ,
 `truies_reprod_50_kg` int NULL ,
 `poulets`             int NULL ,

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


-- ************************************** `faits`

CREATE TABLE `faits`
(
 `id`                       int NOT NULL ,
 `commune`                  int NULL ,
 `volume`                   int NULL ,
 `cheptel`                  int NULL ,
 `total_bovins`             int NULL ,
 `total_vaches`             int NULL ,
 `vaches_laitieres`         int NULL ,
 `vaches_allaitantes`       int NULL ,
 `bovins_plus_un_an`        int NULL ,
 `bovins_moins_un_an`       int NULL ,
 `chevres`                  int NULL ,
 `brebis_nourrices`         int NULL ,
 `brebis_laitieres`         int NULL ,
 `total_porcins`            int NULL ,
 `truies_reprod_plus_50_kg` int NULL ,
 `poulets`                  int NULL ,
 `volume_1`                 int NULL ,
 `col_92`                   int NULL ,
 `col_93`                    NULL ,

PRIMARY KEY (`id`),
KEY `fkIdx_62` (`commune`),
CONSTRAINT `FK_61` FOREIGN KEY `fkIdx_62` (`commune`) REFERENCES `communes_par_territoire` (`id`),
KEY `fkIdx_69` (`volume`),
CONSTRAINT `FK_68` FOREIGN KEY `fkIdx_69` (`volume`) REFERENCES `volumes_eau` (`id`),
KEY `fkIdx_76` (`cheptel`),
CONSTRAINT `FK_75` FOREIGN KEY `fkIdx_76` (`cheptel`) REFERENCES `cheptels_par_commune` (`id`),
 CONSTRAINT `check_41` CHECK ( communes_par_territoire.id )
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



















