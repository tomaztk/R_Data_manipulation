
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


