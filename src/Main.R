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

is.ensemble <- function(x) {
  return(x==1)
}

is.cheptel <- function(x) {
  return(x==40)
}

# solution from https://stackoverflow.com/questions/26393341/r-delete-accents-in-string
# begin
rm_accent <- function(str,pattern="all") {
  if(!is.character(str))
    str <- as.character(str)
  
  pattern <- unique(pattern)
  
  if(any(pattern=="Ç"))
    pattern[pattern=="Ç"] <- "ç"
  
  symbols <- c(
    acute = "áéíóúÁÉÍÓÚýÝ",
    grave = "àèìòùÀÈÌÒÙ",
    circunflex = "âêîôûÂÊÎÔÛ",
    tilde = "ãõÃÕñÑ",
    umlaut = "äëïöüÄËÏÖÜÿ",
    cedil = "çÇ"
  )
  
  nudeSymbols <- c(
    acute = "aeiouAEIOUyY",
    grave = "aeiouAEIOU",
    circunflex = "aeiouAEIOU",
    tilde = "aoAOnN",
    umlaut = "aeiouAEIOUy",
    cedil = "cC"
  )
  
  accentTypes <- c("´","`","^","~","¨","ç")
  
  if(any(c("all","al","a","todos","t","to","tod","todo")%in%pattern)) # opcao retirar todos
    return(chartr(paste(symbols, collapse=""), paste(nudeSymbols, collapse=""), str))
  
  for(i in which(accentTypes%in%pattern))
    str <- chartr(symbols[i],nudeSymbols[i], str) 
  
  return(str)
}
# end

format.text <- function(x) {
  return(lowerCase(rm_accent(x)))
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

# Que les lignes de la Corse
variable.canton.mod <- FDS_RA_3010.2000["CANTON_MOD"]
variable.is.Corse <- apply(variable.canton.mod, 1, is.Corse)
res <- FDS_RA_3010.2000["CANTON_LIB"]
res <- apply(res, 1, remove.digit.Corse)
# Que les ensembles
variable.dim3.mod <- FDS_RA_3010.2000["RA_3010_DIM3_MOD"]
variable.is.ensemble <- apply(variable.dim3.mod, 1, is.ensemble)
# Que les cheptels
variable.dim3.mod <- FDS_RA_3010.2000["N027_MOD"]
variable.is.cheptel <- apply(variable.dim3.mod, 1, is.cheptel)
# List de filtrage
variable.filter <- (variable.is.cheptel + variable.is.ensemble + variable.is.Corse) == 3

FDS_RA_3010.2000.reduit <- data.frame(
  "nom" = format.text(FDS_RA_3010.2010$NOM[variable.filter]),
  "annref" = FDS_RA_3010.2000$ANNREF[variable.filter],
  "canton" = format.text(FDS_RA_3010.2000$CANTON[variable.filter]),
  "canton_mod" = format.text(FDS_RA_3010.2000$CANTON_MOD[variable.filter]),
  "canton_lib" = format.text(res[variable.filter]),
  "ra_3010_dim2" = format.text(FDS_RA_3010.2000$RA_3010_DIM2[variable.filter]),
  "ra_3010_dim2_mod" = FDS_RA_3010.2000$RA_3010_DIM2_MOD[variable.filter],
  "ra_3010_dim2_lib" = format.text(FDS_RA_3010.2000$RA_3010_DIM2_LIB[variable.filter]),
  "ra_3010_dim3" = format.text(FDS_RA_3010.2000$RA_3010_DIM3[variable.filter]),
  "ra_3010_dim3_mod" = FDS_RA_3010.2000$RA_3010_DIM3_MOD[variable.filter],
  "ra_3010_dim3_lib" = format.text(FDS_RA_3010.2000$RA_3010_DIM3_LIB[variable.filter]),
  "n118" = format.text(FDS_RA_3010.2000$N118[variable.filter]),
  "n118_mod" = FDS_RA_3010.2000$N118_MOD[variable.filter],
  "n118_lib" = format.text(FDS_RA_3010.2000$N118_LIB[variable.filter]),
  "n027" = format.text(FDS_RA_3010.2000$N027[variable.filter]),
  "n027_mod" = FDS_RA_3010.2000$N027_MOD[variable.filter],
  "n027_lib" = format.text(FDS_RA_3010.2000$N027_LIB[variable.filter]),
  "valeur" = FDS_RA_3010.2000$VALEUR[variable.filter],
  "qualite" = format.text(FDS_RA_3010.2000$QUALITE[variable.filter])
)

# changement de l'année pouravoir une correspondance avec la table volume d'eau
FDS_RA_3010.2000.reduit$annref <- (FDS_RA_3010.2000.reduit$annref + 3)

summary(FDS_RA_3010.2000.reduit)

write.csv(FDS_RA_3010.2000.reduit, file="..\\csv_cheptel_2000_2010_corse\\FDS_RA_3010_2000_reduit.csv", row.names = FALSE, fileEncoding = "UTF-8")

FDS_RA_3010.2000.reduit.omit <- na.omit(FDS_RA_3010.2000.reduit)
summary(FDS_RA_3010.2000.reduit.omit)

write.csv(FDS_RA_3010.2000.reduit.omit, file="..\\CSVFINAL\\FDS_RA_3010_2000_reduit_omit.csv", row.names = FALSE, fileEncoding = "UTF-8")

################################################################################
#                                Formatage 2010                                #
################################################################################

# Que les lignes de la Corse
variable.canton.mod <- FDS_RA_3010.2010["CANTON_MOD"]
variable.is.Corse <- apply(variable.canton.mod, 1, is.Corse)
res <- FDS_RA_3010.2010["CANTON_LIB"]
res <- apply(res, 1, remove.digit.Corse)
# Que les ensembles
variable.dim3.mod <- FDS_RA_3010.2010["RA_3010_DIM3_MOD"]
variable.is.ensemble <- apply(variable.dim3.mod, 1, is.ensemble)
# Que les cheptels
variable.dim3.mod <- FDS_RA_3010.2010["N027_MOD"]
variable.is.cheptel <- apply(variable.dim3.mod, 1, is.cheptel)
# List de filtrage
variable.filter <- (variable.is.cheptel + variable.is.ensemble + variable.is.Corse) == 3

FDS_RA_3010.2010.reduit <- data.frame(
  "nom" = format.text(FDS_RA_3010.2010$NOM[variable.filter]),
  "annref" = FDS_RA_3010.2010$ANNREF[variable.filter],
  "canton" = format.text(FDS_RA_3010.2010$CANTON[variable.filter]),
  "canton_mod" = format.text(FDS_RA_3010.2010$CANTON_MOD[variable.filter]),
  "canton_lib" = format.text(res[variable.filter]),
  "ra_3010_dim2" = format.text(FDS_RA_3010.2010$RA_3010_DIM2[variable.filter]),
  "ra_3010_dim2_mod" = FDS_RA_3010.2010$RA_3010_DIM2_MOD[variable.filter],
  "ra_3010_dim2_lib" = format.text(FDS_RA_3010.2010$RA_3010_DIM2_LIB[variable.filter]),
  "ra_3010_dim3" = format.text(FDS_RA_3010.2010$RA_3010_DIM3[variable.filter]),
  "ra_3010_dim3_mod" = FDS_RA_3010.2010$RA_3010_DIM3_MOD[variable.filter],
  "ra_3010_dim3_lib" = format.text(FDS_RA_3010.2010$RA_3010_DIM3_LIB[variable.filter]),
  "n118" = format.text(FDS_RA_3010.2010$N118[variable.filter]),
  "n118_mod" = FDS_RA_3010.2010$N118_MOD[variable.filter],
  "n118_lib" = format.text(FDS_RA_3010.2010$N118_LIB[variable.filter]),
  "n027" = format.text(FDS_RA_3010.2010$N027[variable.filter]),
  "n027_mod" = FDS_RA_3010.2010$N027_MOD[variable.filter],
  "n027_lib" = format.text(FDS_RA_3010.2010$N027_LIB[variable.filter]),
  "valeur" = FDS_RA_3010.2010$VALEUR[variable.filter],
  "qualite" = format.text(FDS_RA_3010.2010$QUALITE[variable.filter])
)

summary(FDS_RA_3010.2010.reduit)

write.csv(FDS_RA_3010.2010.reduit, file="..\\csv_cheptel_2000_2010_corse\\FDS_RA_3010_2010_reduit.csv", row.names = FALSE, fileEncoding = "UTF-8")

FDS_RA_3010.2010.reduit.omit <- na.omit(FDS_RA_3010.2010.reduit)
summary(FDS_RA_3010.2010.reduit.omit)

write.csv(FDS_RA_3010.2010.reduit.omit, file="..\\CSVFINAL\\FDS_RA_3010_2010_reduit_omit.csv", row.names = FALSE, fileEncoding = "UTF-8")

################################################################################
#                           Communes par territoire                            #
################################################################################

communes_par_territoire_de_projet_de_la_collectivite_territoriale_de_corse.lowerCase <- data.frame(
  "commune" = format.text(communes_par_territoire_de_projet_de_la_collectivite_territoriale_de_corse$Commune),
  "canton" = format.text(communes_par_territoire_de_projet_de_la_collectivite_territoriale_de_corse$Canton),
  "departement" = format.text(communes_par_territoire_de_projet_de_la_collectivite_territoriale_de_corse$Département),
  "territoire_de_projet" = format.text(communes_par_territoire_de_projet_de_la_collectivite_territoriale_de_corse$Territoire.de.projet)
)

write.csv(communes_par_territoire_de_projet_de_la_collectivite_territoriale_de_corse.lowerCase, file="..\\CSVFINAL\\communes_par_territoire_de_projet_de_la_collectivite_territoriale_de_corse.csv", row.names = FALSE, fileEncoding = "UTF-8")

################################################################################
#                                Volumes d'eau                                 #
################################################################################

volumeseaubrutefacturesparperimetres.lowerCase = data.frame(
  "date" = volumeseaubrutefacturesparperimetres$Date,
  "territoire" = format.text(volumeseaubrutefacturesparperimetres$Territoire),
  "volume_eau_brute" = volumeseaubrutefacturesparperimetres$Volume.Eau.Brute
)

write.csv(volumeseaubrutefacturesparperimetres.lowerCase, file="..\\csv_volEau_&_communes\\volumes_eau_brute_factures_par_perimetres.csv", row.names = FALSE, fileEncoding = "UTF-8")