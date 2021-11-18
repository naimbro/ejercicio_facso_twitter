library(rtweet)
library(tidyverse)
library(glue)

################################################## DESCARGA AMIGOS DE AMIGOS
bolsas <- read.csv("bolsas.csv")

# extraer los miles de IDs
tu_nombre <- "naim_bro"
mi_bolsa <- bolsas$ids_twitter[bolsas$asignacion == tu_nombre]
mis_amigos_de_amigos <- safely_get_friends(mi_bolsa, retryonratelimit = TRUE)

# guardar en carpeta "datos"
ruta <- glue("datos/amigos_{tu_nombre}.csv")
write.csv(mis_amigos_de_amigos$result, ruta)