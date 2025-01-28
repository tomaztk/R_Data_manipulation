library(ggplot2)
library(patchwork)
library(tidyverse)
library(viridis)

# data
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

require(graphics)

hcl.pals()
hcl.colors()

hcl.pals("qualitative")
hcl.pals("sequential")
hcl.pals("diverging")
hcl.pals("divergingx")

library("colorspace")
colorspace::qualitative_hcl(3, "Set3")
colorspace::sequential_hcl(4, "Blues3")
colorspace::diverge_hcl(5, "Tropic")

hcl_palettes()

# Run with x-quartz on mac
pal <- choose_palette()


# 1) Viridis
#scale_color_viridis(): Change the color of points, lines and texts
#scale_fill_viridis(): Change the fill color of areas (box plot, bar plot, etc)
#viridis(n), magma(n), inferno(n) and plasma(n): Generate color palettes for base plot, where n is the number of 

# Gradient color
iris %>% ggplot( aes(Sepal.Length, Sepal.Width))+
        geom_point(aes(color = Sepal.Length)) +
        scale_color_viridis(option = "D")+
        theme_minimal() 

iris %>% ggplot( aes(Sepal.Length, Sepal.Width))+
            geom_point(aes(color = Sepal.Length)) +
            scale_color_viridis(option = "H")+   #A, B, C, D, E, F, G, H
            theme_minimal() 


# Discrete color. use the argument discrete = TRUE
iris %>% ggplot( aes(Sepal.Length, Sepal.Width))+
          geom_point(aes(color = Species)) +
          geom_smooth(aes(color = Species, fill = Species), method = "lm") + 
          scale_color_viridis(discrete = TRUE, option = "C")+
          #scale_fill_viridis(discrete = TRUE) +
          theme_minimal() 


# 2) RColorBrewer
library(RColorBrewer)

display.brewer.all()

display.brewer.all(colorblindFriendly = TRUE)

#  scale_fill_brewer() for box plot, bar plot, violin plot, dot plot, etc
#  scale_color_brewer() for lines and points

brewer.pal(n = 8, name = "Dark2")
barplot(c(2,5,7,5,4,2,1,2,5), col = brewer.pal(n = 10, name = "BrBG"))  # "RdBu"))

iris %>% ggplot( aes(Sepal.Length, Sepal.Width))+
  geom_point(aes(color = Species))  + 
  #scale_color_brewer(palette = "Dark2") +
  scale_color_brewer(palette = "Pastel1") +
  theme_minimal()
  

# 3) Wes Anderson

library(wesanderson)
names(wes_palettes)

names_WA <- names(wes_palettes)

wes_palette("Darjeeling1")
wes_palette("Moonrise1")
wes_palette("GrandBudapest1")
wes_palette("AsteroidCity1")
wes_palette("AsteroidCity2")

# 6 x 4
števc <- 0
for (i in 1:6){
  for (j in 0:3){
    števc <- števc + 1
    p <- wes_palette(names_WA[števc])
    print(števc)
    cat(p)

  }
}



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


library("ggplot2")
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
# base + guides(colour = guide_legend(override.aes = list(alpha = 1)))


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


### 4. Building layers (layer by Layer)

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


### 5. Themes

base <- iris %>%
     ggplot(aes(x=Sepal.Length, y=Sepal.Width, colour=Species)) + 
     geom_point()

base + theme_bw()
base + theme_classic()
base + theme_dark()
base + theme_get()
base + theme_minimal()
base + theme_void()
base + theme_test()

# making own theme

my_theme <- theme(
  plot.title = element_text(size = 16, face = "bold"), # Font size set to 16 and bold.
  axis.title = element_text(size = 14), # Font size set to 12.
  axis.text = element_text(size = 10), # Font size set to 10.
  legend.title = element_text(size = 12, face = "bold"), # Font size of the title of the legend set to 12 and bold.
  legend.text = element_text(size = 10), # font size of the text in the legend
  panel.background = element_rect(fill = "cornsilk"), # color of the panel background
  panel.grid.major = element_line(color = "#b29a9a", linetype = "dashed"), # color and type of the panel lines
  panel.grid.minor = element_blank(), # invisible auxiliary grids
  plot.background = element_rect(fill = "cornsilk"), # plot's background
  plot.margin = margin(1, 1, 1, 1, "cm"), # chart margins
  strip.background = element_rect(fill = "cornsilk", color = "#ff975d"), # strip background
  strip.text = element_text(size = 12, face = "bold"), # strip texts
  plot.title.position = "plot", #position of the plot title
  legend.position = "right", # position of the legend
  legend.box.background = element_rect(color = "cornsilk"), # background of the plot
  legend.key.size = unit(1, "cm") # size of the legends key
)


base + labs(title = "My custom theme on  base graph") + my_theme


## 6. Coordinate systems




## 7. FAcets
