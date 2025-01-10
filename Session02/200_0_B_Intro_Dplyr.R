### Using Tidyverse - Part 2
### Learn functions: `group_by`, `summarize`,  `arrange`, `join`


## ------------
## group_by
## ------------

# What does group_by() do?
  
  # Groups rows by one or more columns.
  # Used with other functions like summarize() to perform grouped calculations.
  # Replacement for Base R’s split() or complex loops.


# Base R equivalent
split(mtcars$mpg, mtcars$cyl)

# Tidyverse
mtcars %>%
  group_by(cyl)


####   Examples:

# Group by once column
mtcars %>%
  group_by(cyl)

# Group by multiple columns
mtcars %>%
  group_by(cyl, gear)


## ------------
## summarize
## ------------

# What does summarize() do?
  
 # Reduces each group to a single summary row.
 # Commonly used with group_by().
 # Replacement for Base R’s aggregate() or loops.


# Base R equivalent
aggregate(mpg ~ cyl, data = mtcars, mean)

# Tidyverse
mtcars %>%
  group_by(cyl) %>%
  summarize(mean_mpg = mean(mpg))


####   Examples:

# Calculate summary statistics
mtcars %>%
  group_by(cyl) %>%
  summarize(mean_mpg = mean(mpg))


# Calculate multiple statistics

mtcars %>%
  group_by(cyl) %>%
  summarize(mean_mpg = mean(mpg), total_hp = sum(hp))

# Calculate count of rows

mtcars %>%
  group_by(cyl) %>%
  summarize(count = n())


# Useful functions
# Center: mean(), median()
# Spread: sd(), IQR(), mad()
# Range: min(), max(),
# Position: first(), last(), nth(),
# Count: n(), n_distinct()
# Logical: any(), all()

# using accross to round values on first, second and third columm
mtcars%>%
    mutate(across(c(1:3), round))


# EXERCISE 1:  calculate the average Sepal.Length for each Species in the iris dataset.

# EXERCISE 2: In iris dataset calculate average for each species for Sepal.Lenght and Sepal.Width

iris %>%
  group_by(Species) %>%
  summarise(across(starts_with("Sepal"), ~ mean(.x, na.rm = TRUE)))


## ------------
## arrange
## ------------


What does arrange() do?
  
  Orders rows of a dataset by one or more columns.
Replacement for Base R’s order().
