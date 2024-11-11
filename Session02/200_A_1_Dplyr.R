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
