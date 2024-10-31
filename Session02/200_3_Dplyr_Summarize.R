library(tidyverse)


#g et data
police <- read_csv("https://raw.githubusercontent.com/nuitrcs/r-tidyverse/main/data/ev_police.csv",
                   col_types=c("location"="c"))



## ====================
# # summarize
## ====================

police %>% 
  mutate(vehicle_age = 2024-vehicle_year) %>% # computing a new variable first
  summarize(mean_vehicle_age = mean(vehicle_age))


#As a side note, if we needed the single value (or a single vector), we could `pull()` it
police %>% 
  mutate(vehicle_age = 2024-vehicle_year) %>% # computing a new variable first
  summarize(mean_vehicle_age = mean(vehicle_age)) %>%
  pull()


# We can compute more than one summary measure at the same time:

police %>% 
  mutate(vehicle_age = 2024-vehicle_year) %>% # computing a new variable first
  summarize(mean_vehicle_age = mean(vehicle_age),
            sd_vehicle_age = sd(vehicle_age),
            min_date = min(date),
            max_date = max(date))

## ====================
# # Across
## ====================

# If we want to apply the same summary functions to multiple columns in our data frame, 
# we can write out all of the summary commands explicitly, 
# or we can use `across()` to select which variables to summarize with which functions.

# Let's use the `n_distinct()` function to count the number of distinct 
# values in each column (`n_distinct(x)` is the same as `length(unique(x))`.  T
# This will help us see which columns don't have useful information because every value is the same.

# `across()` selects columns using the helper functions you could give to `select()` directly.  
# We'll use `everything()` here to select all columns.

police %>%
  summarize(across(everything(), n_distinct))


# we can use select() function to pick only wanted variables
police %>%
  summarize(across(c(date, time, location, beat, subject_age), n_distinct))

# we can also apply different functions
police %>%
  summarize(across(c(vehicle_year, department_id), sum)) #works

police %>%
  summarize(across(c(vehicle_year, department_id, beat), sum)) #adding different data type; we need to change it


police %>%
  summarize(across(c(vehicle_year, department_id, as.integer(beat)), sum)) #adding different data type; we need to change it


police %>%
  mutate(beat_int = as.integer(beat)) %>% 
  summarize(across(c(vehicle_year, department_id, beat_int), sum)) #adding different data type; we need to change, but we get the NA

police %>%
  mutate(beat_int = as.integer(beat),
         beat_int2 = ifelse(is.na(beat_int), 0, beat_int) 
         ) %>% 
  summarize(across(c(vehicle_year, department_id, beat_int2), sum)) #adding different data type; we need to change 


