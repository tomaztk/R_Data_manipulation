## Data manipulation with dplyr


install.packages("dplyr")
install.packages("ggplot2")

library(dplyr)
library(ggplot2)
library(readr)

## Data available: https://www.kaggle.com/code/ayessa/wine-price-regression    
wine <- read_csv("https://raw.githubusercontent.com/tomaztk/R_Data_manipulation/refs/heads/main/data/wine.csv")

# if locally
#wine <- read.csv("wines_SPA.csv",  stringsAsFactors = FALSE,  encoding = 'UTF-8')
View(wine)

#Removing columns from dataset
wine <- wine[,-c(1,3)]

#Creating a dataset by counting all observations grouped by country and then creating a new variable called count
wine %>% 
  group_by(country)%>% 
  summarize(count=n()) %>% 
  arrange(desc(count))

#Creating a new variable which contains the top 10 countries
selected_countries = wine %>% 
  group_by(country) %>% 
  summarize(count=n()) %>% 
  arrange(desc(count)) %>% 
  top_n(10) %>% 
  select(country)

selected_countries


#Changing the format from data frame to vector as.character referencing the country column
selected_countries = as.character(selected_countries$country)

class(selected_countries)

#Subsetting data selecting top ten countries and their points from wine
select_points=wine %>% 
  filter(country %in% selected_countries) %>%
  select(country, points) %>% 
  arrange(country)

#Scatterplot with smooth line
ggplot(wine, aes(points,price)) + 
  geom_point() + 
  geom_smooth()

#Boxplot between country and points, reordered by median of points. Center aligning the Title of the boxplot
ggplot(select_points, 
       aes(x=reorder(country,points,median),
           y=points)) +
  geom_boxplot(aes(fill=country)) +
  xlab("Country") +
  ylab("Points") + 
  ggtitle("Distribution of Top 10 Wine Producing Countries") + 
  theme(plot.title = element_text(hjust = 0.5))

#Filter by countries that do not appear on the selected_countries dataset
wine %>% 
  filter(!(country %in% selected_countries)) %>%
  group_by(country) %>%
  summarize(median=median(points)) %>%
  arrange(desc(median))

#Creating a new variable called top using country and points to rate them based on points
top=wine %>%
  group_by(country) %>%
  summarize(median=median(points)) %>%
  arrange(desc(median))

class(top)

#Changing the format from data frame to vector as.character referencing the country column
top=as.character(top$country)
top

#Using intersect  function to select the common values in both datasets
both=intersect(top,selected_countries)
both

#Using setdiff to select the non-overlapping values in both datasets
not = setdiff(top, selected_countries)
not

#Creating a subset based on variety using group by and summarize
topwine = wine %>%
  group_by(variety) %>%
  summarize(number=n()) %>%
  arrange(desc(number)) %>%
  top_n(10)

topwine=as.character(topwine$variety)

topwine

#Plot based on variety and points using group by and summarize
wine %>%
  filter(variety %in% topwine) %>%
  group_by(variety)%>%
  summarize(median=median(points)) %>%
  ggplot(aes(reorder(variety,median),median)) +
  geom_col(aes(fill=variety)) +
  xlab('Variety') + ylab('Median Point') +
  scale_x_discrete(labels=abbreviate)

#Creating top 15 percent cheapest wines with high rating using intersect function
top15percent=wine %>%
  arrange(desc(points)) %>%
  filter(points > quantile(points, prob = 0.85))

cheapest15percent=wine %>%
  arrange(price) %>%
  head(nrow(top15percent))

goodvalue = intersect(top15percent,cheapest15percent)

goodvalue

#Feature Engineering

wine = read.csv('wine.csv',
                stringsAsFactors = FALSE,
                encoding = 'UTF-8')

save(wine, file = "wine.rda")
load("wine.rda")

#Omiting one column from the wine dataset
wine = wine[,-c(3)]  

View(wine)

#Using transmute and mutate functions to append a new column
wine1 = wine %>%
  mutate(PPratio = points/price)

wine2 = wine %>%
  transmute(PPratio = points/price)

#Aggregation by country using group by and summarize
wine  %>%
  group_by(country) %>%
  summarize(total = n())

#Missing country values
wine[wine$country == "",]

#Adding missing values in the dataset
wine$country = 
  ifelse(wine$designation == "Askitikos",
         "Greece", wine$country)
wine$country =
  ifelse(wine$designation == "Piedra Feliz",
         "Chile", wine$country)
wine$country =
  ifelse(wine$variety == "Red Blend",
         "Turkey", wine$country)

#Combining Datasets

#Creating a new subset by total number of rows by country
newwine = wine  %>%
  group_by(country) %>%
  summarize(total = n()) %>%
  arrange(desc(total))

#Creating subsets with the head of wine and newwine
subset1=head(wine)
subset2=head(newwine)

#Combining two data frames using full join function
full = full_join(subset1, subset2)
full

#Combining two data frames using inner join function
inner = inner_join(subset1, subset2)
inner

#Combining two data frames using left join function
left = left_join(subset1, subset2)
left



#######################################################################################
#######################################################################################
#######################################################################################

# Uncomment and edit as necessary
install.packages(c("Lahman", "ggplot2", "plyr", "reshape2", 
"data.table", "tidyr"))

# Download and install latest version of dplyr
# On Windows and Macs, you need to install from source at present
# On Windows, this means you need to have Rtools3.1 
# installed from CRAN before installing dplyr. Should be OK on MacOS.
# The installation takes a couple of minutes since C++ files 
# must be compiled.
install.packages("dplyr", type = "source")


# Load packages

library(ggplot2)
library(Lahman)
library(data.table)
library(tidyr)
library(dplyr)


# Toy data frame for basic illustrations
DF <- data.frame(gp = gl(3, 4, labels = LETTERS[1:3]),
                 x = sample(seq(12)),
                 y = rnorm(12))

## Examples of how to use the tbl_*() functions

DT <- data.table(DF, key = "gp")
dft <- tbl_df(DF)   # data frame to dplyr tbl
dtt <- tbl_dt(DT)   # data table to dplyr tbl

str(dft)
str(dtt)
rm(DT, dtt)   # won't use data.table again 
detach(package:data.table, unload = TRUE)


###################
## One-table verbs
###################

# arrange(): sorting

arrange(dft, gp, y)
dft %>% arrange(gp, y)     # data pipeline version
dft %>% arrange(gp, desc(x))  # reverse sort by x w/i gp

# filter(): row subsetting

dft %>% filter(gp == "A")
dft %>% filter(gp %in% c("A", "B") & y > 0)


# count(): frequency tabulation
dft %>% count(gp)
dft %>% count(gp, y > 0)

# tally(): sums numeric vars

dft %>% group_by(gp) %>% tally(y)  # sum of y by gp


# select(): selects columns to retain

dft %>% select(-x)   # remove column named x
dft %>% select(starts_with("g"))   # returns gp

### Better idea of how the function works:
example(dplyr::select)

# summarise(): one-number summar[y/ies] of a variable

dft %>% group_by(gp) %>% summarise(mean_y = mean(y), sd_y = sd(y), n = n())


# mutate(): transforms or creates variables within a tbl object

dft %>% 
  group_by(gp) %>%
  mutate(abs_y = abs(y), norm_y = scale(y, scale = TRUE),
         z = x + 2 * y)

# transmute(): like mutate() except that it drops unused existing variables
#              New in version 0.3

dft %>% mutate(abs_y = abs(y), z = 1 + y/2)
dft %>% transmute(abs_y = abs(y), z = 1 + y/2)

### transmute() can also operate groupwise

dft %>% 
  group_by(gp) %>% 
  transmute(norm_y = scale(y, scale = TRUE))


# slice(): row indexing operator in dplyr using vector positions
#          rather than logical expressions

dft %>% slice(1:5)
dft %>% slice(c(2, 5, 7, 10))

dft %>% group_by(gp) %>% slice(n())
dft %>% group_by(gp) %>% slice(1)

# rename(): renames variables

rename(dft, xx = x, yy = y)
dft %>% rename(xx = x)


##################
# Two-table verbs
##################

t1 <- data.frame(name = c("Tom", "Rick", "Harriet", "Ralph", 
                          "Noriko", "Tyrone", "Ingrid"),
                 position = c("VP", "AVP", "VP", "AVP",
                              "CFO", "CEO", "IT"))
t2 <- data.frame(name = c("Tom", "Harriet", "Ralph", "Noriko",
                          "Ingrid"),
                 company = c("A", "A", "B", "B", "A"))

T1 <- tbl_df(t1)
T2 <- tbl_df(t2)
rm(t1, t2)

inner_join(T1, T2)
left_join(T1, T2)
left_join(T2, T1)   # right join
semi_join(T1, T2)
anti_join(T1, T2)



#################
# do() function
#################

# Used to apply a non-verb function groupwise to a tbl object
# Particularly useful for model-fitting functions

teams <- tbl_df(Lahman::Teams)
teams1013 <- teams %>% 
  filter(yearID >= 2010) %>%
  select(yearID, H, R, lgID)
# Reset the levels of lgID
teams1013 <- teams1013 %>% mutate(lgID = factor(lgID))

# Model runs scored vs. hits by team within season

mod1 <- teams1013 %>% 
  group_by(yearID, lgID) %>%
  do(mod = lm(R ~ H, data = .))

# Some useful things to extract from this object
class(mod1)
length(mod1)
sapply(mod1, class)
mod1


# Utility functions to extract R^2 and the model coefficients

r2 <- function(m) summary(m)$r.squared

coef_df <- function(m) 
{
  sc <- coef(m)
  names(sc) <- c("Intercept", "Slope")
  data.frame(as.list(sc))
}


## In this case, do() is working row-wise on mod1 because the
## mod component is a list, which is why we use [1] for the first
## two variables

mod1 %>% do(data.frame(year = .$yearID[1], league = .$lgID[1],
                       coef_df(.$mod), rsq = r2(.$mod)))

## Another approach, appending the results of do() to the first
## two columns of mod1

data.frame(mod1[, 1:2], 
           mod1 %>% do(data.frame(coef_df(.$mod), 
                                  rsq = r2(.$mod))))



# Alternative approach: all in one
summfun <- function(d)
{
  rsq <- do.call(c, lapply(d$mod, r2))
  coeff <- do.call(rbind, lapply(d$mod, coef))
  dd <- data.frame(d$yearID, d$lgID, coeff, rsq)
  names(dd) <- c("year", "league", "intercept", "slope", "rsq")
  dd
}
summfun(mod1)


##############
## tidyr
##############

# parallels dplyr as reshape2 parallels plyr


### gather()
### stacks multiple columns into two

m1 <- matrix(rnorm(20), ncol = 5, 
             dimnames = list(NULL, paste0("x", 1:5)))
m2 <- matrix(rnorm(20), ncol = 5, 
             dimnames = list(NULL, paste0("y", 1:5)))

DF1 <- data.frame(g = gl(2, 2, labels = LETTERS[1:2]),
                  m1, m2)
names(DF1)

dft1 <- tbl_df(DF1)
dft2 <- dft1 %>% 
  gather(xvar, xvalue, x1:x5)  %>%
  gather(yvar, yvalue, y1:y5)
str(dft2)


### spread() is the inverse function of gather():
### unstacks two columns into several

dft2 %>% spread(xvar, xvalue)



### separate() splits a variable name into two new ones

DF2 <- data.frame(smin = c(2, 4, 3), smax = c(3, 6, 7),
                  tmin = c(3, 0, 4), tmax = c(5, 1, 8))
DFT2 <- tbl_df(DF2)
( DFT3 <- DFT2 %>% gather(var, value, smin:tmax) %>%
    separate(var, c("type", "stat"), 1) )


### unite() is the inverse function of separate

DFT3 %>% unite(type_stat, type, stat)




#Combining two data frames using right join function
right = right_join(subset1, subset2)
right