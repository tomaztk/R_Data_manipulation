
### -- Tidyverse
# LEarn functions: `select`, `filter`,  `slice`, `mutate` 

library(tidyverse)


police <- read_csv("https://raw.githubusercontent.com/nuitrcs/r-tidyverse/main/data/ev_police.csv")


police <- read_csv("https://raw.githubusercontent.com/nuitrcs/r-tidyverse/main/data/ev_police.csv",
                   col_types=c("location"="c"))


fix_data <- read_csv("https://raw.githubusercontent.com/nuitrcs/r-tidyverse/main/data/missing.csv")
fix_data

police

View(police)

police[, 1]
as.data.frame(police)[, 1]


names(police)


## ------------
## select
## ------------

select(police, subject_race)


# If we want to select additional columns, we can just list the column names as additional inputs, each column name separated by commas:
select(police, subject_race, outcome)


# As with `[]` indexing, columns will be returned in the order specified:
select(police, subject_sex, subject_race, date)


#We could also use the column index number if we wanted to instead.  We don't need to put the values in `c()` like we would with `[]` (but we could).
select(police, 1, 4, 10)



### EXERCISE

#Remember: you need to have loaded tidyverse, and the police data, so execute the cells above.
#Convert this base R expression: `police[,c("violation", "citation_issued", "warning_issued")]` to use `select()` instead to do the same thing: 
  


## ------------
## filter
## ------------

# To choose which rows should remain in our data, 
# we use `filter()`.  As with `[]`, we write expressions that evaluate to TRUE or FALSE for each row.  
# Like `select()`, we can use the column names without quotes.


filter(police, location == "60202")


# Note that we use `==` to test for equality and get TRUE/FALSE output.  You can also write more complicated expressions -- anything that will evaluate to a vector of TRUE/FALSE values.

filter(police, is.na(beat))

# Variables (columns) that are already logical (TRUE/FALSE values), can be used to filter:
  
filter(police, contraband_found)


### EXERCISE

# Use `filter()` to choose the rows where subject_race is "white".  
#The equivalent base R expression would be `police[police$subject_race == "white",]`.  


## ------------
## slice
## ------------

# Unlike `select()`, we can't use row numbers to index which rows we want with filter.  This gives an error:

filter(police, 10)

#If we did need to use the row index (row number) to select which rows we want, we can use the `slice()` function.  

slice(police, 10)

# or range; similar to ipos in Python
slice(police, 10:15)


## ------------
## Pipe: Chaining Commands Together
## ------------


# functions all take a data frame as the first input, and they return a data frame as the output.  
# We can rewrite 

select(police, date, time)

# as

police %>% select(date, time)


# and you'll often see code formatted, so `%>%` is at the end of each line, and the following 
# line that are still part of the same expression are indented:

police %>%
  select(date, time)


# The pipe comes from a package called `magrittr`, which has additional special operators in it that you can use.  
# The keyboard shortcut for `%>%` is command-shift-M (Mac) or control-shift-M (Windows).

police %>% 
  select (subject_race, subject_age) %>% 
  filter (subject_race == "white")

# we see a lot of NA
police %>% 
  select (subject_race, subject_age) %>% 
  #lgl
   filter (subject_race == "white" & subject_age == NA ) 
  # filter (subject_race == "white" & (is.na(subject_age) == FALSE))


#  columns must be in select list, if they are not, it will not work

police %>%
  select(subject_sex, outcome) %>%
  filter(subject_race == "white")

# This might not work Because `subject_race` is no longer in the data frame once we try to filter with it.  We'd have to reverse the order,
# it will work
  
police %>%
  filter(subject_race == "white") %>%
  select(subject_sex, outcome)


# You can use the pipe operator to string together commands outside of the tidyverse as well, 
# and it works with any input and output, not just data frames:
  
# without %>% 
sum(is.na(police$beat))

# with %>%  (outside tidyverse)
is.na(police$beat) %>% sum()


### EXERCISE

# Select the date, time, and outcome (columns) of stops that occur in beat "71" (rows).  Make use of the `%>%` operator.  
# The equivalent base R expression would be: `police[police$beat == "71", c("date", "time", "outcome")]`



# Sometimes we may still want to save the result of some expression, such as after performing a bunch of data cleaning steps. 
# We can assign the output of piped commands as we would with any other expression.

police60201 <- police %>%
  filter(location == "60201") %>%
  select(date, time, beat, type, outcome) 


head(police60201)


### EXERCISE

# Select only vehicle_year and vehicle_make columns for observations where there were contraband_weapons

