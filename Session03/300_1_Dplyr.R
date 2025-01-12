### Using Tidyverse - Part 5
### exploring packages:  ReadR, purrr,  DataEditR, gt



## ## ## ## ## ## ## ## ## ## ## ##
## readr (from Tidyverse)
## ## ## ## ## ## ## ## ## ## ## ##
# install.packages("readr")
library(readr)



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
