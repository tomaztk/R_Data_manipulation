library(tidyverse)
library(gt)

mtcars <- mtcars
mpg2 <- ggplot2::mpg


# Comparing many distributions, you can also have different perpsecitve by using:


mpg2 %>%
  ggplot(aes(as.factor(cyl), cty)) + 
  geom_boxplot()  


mpg2 %>%
  ggplot(aes(cyl, cty)) + 
  geom_boxplot(aes(group = cut_width(cyl, 1)))  



# Facets


mpg3 <- subset(mpg, cyl != 5 & drv %in% c("4", "f") & class != "2seater")

ggplot(mpg3, aes(displ, hwy)) +
  geom_point() + 
  facet_wrap(~class, ncol = 3)


# Add Table

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
