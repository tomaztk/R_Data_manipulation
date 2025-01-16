### Using Tidyverse - Part 5
### exploring packages:  ReadR, purrr,  DataEditR, gt



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


# tiger <- list(species = "tiger", name = "Cuddle", weight = 150, age = 12)
# shark <- list(species = "shark", name = "Teeth", weight = 302, age = 15)
# dragon <- list(species = "dragon", name = "Firebreath", weight = 2400, age = 4)
# 
# animals <- list(tiger,shark,dragon)
# names(animals) <- c("earth","water","fantasy")
# 
# map(animals,"name") # See output
# map(animals, "species") # See output
# map(animals, "age") # See output. Cool!



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

# Example: Add corresponding elements of two vectors
result <- map2(1:5, 6:10, ~ .x + .y)
print(result)









## ------------
## modify()
## ------------

#modify  
modify(c(1, 4, 200, 52525), add5percent)



## ## ## ## ## ## ## ## ## ## ## ##
## DataEditR
## ## ## ## ## ## ## ## ## ## ## ##

# install.packages("DataEditR")
library(DataEditR)



## ## ## ## ## ## ## ## ## ## ## ##
## gt
## ## ## ## ## ## ## ## ## ## ## ##
# install.packages("gt")
library(gt)

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
