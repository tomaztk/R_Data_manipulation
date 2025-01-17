### Using Tidyverse - Part 5
### exploring packages:  ReadR, purrr,  DataEditR, gt

mtcars <- mtcars

## ## ## ## ## ## ## ## ## ## ## ##
## readr (from Tidyverse)
## ## ## ## ## ## ## ## ## ## ## ##
# install.packages("readr")
library(readr)

# read_csv(): comma-separated values (CSV)
# read_tsv(): tab-separated values (TSV)
# read_csv2(): semicolon-separated values with , as the decimal mark
# read_delim(): delimited files (CSV and TSV are important special cases)
# read_fwf(): fixed-width files
# read_table(): whitespace-separated files
# read_log(): web log files

#setwd("/Users/tomazkastrun/Documents/tomaztk_github/R_Data_manipulation/Session03")
#getwd()

read_delim("sub_iris_pipe.txt", delim = "|")  #  Read files with any delimiter. If no  delimiter is specified, 
                                    #   it will automatically guess. 

read_csv("sub_iris.csv")    # Read a comma delimited file with period  decimal marks.

read_csv2("sub_iris_semicolon.csv") # Read semicolon delimited files with comma decimal marks. 


# read_tsv(file) # Read a tab delimited file. Also read_table(). 


# Arguments

read_csv("sub_iris.csv", col_names = FALSE) # no header
read_csv("sub_iris.csv", skip = 1, col_names = FALSE) # skip lines

read_csv("sub_iris.csv", n_max = 1) # Read a subset of lines 
read_csv("sub_iris.csv", na = c("1")) # Read values as missing 
read_csv("sub_iris.csv", na = c("3")) # Read values as missing 

read_csv("sub_iris.csv",  col_names = c("id", "sep_len", "sep_wid", "pet_len"))  # provides header (column names)
read_csv("sub_iris.csv",  col_names = c("id", "sep_len", "sep_wid", "pet_len"), skip = 1) 


read_delim("sub_iris.csv", locale =  locale(decimal_mark = ".")) #specify decimal marks
read_delim("sub_iris.csv", locale =  locale(decimal_mark = ",")) #specify decimal marks


## ## ## ## ## ## ## ## ## ## ## ##
## purrr (from Tidyverse)
## ## ## ## ## ## ## ## ## ## ## ##
# install.packages("purrr")
library(purrr)


# The purrr package simplifies iterations, replacing for loops with elegant, functional-style code.
# Dplyr (from Tidyverse) works amazing with data.frames, purrr workhorse is list. List is  way of storing many objects of 
#  any type (e.g. data frames, plots, vectors) together in a single object

# Example of list, that has three elements: a single number, a vector and a data frame

my_list <- list(my_num <- 2908 ,
            num_vector <- c(1:10),
            char_vector <- c("To", "je stavek. Razbit na vec elementov.", "ok", "d"),
            my_df <- data.frame(A = 1:3, B = 4:6, C = 7:9),
            my_mtcars <- as.data.frame(mtcars[1:10, c("mpg", "hp", "cyl")])
    )                        

#complete list
my_list

# 4th element of the list
my_list[4]

my_list$my_df[, 2]


## ------------
## map()
## ------------

# Key Functions is map.
# similar to R: apply

# A map function is one that applies the same action/function to every element 
# of an object (e.g. each entry of a list or a vector, or each of the columns of a data frame).
  
# map(): Apply a function to each element of a list.
# map_df(): Apply a function and return a data frame.
# map_dbl(): Apply a function and return a vector of type double.
# map2(): Map a function over two lists simultaneously.
# pmap(): Map a function over multiple lists.



# !!! Input for map() can be: 1) a list 2) a vector or 3) a data.frame.
# map() functino works great with %>% operator. it also introduces own |>


# A map function is one that applies the same action/function to every element of an object 
# (e.g. each entry of a list or a vector, or each of the columns of a data frame).

add5percent <- function(.x) {
  return((.x * 0.05) + .x)  #reusing args
  #return((.x * 1.05) )
}

map(.x = c(1, 4, 200, 52525), 
    .f = add5percent)

map(my_list[4], add5percent) #complete df
map(my_list[[4]]$A, add5percent) # variable from df

map_dbl(my_list[[5]]$mpg, add5percent) # double map on double vector
map(my_list[[5]]$mpg, add5percent) # normal map on double vector
map_chr(c(1, 4, 200, 52525), add5percent) #adds and converts to character

#working with map_df and internal function
map_df(c(1, 4, 200, 52525), 
        .f = function(.x) {
            return(data.frame(old_number = .x, 
                new_number = add5percent(.x)) ) }
      )



#Compute the mean of each column in mtcars
map(mtcars, mean)

## ------------
## map2()
## ------------

# Applies a function to corresponding elements of two vectors/lists.
# Input: Two lists/vectors of the same length.
# Output: A list.

# Example: Add corresponding elements of two vectors
result <- map2(1:5, 6:10, ~ .x + .y)
print(result)

#row-wise
result <- map2(mtcars$mpg, mtcars$cyl, ~ .x + .y)
print(result)

head(mtcars)
head(result)


## ------------
## pmap()
## ------------
# Applies a function to multiple arguments stored in a list or data frame.
# Input: A list of arguments (or data frame columns).
# Output: A list.


# Example: Add numbers in rows of a data frame

a_vec <- list(as.vector(mtcars$mpg), as.vector(mtcars$cyl), as.vector(mtcars$disp))
a_vec[1]
a_vec[2]
a_vec[3]


my_func <- function(a,b,c) return(a+b+c)

result <- pmap(a_vec,  my_func)

head(mtcars)
head(result)


## ------------
## imap()
## ------------
# It applies a function to each element and its index.
#Input: A list/vector.
#Output: A list.


result <- imap(mtcars, ~ paste0(.y, "_", mean(.x)))

head(mtcars)
head(result)

## ------------
## map() functions 
## and chaining
## ------------

sample_l <-  list(a = 1:4, b = 8:12,c = 20:23)

set.seed(2908) #assuring same results because of rnorm function
sample_l |>
  map(rnorm, n = 10) |> 
  map_dbl(mean) 

set.seed(2908) 
sample_l %>%
  map(rnorm, n = 10) %>% 
  map_dbl(mean) 


mtcars |> 
    map_dbl(sum)


# Supply multiple values to index deeply into a list
sample_l2 <- list(
  list(num = 1:3,     letters[1:3]),
  list(num = 101:103, letters[4:6]),
  list()
)

sample_l2 |> map(c(2)) # positions
sample_l2 |> map(c(2,2)) # positions

sample_l2 |> map(list("num", 3)) #naming the positions

#split into lists by variable cyl
by_cyl <- mtcars |> split(mtcars$cyl)

#for each dataframe in list by_cyl calcualte lm
mods <- by_cyl |> map(\(df) lm(mpg ~ wt, data = df))

#maps 2 lists (iterate by same values lists (in this case cyl)) and apply function predict (from stats function)
map2(mods, by_cyl, predict)




## ------------
## modify()    ## Modify elements of a list or vector.
## modify_if() ## Modify elements conditionally.
## modify_at() ## Modify specific elements based on index or names.
## ------------
# ways return a fixed object type

#modify

modify(mtcars, ~ .x + 10)


#modify_if  
mtcars |>
  modify_if(is.numeric, as.character) |>
  str()


iris %>%
  modify_if(is.factor, as.character) |>
  str()

iris %>% str()
# iris |> str()

mtcars |> modify_if(is.numeric, ~ .x * 2) 


#modify_at

mtcars |> modify_at(c("cyl", "am"), as.character) |> str()

mtcars |> modify_at("mpg", ~ .x + 5) %>%
  select(mpg)

# combining purrr and dplyr (please be consistent!!!)
mtcars |> 
  mutate(abc = mpg) %>%
  modify_at("mpg", ~ .x + 5) %>%
  select(mpg, abc) |>
  str()


## ------------
## reduce
## ------------
#  Combine list elements iteratively with a binary function.
# Input: A list and a function.
# Output: A single scalar value.


reduce(1:5, `*`)
1:5
1*2*3*4*5

1:5 |> reduce(`*`)
1:5 |> reduce(`+`)


my_paste <- function(x, y) {
  paste(x, y, sep = "-")
}

list_stavek <- list(c(rep("A",4)), c(0:4))

list_stavek |> reduce(my_paste)

# reduce2 (using two lists)
list1 <- list(c(0, 1), c(2, 3), c(4, 5)) #3 lists
list2 <- list(c(6, 7), c(8, 9)) #2 lists

reduce2(list1, list2, paste)
reduce2(list1, list2, paste0)


## ------------
## accumulate
## ------------
# Similar to reduce, but returns intermediate results.
#Input: A list and a function.
#Output: A list/vector of intermediate results.


accumulate(1:5, `*`)

accumulate(1:5, `*`, .dir = "backward")

1:10 %>%
  accumulate( paste, sep=".", .dir="backward")


accumulate(1:10, \(curr, nxt) curr + nxt, .init = 0)
reduce(1:10, \(curr, nxt) curr + nxt, .init = 0)


## ------------
## compact
## ------------
# filtering function; part of predicate functions
#removes NULL elements.
#Input: A list.
#Output: A list without NULL.

my_list <- list(a = 1, b = NULL, c = 3)

my_list
compact(my_list)


## ------------
## keep
## ------------

#Keeps elements that satisfy a condition.
#Input: A list/vector and a condition.
#Output: Filtered list/vector.


keep(mtcars, ~ mean(.x) > 20)
keep(mtcars, ~ mean(.x) > 5)



## ------------
## keep_at
## ------------

# Keeps elements based on specific indices or names.
#Input: A list/vector and indices/names.
#Output: Filtered list/vector.

keep_at(mtcars, c("mpg", "cyl"))

mtcars %>% 
    keep_at(c("mpg", "cyl"))


## ------------
## discard
## ------------

#Removes elements that satisfy a condition. or a column level!
#Input: A list/vector and a condition.
#Output: Filtered list/vector.
  

discard(mtcars, ~ mean(.x) < 20)
discard(mtcars, ~ mean(.x) < 5)


## ------------
## discard_at
## ------------
# discard elements based on specific indices or names.
#Input: A list/vector and a condition.
#Output: Filtered list/vector.

mtcars %>% 
  discard_at(c("mpg", "cyl"))


# drop columns where name lenght == 2
mtcars %>% 
  discard_at(~ nchar(.x) == 2) 


## ------------
## pluck
## ------------
#Extracts a specific element from a list. 
# using combination of numeric positions, vectors or list names for extracting 
# deeply nested data structures
#Input: A list and an index/name.
#Output: Extracted element.

pluck(mtcars, "mpg")

# let's make more complex (nested) structure
obj1 <- list("a", list(1, name = "Tom"))
obj2 <- list("b", list(2, name = "John"))
all_object <- list(obj1, obj2)

all_object

pluck(all_object, 1)
# in base R
all_object[[1]]


pluck(all_object, 1, 2)
# in base R
all_object[[1]][[2]]


pluck(all_object, 1, 2, "name")
# in base R
all_object[[1]][[2]][["name"]]



## ------------
## list_flatten
## ------------
# Flattens a list of lists into a single list.
# Input: A nested list.
#Output: A flat list.

simple_list <- list("a", ime="Tom", 29)
simple_list

#same functionality
list_flatten(simple_list) %>% str()
simple_list |> list_flatten() |> str()


# three time nested list
obj1 <- list("a", list(1, name = "Tom", list(29,8)))
obj2 <- list("b", list(2, name = "John", list(29,10)))
obj3 <- list("c", list(4, name = "Jill", list(20,20)))
all_object <- list(obj1, obj2,obj3)

#does not flatten immediately
all_object |> list_flatten() |> str()

# Three times is a charm :)
all_object |> list_flatten() |> 
              list_flatten() |> 
              list_flatten() |> str()


# check depth of nested lists
all_object |> pluck_depth()

all_object |>list_flatten() |> pluck_depth()

## ------------
## list_cbind
## list_rbind
## ------------
# Concatenate / combines elements into a vector or dataframe  
# by concatenating (list_c) or row|column binding (list_cbind, list_rbind)
# in R: cbind  or rows  R: rbind
#Input: Lists.
#Output: vector or Data frame

l <- list(a = 1:3, b = 4:6)
print(l)

l %>% list_c()

mtcars_df1 <- mtcars %>%
                select(mpg, cyl) %>%
                filter(cyl == 6 & mpg >= 20.0) %>%
                  rownames_to_column() 

mtcars_df2 <- mtcars %>%
                select(mpg, cyl) %>%
                filter(cyl == 8 & mpg <= 16.0) %>%
                rownames_to_column() 
                  

mtcars_list <- list(a=mtcars_df1, 
                       b=mtcars_df2)

#will append rows
list_rbind(mtcars_list)

#error, not same length
list_cbind(mtcars_list)


mtcars_list <- list(a=mtcars_df1, 
                    b=data.frame(price=100))

#column bind will work
list_cbind(mtcars_list)
 


1## ## ## ## ## ## ## ## ## ## ## ##
## DataEditR
## ## ## ## ## ## ## ## ## ## ## ##

# install.packages("DataEditR")
library(DataEditR)
  
# RStudio add-in and flexible display options (either dialog box, browser or RStudio viewer pane)
# fast rendering to quickly view datasets
# 1)ability to interactively create data.frames from scratch
# 2)load tabular data saved to file using any reading function (e.g. read.csv())
# 3) save edited data to file using any writing function (e.g. write.csv())
# 
# Data editing features:

data_edit()
data_edit(mtcars)
data_edit(iris)

#adding column programmatically
data_edit(iris, col_bind = data.frame(1,2,3)) #adding three columns
data_edit(iris, row_bind = c(5.1, 3.7,1.5,0.4,3.4)) # adding 5 rows
data_edit(iris, row_bind = data.frame(Sepal.Length=5.1, Sepal.Width=3.7,Petal.Length=1.5,Petal.Width=0.4,Species="SetVersi")) #adding row

# Save changes output to csv. file
mtcars_new <- data_edit(mtcars, save_as = "mtcars_new.csv")



## ## ## ## ## ## ## ## ## ## ## ##
## gt
## reference: https://gt.rstudio.com/reference/index.html
## ## ## ## ## ## ## ## ## ## ## ##
# install.packages("gt")
library(gt)

#Introduction to gt
# The gt package simplifies creating beautiful, publication-quality tables in R.
# And Offers powerful formatting tools for styling, summarizing, and customizing tables.



## ------------
# 1. Basic Table Creation
## ------------

# Create a basic table from a data frame.
#Takes a dataframe  or tibble as an input


mtcars %>%
  head(5) %>% 
  gt()

table_1 <- mtcars %>%
  head(5) %>% 
  gt()


print(table_1)



## ------------
# 2. Adding titles, subtitles, notes
## ------------
# Functions: tab_header, tab_footnote.

# Adding titles
table_2 <- mtcars %>% 
  head(5) %>% 
  gt() %>% 
  tab_header(
    title = "Table of mtcars Dataset",
    subtitle = "A subset of the mtcars data (first 5 rows)"
  )
print(table_2)


#  Add a footnote
table_2 <- table_2 %>% 
  tab_footnote(
    footnote = "Source: mtcars dataset; mpg variable",
    locations = cells_column_labels(c(mpg))
  )
print(table_2)


## ------------
# 3. Data formatting columns
## ------------
# functions: fmt_number, fmt_percent, fmt_currency, fmt_date, fmt_missing.


# Format columns 
table_3 <- mtcars %>% 
  mutate(
    datetime = seq(
      from = as.POSIXct("2025-01-01 00:00:00"),
      by = "1 hour",
      length.out = n()
    )
    ,timedate = seq(
      from = as.POSIXct("2025-01-01 00:00:00"),
      by = "1 hour",
      length.out = n()
    )
  ) %>%
  head(5) %>% 
  gt() %>% 
  fmt_number(
    columns = c(mpg, wt),
    decimals = 2
  ) %>% 
  fmt_currency(
    columns = c(disp),
    currency = "EUR"
  ) %>%
  fmt_percent(
    columns = drat, 
    decimals = 0
  ) %>%
  fmt_date (
    columns = datetime,
    date_style = "day_m"
  )  %>%
  fmt_time (
    columns = timedate,
    time_style = "h_m_p" #"hm"
    #locale = "sl"
  )

print(table_3)


#Check locale
info_locales()


## ------------
# 4. Highlighting Important Data
# Conditional formatting
## ------------
# Functions: tab_style, data_color.

# Example: Highlight rows where mpg > 20
table_4 <- mtcars %>% 
  head(10) %>% 
  gt() %>% 
  tab_style(
    style = cell_fill(color = "lightblue"),
    locations = cells_body(
      rows = mpg > 20
    )
  )

print(table_4)


## ------------
# 5. Adding Summary Rows
#  and totals
## ------------
# summary_rows, grand_summary_rows.

mtcars_sub <- mtcars %>% 
  filter(cyl == 6) %>%
  head(10) 

table_5 <- mtcars_sub %>%
  select(cyl, disp, mpg, wt) %>%
  gt(groupname_col = "cyl") %>% 
  summary_rows(
    groups = c("4", "6", "8"), 
    fns = list(
      "min",
      "max",
      list(label = "avg", fn = "mean")
    )
  )

print(table_5)

table_5 <- mtcars %>% 
  select("mpg", "qsec", "gear", "cyl") %>%
  rownames_to_column() %>% 
  gt(groupname_col = "cyl") %>% 
  summary_rows(
      groups = c("4", "6", "8"), 
      columns = c("mpg", "qsec", "gear"), 
      fns = list(
            min = ~min(.x),
            avg = ~mean(.x)
            
            ))

print(table_5)

## ------------
# 6. Customizing Column Labels and spanners
#  (or renaming)
## ------------
# cols_label, tab_spanner.


table_6 <- mtcars %>% 
  head(5) %>% 
  gt() %>% 
  cols_label(
    mpg = "Miles/Gallon",
    cyl = "Cylinders"
  ) %>% 
  tab_spanner(
    label = "Performance Metrics",
    columns = c(mpg, wt)
  )
print(table_6)


## ------------
# 7. Styling Tables
#  fonts, themes, colours
## ------------
# Functions: opt_table_lines, opt_row_striping, tab_options.


# row striping
table_7A <- mtcars %>% 
  head(10) %>% 
  gt() %>% 
  opt_row_striping()

print(table_7A)

# Example: Customize fonts and colors
table_7B <- table_7A %>% 
  tab_options(
    table.font.size = px(12),
    table.border.top.color = "black",
    table_body.hlines.color = "gray"
  )
print(table_7B)



## ------------
# 8. Adding images /  inline HTML
#  fonts, themes, colours
## ------------
# functions: text_transform, cols_merge.


table_8 <- mtcars %>% 
  head(5) %>% 
  select(mpg, cyl, disp, hp) %>%
  gt() %>% 
  text_transform(
    fn = function(x) { 
        paste0(
          "<strong>",  
          x, 
          "</strong>"
        ) 
    },
    locations = cells_body(columns = c("mpg"))
  )
print(table_8)

## ------------
# Exporting
## ------------

#  Save table to  an image
# must have `CHROMOTE_CHROME` in path!
table_8 %>% 
  gtsave( filename = "table.png" )


## ------------
# #  example :)
# #  example :)
# #  example :)
## ------------


# issue with summary !?!!!

example_1 <- mtcars %>% 
  group_by(cyl) %>% 
  gt() %>% 
  summary_rows(
    #groups = TRUE, #does not work!
    groups = c("4", "6", "8"),  # Replace with actual group names
    columns = c(mpg, wt),
    fns = list(mean = ~ mean(.))
  ) %>% 
  fmt_number(
    columns = c(mpg, wt),
    decimals = 2
  ) %>% 
  tab_style(
    style = cell_fill(color = "lightgray"),
    locations = cells_summary(groups = TRUE)
  )


print(example_1)



example_2 <- mtcars %>% 
  gt() %>% 
  tab_header(
    title = "Styled mtcars Table",
    subtitle = "Custom Formatting and Highlighting"
  ) %>% 
  fmt_number(
    columns = c(mpg, wt),
    decimals = 1
  ) %>% 
  tab_style(
    style = cell_fill(color = "yellow"),
    locations = cells_body(rows = mpg > 25)
  ) %>% 
  opt_row_striping() %>% 
  tab_options(
    table.border.top.width = px(3),
    table.border.top.color = "blue"
  )

print(example_2)


example_3 <- mtcars %>% 
  gt() %>% 
  cols_label(
    mpg = "Miles per Gallon",
    cyl = "Cylinders"
  ) %>% 
  tab_spanner(
    label = "Engine Metrics",
    columns = c(mpg, hp, cyl)
  ) %>% 
  summary_rows(
    groups = NULL,
    columns = vars(mpg, wt),
    fns = list(Mean = ~ mean(.), Max = ~ max(.))
  ) %>% 
  tab_options(
    table.font.size = px(12),
    table_body.hlines.color = "darkgray"
  )

print(example_3)




