### Using Tidyverse/ggplot - Part 5

getwd()
setwd("/Users/tomazkastrun/Documents/tomaztk_github/R_Data_manipulation/Session04")

library(tidyverse)
library(ggplot2)

# additional packages
# install.packages(c(
#   "colorBlindness", "directlabels", "ggforce", "gghighlight", 
#   "ggnewscale", "ggplot2", "ggraph", "ggrepel", "ggtext", "ggthemes", 
#   "hexbin", "Hmisc", "mapproj", "maps", "munsell", "ozmaps", 
#   "paletteer", "patchwork", "rmapshaper", "scico", "seriation", "sf", 
#   "stars", "tidygraph", "wesanderson" 
# ))


# What is ggplot2? - ggplot2 is a visualization package in R that implements the "Grammar of Graphics" to create complex and aesthetic visualizations.
# Why use ggplot2? - Customizable, supports layering, works with tidy data, and integrates well with dplyr.
# Required Data.frame Format: - Works with data frames or tibbles, preferably in long format for facets or grouped visualizations.


# All plots are composed of the data, the information you want to visualise, and a mapping, the description of how the data’s variables are mapped to aesthetic attributes. There are five mapping components:

# 1)  A layer is a collection of geometric elements and statistical transformations. 
# Geometric elements, geoms for short, represent what you actually see in the plot: points, lines, polygons, etc. 
# Statistical transformations, stats for short, summarise the data: for example, binning and counting observations to create a histogram, or fitting a linear model.
# 
# 2) Scales map values in the data space to values in the aesthetic space. This includes the use of colour, shape or size. 
# Scales also draw the legend and axes, which make it possible to read the original data values from the plot (an inverse mapping).
# 
# 3) A coord, or coordinate system, describes how data coordinates are mapped to the plane of the graphic. It also provides axes 
# and gridlines to help read the graph. We normally use the Cartesian coordinate system, but a number of others are available, including 
# polar coordinates and map projections.
# 
# 4) A facet specifies how to break up and display subsets of data as small multiples. This is also known as conditioning or latticing/trellising.
# 
# 5) A theme controls the finer points of display, like the font size and background colour. While the defaults in ggplot2 have been 
# chosen with care, you may need to consult other references to create an attractive plot. 
# A good starting place is Tufte’s early works (Tufte 1990, 1997, 2001).


ggplot()

## ## ## ## ## ## ## ## ## 
## 0. General Key components
## ## ## ## ## ## ## ## ## 

# Key concepts
    # 1)   data,
    # 2) A set of aesthetic mappings between variables in the data and visual properties, and
    # 3) At least one layer which describes how to render each observation. Layers are usually created with a geom function.

mtcars <- mtcars
mpg2 <- ggplot2::mpg


mpg2 %>%
  ggplot(aes(x=displ, y=hwy)) +
  geom_point()

# key components
ggplot(mpg2,                   #data
      aes(x=displ, y=hwy)) +   #aesthetic mappings
  geom_point()                 #layer for data rendering


ggplot(mtcars,                   #data
       aes(x=disp, y=wt)) +   #aesthetic mappings
  geom_point()                 #layer for data rendering



#how can we describe these
ggplot(mpg2, aes(cty, hwy)) + geom_point()
ggplot(diamonds, aes(carat, price)) + geom_point()
ggplot(economics, aes(date, unemploy)) + geom_line()
ggplot(mpg2, aes(cty)) + geom_histogram()


# upgrading aesthetics

# aes(displ, hwy, colour = class)
# aes(displ, hwy, shape = drv)
# aes(displ, hwy, size = cyl)


ggplot(mpg2, aes(displ, hwy, colour = class)) + geom_point() # good for categorical variables
ggplot(mpg2,  aes(displ, hwy, shape = drv)) + geom_point()
ggplot(mpg2,  aes(displ, hwy, size = cyl)) + geom_point() # good for continuous variables



ggplot(mpg2, aes(displ, hwy, colour = class)) + geom_point()
#can be converted for single value 
ggplot(mpg2, aes(displ, hwy)) + geom_point(aes(colour = "blue"))
ggplot(mpg, aes(displ, hwy)) + geom_point(colour = "blue")



# facets

ggplot(mpg2, aes(displ, hwy, colour = class))  + geom_point()

# or into each graphs
ggplot(mpg2, aes(displ, hwy)) + 
  geom_point() + 
  facet_wrap(~class)
                                     

#### 1. Layers

# data + aesthetics + layer mapping graph

### 1.1 Simple and basic graphs / individual geoms!

# Each of these geoms is two dimensional and requires both x and y aesthetics.
   # geom_area()
   # geom_bar()
   # geom_point()
   # geom_line()


# lets create sample dataset
mpg2_short <- mpg2 %>%
  select("cty", hwy) %>%
  tail(5) %>%
  transmute( x = cty
          ,y = hwy
          ,id_label = 1:5)

mpg2_short


p <- ggplot(mpg2_short, aes(x, y, label = id_label)) + 
  labs(x = NULL, y = NULL) + # we will explain it later
  theme(plot.title = element_text(size = 15)) # defined schema

#check p
p

p + geom_point() + ggtitle("point")
p + geom_path() + ggtitle("Connecting the dots")
p + geom_text() + ggtitle("This is sample dataset with geom_text")
p + geom_bar(stat = "identity") + ggtitle("Sample graph using geom_bar")
p + geom_tile() + ggtitle("Sample graph using geom_tile")



