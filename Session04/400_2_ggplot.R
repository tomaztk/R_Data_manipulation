library(ggplot2)
library(patchwork)
library(tidyverse)

library(viridis)


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
            scale_color_viridis(option = "A")+   #B, C, D, E, F, G
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
barplot(c(2,5,7), col = brewer.pal(n = 3, name = "RdBu"))

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




### 4. Building layers


### 5. Themes



## 6. Coordinate systems




## 7. FAcets
