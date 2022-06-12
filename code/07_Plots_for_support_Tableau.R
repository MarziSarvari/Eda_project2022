#Get the world map country border points
library(maps)
library(ggplot2)
world_map <- map_data("world")

#Creat a base plot with gpplot2
p <- ggplot() + coord_fixed() +
  xlab("") + ylab("")

#Add map to base plot
base_world_messy <- p + geom_polygon(data=world_map, aes(x=long, y=lat, group=group), 
                                     colour="light green", fill="light green")
# base_world_messy

#Strip the map down so it looks super clean (and beautiful!)
cleanup <- 
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), 
        panel.background = element_rect(fill = 'white', colour = 'white'), 
        axis.line = element_line(colour = "white"), legend.position="none",
        axis.ticks=element_blank(), axis.text.x=element_blank(),
        axis.text.y=element_blank())
base_world <- base_world_messy + cleanup
# base_world


library(data.table)
getwd()
#setwd('Z:/PRAHA/CZU/CLASES/ZVX114E - Exploratory Data Analysis/project/')

# Loading files
df_station <- fread('./dataPlot/estacions_prom.csv')
df <- fread('./dataPlot/paises_prom.csv')
df$grdc_no <- as.character(df$grdc_no)
df_station$grdc_no <- as.character(df$grdc_no)
colnames(df)[6] <- c('avg')
colnames(df_station)[6] <- c('avg')
str(df)

station3265300 <- fread('./dataPlot/3265300yearly.csv')



# MAP PLOTS:
# Show the mean of period 1970-2000, of the mean value by country.
# The circle's size depends on the average

#Add data points to map with value affecting size
map_data_sized <- 
  base_world +
  geom_point(data=df, 
             aes(x=long, y=lat, size=avg), colour="Deep Pink", 
             fill="Red", pch=21, alpha=I(0.8))

map_data_sized

# The colour of the circle varies from mean value. Darker, lower. Brighter, higher.
# The location in the map is the mean value of the stations.
# It also adds a second layer, fix sized, with the position of the stations.

#Add data points to map with value affecting colour
map_data_coloured <- 
  base_world +
  geom_point(data=df_station, 
             aes(x=long, y=lat), colour="White", 
             fill="Dark Violet", pch=21, size=3, alpha=I(0.5)) + 
  geom_point(data=df, 
             aes(x=long, y=lat, colour=avg), size=5, alpha=I(0.7))

map_data_coloured



# BAR PLOT

# Same information than the map, but in bars

# Basic barplot
p<-ggplot(data=df, aes(x=country, y=avg)) +
  geom_bar(stat="identity", fill="steelblue", width=.8) + 
  #geom_text(aes(label=avg), vjust=-0.3, size=3.5) +
  theme_minimal()
p



