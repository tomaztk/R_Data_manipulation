## ----xaringan-themer, include = FALSE------------------------------------
library(xaringanthemer)
mono_accent(base_color = "#43418A")


## ----install_ggplot, eval=FALSE, tidy=FALSE------------------------------
## install.packages("ggplot2")


## ----load_ggplot, eval=FALSE, tidy=FALSE---------------------------------
## library(ggplot2)


## ----try_ggplot, eval=FALSE, tidy=FALSE----------------------------------
## head(diamonds)
## qplot(clarity, data = diamonds, fill = cut, geom = "bar")


## ----little_arithm, comment = '', eval=TRUE, tidy=FALSE------------------
10^2 + 36


## ----work_with_variables-------------------------------------------------
a <- 4


## ----comment = ''--------------------------------------------------------
a


## ----little_arithm_challenge, eval=FALSE---------------------------------
## a*5
## (a+10)/2
## a <- a+1


## ------------------------------------------------------------------------
my_numeric <- 42.5

my_character <- "some text"

my_logical <- TRUE

my_date <- as.Date("05/29/2018", "%m/%d/%Y")


## ----comment = ''--------------------------------------------------------
class(my_numeric)
class(my_date)


## ----eval=FALSE----------------------------------------------------------
## ls()


## ----eval=FALSE----------------------------------------------------------
## rm(a)                                     # remove a single object
## rm(my_character, my_logical)              # remove multiple objects
## rm(list = c('my_date', 'my_numeric'))     # remove a list of objects
## rm(list = ls())                           # remove all objects


## ----vectors_in_R, eval=FALSE--------------------------------------------
## my_vector <- c(1, 2, 3, 4)
## my_vector_2 <- c(0, 3:5, 20, 0)
## my_vector_2[2]       # inspect entry 2 from vector my_vector_2
## my_vector_2[2:3]     # inspect entries 2 and 3
## length(my_vector_2)  # get vector length
## my_family <- c("Katrien", "Jan", "Leen")
## my_family


## ----vector_challenge, comment = ''--------------------------------------
my_vector <- c("Katrien Antonio", "teacher")
names(my_vector) <- c("Name", "Profession")
my_vector


## ----vector_challenge_solved, comment = ''-------------------------------
my_vector <- c("Katrien Antonio", "teacher")
names(my_vector) <- c("Name", "Profession")
my_vector

attributes(my_vector)
length(my_vector)
names(my_vector)


## ----matrices_in_R, comment = ''-----------------------------------------
my_matrix <- matrix(1:12, 3, 4, byrow = TRUE)
my_matrix
my_matrix[1, 1]


## ----comment = '', eval = FALSE------------------------------------------
mtcars
str(mtcars)
head(mtcars)


## ----comment = '', eval = FALSE------------------------------------------
summary(mtcars$cyl)   # use $ to extract variable from a data frame


## ----comment = '', eval = FALSE------------------------------------------
diamond
str(diamond)  # built-in in library ggplot2
head(diamond)


## ----comment = ''--------------------------------------------------------
my_list <- list(one = 1, two = c(1, 2), five = seq(1, 4, length=5),
                six = c("Katrien", "Jan"))
names(my_list)
str(my_list)


## ------------------------------------------------------------------------
fav_music <- c("Prince", "REM", "Ryan Adams", "BLOF")
num_concerts <- c(0, 3, 1, 0)
num_records <- c(2, 7, 5, 1)
my_music <- data.frame(fav_music, num_concerts, num_records)
names(my_music) <- c("artist", "concerts", "records")


## ------------------------------------------------------------------------
summary(my_music)
my_music$records
sum(my_music$records)


## ----comment = ''--------------------------------------------------------
getwd()


## ----comment = ''--------------------------------------------------------
path <- file.path("C:/Users/u0043788/Dropbox/R tutorial/Basic R")


## ----eval=FALSE----------------------------------------------------------
## path <- file.path("./data/swimming_pools.csv")


## ----eval=FALSE----------------------------------------------------------
## path.hotdogs <- file.path(path, "hotdogs.txt")
## path.hotdogs    # inspect path name
## hotdogs <- read.table(path.hotdogs, header = FALSE,
##                       col.names = c("type", "calories", "sodium"))
## str(hotdogs)    # inspect data imported


## ----eval=FALSE----------------------------------------------------------
## hotdogs2 <- read.table(path.hotdogs, header = FALSE,
##                        col.names = c("type", "calories", "sodium"),
##                        colClasses = c("factor", "NULL", "numeric"))
## str(hotdogs2)


## ----eval=FALSE----------------------------------------------------------
## path.pools <- file.path(path, "swimming_pools.csv")
## pools <- read.csv(path.pools)
## str(pools)


## ----eval=FALSE----------------------------------------------------------
## pools <- read.csv(path.pools, stringsAsFactors = FALSE)
## str(pools)


## ----eval=FALSE----------------------------------------------------------
## library(readxl)
## path.urbanpop <- file.path(path, "urbanpop.xlsx")
## excel_sheets(path.urbanpop) # list sheet names with `excel_sheets()`


## ----eval=FALSE----------------------------------------------------------
## pop_1 <- read_excel(path.urbanpop, sheet = 1)
## pop_2 <- read_excel(path.urbanpop, sheet = 2)


## ----eval=FALSE----------------------------------------------------------
## str(pop_1)
## pop_list <- list(pop_1, pop_2)


## ------------------------------------------------------------------------
path <- file.path('./data')
path.danish <- file.path(path, "danish.txt")
danish <- read.table(path.danish, header = TRUE)
danish$Date <- as.Date(danish$Date, "%m/%d/%Y")
str(danish)


## ----eval=FALSE----------------------------------------------------------
## library(haven)
## severity <- read_sas('./data/severity.sas7bdat')
## str(severity)


## ----echo=FALSE, include=FALSE-------------------------------------------
getwd()
CPS1985 <- read.table("./data/CPS1985.txt", header = TRUE)


## ------------------------------------------------------------------------
summary(CPS1985$wage)         # get a summary
is.numeric(CPS1985$wage)      # check if variable is numeric
mean(CPS1985$wage)            # get mean
var(CPS1985$wage)             # get variance


## ----out.width='45%', fig.align="center"---------------------------------
hist(log(CPS1985$wage), freq = FALSE, nclass = 20, col = "light blue")
lines(density(log(CPS1985$wage)), col = "red")


## ----comment = ''--------------------------------------------------------
summary(CPS1985$occupation)


## ----comment = ''--------------------------------------------------------
levels(CPS1985$occupation)[c(2, 6)] <- c("techn", "mgmt")
summary(CPS1985$occupation)


## ----eval=FALSE----------------------------------------------------------
## tab <- table(CPS1985$occupation)
## prop.table(tab)
## barplot(tab)
## pie(tab, col = gray(seq(0.4, 1.0, length = 6)))


## ----comment = ''--------------------------------------------------------
attach(CPS1985)                 # attach the data set to avoid use of $ 
table(gender, occupation)       # no name_df$name_var necessary
prop.table(table(gender, occupation))
detach(CPS1985)                 # now detach when work is done


## ----out.width='45%', fig.align="center"---------------------------------
plot(gender ~ occupation, data = CPS1985)


## ----echo=FALSE, include=FALSE-------------------------------------------
attach(CPS1985)


## ------------------------------------------------------------------------
tapply(wage, gender, mean)
tapply(log(wage), list(gender, occupation), mean)


## ----echo=FALSE----------------------------------------------------------
detach(CPS1985)


## ----out.width='45%', fig.align="center"---------------------------------
boxplot(log(wage) ~ gender, data = CPS1985)


## ----out.width='75%', fig.align="center"---------------------------------
boxplot(log(wage) ~ gender + occupation, data = CPS1985)


## ----eval=FALSE----------------------------------------------------------
## plot(log(subs), log(citeprice), data = Journals)
## rug(log(Journals$subs))
## rug(log(Journals$citeprice), side = 2)


## ----eval=FALSE----------------------------------------------------------
## plot(log(citeprice) ~ log(subs), data = Journals, pch = 19,
##      col = "blue", xlim = c(0, 8), ylim = c(-7, 4),
##      main = "Library subscriptions")
## rug(log(Journals$subs))
## rug(log(Journals$citeprice), side=2)


## ----out.width='45%', fig.align="center"---------------------------------
curve(dnorm, from = -5, to = 5, col = "red", lwd = 3, 
      main = "Density of the standard normal distribution")


## ----eval=FALSE----------------------------------------------------------
## library(ggplot2)
## ggplot(data = mpg)
## ggplot(mpg)


## ----comment = '', tidy=TRUE, message=FALSE, out.width='50%', fig.align="center"----
library(ggplot2)
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy))


## ----comment = '', tidy=TRUE, message=FALSE, out.width='60%', fig.align="center"----
ggplot(data = mpg) +
  geom_point(aes(x = displ, y = hwy, 
                 color = class))


## ----eval=FALSE----------------------------------------------------------
## ggplot(mpg) + geom_point(aes(x = displ, y = hwy, color = class))


## ----eval=FALSE----------------------------------------------------------
## ggplot(mpg) + geom_point(aes(x = displ, y = hwy, color = "blue"))


## ----eval=FALSE----------------------------------------------------------
## ggplot(mpg) + geom_point(aes(x = displ, y = hwy), color = "blue")


## ----eval=FALSE----------------------------------------------------------
## ggplot(mpg) + geom_point(mapping = aes(x = class, y = hwy))


## ----eval=FALSE----------------------------------------------------------
## ggplot(data = mpg) +
## geom_boxplot(mapping = aes(x = class, y = hwy))


## ----eval=FALSE----------------------------------------------------------
## ggplot(data = mpg) +
## geom_histogram(mapping = aes(x = hwy))


## ----eval=FALSE----------------------------------------------------------
## ggplot(data = mpg) +
## geom_density(mapping = aes(x = hwy))


## ----eval=FALSE----------------------------------------------------------
## ggplot(data = mpg) +
##   geom_point(mapping = aes(x = displ, y = hwy)) +
##   geom_smooth(mapping = aes(x = displ, y = hwy))


## ----message=FALSE, out.width='45%', fig.align="center"------------------
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth() + theme_bw()       # adjust theme 


## ----message=FALSE, out.width='45%', fig.align="center"------------------
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = drv)) +
  geom_smooth() + theme_bw()


## ----message=FALSE, out.width='45%', fig.align="center"------------------
library(dplyr)
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = drv)) +
  geom_smooth(data = filter(mpg, drv == "f")) + theme_bw()


## ----out.width='45%', fig.align="center"---------------------------------
plot(danish$Date, danish$Loss.in.DKM, type = "l", xlab = "Date", ylab = "Loss",
     main = "Fire insurance data")


## ----out.width='45%', fig.align="center"---------------------------------
ggplot(danish, aes(x = Date, y = Loss.in.DKM)) +  
  geom_line() + theme_bw() +
  labs(title = "Fire insurance data", x = "Date", y = "Loss") 


## ------------------------------------------------------------------------
car_price <- read.csv("./data/car_price.csv")


## ----comment = '', out.width='35%', fig.align="center"-------------------
plot(price ~  income, data = car_price)
lines(lowess(car_price$income, car_price$price), col = "blue")


## ----comment = '', out.width='45%', fig.align="center"-------------------
ggplot(car_price, aes(x = income, y = price)) +
  geom_point(shape = 1, alpha = 1/2) + 
  geom_smooth() + theme_bw()


## ----eval=FALSE----------------------------------------------------------
## str(mtcars)


## ----message=FALSE, out.width='45%', fig.align="center"------------------
library(tibble)
as_tibble(mtcars)


## ----eval=FALSE----------------------------------------------------------
## diamonds %>% filter(cut == "Ideal")


## ------------------------------------------------------------------------
filter(diamonds, cut == "Ideal")


## ------------------------------------------------------------------------
mutate(diamonds, price_per_carat = price/carat)


## ------------------------------------------------------------------------
diamonds %>% mutate(price_per_carat = price/carat) %>% 
  filter(price_per_carat > 1500) 


## ------------------------------------------------------------------------
diamonds %>% summarise(mean = mean(price), std_dev = sd(price))


## ------------------------------------------------------------------------
diamonds %>% group_by(cut) %>% summarize(price = mean(price), carat = mean(carat))


## ----eval=FALSE----------------------------------------------------------
## Parade2005 %>% filter(state == "CA") %>%
##               summarize(mean = mean(earnings))


## ----eval=FALSE----------------------------------------------------------
## Parade2005 %>% filter(state == "ID") %>% summarize(number = n())


## ----eval=FALSE----------------------------------------------------------
## Parade2005 %>% group_by(celebrity) %>%
##   summarize(mean = mean(earnings), median = median(earnings))


## ----eval=FALSE----------------------------------------------------------
## Parade2005 %>% group_by(celebrity) %>%
##   ggplot(aes(x = celebrity, y = earnings)) + theme_bw() +
##   geom_boxplot(color = "blue")


## ----eval=FALSE----------------------------------------------------------
## 3 == (2 + 1)
## "intermediate" != "r"
## (1 + 2) > 4
## katrien <- c(19, 22, 4, 5, 7)
## katrien > 5


## ----eval=FALSE----------------------------------------------------------
## TRUE & TRUE
## FALSE | TRUE
## 5 <= 5 & 2 < 3
## 3 < 4 | 7 < 6


## ------------------------------------------------------------------------
katrien <- c(19, 22, 4, 5, 7)
jan <- c(34, 55, 76, 25, 4)
katrien > 5 & jan <= 30


## ------------------------------------------------------------------------
!TRUE


## ----comment = ''--------------------------------------------------------
num_attendees <- 30
if (num_attendees > 5) {
  print("You're popular!")
}


## ----comment = ''--------------------------------------------------------
num_attendees <- 5
if (num_attendees > 5) {
  print("You're popular!")
}else{
  print("You are not so popular!")
}


## ----comment = ''--------------------------------------------------------
todo <- 64

while (todo > 30) {
  print("Work harder")
  todo <- todo - 7
}


## ----comment = '', eval=FALSE--------------------------------------------
primes <- c(2, 3, 5, 7, 11, 13)

# loop version 1
for (p in primes) {
  print(p)
}
# loop version 2
for (i in 1:length(primes)) {
  print(primes[i])
}


## ----comment = ''--------------------------------------------------------
my_sqrt <- function(x) {
  sqrt(x)
}

# use the function
my_sqrt(12)


## ----comment = ''--------------------------------------------------------
my_sqrt <- function(x, print_info = TRUE) {
  y <- sqrt(x)
  if (print_info) {
    print(paste("sqrt", x, "equals", y))
  }
  return(y)
}

# some calls of the function
my_sqrt(16)
my_sqrt(16, FALSE)
my_sqrt(16, TRUE)


## ----eval=FALSE----------------------------------------------------------
## cat("Mean is:", mean, ", SD is:", stdv, "\n")


## ----comment = ''--------------------------------------------------------
f.sum <- function (x, y) {
  r <- x + y
  r
}

f.sum(5, 10)


## ----comment = ''--------------------------------------------------------
f.count <- function (v, x) {
  count <- 0
  for (i in 1:length(v)) {
    if (v[i] == x) {
      count <- count + 1
    }
  }
  count
}

f.count(c(1:9, rep(10, 100)), 10)


## ----comment = ''--------------------------------------------------------
desi <- function(x, med = FALSE) {
  mean <- round(mean(x), 1)
  stdv <- round(sd(x), 1)
  cat("Mean is:", mean, ", SD is:", stdv, "\n")
  
  if(med){
    median <- median(x)
    cat("Median is:", median , "\n")
  }
}

desi(1:10, med=TRUE)