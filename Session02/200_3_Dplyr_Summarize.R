library(tidyverse)


#g et data
police <- read_csv("https://raw.githubusercontent.com/nuitrcs/r-tidyverse/main/data/ev_police.csv",
                   col_types=c("location"="c"))




# summarize

police %>% 
  mutate(vehicle_age = 2017-vehicle_year) %>% # computing a new variable first
  summarize(mean_vehicle_age = mean(vehicle_age))

