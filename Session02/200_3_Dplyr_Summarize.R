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

# using multiple functions and doing data type conversion
# select columns that are not of type character using `where` and exclamation mark (! is opposite)
police %>%
  summarize(across(!where(is.character), 
                   list(min, max)))   # take the min and max of each column


# and giving columns names:
police %>%
  summarize(across(!where(is.character), 
                   list(min_val=min, max_val=max)))


## using lmabda function
#   that operates on each column
police %>%
  summarize(across(everything(),
                   ~sum(is.na(.x))))  


## ====================
# # Group by
## ====================


police <- mutate(police, vehicle_age = 2017-vehicle_year)


# summarize and combine with group_by on column `vehicle_age` 


police %>% 
  group_by(subject_sex) %>%
  summarize(mean_vehicle_age = mean(vehicle_age),
            sd_vehicle_age = sd(vehicle_age))


# Now we get one row for each group, and one column for each summary measure.
# We can group by multiple columns

police %>% 
  group_by(subject_sex, subject_race) %>%
  summarize(mean_vehicle_age = mean(vehicle_age),
            sd_vehicle_age = sd(vehicle_age))


# we can immediately use variables, we have created in the same run
police %>%
  group_by(subject_race) %>%
  summarize(warnings = sum(outcome == "warning"),
            citations = sum(outcome == "citation"), 
            ratio = warnings/citations)


## ====================
## Ungrouping
## ====================

# If you have a grouped data frame, 
# you may need to ungroup it to get rid of the groups.  
# To do so, use `ungroup()`:

police %>% 
  group_by(subject_sex) %>%
  summarize(avg_gender = mean(vehicle_age) ) %>% 
  ungroup()
