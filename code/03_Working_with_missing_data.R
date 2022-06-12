library(data.table)
library(readxl)
library(ggplot2)
library(dplyr)
library(tidyverse)

grdc_selection <- fread('./data/grdc_selection_with_category.csv')
grdc_selection <- subset( grdc_selection, select = -V1 )

missing_values <- grdc_selection %>% group_by(Station) %>% summarise(count=sum(is.na(MQ))) %>% arrange(desc(count))
missing_values_dt <- as.data.table(missing_values)

sample_size <- grdc_selection[, .(size = .N), by = Station]
Proportion_of_nas <- missing_values_dt[sample_size, on = 'Station']
Proportion_of_nas[, missing := 0]
Proportion_of_nas[, missing := count / size]
Proportion_of_nas[, missing := round(missing, 3)]
setcolorder(Proportion_of_nas,                       
            c(setdiff(names(Proportion_of_nas), 'missing'), 'missing'))

ggplot(data=Proportion_of_nas, aes(x=Station, y=missing)) +
  geom_bar(stat="identity")

# grdc_selection_without_nas <- grdc_selection[complete.cases(grdc_selection[ , 13:15]),]

Proportion_of_nas_Less_missing <- Proportion_of_nas[Proportion_of_nas$missing < 0.05, ]

grdc_selection_representer <- grdc_selection[grdc_selection$Station %in% Proportion_of_nas_Less_missing$Station]

grdc_selection_representer[ grdc_selection_representer == "NA" ] <- NA

grdc_selection_representer_without_nas <- na.omit(grdc_selection_representer)


write.csv(grdc_selection_representer_without_nas ,"./data/grdc_selection_with_category_without_nas.csv", row.names = TRUE)




