library(ggplot2)
library(patchwork)
library(tidyverse)
library(viridis)
library(nlme)  # adding because of Oxboys dataset
library(RColorBrewer)
library(wesanderson)

# data
mtcars <- mtcars
mpg2 <- ggplot2::mpg

####  3. Colours and Legends

## General

# Color palette is a collection of colors.
# Color ramp is a synonym for a collection or palette of colors.
# Color space is a specific organization of colors.

## Color Blindness

# Deuteranomaly is a type of color blindness from the defectiveness of green cone cells.
# Protanomaly is a type of color blindness from the defectiveness of red cone cells.
# Tritanomaly is a type of colorblindness from the defectiveness of blue cone cells.


## Color Spaces

#HSV is an acronym for “hue-saturation-value” and is a simple transformation of the RGB palette. HSV palletes are disfavored.
#HCL is an acronym for “hue-chroma-luminance”. HCL palettes are preferred because they account for human color perception.
#RGB is an acronym for “red-green-blue”.

## Palette Types

# Qualitative palettes are used for categorical data “where no particular ordering of catgories is available and every color should receive the same perceptual weight.”
# Sequential palettes are used for “coding ordered/numeric information where colors go from high to low or vice versa.”
# Diverging palettes are “designed for coding numeric information around a central neutral value.” Their use shows contrasts between two extremes.


colorBlindness::displayAllColors(rainbow(6))
colorBlindness::displayAllColors(viridis::viridis(6))


# colour palletes

# 0) GrDevices

grDevices::colors()

"honeydew3"
"lightsteelblue2"
"pink"
"tan1" 
"turquoise4"

require(graphics)

hcl.pals()
hcl.colors(3)

hcl.pals("qualitative")
hcl.pals("sequential")
hcl.pals("diverging")
hcl.pals("divergingx")

"BluGrn"
"#F9F9F9"
"#ADCCF6"
"mistyrose"

library("colorspace")
colorspace::qualitative_hcl(3, "Set3")
colorspace::sequential_hcl(4, "Blues3")
colorspace::diverge_hcl(5, "Tropic")

hcl_palettes()

# Run with x-quartz on mac
#Caution! Do Not Run this!
pal <- choose_palette()


# 1) Viridis
#scale_color_viridis(): Change the color of points, lines and texts
#scale_fill_viridis(): Change the fill color of areas (box plot, bar plot, etc)
#viridis(n), magma(n), inferno(n) and plasma(n): Generate color palettes for base plot, where n is the number of 

# Gradient color
iris %>% ggplot( aes(Sepal.Length, Sepal.Width)) +
        geom_point(aes(color = Sepal.Length)) +
        scale_color_viridis(option = "D") +
        theme_minimal() 

iris %>% ggplot( aes(Sepal.Length, Sepal.Width))+
            geom_point(aes(color = Sepal.Length)) +
            scale_color_viridis(option = "A")+   #A, B, C, D, E, F, G, H
            theme_minimal() 


# Discrete color. use the argument discrete = TRUE
iris %>% ggplot( aes(Sepal.Length, Sepal.Width))+
          geom_point(aes(color = Species)) +
          geom_smooth(aes(color = Species, fill = Species), method = "lm") + 
          #scale_color_viridis(discrete = TRUE, option = "C")+
          scale_fill_viridis(discrete = TRUE) +
          theme_minimal() 


# 2) RColorBrewer
library(RColorBrewer)

display.brewer.all()

display.brewer.all(colorblindFriendly = TRUE)

#  scale_fill_brewer() for box plot, bar plot, violin plot, dot plot, etc
#  scale_color_brewer() for lines and points

brewer.pal(n = 8, name = "Dark2")
# "#1B9E77" "#D95F02" "#7570B3" "#E7298A" "#66A61E" "#E6AB02" "#A6761D" "#666666"
barplot(c(2,5,7,5,4,2,1,2,5), col = brewer.pal(n = 10, name = "RdBu"))  # "RdBu"))

iris %>% ggplot( aes(Sepal.Length, Sepal.Width))+
  geom_point(aes(color = Species))  + 
  scale_color_brewer(palette = "Dark2") +
  #scale_color_brewer(palette = "Pastel1") +
  theme_minimal()
  

# 3) Wes Anderson

library(wesanderson)
names(wes_palettes)

names_WA <- names(wes_palettes)

wes_palette("Darjeeling1")
wes_palette("Moonrise1")
wes_palette("GrandBudapest3")
wes_palette("AsteroidCity1")
wes_palette("AsteroidCity2")

# # 6 x 4
# števc <- 0
# for (i in 1:6){
#   for (j in 0:3){
#     števc <- števc + 1
#     p <- wes_palette(names_WA[števc])
#     print(števc)
#     cat(p)
# 
#   }
# }



# gradients viridis, distiller
erupt <- 
  faithfuld %>%
  ggplot(aes(waiting, eruptions, fill = density)) +
  geom_raster() +
  scale_x_continuous(NULL, expand = c(0, 0)) + 
  scale_y_continuous(NULL, expand = c(0, 0)) + 
  theme(legend.position = "none")

erupt
erupt + scale_fill_viridis_c()
erupt + scale_fill_viridis_c(option = "magma")
erupt + scale_fill_distiller()
erupt + scale_fill_distiller(palette = "RdPu")
erupt + scale_fill_distiller(palette = "YlOrBr")

#using fill gradient
erupt + scale_fill_gradient(low = "grey", high = "brown")
erupt + 
  scale_fill_gradient2(
    low = "grey", 
    mid = "white", 
    high = "brown", 
    midpoint = .02
  )
erupt + scale_fill_gradientn(colours = terrain.colors(7))



####  building own palletes
# scale_fill_manual() 

# getwd()


cvi_colours = list(
  cvi_purples = c("#381532", "#4b1b42", "#5d2252", "#702963",
                  "#833074", "#953784", "#a83e95"),
  my_favourite_colours = c("#702963", "#637029",    "#296370")
)


cvi_palettes = function(name, n, all_palettes = cvi_colours, type = c("discrete", "continuous")) {
  palette = all_palettes[[name]]
  if (missing(n)) {
    n = length(palette)
  }

  type = match.arg(type)
  out = switch(type,continuous = grDevices::colorRampPalette(palette)(n),discrete = palette[1:n])
  structure(out, name = name, class = "palette")
}


cvi_palettes("my_favourite_colours", type = "discrete")


df <- data.frame(x = c("A", "B", "C"), y = 1:3)
g <- ggplot(data = df, mapping = aes(x = x, y = y)) +
  theme_minimal() +
  theme(legend.position = c(0.05, 0.95),
        legend.justification = c(0, 1),
        legend.title = element_blank(),
        axis.title = element_blank())


g + geom_col(aes(fill = x), colour = "black", size = 2) + ggtitle("Fill")
g + geom_col(aes(colour = x), fill = "white", size = 2) + ggtitle("Colour")


scale_colour_cvi_d = function(name) {
  ggplot2::scale_colour_manual(values = cvi_palettes(name,type = "discrete"))
}

scale_colour_cvi_c = function(name) {
  ggplot2::scale_colour_gradientn(colours = cvi_palettes(name = name, type = "continuous"))
}

scale_fill_cvi_d = function(name) {
  ggplot2::scale_fill_manual(values = cvi_palettes(name,type = "discrete"))
  
}

scale_fill_cvi_c = function(name) {
  ggplot2::scale_fill_gradientn(colours = cvi_palettes(name = name,type = "continuous"))
  
}

scale_color_cvi_d = scale_colour_cvi_d
scale_color_cvi_c = scale_colour_cvi_c
g + geom_col(aes(fill = x), size = 3) + scale_fill_cvi_d("my_favourite_colours")




#### Drawing Missing values

df <- data.frame(x = 1, y = 1:5, z = c(1, 3, 2, NA, 5))
df

base <- ggplot(df, aes(x, y)) + 
  geom_tile(aes(fill = z), linewidth = 5) + 
  labs(x = NULL, y = NULL) +
  scale_x_continuous(labels = NULL)

base
base + scale_fill_gradient(na.value = NA)
base + scale_fill_gradient(na.value = "yellow")


## Legends

base <- 
  mpg2 %>%
  ggplot(aes(cyl, displ, colour = hwy)) +
  geom_point(size = 2)

base

# Legend can be controlled by  using the guide_colourbar() function.
  #  reverse flips the colour bar to put the lowest values at the top.
  #  barwidth and barheight allow you to specify the size of the bar. These are grid units, e.g. unit(1, "cm").
  #  direction specifies the direction of the guide, "horizontal" or "vertical".

base + guides(colour = guide_colourbar(reverse = TRUE))
base + guides(colour = guide_colourbar(barheight = unit(2, "cm")))
base + guides(colour = guide_colourbar(direction = "horizontal"))



# Discrete values can be used the guide argument to the scale function or with the guides(), 
# which can be customised using guide_legend(). 

base <- mpg2 %>% ggplot(aes(drv, fill = factor(cyl))) + geom_bar() 

base
base + guides(fill = guide_legend(ncol = 2))
base + guides(fill = guide_legend(ncol = 2, byrow = TRUE))
base + guides(fill = guide_legend(reverse = TRUE))
base + guides(colour = guide_legend(override.aes = list(alpha = 1)))


# Date legends

base <- ggplot(economics, aes(psavert, uempmed, colour = date)) + 
  geom_point() 

base
base + 
  scale_colour_date(
    date_breaks = "142 months", 
    date_labels = "%b %Y"
  )


## Legend position (is part of theme)


base <- 
  mpg2 %>%
  ggplot(aes(cty, displ, colour = drv)) +
  geom_point(aes(colour = drv), size = 3) + 
  xlab(NULL) + 
  ylab(NULL)

base

base + theme(legend.position = "left")
base + theme(legend.position = "right") # the default 
base + theme(legend.position = "bottom")
base + theme(legend.position = "none")

# positioning over the graph
base +  theme( legend.position = c(0, 1),  legend.justification = c(0, 1) )
base +  theme(legend.position = c(0.5, 0.5), legend.justification = c(0.5, 0.5))
base +  theme(legend.position = c(1, 0), legend.justification = c(1, 0))



### 4. Building layers (layer by Layer)

# 1)  mapping: A set of aesthetic mappings, specified using the aes() function 
# 2) data: A dataset which overrides the default plot dataset. It is usually omitted (set to NULL), 
# in which case the layer will use the default data specified in ggplot(). 
# 3) geom: The name of the geometric object to use to draw each observation.Can have additional arguments.  All geoms take aesthetics as parameters.
# 4) stat: The name of the statistical tranformation to use. 
#    A statistical transformation performs some useful statistical summary, and is key to histograms and smoothers. 
      # To keep the data as is, use the “identity” stat!!!!
     # !! You only need to set one of stat and geom: every geom has a default stat, and every stat a default geom. !!

# 5) position: The method used to adjust overlapping objects, like jittering, stacking or dodging.

#pseudo
layer(
  mapping = NULL, 
  data = NULL,
  geom = "point", 
  stat = "identity",
  position = "identity"
)


mod <- loess(hwy ~ displ, data = mpg)
grid <- tibble(displ = seq(min(mpg$displ), max(mpg$displ), length = 50))
grid$hwy <- predict(mod, newdata = grid)

grid


std_resid <- resid(mod) / mod$s
outlier <- filter(mpg, abs(std_resid) > 2)
outlier

mpg2 %>%
ggplot(aes(displ, hwy)) + 
  geom_point() + 
  geom_line(data = grid, colour = "blue", linewidth = 1.5) + #adding extra layer of data
  geom_text(data = outlier, aes(label = model))  ## adding extra layer of data



ggplot(mapping = aes(displ, hwy)) + 
  geom_point(data = mpg) + 
  geom_line(data = grid) + 
  geom_text(data = outlier, aes(label = model))


# map aesthetics to constants

ggplot(mpg, aes(displ, hwy)) + 
  geom_point() +
  geom_smooth(aes(colour = "loess"), method = "loess", se = FALSE) + 
  geom_smooth(aes(colour = "lm"), method = "lm", se = FALSE) +
  labs(colour = "Method")


## recap geoms:

# 
### Graphical primitives:
#  geom_blank(): display nothing. Most useful for adjusting axes limits using data.
#  geom_point(): points.
#  geom_path(): paths.
#  geom_ribbon(): ribbons, a path with vertical thickness.
#  geom_segment(): a line segment, specified by start and end position.
#  geom_rect(): rectangles.
#  geom_polygon(): filled polygons.
#  geom_text(): text.

###  One variable:
##   Discrete:
#      geom_bar(): display distribution of discrete variable.

##  Continuous:
#    geom_histogram(): bin and count continuous variable, display with bars.
#    geom_density(): smoothed density estimate.
#    geom_dotplot(): stack individual points into a dot plot.
#    geom_freqpoly(): bin and count continuous variable, display with lines.

### Two variables:
##   Both continuous:
#    geom_point(): scatterplot.
#    geom_quantile(): smoothed quantile regression.
#    geom_rug(): marginal rug plots.
#    geom_smooth(): smoothed line of best fit.
#    geom_text(): text labels.

#### Show distribution:
#   geom_bin2d(): bin into rectangles and count.
#   geom_density2d(): smoothed 2d density estimate.
#   geom_hex(): bin into hexagons and count.

## At least one discrete:
#   geom_count(): count number of point at distinct locations
#   geom_jitter(): randomly jitter overlapping points.

### One continuous, one discrete:
#     geom_bar(stat = "identity"): a bar chart of precomputed summaries.
#     geom_boxplot(): boxplots.
#     geom_violin(): show density of values in each group.

### One time, one continuous:
#    geom_area(): area plot.
#    geom_line(): line plot.
#    geom_step(): step plot.

### Display uncertainty:
#   geom_crossbar(): vertical bar with center.
#   geom_errorbar(): error bars.
#   geom_linerange(): vertical line.
#   geom_pointrange(): vertical line with center.

### Spatial:
#   geom_map(): fast version of geom_polygon() for map data.

###Three variables:
#   geom_contour(): contours.
#   geom_tile(): tile the plane with rectangles.
#   geom_raster(): fast version of geom_tile() for equal sized tiles.




### 5. Themes

base <- iris %>%
     ggplot(aes(x=Sepal.Length, y=Sepal.Width, colour=Species)) + 
     geom_point()

base

base + theme_bw()
base + theme_classic()
base + theme_dark()
base + theme_get()
base + theme_minimal()
base + theme_void()
base + theme_test()

# making own theme

my_theme <- theme(
  plot.title = element_text(size = 14, face = "bold"), # Font size set to 16 and bold.
  axis.title = element_text(size = 12), # Font size set to 12.
  axis.text = element_text(size = 10), # Font size set to 10.
  legend.title = element_text(size = 12, face = "bold"), # Font size of the title of the legend set to 12 and bold.
  legend.text = element_text(size = 10), # font size of the text in the legend
  panel.background = element_rect(fill = "lightblue"), # color of the panel background
  panel.grid.major = element_line(color = "#b29a9a", linetype = "dashed"), # color and type of the panel lines
  panel.grid.minor = element_blank(), # invisible auxiliary grids
  plot.background = element_rect(fill = "lightblue"), # plot's background
  plot.margin = margin(1, 1, 1, 1, "cm"), # chart margins
  strip.background = element_rect(fill = "white", color = "#ff975d"), # strip background
  strip.text = element_text(size = 12, face = "bold"), # strip texts
  plot.title.position = "plot", #position of the plot title
  legend.position = "right", # position of the legend
  legend.box.background = element_rect(color = "lightblue"), # background of the plot
  legend.key.size = unit(1, "cm") # size of the legends key
)


base + labs(title = "My custom theme on  base graph") + my_theme


## 6. Coordinate systems

# fliping axes with coord_flip() 

iris %>%
  ggplot(aes(x=Sepal.Length, y=Sepal.Width, colour=Species)) + 
  geom_point()

iris %>%
  ggplot(aes(x=Sepal.Length, y=Sepal.Width, colour=Species)) + 
  geom_point() + 
  coord_flip()


# fixing ration between x and y with coord_fixed()


# non-linear coordinate system

rect <- data.frame(x = 50, y = 50)
line <- data.frame(x = c(1, 200), y = c(100, 1))

base <- ggplot(mapping = aes(x, y)) + 
  geom_tile(data = rect, aes(width = 50, height = 50)) + 
  geom_line(data = line) + 
  xlab(NULL) + ylab(NULL)

base

base + coord_polar("x")
base + coord_polar("y")
base + coord_flip()
base + coord_trans(y = "log10")
base + coord_fixed()

## 7. Facets


mpg3 <- subset(mpg, cyl != 5 & drv %in% c("4", "f") & class != "2seater")


mpg3

base <- ggplot(mpg3, aes(displ, hwy)) + 
  geom_blank() + #reason why only facets are visible 
  xlab(NULL) + 
  ylab(NULL)

base

# facet_wrap() makes a long ribbon of panels (generated by any number of variables) and wraps it into 2d. 
# This is useful if you have a single variable with many levels and want to arrange the plots in a more space efficient manner. 

base + facet_wrap(~class, ncol = 3)
base + facet_wrap(~class, ncol = 3, as.table = FALSE)

base + facet_wrap(~class, nrow = 3)
base + facet_wrap(~class, nrow = 3, dir = "v")

# facet_grid() lays out plots in a 2d grid
base + facet_grid(. ~ cyl)

base + facet_grid(drv ~ .)

base + facet_grid(drv ~ cyl) + my_theme  + p1 + my_theme

base + p1