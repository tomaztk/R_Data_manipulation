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
p + geom_area() + ggtitle("Area for individual geom") # creates  areas

#other simple types for individual geoms

p + geom_polygon() + ggtitle("Polygon for individual geom")    # creates  polygons - which are filled paths
p + geom_path() + ggtitle("Path for indivudaal geom")    

#geom_rect(), geom_tile() and geom_raster() draw rectangles. 


# geom_rect() is parameterised by the four corners of the rectangle, xmin, ymin, xmax and ymax. 
p + geom_rect() + ggtitle("Sample graph using geom_rect")
# error!
# xmin, xmax, ymin, and ymax.


# Simple data frame for rectangles; we name the variables xmin, xmax, ymin, and ymax.
rect_data <- data.frame(
  xmin = c(1, 2, 3),
  xmax = c(1.5, 2.5, 3.5),
  ymin = c(1, 2, 3),
  ymax = c(2, 3, 4),
  fill_color = c("red", "lightgreen", "lightblue")
)

rect_data %>%
    ggplot(aes(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax, fill  = fill_color)) +
      geom_rect() +
      labs(title = "Simple Example of geom_rect", x = "X-axis", y = "Y-axis") 


#colours are off :) Let' add the scale_fill_identifier
rect_data %>%
  ggplot(aes(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax, fill  = fill_color)) +
  geom_rect() +
  labs(title = "Simple Example of geom_rect", x = "X-axis", y = "Y-axis") +
  scale_fill_identity(guide = "legend")   # Use the fill colors as defined in the data
  # add: guide = "legend" to scale_fill_identity funtion in order to get legend

rm(rect_data)

# geom_tile() is exactly the same, but parameterised by the center of the rect and its size, x, y, width and height. 
p + geom_tile() + ggtitle("Sample graph using geom_tile")


# geom_raster() is a fast special case of geom_tile() used when all the tiles are the same size. .
p + geom_raster() + ggtitle("Sample graph using geom_raster")
#but will get the warniing!!!


## Explore ggplot colors / themes

# packages: Rcolorbrewer, Viridis, Paletteer


#### Exercise 1
# Using Iris dataset, draw histogram, where you will display the count of each observations per species. 
# On x-axis bring species and on y-axis number of observations.

iris %>% ggplot(aes(x=Species)) +
        geom_bar() + ggtitle("Sample graph using geom_bar")


#### Exercise 2
# This same graph, make distinct colours per Species and add additional text on axis

iris %>% ggplot(aes(x=Species, fill=Species)) +
  geom_bar() + ggtitle("Sample graph using geom_bar") +
  labs(title = "Number of Observations by Species",
       x = "Species",
       y = "Number of Observations") 


### 1.2 Simple and basic graphs / collective geoms!

#  A collective geom displays multiple observations with one geometric object.
# This may be a result of a statistical summary, like a boxplot, or may be fundamental to the display of the geom, like a polygon. 
# great for longitudinal data

library(nlme)
#data(Oxboys, package = "nlme")
Oxboys <- Oxboys
head(Oxboys)

## Multiple groups, one aesthetic

# just points
Oxboys %>%
  ggplot(aes(x= age, y = height, group = Subject)) + 
  geom_point() 

# points with lines - interconnecting
Oxboys %>%
  ggplot(aes(x= age, y = height, group = Subject)) + 
  geom_point() + 
  geom_line()


# if you forget to define the grouping variable
# this happens!
Oxboys %>% 
    ggplot( aes(x=age, y=height)) + 
  geom_point() + 
  geom_line()

############
# playing with layers
#############

# different groups on different layers

Oxboys %>% 
ggplot( aes(age, height, group = Subject)) + 
  geom_line() + 
  geom_smooth(method = "lm", se = FALSE)
#> `geom_smooth()` using formula = 'y ~ x'


#changing group
Oxboys %>% 
  ggplot( aes(age, height)) + 
  geom_line(aes(group = Subject)) + 
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, linewidth = 3)


## interaction plots, profile plots, and parallel coordinate plots, like box plot
## are plots that have a discrete x scale,but still have  connecting across groups

mpg2 %>%
ggplot(aes(x=class, y=cty)) + 
  geom_boxplot()



# adding lines connecting through Occasions

Oxboys %>%
ggplot(aes(Occasion, height)) + 
  geom_boxplot() +
  geom_line(aes(group = Subject), colour = "#3366FF", alpha = 0.5)

# because adding just line without the group will not connect the dots
Oxboys %>%
  ggplot(aes(Occasion, height)) + 
    geom_boxplot() +
    geom_line(colour = "#3366FF", alpha = 0.5) # without aesthetics in geom_line



## 1.2 MAtching aesthetics to graphic objects

# important that with collective geoms  how is  the aesthetics of the individual observations 
# mapped to the aesthetics of the complete entity.

mpg2 %>%
ggplot(aes(class)) + 
  geom_bar()

mpg2 %>%
ggplot(aes(class, fill = drv)) + 
  geom_bar()


mpg2 %>%
ggplot(aes(class, fill = hwy)) + 
  geom_bar()
# will produce warning

# adding group hwy to show the value
mpg2 %>%
ggplot(aes(class, fill = hwy, group = hwy)) + 
  geom_bar()



## ## ## ## ## ## ## ## ## 
## 5. Summaries and
## statistics on graphs
## ## ## ## ## ## ## ## ## 

#Discrete x, range: geom_errorbar(), geom_linerange()
#Discrete x, range & center: geom_crossbar(), geom_pointrange()
#Continuous x, range: geom_ribbon()
# Continuous x, range & center: geom_smooth(stat = "identity")



y <- c(18, 11, 16)
df <- data.frame(x = 1:3, y = y, se = c(1.2, 0.5, 1.0))

base <- ggplot(df, aes(x, y, ymin = y - se, ymax = y + se))
base + geom_crossbar()
base + geom_pointrange()
base + geom_smooth(stat = "identity")


base + geom_errorbar()
base + geom_linerange()
base + geom_ribbon()


# Showing the weight of the data


# Unweighted
ggplot(midwest, aes(percwhite, percbelowpoverty)) + 
  geom_point()

# Weight by population
ggplot(midwest, aes(percwhite, percbelowpoverty)) + 
  geom_point(aes(size = poptotal / 1e6)) + 
  scale_size_area("Population\n(millions)", breaks = c(0.5, 1, 2, 4))
