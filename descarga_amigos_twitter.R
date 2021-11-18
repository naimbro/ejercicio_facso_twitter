library(rtweet)
library(tidyverse)

################################################## DESCARGA AMIGOS DE CANDIDATES
safely_get_friends <- safely(get_friends)
candidatos <- c("gabrielboric", "joseantoniokast", "ProvosteYasna", "sebastiansichel", "marcoporchile", "artes_oficial", "Parisi_oficial")
amigos_candidatos <- safely_get_friends(candidatos, retryonratelimit = TRUE)
head(amigos_candidatos$result)

write.csv(amigos_candidatos$result, "amigos_candidatos.csv")