library(data.table)
library(readxl)


move_related_stations_to_new_position <- function(DataTable_stations, DataTable_continents, folder_name) {
  i=0
  names_sub_month <- list()
  names_sub_day <- list()
  
  for (val in DataTable_stations)
  {
    i= i+1
    temp = DataTable_continents[like(names,val)]
    if (nrow(temp) != 0)
    {
      names_sub_day[[paste0("station", i)]] <- temp$names[1]
      names_sub_month[[paste0("station", i)]] <- temp$names[2]
    }
    
  }
  for (val in names_sub_day)
  {
    f= paste('./data/grdc_raw/',folder_name,sep='')
    fr = paste(f,'/',sep = '')
    t = paste('./data/Selected_stations_raw_data/',folder_name, sep = '')
    t2 = paste(t,'/Days/',sep = '')
    file.copy(from = paste(fr,val,sep=""),
              to   = paste(t2,val,sep=""))
  }
  for (val in names_sub_month)
  {
    f= paste('./data/grdc_raw/',folder_name,sep='')
    fr = paste(f,'/',sep = '')
    t = paste('./data/Selected_stations_raw_data/',folder_name, sep = '')
    t2 = paste(t,'/Months/',sep = '')
    file.copy(from = paste(fr,val,sep=""),
              to   = paste(t2,val,sep=""))
  }
}

selected_stations <- read_excel('./data/stations_project.xlsx')

station_numbers <- selected_stations$grdc_no

names <- list.files(path="./data/grdc_raw/Africa", pattern=NULL, all.files=FALSE, full.names=FALSE)
names_table <-as.data.table(names)
move_related_stations_to_new_position(station_numbers,names_table, 'Africa')

names <- list.files(path="./data/grdc_raw/Asia", pattern=NULL, all.files=FALSE, full.names=FALSE)
names_table <-as.data.table(names)
move_related_stations_to_new_position(station_numbers,names_table, 'Asia')

names <- list.files(path="./data/grdc_raw/Europe", pattern=NULL, all.files=FALSE, full.names=FALSE)
names_table <-as.data.table(names)
move_related_stations_to_new_position(station_numbers,names_table, 'Europe')

names <- list.files(path="./data/grdc_raw/North&CentralAmerica", pattern=NULL, all.files=FALSE, full.names=FALSE)
names_table <-as.data.table(names)
move_related_stations_to_new_position(station_numbers,names_table, 'North&CentralAmerica')

names <- list.files(path="./data/grdc_raw/SouthAmerica", pattern=NULL, all.files=FALSE, full.names=FALSE)
names_table <-as.data.table(names)
move_related_stations_to_new_position(station_numbers,names_table, 'SouthAmerica')

names <- list.files(path="./data/grdc_raw/South-WestPacific", pattern=NULL, all.files=FALSE, full.names=FALSE)
names_table <-as.data.table(names)
move_related_stations_to_new_position(station_numbers,names_table, 'South-WestPacific')




