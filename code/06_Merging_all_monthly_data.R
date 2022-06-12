library(data.table)
library(readxl)
library(stringr)

merge_each_continent_monthly_data <- function(raw_path, station_numbers,continent_name) {
  names <- list.files(path=raw_path, pattern=NULL, all.files=FALSE, full.names=FALSE)
  file_names <- as.data.table(names)
  grdc_names_table <-as.data.table(names%>% str_replace("_Q_Month.txt", ""))
  runoff_monthly <- data.frame()
  runoff_monthly <- as.data.table(runoff_monthly)
  
  n_station <- nrow(grdc_names_table)
  for(file_count in 1:n_station){
    temp_dt <- fread(paste0(raw_path, file_names[file_count]))
    station_id <- substr(grdc_names_table[file_count], 1, n_station)
    temp_dt <- cbind(id = factor(station_id), temp_dt)
    #temp_dt <- id_sname[temp_dt, on = 'Station_Id', ]
    runoff_monthly <- rbind(runoff_monthly, temp_dt)
  }
  
  runoff_monthly <- runoff_monthly[ , (c(3)) := NULL ]
  runoff_monthly[, Continent := factor(continent_name)]
  
  names(runoff_monthly)[2] <- c("date")
  runoff_monthly[ runoff_monthly == -999.000 ] <- NA
  runoff_monthly <- na.omit(runoff_monthly)
  
}


selected_stations <- read_excel('./data/stations_project.xlsx')
station_numbers <- selected_stations$grdc_no

raw_path <- './data/Selected_stations_raw_data/Africa/Months/'
africa_data <- merge_each_continent_monthly_data(raw_path, station_numbers,'AF')

# raw_path <- './data/Selected_stations_raw_data/Asia/Months/'
# asia_data <- merge_each_continent_monthly_data(raw_path, station_numbers,'AS')
#no data for Asia

raw_path <- './data/Selected_stations_raw_data/Europe/Months/'
europe_data <- merge_each_continent_monthly_data(raw_path, station_numbers, 'EU')

raw_path <- './data/Selected_stations_raw_data/NorthCentralAmerica/Months/'
NorthCentralAmerica_data <- merge_each_continent_monthly_data(raw_path, station_numbers, 'NAm')

raw_path <- './data/Selected_stations_raw_data/SouthAmerica/Months/'
SouthAmerica_data <- merge_each_continent_monthly_data(raw_path, station_numbers, 'SA')

raw_path <- './data/Selected_stations_raw_data/SouthWestPacific/Months/'
SoutWestPacific_data <- merge_each_continent_monthly_data(raw_path, station_numbers, 'SWPacific')

runoff_month_raw <- rbind(africa_data, europe_data, NorthCentralAmerica_data, SouthAmerica_data, SoutWestPacific_data)
runoff_month_raw[, Date := as.Date(date)]
runoff_month_raw <- runoff_month_raw[ , (c(2)) := NULL ]


write.csv(runoff_month_raw ,"./data/runoff_month_raw.csv", row.names = TRUE)

runoff_month_raw[, year := year(Date)]
runoff_month_raw[, month := month(Date)]

runoff_year <- runoff_month_raw[, .(value = mean(Calculated)), by = .(year, id, Continent)]

# library(ggplot2)
# ggplot(runoff_year[year>1990], aes(x = year, y = value, col = Continent)) +
#   geom_smooth(method = 'loess', formula = y~x, se = 0) + 
#   ggtitle('Continent runoff') +
#   xlab(label = "Year") +
#   ylab(label = "Runoff (m3/s)") +
#   theme_bw()

runoff_month_raw[month == 12 | month == 1 | month == 2, season := 'winter']
runoff_month_raw[month == 3 | month == 4 | month == 5, season := 'spring']
runoff_month_raw[month == 6 | month == 7 | month == 8, season := 'summer']
runoff_month_raw[month == 9 | month == 10 | month == 11, season := 'autumn']
runoff_month_raw[, season := factor(season, levels = c('winter', 'spring', 'summer', 'autumn'))]

runoff_year_season <- runoff_month_raw[, .(value = mean(Calculated)), by = .(year, id, Continent,season)]
write.csv(runoff_year_season ,"./data/runoff_seasonal.csv", row.names = TRUE)


