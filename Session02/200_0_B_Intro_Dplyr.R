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
  summarize(
      mean_mpg = mean(mpg), 
      total_hp = sum(hp)
      )

# Calculate count of rows

mtcars %>%
  group_by(cyl) %>%
  summarize(
    count = n()
    )


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
iris %>%
  group_by(Species) %>%
  summarise(
        avg_sep_len = mean(Sepal.Length, na.rm = TRUE),
        avg_sep_wid = mean(Sepal.Width, na.rm = TRUE)
  )
  

# EXERCISE 2: In iris dataset calculate average for each species for Sepal.Lenght and Sepal.Width

iris %>%
  group_by(Species) %>%
  summarise(across(starts_with("Sepal"), ~ mean(.x, na.rm = TRUE)))


## ------------
## arrange
## ------------


# What does arrange() do?

#  Orders rows of a dataset by one or more columns.
#  Replacement for Base R’s order().


# Base R equivalent
mtcars[order(mtcars$mpg), ]

# Tidyverse
mtcars %>%
  arrange(mpg) 

####   Examples:


# arrange (sort) in ascending order
mtcars %>%
  arrange(mpg)

#arrange (sort) in descending order

mtcars %>%
  arrange(desc(mpg))

# arrange by multiple columns
mtcars %>%
  arrange(cyl, desc(mpg))


# arrange by group
# grouped arrange ignores groups
by_cyl <- mtcars %>% group_by(cyl)

by_cyl %>% arrange(desc(wt))
#vs.
by_cyl %>% arrange(desc(wt), .by_group = TRUE)


# EXERCISE 1 : get the iris dataset and arrange by Sepal.Length in descending order.

iris %>%
  arrange(desc(Sepal.Length), desc(Sepal.Width))

## ------------
## join
## ------------

# What do join functions do?
  
#  Combine two datasets by matching rows based on one or more keys.
#  Replacement for Base R’s merge().


## Common Joins in Tidyverse:
  
# inner_join(): Keeps only rows with matches in both datasets.
# left_join(): Keeps all rows in the left dataset, with matching rows from the right.
# right_join(): Keeps all rows in the right dataset, with matching rows from the left.
# full_join(): Keeps all rows from both datasets.


# Create sample data
df1 <- data.frame(id = 1:3, value1 = c("A", "B", "C"))
df2 <- data.frame(id = 2:4, value2 = c("X", "Y", "Z"))

head(df1)
head(df2)


# Base R equivalent
merge(df1, df2, by = "id")

# Tidyverse
df1 %>%
  inner_join(df2, by = "id")


####   Examples:

# Inner Join
df1 <- data.frame(id = 1:3, value1 = c("A", "B", "C"))
df2 <- data.frame(id = 2:4, value2 = c("X", "Y", "Z"))

df1 %>%
  inner_join(df2, by = "id")


# Left Join
df1 %>%
  left_join(df2, by = "id")

# Right Join
df1 %>%
  right_join(df2, by = "id")


# Right Join
df2 %>%
  right_join(df1, by = "id")


# Full (outer) join
df1 %>%
  full_join(df2, by = "id")


# EXERCISE 1: perform an inner_join() and a full_join() by column name

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

View(df1)
View(df2)


# EXERCISE 1: perform an inner_join() and a full_join().
inner_join(df1, df2, by = c("ime"))

df1 %>%
  inner_join (df2, by = c("ime"))


full_join(df1, df2, by = c("ime"))

df1 %>%
  full_join (df2, by = c("ime"))  %>%
  left_join (df3, by = c("dom")) %>%
  right_join (df4, by = c("okraj.y"))


# EXERCISE 2: Create an inner_join() on multiple columns (ime, okraj).

df1 %>%
  inner_join(df2, by = c("ime", "okraj"))


## ------------
## combining 
## ------------


# Analyze mtcars:
# 1) Group by cyl.
# 2) Calculate the mean of mpg and the total hp.
# 3) Arrange the results in descending order of mean mpg.


mtcars %>%
  group_by(cyl) %>%
  summarize(
      mean_mpg = mean(mpg), 
      total_hp = sum(hp)
      ) %>%
  arrange(desc(mean_mpg))



# Find average value of Sepal.Length in iris dataset and arrange results in asc order 
iris %>%
  group_by(Species) %>%
  summarize(avg_sepal_length = mean(Sepal.Length)) %>%
  arrange(avg_sepal_length)

