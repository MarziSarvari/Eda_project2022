library(data.table)
library(readxl)
library(ggplot2)
library(dplyr)
library(tidyverse)

grdc_selection <- fread('./data/grdc_selection_with_category.csv')
grdc_selection <- subset( grdc_selection, select = -V1 )

grdc_selection[ grdc_selection == "NA" ] <- NA

grdc_selection_without_nas <- na.omit(grdc_selection)
colset_4 <-  c("#D35C37", "#BF9A77", "#D6C6B9", "#97B8C2")


Elevation_Category_mean <- grdc_selection_without_nas[, .(value = mean(MQ)), .(Year, Elevation_Category)]



ggplot(Elevation_Category_mean[Year>1990], aes(x = Year, y = value, col = Elevation_Category)) +
  geom_line(size= 1) +
  xlab(label = "Year") +
  ylab(label = "Runoff (m3/s)")+
  ggtitle("Elevation")


ggplot(Elevation_Category_mean[Year>1990], aes(x = Year, y = value, col = Elevation_Category)) +
  geom_line(size= 1) +
  geom_smooth(method = 'lm', formula = y~x, se = 0, col = colset_4[1]) +
  geom_smooth(method = 'loess', formula = y~x, se = 0, col = colset_4[4]) +
  xlab(label = "Year") +
  ylab(label = "Runoff (m3/s)")+
  ggtitle("Elevation")

ggplot(Elevation_Category_mean[Year>1990], aes(x = Year, y = value, col = Elevation_Category)) +
  geom_smooth(method = 'loess', formula = y~x, se = 0) + 
  scale_color_manual(values = colorRampPalette(colset_4)(5)) +
  ggtitle('Elevation runoff') +
  xlab(label = "Year") +
  ylab(label = "Runoff (m3/s)") +
  theme_bw()

  

ggplot(Elevation_Category_mean[Year>1990], aes(x = Year, y = value, fill = Elevation_Category, group = Year)) +
  geom_boxplot() +
  facet_wrap(~Elevation_Category, scales = 'free') +
  xlab(label = "Year") +
  ylab(label = "Runoff (m3/s)") +
  ggtitle("Elevation Boxplot")+
  theme_bw()


######################################

Lat_Category_mean <- grdc_selection_without_nas[, .(value = mean(MQ)), .(Year, Lat_Category)]

ggplot(Lat_Category_mean[Year>1990], aes(x = Year, y = value, col = Lat_Category)) +
  geom_line(size= 1) +
  xlab(label = "Year") +
  ylab(label = "Runoff (m3/s)")+
  ggtitle("Latitude")


ggplot(Lat_Category_mean[Year>1990], aes(x = Year, y = value, col = Lat_Category)) +
  geom_line(size= 1) +  
  geom_smooth(method = 'lm', formula = y~x, se = 0, col = colset_4[1]) +
  geom_smooth(method = 'loess', formula = y~x, se = 0, col = colset_4[4]) +
  xlab(label = "Year") +
  ylab(label = "Runoff (m3/s)")+
  ggtitle("Latitude")


ggplot(Lat_Category_mean[Year>1990], aes(x = Year, y = value, col = Lat_Category)) +
  geom_smooth(method = 'loess', formula = y~x, se = 0) + 
  scale_color_manual(values = colorRampPalette(colset_4)(5)) +
  ggtitle('Latitude runoff') +
  xlab(label = "Year") +
  ylab(label = "Runoff (m3/s)") +
  theme_bw()



ggplot(Lat_Category_mean[Year>1990], aes(x = Year, y = value, fill = Lat_Category, group = Year)) +
  geom_boxplot() +
  facet_wrap(~Lat_Category, scales = 'free') +
  xlab(label = "Year") +
  ylab(label = "Runoff (m3/s)") +
  ggtitle("Latitude Boxplot")+
  theme_bw()



##########################


Continent_mean <- grdc_selection_without_nas[, .(value = mean(MQ)), .(Year, Continent)]



ggplot(Continent_mean[Year>1990], aes(x = Year, y = value, col = Continent)) +
  geom_line(size= 1) +
  xlab(label = "Year") +
  ylab(label = "Runoff (m3/s)")+
  ggtitle("Elevation")


ggplot(Continent_mean[Year>1990], aes(x = Year, y = value, col = Continent)) +
  geom_line(size= 1) +
  geom_smooth(method = 'lm', formula = y~x, se = 0, col = colset_4[1]) +
  geom_smooth(method = 'loess', formula = y~x, se = 0, col = colset_4[4]) +
  xlab(label = "Year") +
  ylab(label = "Runoff (m3/s)")+
  ggtitle("Elevation")

ggplot(Continent_mean[Year>1990], aes(x = Year, y = value, col = Continent)) +
  geom_smooth(method = 'loess', formula = y~x, se = 0) + 
  scale_color_manual(values = colorRampPalette(colset_4)(6)) +
  ggtitle('Winter runoff') +
  xlab(label = "Year") +
  ylab(label = "Runoff (m3/s)") +
  theme_bw()



