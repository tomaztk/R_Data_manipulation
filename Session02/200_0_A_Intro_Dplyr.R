### Using Tidyverse - Part 1
### Learn functions: `select`, `filter`,  `slice`, `mutate` 



# What is the Tidyverse?
#  A collection of R packages designed for data manipulation, exploration, and visualization.
#  Core package: dplyr, which simplifies common data wrangling tasks.

#Base R vs Tidyverse

# Base R can require more verbose or unintuitive syntax.
# Tidyverse functions are intuitive, readable, and chainable using pipes (%>%).


# install.packages("tidyverse")
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
mtcars[ , c("mpg", "cyl")]
mtcars[1:3, c("mpg", "cyl", "wt")]


# Tidyverse
select(mtcars, mpg, cyl)
mtcars[ , c("mpg", "cyl")]



####   Examples:

# Selecting columns by name
select(mtcars, mpg, cyl)


# Doubles are ignored
select(mtcars, mpg, cyl, cyl) # is ignored

select(mtcars, cyl, mpg) # is ok

select(mtcars, 1,3,6,7,8) # is returned by order columns in dataframe

select(mtcars, c(1, 3,6)) # we see, that we do not need to use c() function, but it still works 
select(mtcars, c(cyl,mpg)) 


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
select(mtcars, c(disp, drat))

# EXERCISE 2: Rewrite using select(): command: mtcars[,c("cyl", "hp", "mpg")]
mtcars[,c("cyl", "hp", "mpg")]
select(mtcars, c("cyl", "hp", "mpg"))


# EXERCISE 3: In iris dataset select columns that ends with "Width" or with "Length"
select(iris, ends_with(c("Width", "Length")))



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
filter(mtcars, gear == 5 | mpg > 25)

# EXERCISE 2:  Rewrite using filter():  mtcars[mtcars$mpg == 21,]
mtcars[mtcars$mpg == 21,]
filter(mtcars, mpg == 21)

# EXERCISE 3: In mtcars dataset filter rows where mpg is between 21 and 25
filter(mtcars, between(mpg, 21, 25))
filter(mtcars, mpg >= 21 & mpg < 25)


## ------------
## slice
## ------------


# What does slice() do?
#  Selects rows by position or subseting rows by using index positions
#  Replacement for Base R’s head(), tail(), or indexing [ ].


# Base R
mtcars[1:5, ]

# Tidyverse
slice(mtcars, 1:5)


####   Examples:

#Slice specific rows
slice(mtcars, 1:5)

# So filtering will do row selecting, but it will not be
# able to return the 10th row; therefore, we use slice

filter(mtcars, 10) # returns error in filter()
slice(mtcars, 10)

#remove rows by positon
slice(mtcars, -1) # remove the first row

# Return rows from 20th all to the end
slice(mtcars, 20:n())


#Additinoal functions for head and tail 
slice_head(mtcars, n=3) 
slice_tail(mtcars, n=5) 
slice_tail(mtcars, 5) # will give you an error! 



# for random selections of rows
slice_sample(mtcars, n=4)  # run couple of times!
mtcars_subset <- slice(mtcars, 2:4)

slice_sample(mtcars_subset, n=12, replace = TRUE) # with repeatition
slice_sample(mtcars_subset, n=12, replace = FALSE) # without repeat; but return only 3 rows


# select rows with smallers or largest values of a variable
slice_min(mtcars, cyl, n = 1) 
slice_min(mtcars, cyl, n = 1, with_ties = FALSE) # Use with_ties = FALSE to return exactly n matches

slice_max(mtcars, mpg, n = 5) #biggest: 33.9, 32.4, 30.4,...


# EXERCISE 1: Extract last 5  rows from mtcars; use function slice_tail()
# Can we do it without slice_tail() ?

slice_tail(mtcars, n=5)
# n()-5:n()

# EXERCISE 2:  Rewrite using slice():  mtcars[1:5, ]
mtcars[1:5, ]
slice(mtcars, 1:5)


## ------------
## Mutate
## ------------

# What does mutate() do?
#  Adds or modifies columns to an existing dataset.
#  Replacement for Base R’s $ operator or transform().
 

# Base R
mtcars$new_col <- mtcars$mpg * 2

 rm(mtcars)
 mtcars <- mtcars

# Tidyverse
mutate(mtcars, new_col = mpg * 2)


####   Examples:


# Create new column called weight_ratio
mutate(mtcars, weight_ratio = wt / disp)

# Modify an existing column
mutate(mtcars, hp = hp * 2)

# Add multiple columns
mutate(mtcars, hp2 = hp**2, 
               mpg2 = mpg^2
       )


## Additional functions
# lead(), lag()
# dense_rank(), min_rank(), percent_rank(), row_number(), cume_dist(), ntile()
# cumsum(), cummean(), cummin(), cummax(), cumany(), cumall()
# na_if(), coalesce()
# if_else(), recode(), case_when()


# Ranking
mutate(mtcars, rank = min_rank(desc(mpg)))

mutate(mtcars, calc =  mean(disp, na.rm = TRUE) / cyl)

# Way to do it: mutate(g = ifelse(condition1, 2, ifelse(condition2, 3, g))
mutate(mtcars, g = ifelse(gear == 2 | gear == 5 | gear == 3 , 2,
                  ifelse(gear == 1 | gear == 4, 3, NA)))


# EXERCISE: In mtcars dataset add column using function lag()
 mutate(mtcars, last_prev_val_cyl = lag(cyl))

# EXERICE: Rewrite mtcars$new_col <- mtcars$cyl*mtcars$gea
mtcars$new_col <- mtcars$cyl*mtcars$gear
mutate(mtcars, new_col = cyl*gear) 


## ------------
## Pipe: Chaining Commands Together
## ------------


# What does the pipe operator do?

#  is represented as %>%
#  Chains commands together to make code more readable.
#  Passes the output of one function as input to the next.


# R (without pipe)
filtered <- filter(mtcars, cyl == 6)
selected <- select(filtered, mpg, hp)

selected

# R with example with Pipes
mtcars %>%
  filter(cyl == 6) %>%
  select(mpg, hp)


####   Examples:


# combining functions 
mtcars %>%
  filter(mpg > 20) %>%
  select(mpg, hp)

mtcars[mtcars$mpg > 20, c("mpg", "hp")]


# EXERCISE 1: Use mtcars and for rows where gear == 4 and select disp and wt.
mtcars %>%
  filter(gear == 4) %>%
  select(disp, wt)

# EXERCISE 2: The equivalent base R expression would be: `mtcars[mtcars$mpg >= 22.1, c("cyl", "gear", "hp")]`

mtcars[mtcars$mpg >= 22.1, c("cyl", "gear", "hp")]

mtcars %>%
  filter(mpg >= 22.1) %>%
  select("cyl", "gear", "hp")



## ------------
## Pipe: Combinations of functions!
## ------------


# Build a Pipeline:
  # Filter rows (mpg > 20).
  # Select specific columns (mpg, cyl, hp).
  # Add a new column (power_to_weight as hp/wt).
  # Extract the first 5 rows. !!! podatki niso sortirani


mtcars %>%
   filter(mpg > 20) %>%
   select(mpg, cyl, hp,wt) %>%
   mutate(power_to_weight = hp/wt) %>%
   slice(1:5)



# Explain this pipeline

iris %>%
  filter(Species == "setosa") %>%
  mutate(Petal.Area = Petal.Length * Petal.Width) %>%
  select(Sepal.Length, Petal.Area) %>%
  slice(1:10)


# EXERCISE 1: Filter iris for Sepal.Length > 5, create a new column for Sepal.Ratio 
# (Sepal.Width/Sepal.Length), and select only Sepal.Length, Sepal.Ratio.

iris %>%
  filter(Sepal.Length > 5) %>%
  mutate(Sepal.Ratio = Sepal.Width/Sepal.Length) %>%
  select(Sepal.Length, Sepal.Ratio)

## ------------
## Pipe: Caveats!
## ------------

# 1 Order of operations!

# The order of functions in a pipeline can be repeated and order of the functions is usually not sensitve
# There is no set order because you can put these commands in any order or sequence depending on what 
# it is that you want to do.

# Filtering first
mtcars %>%
  filter(mpg > 30) %>%
  mutate(high_mpg = mpg > 30)

# Mutating first
mtcars %>%
  mutate(high_mpg = mpg > 30) %>%
  filter(mpg > 30)


mtcars %>% mutate(high_mpg = mpg > 30) %>% filter(mpg > 30)

# Mutating first
mtcars %>%
  filter(mpg > 30) %>%
  mutate(high_mpg = mpg > 30)


mtcars %>%
  filter(cyl == 4) %>%
  select (wt, mpg)


mtcars %>%
  select (wt, mpg) %>%
  filter(cyl == 4)


# 2 Variables
mpg <- 10  # Global variable
mtcars %>%
  mutate(new_mpg = mpg * 2)  # Uses 'mpg' from mtcars, not the global one


# 3 Naming "conflicts"
mtcars %>%
  mutate(cyl = cyl * 2)  # Overwrites the 'cyl' column


# 4. Not all functions work directly with pipe

mtcars %>%
  mean()  # Error: 'mean()' expects a numeric vector, not a data frame

mtcars %>%
 select(mpg) %>%
  mean()  # argument is not numeric or logical: returning NA
  
mtcars %>%
  summarize(avg_mpg = mean(mpg)) 

  
mtcars %>%
  filter(cyl == 6) %>%
  select(mpg, hp) %>%
  cor()  # Base R correlation function


# Use glimpse() to check the in-between dataset 
mtcars %>%
  filter(mpg > 20) %>%
  glimpse() %>%
  select(mpg, hp)


