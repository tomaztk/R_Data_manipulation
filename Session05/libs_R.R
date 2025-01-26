setw()

library(dplyr)

pcks_4_install <- c("ggplot2", "RGL", "leaflet", "Plotly")
install.packages(pcks_4_install)
lapply(pcks_4_install, require, character.only = TRUE)