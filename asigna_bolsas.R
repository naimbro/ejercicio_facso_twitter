library(tidyverse)
library(googledrive)

################################################## ASIGNAMOS BOLSAS DE IDs
amigos_candidatos <- read.csv("amigos_candidatos.csv")

amigos_unicos <- unique(amigos_candidatos$user_id)
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

write.csv(bolsas, "bolsas.csv")
