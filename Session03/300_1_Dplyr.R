### Using Tidyverse - Part 5
### exploring packages:  ReadR, purrr,  DataEditR, gt



## ## ## ## ## ## ## ## ## ## ## ##
## readr (from Tidyverse)
## ## ## ## ## ## ## ## ## ## ## ##
# install.packages("readr")
library(readr)


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
