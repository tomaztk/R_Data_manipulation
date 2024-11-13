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




