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


### Cleanup

# So you've joined two data sets, and now you have a bunch of columns with ".x" and ".y" (or other types of repeats).  What do you do?
#Option 1: select only the columns you really want in the result ahead of doing the join.  
# NOTE: this is one of the very few times I might nest dplyr function calls


cases %>%
  select(countyFIPS, county, state, cases) %>%
  left_join(select(demo, fips, total, white, black),
            by=c("countyFIPS"="fips"))


# Why nest the `select` call instead of saving a subset of the data first, and using that? 
# Mostly for situations where the datasets are large, and I don't want extra copies of the data frame 
# in my environment.  In this case, the data sets are small enough that I could do this instead:

demo_sub <- select(demo, fips, total, white, black)

cases %>%
  select(countyFIPS, county, state, cases) %>%
  left_join(demo_sub,
            by=c("countyFIPS"="fips"))

#But I have `demo_sub` hanging around in my environment then (I like to keep my environment clean when possible!).
#Option 2: use `rename()` or `select()` on the result of the join:
  

cases %>%
  left_join(demo,
            by=c("countyFIPS"="fips")) %>%
  select(countyFIPS, county=county.x, state=state.x, 
         cases, total, white, black)
