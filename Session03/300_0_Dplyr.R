### Using Tidyverse - Part 4

library(tidyr)
library(tidyverse)
library(dplyr)

## Functions:
  # Data reshaping: pivot_longer(), pivot_wider(), nest(), unnest()
  # Row and column operations: reframe(), ungroup(), bind_cols(), bind_rows(), row_insert(), row_append(), row_update(), row_delete()
  # Set operations: intersect(), union(), union_all()
  # Grouped data operations: group_cols(), group_map(), group_modify(), group_walk()

#Helper functions:
  # Column manipulation: pull(), relocate(), rename()
  # Set operations: setdiff()
  # Column transformations: across(), c_across()

# Datasets
  # mtcars
  # iris


mtcars <- mtcars
iris <- iris

## ## ## ## ## ## ## ## ## ## ## ##
## Data Reshaping Functions
## ## ## ## ## ## ## ## ## ## ## ##

## ------------
## pivot_longer()
## ------------

# Transforms data from wide format to long format.
# Replacement for reshape() in Base R.

dim(mtcars)

mtcars_long <- mtcars %>%
  pivot_longer(
        cols = c(mpg, hp, disp), 
        names_to = "metric", 
        values_to = "value"
        ) %>%
  select(metric, value)


# is "ok" but we need car names and drop unneeded variables
head(mtcars_long,5)


mtcars_long <- mtcars %>%
  mutate(car_name = rownames(mtcars)) %>%
  pivot_longer(cols = c(mpg, hp, disp), names_to = "car_attribute", values_to = "value") %>%
  select(car_name, car_attribute, value)


head(mtcars_long,15)

#now it is easier to visualize this
ggplot(mtcars_long, aes(x = car_name, y = value, fill = car_attribute)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Car Data comparison: Long Format Example", x = "Car Name", y = "Value") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5)) +
  coord_flip()

#or if we do it in excel :)


## ------------
## pivot_wider()
## ------------

# Transforms data from long format to wide format.
# Replacement for reshape() in Base R.

mtcars_wide <- mtcars %>%
  mutate(car_name = rownames(mtcars)) %>%
  pivot_wider(
      names_from = car_name, 
      values_from = c(mpg,cyl,disp)
    )

colnames(mtcars_wide)

head(mtcars_wide,5)

# example 2
# simulating one-hot encoding
mtcars %>%
  mutate(car_name = rownames(mtcars)) %>%
  pivot_wider(
    names_from = cyl, # Column to spread 
    values_from = mpg, 
    names_prefix = "cyl_"
  )

# example 3
mtcars %>%
  mutate(car_name = rownames(mtcars)) %>%
  group_by(gear, am, cyl) %>% 
  summarize(avg_mpg = mean(mpg), .groups = "drop") %>% # Calculate average mpg
  pivot_wider(
    names_from = cyl,        # spread
    values_from = avg_mpg,   # Fill values with the `avg_mpg` column
    #values_fn = ~ mean(.x, na.rm = TRUE)
    names_prefix = "cyl_"    # Add a prefix for clarity
  )


#example 4

set.seed(2908)
random_data <- data.frame(
  country = rep(c("Slovenia", "Austria", "Portugal", "Germany", "Japan"), each = 5),
  year = rep(2015:2019, times = 5),
  population = rep(c(320, 1300, 200, 80, 125), each = 5) + sample(-10:10, 25, replace = TRUE), 
  cases = sample(5000:50000, 25, replace = TRUE)
)


head(random_data,10)

# wider dataset with year but 
# still not 5x5 table, because of population
random_data %>%
  pivot_wider(
    names_from = year,    
    values_from = cases,  
    names_prefix = "year_" #add prefix
  )

# do this
random_data %>%
  group_by(country) %>% 
  mutate(avg_population = mean(population)) %>% 
  select(country,avg_population,year,cases) %>%
  pivot_wider(
    names_from = year,
    values_from = cases,
    names_prefix = "year_cases_" #add prefix       
  )

head(random_data,10)


# or
random_data %>%
  group_by(country) %>% 
  mutate(avg_population = mean(population)) %>%   
  ungroup() %>%
  select(-population) %>%                           
  pivot_wider(
    names_from = year,                              
    values_from = cases,                          
    names_prefix = "year_cases_"                         
  )


## ------------
## nest()
## ------------

# Groups and nests data into a list-column of data frames. 
# It is a summarising operation -> you get one row for each group defined by the non-nested columns

mtcars_nested <- mtcars %>%
  group_by(cyl) %>%
  nest()

print(mtcars_nested)

# assume we want to calculate lm for each group of cyl (4,6,8)
mtcars_models <- mtcars %>%
  group_by(cyl) %>% 
  mutate(models = list(lm(mpg ~ wt, data = cur_data())))

print(mtcars_models)

#simpler using nest  
mtcars_cyl_nested <- mtcars %>%
  nest(.by = cyl) %>%
  mutate(models = lapply(data, function(df) lm(mpg ~ wt, data = df))) # I use lapply and function!

print(mtcars_cyl_nested)

# compare
mtcars_models$models
mtcars_cyl_nested$models


## ------------
## unnest()
## ------------

# Expands list-columns created by nest back into a data frame.

mtcars_nested %>%
  unnest(data)


#unnesting lists or vectors

# library(dplyr)
# library(broom)
# library(purrr)

# Fit linear models for each group
mtcars_models <- mtcars %>%
  group_by(cyl) %>%
  summarise(model = list(lm(mpg ~ wt, data = cur_data())), .groups = "drop")

# Unnest the model results into a tidy data frame (coefficients and R²)
model_results <- mtcars_models %>%
  mutate(tidy_model = map(model, tidy),         # Extract coefficients
         glance_model = map(model, glance)) %>% # Extract model summaries
  select(-model) %>%                            
  unnest(c(tidy_model, glance_model), names_sep = "_")  


# View the results
print(model_results)


mtcars_models %>%
  mutate(tidy_model = map(model, tidy)) %>%
  select(cyl, tidy_model) %>%
  unnest(tidy_model) %>%
  select(cyl, term, estimate, p.value)

mtcars_models %>%
  mutate(glance_model = map(model, glance)) %>%
  unnest(glance_model) %>%
  select(cyl, r.squared, adj.r.squared) %>%
  ggplot() + geom_bar() ...



## ## ## ## ## ## ## ## ## ## ## ##
## Row and column operations
## ## ## ## ## ## ## ## ## ## ## ##

# reframe(), ungroup(), bind_cols(), bind_rows(), 
# row_insert(), row_append(), row_update(), row_delete()


## ------------
## reframe()
## ------------

# A tidy way to create summarized outputs.

mtcars %>%
  group_by(cyl) %>%
  reframe(
          avg_mpg = mean(mpg), 
          count = n()
          )

## ------------
## ungroup()
## ------------
 
# Removes grouping from a grouped data frame.

mtcars %>%
  group_by(cyl) %>%
  summarize(mean_mpg = mean(mpg)
            ,count = n()
            ) %>%
  ungroup() 
  

mtcars_grouped <- mtcars |>  
  group_by(cyl, mpg)


mtcars_grouped
# but wait, looks like original dataset mtcars?!? -> check global environment!

#now we can summarize directly
mtcars_grouped %>%
  summarise(n=n())

mtcars_ungroped <- mtcars_grouped %>% 
  ungroup()

mtcars_ungroped
# but wait, looks exactly as the original dataset mtcars! -> check global environment!


# tidy %>%
# purr |> 

## ------------
##  bind_cols() 
##  bind_rows()
## ------------

# Combines datasets by columns or rows.
# Replacements for cbind() and rbind() in R Base language.


# Bind two columns together
new_data_cols <- bind_cols(mtcars, 
                      tibble(new_col = 1:nrow(mtcars))
                      )

head(new_data_cols)

# mtcars[1,] # row we will append / bind
new_data_rows <- bind_rows(mtcars, 
                            mtcars[1,]
                           )

tail(new_data_rows)


## ------------
##  row_insert()
##  row_append()
##  row_update()
##  row_delete()
## ------------

# Operations like row_insert, row_append, row_update, and row_delete 
# are self-explanatory. These are part of dplyr ecosystem and work with tibbles and data.frames.
# we will focus on insert, update and delete (append is similar to bind_rows)



df <- data.frame(a = 1:3, b = letters[c(1:2, NA)], c = 0.5 + 0:2)

df

# row insert is similar to rbind_rows
df <- rows_insert(df, tibble(a = 4, b = "z"))


# error 
try(rows_insert(df, tibble(a = 3, b = "z")))

# error because after 7
df %>% rows_insert(., tibble(a = 15, b = "r"), after = 7)


df %>% rows_insert(., tibble(a = 15, b = "r", c=2.4))





## ## ## ## ## ## ## ## ## ## ## ##
## Row  operations
## # intersect(), union(), union_all()
## ## ## ## ## ## ## ## ## ## ## ##

## ------------
##  intersect()
## ------------

# Finds rows common to two datasets.

mtcars[1:10, ]
mtcars[5:15, ]

intersect_rows <- intersect(mtcars[1:10, ], mtcars[5:15, ])
head(intersect_rows)


## ------------
##  union()
##  union_all()
## ------------

# Combines rows from two datasets. union_all() keeps duplicates.

union_dataset <- union(mtcars[1:10, ], mtcars[5:15, ])
union_dataset

union_all_dataset <- union_all(mtcars[1:10, ], mtcars[5:15, ])
union_all_dataset

## ## ## ## ## ## ## ## ## ## ## ##
## Grouped data operations
## group_map(), group_modify(), group_walk()
## ## ## ## ## ## ## ## ## ## ## ##


## ------------
##  group_map()
## ------------

# Applies a function to each group and returns a list.
# Is a purrr-style functions that can be used to iterate on grouped tibbles.

# applies function f
# group_map(.data, .f, ..., .keep = FALSE)


map_mtcars <- mtcars %>%
  group_by(cyl) %>%
  group_map(~ mean(.x$mpg))

map_mtcars

mtcars %>%
  group_by(cyl) %>%
  group_map(~ head(.x, 2))

m1<-mtcars %>%
  group_by(cyl) %>%
  group_map( ~ lm(mpg ~ wt, data =.))

m1

## ------------
##  group_modify()
## ------------

# Allows for custom modifications to each group and returns a grouped tibble. In that case .f must return a data frame.
# Is a purrr-style functions that can be used to iterate on grouped tibbles.

# Use group_modify() when summarize() is too limited, in terms of
# what you need to do and return for each group. group_modify() is 
# good for "data frame in, data frame out". If that is too limited, 
# you need to use a nested or split workflow. group_modify() is an 
# evolution of do(), if you have used that before. (source: Tidyverse documentation)


# will get head(3) from each subset
mtcars %>%
  group_by(cyl) %>%
  group_modify(~ head(.x, 3))


#will produce error. it expects data.frame as a result set
mtcars %>%
  group_by(cyl) %>%
  group_modify( ~ lm(mpg ~ wt, data =.))
 
# we use broom 
mtcars %>%
  group_by(cyl) %>%
  # group_modify( ~ lm(mpg ~ wt, data =.))
   group_modify( ~ broom::tidy(lm(mpg~ wt, data =.)))


## ------------
##  group_walk()
## ------------

# group_walk() calls .f for side effects and returns the input .tbl, invisibly.
# Runs a side-effect function (e.g., print) on each group.
# Is a purrr-style functions that can be used to iterate on grouped tibbles.


mtcars %>%
  group_by(cyl) %>%
  group_walk(~ print(mean(.x$mpg)))


getwd()
setwd("/Users/tomazkastrun/Documents/tomaztk_github/R_Data_manipulation/Session03")

mtcars %>%
  group_by(cyl) %>%
  group_walk(~ write.csv(.x, file = file.path(getwd(), paste0("cyl_",.y$cyl, ".csv"))))


## ## ## ## ## ## ## ## ## ## ## ##
## Helper functions
## Column manipulation: pull(), relocate(), rename()
## Column transformations: across(), c_across()
## ## ## ## ## ## ## ## ## ## ## ##

## ------------
## pull()
## ------------

# Extract a single column, and stores it as an vector (int,num, char,...)
# In base R is done with column selection

mpg_vector <- mtcars %>%
    pull(mpg)

mpg_vector
class(mpg_vector)

#base R
mpg_vector2 <- mtcars$mpg

mpg_vector2

carname_vector <- mtcars %>%
  mutate(car_name = rownames(mtcars)) %>%
  pull(car_name)

# check types
class(mpg_vector)
class(mpg_vector2)
class(carname_vector)


## ------------
## relocate()
## ------------

# Change column order. 
# Useful function when importing data from files (csv, txt, excel) or from databases or other endpoints 


mtcars_persistent <- mtcars
colnames(mtcars_persistent)
#  [1] "mpg"  "cyl"  "disp" "hp"   "drat" "wt"   "qsec" "vs"   "am"   "gear" "carb"

mtcars_persistent <- mtcars_persistent %>%
  relocate(mpg, .after = cyl)

colnames(mtcars_persistent)
#  [1] "cyl"  "mpg"  "disp" "hp"   "drat" "wt"   "qsec" "vs"   "am"   "gear" "carb"



## ------------
## rename()
## ------------

# Renames columns.

mtcars_persistent <- mtcars_persistent %>%
  rename(miles_per_gallon = mpg,
         cylinder = cyl,
         horse_power = hp)

colnames(mtcars_persistent)
# [1] "cylinder"         "miles_per_gallon" "disp"             "horse_power"      "drat"             "wt"               "qsec"            
# [8] "vs"               "am"               "gear"             "carb"      

## ------------
## renames_with()
## ------------

# Renames columns using a function.
# Let's experiment with  `iris` dataset

iris_persistent <- iris

colnames(iris_persistent)
# [1] "Sepal.Length" "Sepal.Width"  "Petal.Length" "Petal.Width"  "Species" 

# R is case-sensitive and dots in the variable names redundant.
# Let's change that

iris_persistent <- iris_persistent %>%
  rename_with( ~ tolower(gsub(".", "", .x, fixed = TRUE)))

colnames(iris_persistent)
# [1] "sepallength" "sepalwidth"  "petallength" "petalwidth"  "species"  


## ------------
## across() 
## ------------

# Applies functions to multiple columns simultaneously.
# Makes it easy to apply the same transformation to multiple columns, allowing you to use select(),  summarise() and mutate().

set.seed(2908)
df <- data.frame(id = 1:4, w = runif(4), x = runif(4), y = runif(4), z = runif(4))
n <- rnorm(1)

df

df %>%
  mutate(across(w:z, ~ .x + n))

df

mtcars %>%
  mutate(across(c(mpg, hp), ~ . * 2))

## ------------
## c_across()
## ------------
 
# Combine values from multiple columns and works rowwise() to make it easy to perform row-wise aggregations.
# in Base R is similar to c()

df %>%
  # check with rowwise() and without rowwise()
  # rowwise() %>% #adding rowwise to achieve row wise operation
  mutate(
    sum = sum(c_across(w:z)),
    sd = sd(c_across(w:z))
  )


