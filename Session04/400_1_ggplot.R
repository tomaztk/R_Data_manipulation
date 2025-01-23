
### Arranging plots

library(ggplot2)
library(patchwork)


p1 <- ggplot(mpg2) + 
  geom_point(aes(x = displ, y = hwy))

p2 <- ggplot(mpg2) + 
  geom_bar(aes(x = as.character(year), fill = drv), position = "dodge") + 
  labs(x = "year")

p3 <- ggplot(mpg2) + 
  geom_density(aes(x = hwy, fill = drv), colour = NA) + 
  facet_grid(rows = vars(drv))

p4 <- ggplot(mpg2) + 
  stat_summary(aes(x = drv, y = hwy, fill = drv), geom = "col", fun.data = mean_se) +
  stat_summary(aes(x = drv, y = hwy), geom = "errorbar", fun.data = mean_se, width = 0.5)


# plots arranging

p1 + p2

p1 + p2 + p3 + p4


# arranging differently

p1 + p2 + p3 + plot_layout(ncol = 2)

#package patchwork
# patchwork provides two operators, 
# # | and / respectively, to facilitate this (under the hood they simply set number of rows or columns in the layout to 1).

p1 / p2

p3 | p4


# and creating beautiful combinations

p3 | (p2 / (p1 | p4))


# for more complex outlies, you can specify the layout
layout <- "
AAB
C#B
CDD
"

p1 + p2 + p3 + p4 + plot_layout(design = layout)


#and using collect

p1 + p2 + p3 + plot_layout(ncol = 2, guides = "collect")
p1 + p2 + p3 + guide_area() + plot_layout(ncol = 2, guides = "collect")


###### ###### ######
## Positions and scales
###### ###### ######

mpg2 %>%
ggplot(aes(x = displ)) + 
    geom_histogram()

# In this example the y aesthetic is not specified by the user. 
# Rather, the aesthetic is mapped to a computed variable: geom_histogram() 
# computes a count variable that gets mapped to the y aesthetic. 
# The default behaviour of geom_histogram() is equivalent to the following:
  
mpg2 %>%
ggplot(aes(x = displ, y = after_stat(count))) + 
    geom_histogram()



# aligning scales

mpg_99 <- mpg2 %>% filter(year == 1999)
mpg_08 <- mpg2 %>% filter(year == 2008)

base_99 <- ggplot(mpg_99, aes(displ, hwy)) + geom_point() 
base_08 <- ggplot(mpg_08, aes(displ, hwy)) + geom_point() 

# we see that the scales are off
base_99 #y-scale from 15 to 45
base_08 #y-scale from 15 to 35


# we fix the x-axis and y-axis with limits
base_99 + 
  scale_x_continuous(limits = c(1, 7)) +
  scale_y_continuous(limits = c(10, 45))

base_08 + 
  scale_x_continuous(limits = c(1, 7)) +
  scale_y_continuous(limits = c(10, 45))



# adding breaks in scales

break_data <- data.frame(
  const = 1, 
  up = 1:4,
  txt = letters[1:4], 
  big = (1:4)*1000,
  log = c(2, 5, 10, 2000)
)

base <- ggplot(break_data, aes(big, const)) + 
  geom_point() + 
  labs(x = NULL, y = NULL) +
  scale_y_continuous(breaks = NULL) 

base


# we can now change the breaks by adding major or minor gridlines

base + scale_x_continuous(breaks = c(1000, 2000, 4000))
base + scale_x_continuous(breaks = c(1000, 1500, 2000, 4000))


# many different breaks

#scales::breaks_extended() creates automatic breaks for numeric axes.
#scales::breaks_log() creates breaks appropriate for log axes.
#scales::breaks_pretty() creates “pretty” breaks for date/times.
#scales::breaks_width() creates equally spaced breaks.


#minor breaks

base <- ggplot(break_data, aes(log, const)) + 
  geom_point() + 
  labs(x = NULL, y = NULL) +
  scale_y_continuous(breaks = NULL) 

# create x-scale
mb <- unique(as.numeric(1:10 %o% 10 ^ (0:3)))

base + scale_x_log10()
base + scale_x_log10(minor_breaks = mb)


# Labels

base <- ggplot(break_data, aes(big, const)) + 
  geom_point() + 
  labs(x = NULL, y = NULL) +
  scale_y_continuous(breaks = NULL) 

base
base + 
  scale_x_continuous(
    breaks = c(2000, 4000), 
    labels = c("2k", "4k")
  ) 


base <- ggplot(break_data, aes(big, const)) + 
  geom_point() + 
  labs(x = NULL, y = NULL) +
  scale_x_continuous(breaks = NULL)

base

base + scale_y_continuous(labels = scales::label_percent())

base + scale_y_continuous(
  labels = scales::label_dollar(prefix = "", suffix = "€")
)


## Transformations

base <- ggplot(mpg2, aes(displ, hwy)) + geom_point()

base
base + scale_x_reverse()
base + scale_y_reverse()

# Every continuous scale takes a trans argument, allowing the use of a variety of transformations: 

# convert from fuel economy to fuel consumption
ggplot(mpg, aes(displ, hwy)) + 
  geom_point() + 
  scale_y_continuous(trans = "reciprocal")

# log transform x and y axes
ggplot(diamonds, aes(price, carat)) + 
  geom_bin2d() + 
  scale_x_continuous(trans = "log10") +
  scale_y_continuous(trans = "log10")

# couple of transformers
# "log" 	scales::log_trans() 	
# log10" 	scales::log10_trans()
# "logit" 	scales::logit_trans()
# "exp" 	scales::exp_trans()


# same transformation
mpg2 %>%
ggplot(aes(displ, hwy)) + 
  geom_point() + 
  scale_y_continuous(trans = "reciprocal")

mpg2 %>%
ggplot(aes(displ, hwy)) + 
  geom_point() + 
  scale_y_continuous(trans = scales::reciprocal_trans())


# or

# manual transformation
mpg2 %>%
ggplot( aes(log10(displ), hwy)) + 
  geom_point()

# transform using scales
mpg2 %>%
ggplot( aes(displ, hwy)) + 
  geom_point() + 
  scale_x_log10()


# time labels

# %a 	day of week, abbreviated (Mon-Sun)
# %A 	day of week, full (Monday-Sunday)
# %e 	day of month (1-31)
# %d 	day of month (01-31)
# %m 	month, numeric (01-12)
# %M 	minute (00-59)
# %l 	hour, in 12-hour clock (1-12)
# %I 	hour, in 12-hour clock (01-12)
# %p 	am/pm
# %H 	hour, in 24-hour clock (00-23)


base <- ggplot(economics, aes(date, psavert)) + 
  geom_line(na.rm = TRUE) +
  labs(x = NULL, y = NULL)

base + scale_x_date(date_breaks = "5 years")
base + scale_x_date(date_breaks = "5 years", date_labels = "%y")


lim <- as.Date(c("2004-01-01", "2005-01-01"))

base + scale_x_date(limits = lim, date_labels = "%b %y")
base + scale_x_date(limits = lim, date_labels = "%B\n%Y")


base + 
  scale_x_date(
    limits = lim, 
    labels = scales::label_date_short()
  )


# label positioning

base <- ggplot(economics, aes(date, psavert)) + 
  geom_line(na.rm = TRUE) +
  labs(x = NULL, y = NULL)

base + scale_x_date(date_breaks = "5 years")

base + guides(x = guide_axis(n.dodge = 3))
base + guides(x = guide_axis(angle = 90))


# Binned position scales

ggplot(mpg, aes(hwy)) + geom_histogram(bins = 8)

ggplot(mpg, aes(hwy)) + 
  geom_bar() +
  scale_x_binned() 





