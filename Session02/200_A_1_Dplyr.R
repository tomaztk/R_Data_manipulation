# 200_A_1_DPLRY

# install.packages("dplyr")
library(dplyr)

### ------------------
### ------------------
## Start with Wrangling
### ------------------
### ------------------

#sample data
iris <- iris


#viewing data
as_tibble(iris)

glimpse(iris)

View(iris)


# Extract rows that meet logical criteria.
dplyr::filter(iris, Sepal.Length > 7)

# Remove duplicate rows.
dplyr::distinct(iris)

# Randomly select fraction of rows.
dplyr::sample_frac(iris, 0.5, replace = TRUE)

# Randomly select n rows.
dplyr::sample_n(iris, 10, replace = TRUE)

# Select rows by position.
dplyr::slice(iris, 10:15)

# Select and order top n entries (by group if grouped data).
dplyr::top_n(iris, 2, Species)



######################
### Summarising data
#####################

# Summarise uses summary functions, functions that
# take a vector of values and return a single value

#  Summarise data into single row of values.
dplyr::summarise(iris, avg = mean(Sepal.Length))

# Apply summary function to each column.
dplyr::summarise_each(iris, funs(mean))

# Count number of rows with each unique value of variable (with or without weights).
dplyr::count(iris, Species, wt = Sepal.Length)
dplyr::count(iris, Species)


dplyr::first(iris)
dplyr::last(iris)
dplyr::nth(iris,34)
dplyr::n_distinct(iris)
dplyr::summarise(iris, minimum=min(Sepal.Length))


#####################
# selecting columns
#####################

# Select columns by name or helper function
dplyr::select(iris, Sepal.Width, Petal.Length, Species)


# Select columns whose name contains a character string.
select(iris, contains("."))

# Select columns whose name ends with a character string.
select(iris, ends_with("Length"))

# Select every column.
select(iris, everything())

# Select columns whose name matches a regular expression.
select(iris, matches(".t."))

# Select columns named x1, x2, x3, x4, x5.
select(iris, num_range("x2", 1:5))

# Select columns whose names are in a group of names.
select(iris, one_of(c("Species","Sepal.Width", "nonexisting", "justaName")))

# Select columns whose name starts with a character string.
select(iris, starts_with("Sepal"))

# Select all columns between Sepal.Length and Petal.Width (inclusive).
select(iris, Sepal.Length:Petal.Width)

# Select all columns except Species
select(iris, -Species)


#####################
# Making new variables
#####################


# Compute and append one or more new columns.
dplyr::mutate(iris, sepal = Sepal.Length + Sepal.Width)

# Apply window function to each column.
dplyr::mutate_each(iris, funs(min_rank))

# Compute one or more new columns. Drop original columns.
dplyr::transmute(iris, sepal = Sepal.Length + Sepal.Width)


## Window functions

# Copy with values shifted by 1.
dplyr::lead(iris, n  = 1)

# Copy with values lagged by 1.
dplyr::lag(iris, n = 1)


# Ranks with no gaps.
dplyr::dense_rank(iris$Sepal.Length)

# Ranks. Ties get min rank.
dplyr::min_rank(iris$Sepal.Length)

# eg
barplot(dplyr::min_rank(iris$Sepal.Length))

# Ranks rescaled to [0, 1].
dplyr::percent_rank(iris$Sepal.Length)

# Ranks. Ties got to first value.
dplyr::row_number(iris$Sepal.Length)

# Bin vector into n buckets.
dplyr::ntile(x = row_number()) #, iris$Sepal.Length)

# Are values between a and b?
dplyr::between(iris$Sepal.Length, 5, 6)

# Cumulative distribution.  
dplyr::cume_dist(iris$Sepal.Length)

#Cumulative all
dplyr::cumall(iris$Sepal.Length)

#Cumulative any, mean, sum, max, min, cumulative prod, element-wise min, element-wise max
# dplyr::cumany; dplyr::cummean; dplyr::sum; dplyr::max; dplyr::min; dplyr::cumprod: dplyr::pmin, dplyr::pmax

#####################
#  Joins
#####################

df1 <- data_frame(
  ime = c("Matjaz", "Marko", "Tomaz"),
  dom = c("Ljubljana", "Celje", "Koper"),
  institut = c("ABC-CD", "ABC-CD", "ABC-DE")
)
df2 <- data_frame(
  ime = c("Matjaz", "Marko", "Janez"),
  barva = c("modra", "rdeca", "zelena")
)

# Join matching rows from b to a.
dplyr::left_join(df1, df2, by = "ime")

# Join matching rows from a to b.
dplyr::right_join(df1, df2, by = "ime")

# Join data. Retain only rows in both sets.
dplyr::inner_join(df1, df2, by = "ime")

# Join data. Retain all values, all rows.
dplyr::full_join(df1, df2, by = "ime")



df1 <- data_frame(
  ime = c("Matjaz", "Marko", "Tomaz"),
  dom = c("Ljubljana", "Celje", "Koper"),
  okraj = c("ABC-CD", "ABC-CD", "ABC-DE")
)
df2 <- data_frame(
  ime = c("Matjaz", "Marko", "Janez"),
  barva = c("modra", "rdeca", "zelena"),
  okraj = c("ABC-CD", "ABC-DE", "ABC-DE")
)

inner_join(df1, df2, by = c("ime"))

inner_join(df1, df2, by = c("ime", "okraj"))


####################
## Creating dataset
####################

(d1 <- tibble(
  ID = 1:10,
  Year.2021 = c(12, 10, 5, 3, 15, 11, 12, 10, 7, 5),
  Year.2022 = c(12, 3, 15, 1, 13, 4, 1, 16, 7, 13),
  Year.2023 = c(12, 0, 5, 3, 15, 11, 12, 10, 7, 15),
  Year.2024 = c(2, 10, 6, 3, 1, 11, 12, 10, 7, 10)))


d1

tibble(
  trap = rep(1:10, 4),
  year = c(rep(2013, 10), rep(2014, 10), rep(2015, 10), rep(2016, 10)),
  numberInsects = c(12, 10, 5, 3, 15, 11, 12, 10, 7, 5,
                    12, 3, 15, 1, 13, 4, 1, 16, 7, 13,
                    12, 0, 5, 3, 15, 11, 12, 10, 7, 15,
                    2, 10, 6, 3, 1, 11, 12, 10, 7, 10))

## ## ## ## ## ## ##
## nest | unnest
## ## ## ## ## ## ##

# Nesting converts grouped data to a form where each group becomes a single row containing a nested data frame, 
# and unnesting does the opposite.  nest(), unnest()

df <- tibble(
  id_year = c(1,2,3),
  info_years = list(tibble(
    id_info = c(2,3,4),
    info_desc = c("this 2","this 3","this 4")
  ))
)

df

tidyr::unnest(df, info_years)


library(tidyverse)

# Create a sample data frame
data <- tibble(
  group = c("A", "A", "B", "B", "C"),
  value = c(10, 20, 30, 40, 50)
)
data

dplyr::group_by(data, group)

# Nest data by group
nested_data <- data %>%
  group_by(group) %>%
  nest()

print(nested_data)


# Unnest the nested data back to a flat structure
unnested_data <- nested_data %>%
  unnest(data)
print(unnested_data)


# combining both
# Group, nest, process, and unnest
# Add average value per group on each row
processed_data <- data %>%
  group_by(group) %>%
  nest() %>%
  mutate(mean_value = map_dbl(data, ~ mean(.x$value))) %>%
  unnest(data)

print(processed_data)



# Splitting and combining character columns. 
# Use separate() and extract() to pull a single character column into multiple columns; 
# use unite() to combine multiple columns into a single character column.

## Missing
# complete()
# drop_na() 
# fill()
# replace_na()
