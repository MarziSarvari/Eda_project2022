library(data.table)
library(readxl)
library(ggplot2)


stations_project <- read_excel('./data/stations_project.xlsx')
station_numbers <- stations_project$grdc_no

grdc_selection <- fread('./data/grdc_selection.csv')

grdc_based_on_stations_project <- grdc_selection[grdc_selection$ID %in% station_numbers ,]
# temp <- unique(grdc_reduction, by = "ID")  //// 67
# temp2 <- unique(grdc_selection, by = "ID")  ////696

reduced_Unique_ids <- unique(grdc_based_on_stations_project, by = "ID")


ggplot(data = grdc_based_on_stations_project, aes(x = Year)) +
  geom_line(aes( y = MQ), color ="black") +
  geom_line(aes( y = HQ), color ="red") +
  geom_line(aes( y = LQ), color ="blue") +
  facet_wrap(~Station) + 
  theme_bw()


ggplot(data = grdc_based_on_stations_project, aes(x = Lon, y = Alt)) +
  geom_point() +
  geom_text(label = grdc_based_on_stations_project$Station) +
  theme_bw()


grdc_based_on_stations_project[, value_MQ_norm := (MQ - mean(MQ)) / sd(MQ), by = Station]

colset <-  c("#D35C37", "#BF9A77", "#D6C6B9", "#97B8C2")

library(tidyverse)
grdc_based_on_stations_project_withoutNA <- grdc_based_on_stations_project %>% drop_na("value_MQ_norm")
n_stations <- nrow(unique(grdc_based_on_stations_project_withoutNA, by = "ID"))

ggplot(grdc_based_on_stations_project_withoutNA[Year > 1990], aes(x = Year, y = value_MQ_norm, col = Station)) +
  geom_line() +
  geom_point() + 
  scale_color_manual(values = colorRampPalette(colset)(n_stations)) +
  theme_bw()


ggplot(grdc_based_on_stations_project_withoutNA[Year < 1990], aes(x = Year, y = value_MQ_norm, col = Station)) +
  geom_line() +
  geom_point() + 
  scale_color_manual(values = colorRampPalette(colset)(n_stations)) +
  theme_bw()

ggplot(grdc_based_on_stations_project_withoutNA, aes(x = Year, y = value_MQ_norm, col = Station)) +
  geom_line() +
  geom_point() + 
  scale_color_manual(values = colorRampPalette(colset)(n_stations)) +
  theme_bw()

ggplot(grdc_based_on_stations_project_withoutNA[Alt < 100], aes(x = Year, y = value_MQ_norm, col = Station)) +
  geom_line() +
  geom_point() + 
  scale_color_manual(values = colorRampPalette(colset)(n_stations)) +
  theme_bw()

ggplot(grdc_based_on_stations_project_withoutNA, aes(x = Year, y = value_MQ_norm, col = Continent)) +
  geom_line() +
  geom_point() + 
  scale_color_manual(values = colorRampPalette(colset)(n_stations)) +
  theme_bw()

