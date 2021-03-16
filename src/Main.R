################################################################################
#                                 Bibliothèques                                #
################################################################################

library(splus2R)

################################################################################
#                                   Fonctions                                  #
################################################################################

is.Corse <- function(x) {
  return(!is.na(x) && nchar(x) > 1 && (substr(x, 1, 2) == "2A" || substr(x, 1, 2) == "2B"))
}

remove.digit.Corse <- function(x) {
  return(substr(x, 8, nchar(x)))
}

################################################################################
#                            Importation des données                           #
################################################################################

FDS_RA_3010.2000 <- read.csv(file.choose(), header = T, dec = ".", sep = ";", na.strings = "", encoding = "UTF-8")
FDS_RA_3010.2010 <- read.csv(file.choose(), header = T, dec = ".", sep = ";", na.strings = "", encoding = "UTF-8")
communes_par_territoire_de_projet_de_la_collectivite_territoriale_de_corse <- read.csv(file.choose(), header = T, sep = ";", encoding = "UTF-8")
volumeseaubrutefacturesparperimetres <- read.csv(file.choose(), header = T, sep = ";", encoding = "UTF-8")

################################################################################
#                                Formatage 2000                                #
################################################################################

variable <- FDS_RA_3010.2000["CANTON_MOD"]
variable.is.Corse <- apply(variable, 1, is.Corse)
res <- FDS_RA_3010.2000["CANTON_LIB"]
res <- apply(res, 1, remove.digit.Corse)

FDS_RA_3010.2000.reduit <- data.frame(
  "NOM" = lowerCase(FDS_RA_3010.2010$NOM[variable.is.Corse]),
  "ANNREF" = FDS_RA_3010.2000$ANNREF[variable.is.Corse],
  "CANTON" = lowerCase(FDS_RA_3010.2000$CANTON[variable.is.Corse]),
  "CANTON_MOD" = lowerCase(FDS_RA_3010.2000$CANTON_MOD[variable.is.Corse]),
  "CANTON_LIB" = lowerCase(res[variable.is.Corse]),
  "RA_3010_DIM2" = lowerCase(FDS_RA_3010.2000$RA_3010_DIM2[variable.is.Corse]),
  "RA_3010_DIM2_MOD" = FDS_RA_3010.2000$RA_3010_DIM2_MOD[variable.is.Corse],
  "RA_3010_DIM2_LIB" = lowerCase(FDS_RA_3010.2000$RA_3010_DIM2_LIB[variable.is.Corse]),
  "RA_3010_DIM3" = lowerCase(FDS_RA_3010.2000$RA_3010_DIM3[variable.is.Corse]),
  "RA_3010_DIM3_MOD" = FDS_RA_3010.2000$RA_3010_DIM3_MOD[variable.is.Corse],
  "RA_3010_DIM3_LIB" = lowerCase(FDS_RA_3010.2000$RA_3010_DIM3_LIB[variable.is.Corse]),
  "N118" = lowerCase(FDS_RA_3010.2000$N118[variable.is.Corse]),
  "N118_MOD" = FDS_RA_3010.2000$N118_MOD[variable.is.Corse],
  "N118_LIB" = lowerCase(FDS_RA_3010.2000$N118_LIB[variable.is.Corse]),
  "N027" = lowerCase(FDS_RA_3010.2000$N027[variable.is.Corse]),
  "N027_MOD" = FDS_RA_3010.2000$N027_MOD[variable.is.Corse],
  "N027_LIB" = lowerCase(FDS_RA_3010.2000$N027_LIB[variable.is.Corse]),
  "VALEUR" = FDS_RA_3010.2000$VALEUR[variable.is.Corse],
  "QUALITE" = lowerCase(FDS_RA_3010.2000$QUALITE[variable.is.Corse])
)

summary(FDS_RA_3010.2000.reduit)

write.csv(FDS_RA_3010.2000.reduit, file="..\\csv_cheptel_2000_2010_corse\\FDS_RA_3010_2000_reduit.csv", row.names = FALSE, fileEncoding = "UTF-8")

FDS_RA_3010.2000.reduit.omit <- na.omit(FDS_RA_3010.2000.reduit)
summary(FDS_RA_3010.2000.reduit.omit)

write.csv(FDS_RA_3010.2000.reduit.omit, file="..\\csv_cheptel_2000_2010_corse\\FDS_RA_3010_2000_reduit_omit.csv", row.names = FALSE, fileEncoding = "UTF-8")

################################################################################
#                                Formatage 2010                                #
################################################################################

variable <- FDS_RA_3010.2010["CANTON_MOD"]
variable.is.Corse <- apply(variable, 1, is.Corse)
res <- FDS_RA_3010.2010["CANTON_LIB"]
res <- apply(res, 1, remove.digit.Corse)

FDS_RA_3010.2010.reduit <- data.frame(
  "NOM" = lowerCase(FDS_RA_3010.2010$NOM[variable.is.Corse]),
  "ANNREF" = FDS_RA_3010.2010$ANNREF[variable.is.Corse],
  "CANTON" = lowerCase(FDS_RA_3010.2010$CANTON[variable.is.Corse]),
  "CANTON_MOD" = lowerCase(FDS_RA_3010.2010$CANTON_MOD[variable.is.Corse]),
  "CANTON_LIB" = lowerCase(res[variable.is.Corse]),
  "RA_3010_DIM2" = lowerCase(FDS_RA_3010.2010$RA_3010_DIM2[variable.is.Corse]),
  "RA_3010_DIM2_MOD" = FDS_RA_3010.2010$RA_3010_DIM2_MOD[variable.is.Corse],
  "RA_3010_DIM2_LIB" = lowerCase(FDS_RA_3010.2010$RA_3010_DIM2_LIB[variable.is.Corse]),
  "RA_3010_DIM3" = lowerCase(FDS_RA_3010.2010$RA_3010_DIM3[variable.is.Corse]),
  "RA_3010_DIM3_MOD" = FDS_RA_3010.2010$RA_3010_DIM3_MOD[variable.is.Corse],
  "RA_3010_DIM3_LIB" = lowerCase(FDS_RA_3010.2010$RA_3010_DIM3_LIB[variable.is.Corse]),
  "N118" = lowerCase(FDS_RA_3010.2010$N118[variable.is.Corse]),
  "N118_MOD" = FDS_RA_3010.2010$N118_MOD[variable.is.Corse],
  "N118_LIB" = lowerCase(FDS_RA_3010.2010$N118_LIB[variable.is.Corse]),
  "N027" = lowerCase(FDS_RA_3010.2010$N027[variable.is.Corse]),
  "N027_MOD" = FDS_RA_3010.2010$N027_MOD[variable.is.Corse],
  "N027_LIB" = lowerCase(FDS_RA_3010.2010$N027_LIB[variable.is.Corse]),
  "VALEUR" = FDS_RA_3010.2010$VALEUR[variable.is.Corse],
  "QUALITE" = lowerCase(FDS_RA_3010.2010$QUALITE[variable.is.Corse])
)

summary(FDS_RA_3010.2010.reduit)

write.csv(FDS_RA_3010.2010.reduit, file="..\\csv_cheptel_2000_2010_corse\\FDS_RA_3010_2010_reduit.csv", row.names = FALSE, fileEncoding = "UTF-8")

FDS_RA_3010.2010.reduit.omit <- na.omit(FDS_RA_3010.2010.reduit)
summary(FDS_RA_3010.2010.reduit.omit)

write.csv(FDS_RA_3010.2010.reduit.omit, file="..\\csv_cheptel_2000_2010_corse\\FDS_RA_3010_2010_reduit_omit.csv", row.names = FALSE, fileEncoding = "UTF-8")

################################################################################
#                           Communes par territoire                            #
################################################################################

communes_par_territoire_de_projet_de_la_collectivite_territoriale_de_corse$Commune <- lowerCase(communes_par_territoire_de_projet_de_la_collectivite_territoriale_de_corse$Commune)
communes_par_territoire_de_projet_de_la_collectivite_territoriale_de_corse$Canton <- lowerCase(communes_par_territoire_de_projet_de_la_collectivite_territoriale_de_corse$Canton)
communes_par_territoire_de_projet_de_la_collectivite_territoriale_de_corse$Département <- lowerCase(communes_par_territoire_de_projet_de_la_collectivite_territoriale_de_corse$Département)
communes_par_territoire_de_projet_de_la_collectivite_territoriale_de_corse$Territoire.de.projet <- lowerCase(communes_par_territoire_de_projet_de_la_collectivite_territoriale_de_corse$Territoire.de.projet)

write.csv(communes_par_territoire_de_projet_de_la_collectivite_territoriale_de_corse, file="..\\csv_volEau_&_communes\\communes_par_territoire_de_projet_de_la_collectivite_territoriale_de_corse.csv", row.names = FALSE, fileEncoding = "UTF-8")

################################################################################
#                                Volumes d'eau                                 #
################################################################################

volumeseaubrutefacturesparperimetres$Territoire <- lowerCase(volumeseaubrutefacturesparperimetres$Territoire)

write.csv(volumeseaubrutefacturesparperimetres, file="..\\csv_volEau_&_communes\\volumes_eau_brute_factures_par_perimetres.csv", row.names = FALSE, fileEncoding = "UTF-8")