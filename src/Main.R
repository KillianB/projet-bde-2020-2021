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
#                                  Constantes                                  #
################################################################################

# valeurs sentinelles: valeurs négatives
individusMax <- c(25, # Cheptels par canton (2000): Doit être un entier positif pair
                  25, # Cheptels par canton (2010): Doit être un entier positif pair
                  50, # Communes par territoire de projets: Doit être un entier positif
                  50) # Volumes d'eau par territoire: Doit être un entier positif

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

write.csv(FDS_RA_3010.2000.reduit.omit, file="..\\csv_cheptel_2000_2010_corse\\FDS_RA_3010_2000_reduit_omit.csv", row.names = FALSE, fileEncoding = "UTF-8")

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

write.csv(FDS_RA_3010.2010.reduit.omit, file="..\\csv_cheptel_2000_2010_corse\\FDS_RA_3010_2010_reduit_omit.csv", row.names = FALSE, fileEncoding = "UTF-8")

################################################################################
#                     Cheptels par cantons (2000 + 2010)                       #
################################################################################

individus <- c(0, 0)
# 2000
if (individusMax[1] > 0) {
  individus[1] <- individusMax[1]
} else {
  individus[1] <- length(FDS_RA_3010.2000.reduit.omit$nom)
}
# 2010
if (individusMax[2] > 0) {
  individus[2] <- individusMax[2]
} else {
  individus[2] <- length(FDS_RA_3010.2010.reduit.omit$nom)
}

cheptels_par_cantons <- data.frame(
  "id" = 1:length(c(FDS_RA_3010.2000.reduit.omit$nom[1:individus[1]], FDS_RA_3010.2010.reduit.omit$nom[1:individus[2]])),
  "nom" = c(FDS_RA_3010.2000.reduit.omit$nom[1:individus[1]], FDS_RA_3010.2010.reduit.omit$nom[1:individus[2]]),
  "annref" = c(FDS_RA_3010.2000.reduit.omit$annref[1:individus[1]], FDS_RA_3010.2010.reduit.omit$annref[1:individus[2]]),
  "canton" = c(FDS_RA_3010.2000.reduit.omit$canton[1:individus[1]], FDS_RA_3010.2010.reduit.omit$canton[1:individus[2]]),
  "canton_mod" = c(FDS_RA_3010.2000.reduit.omit$canton_mod[1:individus[1]], FDS_RA_3010.2010.reduit.omit$canton_mod[1:individus[2]]),
  "canton_lib" = c(FDS_RA_3010.2000.reduit.omit$canton_lib[1:individus[1]], FDS_RA_3010.2010.reduit.omit$canton_lib[1:individus[2]]),
  "ra_3010_dim2" = c(FDS_RA_3010.2000.reduit.omit$ra_3010_dim2[1:individus[1]], FDS_RA_3010.2010.reduit.omit$ra_3010_dim2[1:individus[2]]),
  "ra_3010_dim2_mod" = c(FDS_RA_3010.2000.reduit.omit$ra_3010_dim2_mod[1:individus[1]], FDS_RA_3010.2010.reduit.omit$ra_3010_dim2_mod[1:individus[2]]),
  "ra_3010_dim2_lib" = c(FDS_RA_3010.2000.reduit.omit$ra_3010_dim2_lib[1:individus[1]], FDS_RA_3010.2010.reduit.omit$ra_3010_dim2_lib[1:individus[2]]),
  "ra_3010_dim3" = c(FDS_RA_3010.2000.reduit.omit$ra_3010_dim3[1:individus[1]], FDS_RA_3010.2010.reduit.omit$ra_3010_dim3[1:individus[2]]),
  "ra_3010_dim3_mod" = c(FDS_RA_3010.2000.reduit.omit$ra_3010_dim3_mod[1:individus[1]], FDS_RA_3010.2010.reduit.omit$ra_3010_dim3_mod[1:individus[2]]),
  "ra_3010_dim3_lib" = c(FDS_RA_3010.2000.reduit.omit$ra_3010_dim3_lib[1:individus[1]], FDS_RA_3010.2010.reduit.omit$ra_3010_dim3_lib[1:individus[2]]),
  "n118" = c(FDS_RA_3010.2000.reduit.omit$n118[1:individus[1]], FDS_RA_3010.2010.reduit.omit$n118[1:individus[2]]),
  "n118_mod" = c(FDS_RA_3010.2000.reduit.omit$n118_mod[1:individus[1]], FDS_RA_3010.2010.reduit.omit$n118_mod[1:individus[2]]),
  "n118_lib" = c(FDS_RA_3010.2000.reduit.omit$n118_lib[1:individus[1]], FDS_RA_3010.2010.reduit.omit$n118_lib[1:individus[2]]),
  "n027" = c(FDS_RA_3010.2000.reduit.omit$n027[1:individus[1]], FDS_RA_3010.2010.reduit.omit$n027[1:individus[2]]),
  "n027_mod" = c(FDS_RA_3010.2000.reduit.omit$n027_mod[1:individus[1]], FDS_RA_3010.2010.reduit.omit$n027_mod[1:individus[2]]),
  "n027_lib" = c(FDS_RA_3010.2000.reduit.omit$n027_lib[1:individus[1]], FDS_RA_3010.2010.reduit.omit$n027_lib[1:individus[2]]),
  "valeur" = c(FDS_RA_3010.2000.reduit.omit$valeur[1:individus[1]], FDS_RA_3010.2010.reduit.omit$valeur[1:individus[2]]),
  "qualite" = c(FDS_RA_3010.2000.reduit.omit$qualite[1:individus[1]], FDS_RA_3010.2010.reduit.omit$qualite[1:individus[2]])
)

summary(cheptels_par_cantons)

write.csv(cheptels_par_cantons, file="..\\CSVFINAL\\cheptels_par_cantons.csv", row.names = FALSE, fileEncoding = "UTF-8")

################################################################################
#                           Communes par territoire                            #
################################################################################

if (individusMax[2] > 0) {
  individus <- individusMax[2]
} else {
  individus <- length(communes_par_territoire_de_projet_de_la_collectivite_territoriale_de_corse$Commune)
}
communes_par_territoire_de_projet_de_la_collectivite_territoriale_de_corse.lowerCase <- data.frame(
  "id" = 1:individus,
  "commune" = format.text(communes_par_territoire_de_projet_de_la_collectivite_territoriale_de_corse$Commune[1:individus]),
  "canton" = format.text(communes_par_territoire_de_projet_de_la_collectivite_territoriale_de_corse$Canton[1:individus]),
  "departement" = format.text(communes_par_territoire_de_projet_de_la_collectivite_territoriale_de_corse$Département[1:individus]),
  "territoire_de_projet" = format.text(communes_par_territoire_de_projet_de_la_collectivite_territoriale_de_corse$Territoire.de.projet[1:individus])
)

write.csv(communes_par_territoire_de_projet_de_la_collectivite_territoriale_de_corse.lowerCase, file="..\\CSVFINAL\\communes_par_territoire_de_projet_de_la_collectivite_territoriale_de_corse.csv", row.names = FALSE, fileEncoding = "UTF-8")

################################################################################
#                                Volumes d'eau                                 #
################################################################################

if (individusMax[3] > 0) {
  individus <- individusMax[3]
} else {
  individus <- length(volumeseaubrutefacturesparperimetres$Date)
}
volumeseaubrutefacturesparperimetres.lowerCase = data.frame(
  "id" = 1:individus,
  "date" = volumeseaubrutefacturesparperimetres$Date[1:individus],
  "territoire" = format.text(volumeseaubrutefacturesparperimetres$Territoire[1:individus]),
  "volume_eau_brute" = volumeseaubrutefacturesparperimetres$Volume.Eau.Brute[1:individus]
)

write.csv(volumeseaubrutefacturesparperimetres.lowerCase, file="..\\csv_volEau_&_communes\\volumes_eau_brute_factures_par_perimetres.csv", row.names = FALSE, fileEncoding = "UTF-8")

################################################################################
#                              Tables des faits                                #
################################################################################

# Combinaison (cheptels, communes)
n <- length(communes_par_territoire_de_projet_de_la_collectivite_territoriale_de_corse.lowerCase$id)
faits.id_cheptel <- rep.int(cheptels_par_cantons$id, n)
faits.ra_3010_dim2_mod <- rep.int(cheptels_par_cantons$ra_3010_dim2_mod, n)
faits.ra_3010_dim3_mod <- rep.int(cheptels_par_cantons$ra_3010_dim3_mod, n)
faits.n118_mod <- rep.int(cheptels_par_cantons$n118_mod, n)
faits.n027_mod <- rep.int(cheptels_par_cantons$n027_mod, n)
faits.valeur <- rep.int(cheptels_par_cantons$valeur, n)
faits.id_commune <- c()

n <- length(cheptels_par_cantons$id)
for (id_commune in communes_par_territoire_de_projet_de_la_collectivite_territoriale_de_corse.lowerCase$id) {
  faits.id_commune <- append(faits.id_commune, rep.int(id_commune, n))
}

# Combinaison ((cheptels, communes), volumes)
n <- length(volumeseaubrutefacturesparperimetres.lowerCase$id)
faits.id_cheptel <- rep.int(faits.id_cheptel, n)
faits.ra_3010_dim2_mod <- rep.int(faits.ra_3010_dim2_mod, n)
faits.ra_3010_dim3_mod <- rep.int(faits.ra_3010_dim3_mod, n)
faits.n118_mod <- rep.int(faits.n118_mod, n)
faits.n027_mod <- rep.int(faits.n027_mod, n)
faits.valeur <- rep.int(faits.valeur, n)
faits.id_commune <- rep.int(faits.id_commune, n)
faits.id_volume <- c()
faits.volume <- c()

n <- length(cheptels_par_cantons$id) * length(communes_par_territoire_de_projet_de_la_collectivite_territoriale_de_corse.lowerCase$id)
for (id_volume in volumeseaubrutefacturesparperimetres.lowerCase$id) {
  faits.id_volume <- append(faits.id_volume, rep.int(id_volume, n))
}

for (volume in volumeseaubrutefacturesparperimetres.lowerCase$volume_eau_brute) {
  faits.volume <- append(faits.volume, rep.int(volume, n))
}

faits <- data.frame(
  "id" = 1:length(faits.id_cheptel),
  "id_cheptel" = faits.id_cheptel,
  "id_commune" = faits.id_commune,
  "id_volume" = faits.id_volume,
  "ra_3010_dim2_mod" = faits.ra_3010_dim2_mod,
  "ra_3010_dim3_mod" = faits.ra_3010_dim3_mod,
  "n118_mod" = faits.n118_mod,
  "n027_mod" = faits.n027_mod,
  "valeur" = faits.valeur,
  "volume" = faits.volume
)

summary(faits)

write.csv(faits, file="..\\CSVFINAL\\faits.csv", row.names = FALSE, fileEncoding = "UTF-8")
