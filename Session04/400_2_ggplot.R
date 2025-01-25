library(ggplot2)
library(patchwork)



####  3. Colours and Legends

colorBlindness::displayAllColors(rainbow(6))

colorBlindness::displayAllColors(viridis::viridis(6))


erupt <- ggplot(faithfuld, aes(waiting, eruptions, fill = density)) +
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
