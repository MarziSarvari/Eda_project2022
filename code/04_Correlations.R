library(data.table)
library(readxl)
library(ggplot2)
library(dplyr)
library(tidyverse)

stations_project <- fread('./data/stations_project_reference_with_category.csv')
stations_project <- subset( stations_project, select = -V1 )

stations_project[ stations_project == "NA" ] <- NA

stations_project_without_nas <- na.omit(stations_project)


colset_4 <-  c("#D35C37", "#BF9A77", "#D6C6B9", "#97B8C2")
theme_set(theme_bw())

for_cor_mat_area <- stations_project_without_nas[, c('lta_discharge', 'area')]
cor(for_cor_mat_area)

for_cor_mat_alt <- stations_project_without_nas[, c('lta_discharge', 'altitude')]
cor(for_cor_mat_alt)

for_cor_mat_lat <- stations_project_without_nas[, c('lta_discharge', 'lat')]
cor(for_cor_mat_lat)


for_cor_mat_lat <- stations_project_without_nas[, c('r_volume_yr', 'lat')]
cor(for_cor_mat_lat)


ggplot(stations_project_without_nas, aes(x = r_height_yr, y = altitude, col = Lat_Category, cex = Catchment_Size)) +
  geom_point(alpha = 4/10) +
  scale_color_manual(values = colorRampPalette(colset_4)(4)) +
  ylab(label = "Altitude") +
  xlab(label = "Runoff (m3/s)") +
  ggtitle("Altitude_Catchmentsize_Runoff")
  theme_bw()

