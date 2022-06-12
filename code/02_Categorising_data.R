library(data.table)
library(readxl)
library(ggplot2)

grdc_selection <- fread('./data/grdc_selection.csv')


grdc_selection[, Lat_Category := factor('NA')]
grdc_selection[Lat < -66, Lat_Category := factor('Southest')]
grdc_selection[-66 <Lat & Lat< -23 , Lat_Category := factor('South_medium')]
grdc_selection[-23 <Lat & Lat< 23 , Lat_Category := factor('Tropical')]
grdc_selection[23 <Lat & Lat< 65 , Lat_Category := factor('North_medium')]
grdc_selection[Lat >= 65 , Lat_Category := factor('Northest')]



grdc_selection[, Elevation_Category := factor('NA')]
grdc_selection[Alt >= 0 & Alt < 10, Elevation_Category := factor('< 10')]
grdc_selection[Alt >= 10 & Alt < 100, Elevation_Category := factor('10_100')]
grdc_selection[Alt >= 100 & Alt < 500, Elevation_Category := factor('100_500')]
grdc_selection[Alt >= 500 & Alt < 1000, Elevation_Category := factor('500_1000')]
grdc_selection[Alt >= 1000 , Elevation_Category := factor('More than 1000')]

write.csv(grdc_selection ,"./data/grdc_selection_with_category.csv", row.names = TRUE)


stations_project_df <- read_excel('./data/stations_project.xlsx')
stations_project <-as.data.table(stations_project_df)
stations_project[, Elevation_Category := factor('NA')]
stations_project[altitude >= 0 & altitude < 10, Elevation_Category := factor('< 10')]
stations_project[altitude >= 10 & altitude < 100, Elevation_Category := factor('10_100')]
stations_project[altitude >= 100 & altitude < 500, Elevation_Category := factor('100_500')]
stations_project[altitude >= 500 & altitude < 1000, Elevation_Category := factor('500_1000')]
stations_project[altitude >= 1000 , Elevation_Category := factor('More than 1000')]



stations_project[, Lat_Category := factor('Na')]
stations_project[lat < -66, Lat_Category := factor('Southest')]
stations_project[-66 < lat & lat< -23 , Lat_Category := factor('South_medium')]
stations_project[-23 <lat & lat< 23 , Lat_Category := factor('Tropical')]
stations_project[23 <lat & lat< 65 , Lat_Category := factor('North_medium')]
stations_project[lat >= 65 , Lat_Category := factor('Northest')]


stations_project[, Catchment_Size := factor('NA')]
stations_project[area >= 0 & area < 1000, Catchment_Size := factor('< 10^3')]
stations_project[area >= 1000 & area < 10000, Catchment_Size := factor('10^3_10^4')]
stations_project[area >= 10000 & area < 100000, Catchment_Size := factor('10^4_10^5')]
stations_project[area >= 100000 & area < 1000000, Catchment_Size := factor('10^5_10^6')]
stations_project[area >= 1000000 , Elevation_Category := factor('More than 10^6')]

write.csv(stations_project ,"./data/stations_project_with_category.csv", row.names = TRUE)



stations_project_df_refrence <- read_excel('./data/grdc_reference_stations_raw/grdc_reference_stations.xlsx')
stations_project_reference <-as.data.table(stations_project_df_refrence)
stations_project_reference[, Elevation_Category := factor('NA')]
stations_project_reference[altitude >= 0 & altitude < 10, Elevation_Category := factor('More than 10')]
stations_project_reference[altitude >= 10 & altitude < 100, Elevation_Category := factor('10_100')]
stations_project_reference[altitude >= 100 & altitude < 500, Elevation_Category := factor('100_500')]
stations_project_reference[altitude >= 500 & altitude < 1000, Elevation_Category := factor('500_1000')]
stations_project_reference[altitude >= 1000 , Elevation_Category := factor('More than 1000')]



stations_project_reference[, Lat_Category := factor('Na')]
stations_project_reference[lat < -66, Lat_Category := factor('Southest')]
stations_project_reference[-66 < lat & lat< -23 , Lat_Category := factor('South_medium')]
stations_project_reference[-23 <lat & lat< 23 , Lat_Category := factor('Tropical')]
stations_project_reference[23 <lat & lat< 65 , Lat_Category := factor('North_medium')]
stations_project_reference[lat >= 65 , Lat_Category := factor('Northest')]


stations_project_reference[, Catchment_Size := factor('NA')]
stations_project_reference[area >= 0 & area < 1000, Catchment_Size := factor('Less than 10^3')]
stations_project_reference[area >= 1000 & area < 10000, Catchment_Size := factor('10^3_10^4')]
stations_project_reference[area >= 10000 & area < 100000, Catchment_Size := factor('10^4_10^5')]
stations_project_reference[area >= 100000 & area < 1000000, Catchment_Size := factor('10^5_10^6')]
stations_project_reference[area >= 1000000 , Elevation_Category := factor('More than 10^6')]

write.csv(stations_project_reference ,"./data/stations_project_reference_with_category.csv", row.names = TRUE)

