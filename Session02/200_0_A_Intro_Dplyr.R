### Using Tidyverse - Part 1
### Learn functions: `select`, `filter`,  `slice`, `mutate` 



# What is the Tidyverse?
#  A collection of R packages designed for data manipulation, exploration, and visualization.
#  Core package: dplyr, which simplifies common data wrangling tasks.

#Base R vs Tidyverse

# Base R can require more verbose or unintuitive syntax.
# Tidyverse functions are intuitive, readable, and chainable using pipes (%>%).


install.packages("tidyverse")
library(tidyverse)

#sample dataset
datasets::mtcars
datasets::iris
tidyr::billboard

# Persist dataset
mtcars <- mtcars

View(mtcars)

names(mtcars)
colnames(mtcars)
rownames(mtcars)

## ------------
## select
## ------------

# What does select() do?
  
# Extracts specific columns from a dataset.
# Replacement for Base R’s indexing [] or subset() for selecting columns.

# Base R
mtcars[, c("mpg", "cyl")]
mtcars[1:3, c("mpg", "cyl", "wt")]

# Tidyverse
select(mtcars, mpg, cyl)


####   Examples:

# Selecting columns by name
select(mtcars, mpg, cyl)

# Doubles are ignored
select(mtcars, mpg, cyl, cyl) # is ignored
select(mtcars, cyl, mpg) # is ok
select(mtcars, 1, 3,6) # is returned by order columns in dataframe
select(mtcars, c(1, 3,6)) # we see, that we do not need to use c() function, but it still works 



# Selecting columns by patterns (pattern matches)

select(mtcars, starts_with("c"))
select(mtcars, contains("d"))
select(mtcars, matches("[wg]")) # [wg] is part of regular expression
select(billboard,num_range("wk", 6:9))

## Other Pattern matches
# ends_with(): Ends with an exact suffix.
# contains(): Contains a literal string.
# matches(): Matches a regular expression.
# num_range(): Matches a numerical range like x01, x02, x03.

# Dropping the columns
select(mtcars, -hp, -wt)


# EXERCISE 1: Select columns  disp and drat from mtcars.

# EXERCISE 2: Rewrite using select(): command: mtcars[,c("cyl", "hp", "mpg")]

# EXERCISE 3: In iris dataset select columns that ends with "Width" or with "Length"
# select(iris, ends_with(c("Width", "Length")))

## ------------
## filter
## ------------

# What does filter() do?
#  Filters rows based on conditions.
#  Replacement for Base R’s subset() or logical indexing.


# Base R
mtcars[mtcars$cyl == 6, ]

# Tidyverse
filter(mtcars, cyl == 6)


####   Examples:

#Filter wors with a single condition
filter(mtcars, mpg > 20) # comparison operators ==, >, >=, <, <= 
filter(mtcars, mpg == 21)

# Filter rows with multpile conditions
filter(mtcars, mpg > 20, cyl == 6) # When multiple expressions are used, they are combined using &
filter(mtcars, mpg > 20 & cyl == 6) # Logical operators &, |, !, xor()

# Using logical operators when using multiple conditions
filter(mtcars, mpg > 20 | cyl == 4)


# EXERCISE 1: Filter rows where gear is 5 or mpg > 25.

# EXERCISE 2:  Rewrite using filter():  mtcars[mtcars$mpg == 21,]

# EXERCISE 3: In mtcars dataset filter rows where mpg is between 21 and 25
# filter(mtcars, between(mpg, 21, 25))


## ------------
## slice
## ------------


# What does slice() do?
#  Selects rows by position.
#  Replacement for Base R’s head(), tail(), or indexing [ ].


# Base R
mtcars[1:5, ]

# Tidyverse
slice(mtcars, 1:5)


####   Examples: