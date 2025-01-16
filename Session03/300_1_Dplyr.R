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


read_delim("file.txt", delim = "|")  #  Read files with any delimiter. If no  delimiter is specified, 
                                    #   it will automatically guess. 

read_csv("file.csv")    # Read a comma delimited file with period  decimal marks.

read_csv2("file2.csv") # Read semicolon delimited files with comma decimal marks. 


read_tsv("file.tsv") # Read a tab delimited file. Also read_table(). 
read_fwf("file.tsv", fwf_widths(c(2, 2, NA)))  # Read a fixed width file. 



# Arguments

read_csv("file.csv", col_names = FALSE) # no header
read_csv("file.csv",  col_names = c("x", "y", "z"))  # provides header (column names)
read_csv("file.csv", skip = 1) # skip lines
read_csv("file.csv", n_max = 1) # Read a subset of lines 
read_csv("file.csv", na = c("1")) # Read values as missing 
read_delim("file2.csv", locale =  locale(decimal_mark = ",")) #specify decimal marks


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
a_vec$[2]
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




  

## ## ## ## ## ## ## ## ## ## ## ##
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


gt()

gt_preview() 








start_date <- "2010-06-07"
end_date <- "2010-06-14"

sp500 |>
  dplyr::filter(date >= start_date & date <= end_date) |>
  dplyr::select(-adj_close) |>
  gt() |>
  tab_header(
    title = "S&P 500",
    subtitle = glue::glue("{start_date} to {end_date}")
  ) |>
  fmt_currency() |>
  fmt_date(columns = date, date_style = "wd_m_day_year") |>
  fmt_number(columns = volume, suffixing = TRUE)
