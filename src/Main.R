
################################################################################
#                                   Fonctions                                  #
################################################################################

is.Corse <- function(x) {
  return(!is.na(x) && nchar(x) > 1 && (substr(x, 1, 2) == "2A" || substr(x, 1, 2) == "2B"))
}

################################################################################
#                            Importation des données                           #
################################################################################

# FDS_G_2141.2010 <- read.csv(file.choose(), header = T, dec = ",", sep = ";", na.strings = "............")
FDS_RA_3010.2000 <- read.csv(file.choose(), header = T, dec = ".", sep = ";", na.strings = "")
FDS_RA_3010.2010 <- read.csv(file.choose(), header = T, dec = ".", sep = ";", na.strings = "")

################################################################################
#                                Formatage 2000                                #
################################################################################

variable <- FDS_RA_3010.2000["CANTON_MOD"]
variable.is.Corse <- apply(variable, 1, is.Corse)
res <- variable$CANTON_MOD[variable.is.Corse]

FDS_RA_3010.2000.reduit <- data.frame(
  "ANNREF" = FDS_RA_3010.2000$ANNREF[variable.is.Corse],
  "CANTON" = FDS_RA_3010.2000$CANTON[variable.is.Corse],
  "CANTON_MOD" = FDS_RA_3010.2000$CANTON_MOD[variable.is.Corse],
  "CANTON_LIB" = FDS_RA_3010.2000$CANTON_LIB[variable.is.Corse],
  "RA_3010_DIM2" = FDS_RA_3010.2000$RA_3010_DIM2[variable.is.Corse],
  "RA_3010_DIM2_MOD" = FDS_RA_3010.2000$RA_3010_DIM2_MOD[variable.is.Corse],
  "RA_3010_DIM2_LIB" = FDS_RA_3010.2000$RA_3010_DIM2_LIB[variable.is.Corse],
  "RA_3010_DIM3" = FDS_RA_3010.2000$RA_3010_DIM3[variable.is.Corse],
  "RA_3010_DIM3_MOD" = FDS_RA_3010.2000$RA_3010_DIM3_MOD[variable.is.Corse],
  "RA_3010_DIM3_LIB" = FDS_RA_3010.2000$RA_3010_DIM3_LIB[variable.is.Corse],
  "N118" = FDS_RA_3010.2000$N118[variable.is.Corse],
  "N118_MOD" = FDS_RA_3010.2000$N118_MOD[variable.is.Corse],
  "N118_LIB" = FDS_RA_3010.2000$N118_LIB[variable.is.Corse],
  "N027" = FDS_RA_3010.2000$N027[variable.is.Corse],
  "N027_MOD" = FDS_RA_3010.2000$N027_MOD[variable.is.Corse],
  "N027_LIB" = FDS_RA_3010.2000$N027_LIB[variable.is.Corse],
  "VALEUR" = FDS_RA_3010.2000$VALEUR[variable.is.Corse],
  "QUALITE" = FDS_RA_3010.2000$QUALITE[variable.is.Corse],
  "ï..NOM" = FDS_RA_3010.2000$ï..NOM[variable.is.Corse]
)

summary(FDS_RA_3010.2000.reduit)

write.csv(FDS_RA_3010.2000.reduit, file="..\\csv_cheptel_2000_2010_corse\\FDS_RA_3010_2000_reduit.csv", row.names = FALSE)

FDS_RA_3010.2000.reduit.omit <- na.omit(FDS_RA_3010.2000.reduit)
summary(FDS_RA_3010.2000.reduit.omit)

write.csv(FDS_RA_3010.2010.reduit, file="..\\csv_cheptel_2000_2010_corse\\FDS_RA_3010_2000_reduit_omit.csv", row.names = FALSE)

################################################################################
#                                Formatage 2010                                #
################################################################################

variable <- FDS_RA_3010.2010["CANTON_MOD"]
variable.is.Corse <- apply(variable, 1, is.Corse)
res <- variable$CANTON_MOD[variable.is.Corse]


FDS_RA_3010.2010.reduit <- data.frame(
  "ANNREF" = FDS_RA_3010.2010$ANNREF[variable.is.Corse],
  "CANTON" = FDS_RA_3010.2010$CANTON[variable.is.Corse],
  "CANTON_MOD" = FDS_RA_3010.2010$CANTON_MOD[variable.is.Corse],
  "CANTON_LIB" = FDS_RA_3010.2010$CANTON_LIB[variable.is.Corse],
  "RA_3010_DIM2" = FDS_RA_3010.2010$RA_3010_DIM2[variable.is.Corse],
  "RA_3010_DIM2_MOD" = FDS_RA_3010.2010$RA_3010_DIM2_MOD[variable.is.Corse],
  "RA_3010_DIM2_LIB" = FDS_RA_3010.2010$RA_3010_DIM2_LIB[variable.is.Corse],
  "RA_3010_DIM3" = FDS_RA_3010.2010$RA_3010_DIM3[variable.is.Corse],
  "RA_3010_DIM3_MOD" = FDS_RA_3010.2010$RA_3010_DIM3_MOD[variable.is.Corse],
  "RA_3010_DIM3_LIB" = FDS_RA_3010.2010$RA_3010_DIM3_LIB[variable.is.Corse],
  "N118" = FDS_RA_3010.2010$N118[variable.is.Corse],
  "N118_MOD" = FDS_RA_3010.2010$N118_MOD[variable.is.Corse],
  "N118_LIB" = FDS_RA_3010.2010$N118_LIB[variable.is.Corse],
  "N027" = FDS_RA_3010.2010$N027[variable.is.Corse],
  "N027_MOD" = FDS_RA_3010.2010$N027_MOD[variable.is.Corse],
  "N027_LIB" = FDS_RA_3010.2010$N027_LIB[variable.is.Corse],
  "VALEUR" = FDS_RA_3010.2010$VALEUR[variable.is.Corse],
  "QUALITE" = FDS_RA_3010.2010$QUALITE[variable.is.Corse],
  "ï..NOM" = FDS_RA_3010.2010$ï..NOM[variable.is.Corse]
)

summary(FDS_RA_3010.2010.reduit)

write.csv(FDS_RA_3010.2010.reduit, file="..\\csv_cheptel_2000_2010_corse\\FDS_RA_3010_2010_reduit.csv", row.names = FALSE)

FDS_RA_3010.2010.reduit.omit <- na.omit(FDS_RA_3010.2010.reduit)
summary(FDS_RA_3010.2010.reduit.omit)

write.csv(FDS_RA_3010.2010.reduit, file="..\\csv_cheptel_2000_2010_corse\\FDS_RA_3010_2010_reduit_omit.csv", row.names = FALSE)