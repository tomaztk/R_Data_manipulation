library(dplyr)
library(dplyr)
library(readr)

# county level data
demo <- read_csv("https://raw.githubusercontent.com/tomaztk/R_Data_manipulation/main/data/county_demographics.csv")
cases <- read_csv("https://raw.githubusercontent.com/tomaztk/R_Data_manipulation/main/data/county_cases.csv")
deaths <- read_csv("https://raw.githubusercontent.com/tomaztk/R_Data_manipulation/main/data/county_deaths.csv")

# state level data
state_stats <- read_csv("https://raw.githubusercontent.com/tomaztk/R_Data_manipulation/main/data/state_covid.csv")

## =========================
# Adding Rows and Columns
## =========================

# dplyr includes bind_rows and bind_cols, which are roughly equivalent to 
# base R rbind and cbind, but they are a bit easier to work with.


# Let's create some subsets of data  first:
delaware <- filter(demo, state=="Delaware") %>%
  select(1:6)

hawaii <- filter(demo, state=="Hawaii") %>%
  select(1:4,7:9)

# Putting the column names together in a list to print them out together
list("delaware"=names(delaware), "hawaii"=names(hawaii))

# binding the rows together
bind_rows(delaware, hawaii)

# `bind_rows` includes all columns the exist in either dataset and fills in missing values with NA. 
# It matches columns by full name.  If we tried this with `rbind`, we'd get an error, because the set of columns doesn't match.  

## =========================
# # Joins
## =========================


# I'm applying (with lapply) the nrow function to each element of a list, 
# where each element is one of our data frames
# Again, this is just for easy printing together in the notebook
lapply(list(demo=demo, cases=cases, deaths=deaths), nrow)


filter(demo, fips == 1009)
filter(cases, countyFIPS == 1009)
filter(deaths, countyFIPS == 1009)


cases %>%
  left_join(deaths, by="countyFIPS") %>% 
  slice(1:7)


## Background: Join Types

left_join(cases, deaths, by="countyFIPS")

cases_deaths <- left_join(cases, deaths, by="countyFIPS")


## Unmatched rows
left_join(deaths, cases,
          by=c("countyFIPS")) %>%
  ## cases is the name of a column in the cases data frame
  filter(is.na(cases))  

# or "anti" join

anti_join(deaths, cases, 
          by=c("countyFIPS")) 


##  join with missing values

a <- tibble(id=c(1, 2, NA), val=c(10, 20, 30))
b <- tibble(id=c(2, 3, NA, NA), val2 = c("a", "b", "c", "d"))
a
b


left_join(a, b, by="id")

# If we want this to not happen, we can set the `na_matches` argument to "never"

left_join(a, b, by="id",  na_matches="never")
