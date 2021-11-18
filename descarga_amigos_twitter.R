library(igraph)
library(rtweet)
library(tidyverse)
library(googledrive)

################################################## DESCARGA AMIGOS DE CANDIDATES
safely_get_friends <- safely(get_friends)
candidatos <- c("gabrielboric", "joseantoniokast", "ProvosteYasna", "sebastiansichel", "marcoporchile", "artes_oficial", "Parisi_oficial")
amigos_candidatos <- safely_get_friends(candidatos, retryonratelimit = TRUE)
head(amigos_candidatos$result)

################################################## ASIGNAMOS BOLSAS DE IDs
amigos_unicos <- unique(amigos_candidatos$result$user_id)
length(amigos_unicos)

drive_download(as_id('https://docs.google.com/spreadsheets/d/1Y9J0MiOc0340Hpfrwz2PCAKb6xPbZYNsan_76Ft5tj8/edit?usp=sharing'), 'bolsas_twitter.csv', overwrite = TRUE)
bolsas_twitter <- read.csv("bolsas_twitter.csv")
bolsas_twitter

n_bolsas <- length(bolsas_twitter$persona)
bolsas <- split(amigos_unicos, cut(seq_along(amigos_unicos), n_bolsas, labels = FALSE))
print(paste(length(bolsas[[1]])/60, "horas por persona"))

names(bolsas) <- bolsas_twitter$persona
bolsas <- lapply(bolsas, function(ids_twitter) as.data.frame(ids_twitter))
bolsas <- bind_rows(bolsas, .id = "asignacion")
names(bolsas)

################################################## DESCARGA AMIGOS DE AMIGOS

mi_bolsa <- bolsas$ids_twitter[bolsas$asignacion == "naim_bro"]
amigos_de_amigos <- safely_get_friends(mi_bolsa, retryonratelimit = TRUE)

