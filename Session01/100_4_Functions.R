# Clear the Terminal 
rm(list = ls())


# ====================== Function R ============================

# Build-in Functions_____|_____ Math Function
#                        |
#                        |_____ String Function or Character Function
#                        |
#                        |_____ Statistical Probability Function 
#                        |
#                        |_____ Other Statistical Function


# -------------------------------------
# 1) Math Function
# -------------------------------------

# a) abs(var_name or value) ==> Absolute Value

variable_1 <- -25  # change to negative!!!

abs_value <- abs(variable_1)
print(abs_value)


# b) sqrt(var_name or value) ==> square root of the value
sqrt_value <- sqrt(variable_1)

print(sqrt_value)

# c) ceiling(var_name or value) ==> 6.1,6.,6.,.....,6.9 ==> 7
variable_2 <- 6.4
ceiling_value <- ceiling(variable_2)

print(ceiling_value)


# d) floor(var_name or value) ==> 6.1,6.,6.,.....,6.9 ==> 6
floor_value <- floor(variable_2)

print(floor_value)

# e) trunc(values or var_name) ==> vector value are exact convert
variable_3 <- c(2.4,3.5,5.3)
trunc_value <- trunc(variable_3)

print(trunc_value)

# f) sin(values or var_name), cos(values or var_name) and tan(values or var_name) ==> trignometric convertion
variable_4 <- 4

sin_value <- sin(variable_4)
cos_value <- cos(variable_4)
tan_value <- tan(variable_4)

print(sin_value)
print(cos_value)
print(tan_value)

# g) log(values or var_name) ==> normal logarithm 
log_value <- log(variable_4)

print(log_value)

# h) log10(values or var_name)  ==> Common logarithm 
log10_value <- log10(variable_4)

print(log10_value)

# i) exp(values or var_name)  ==> Exponent
exp_value <- exp(variable_4)

print(exp_value)

# -------------------------------------
# 2) String or Character Function in R
# -------------------------------------

# a) substr( var_name , selection_start_no , selection_end_no)
variable1 <- "987654321"

substr(variable1, 1, 4)

help(substr)

# b) grep( searching-key , items-list)

str_1 <- c('joyal','noyal','justin') # index : 1 -> joyal , 2 -> noyal , 3 -> justin

pattern <- 's'  # Searching Key word

grep(pattern, str_1)

# 3) sub("Changing_Key" , "Inserting_New_Key" , Changing_variable_name)

str_2 <- "Slovenija is beaufitul country"
change_var <- "Avstrija"
sub("Slovenija" , change_var , str_2)


str_3 <- "My friend Jakob is bad"
change_var_1 <- "Good"
sub("bad" , change_var_1 , str_3)

# 4) paste(any datatypes are declare join to String) 


paste("One",2,"Three",4,"Five")

paste0("One",2,"Three",4,"Five") #without the space


# 5) strsplit(split_string_data , " ") => character by split
str_4 <- "Split all the Characters"
strsplit(str_4,"")

str_5 <- "Work hard to great success"
strsplit(str_5," ")

# 6) tolower( var_name or value ) ==> convert to small letters

var_1 <- "HELLO LJUBLJANA"
tolower(var_1)


# 7) toupper( var_name or value ) ==> convert to Capital letters

var_2 <- "hello LjuBljana"
toupper(var_2)

# Basic Other Statistices Function
var_1 <- c(0:10)

mean(var_1)
sd(var_1)
median(var_1)
range(var_1)
sum(var_1)
min(var_1)
max(var_1)
summary(var_1)

# Create a sequence of numbers from 32 to 44.
print(seq(32,44))

# Find mean of numbers from 25 to 82.
print(mean(25:82))

# Find sum of numbers frm 41 to 68.
print(sum(41:68))



#  User-defined Function
# ========================================================
#   function_name <- function(){ 
#    ----Function Block----
#     }
# ========================================================



# 1) Without Argument and Without Return Value
function_1 <- function()
{
  print("Without Argument Without Return Value")
}

function_1()

# 2) With Argument and With Return Value
function_2 <- function(a,b)
{
  return(a+b)
}

sum_of_num <- function_2(10,20)
cat("Sum of two Number is :",sum_of_num)



# 3) Without Argument and With Return Value
function_3 <- function()
{
  num1 <- 10
  num2 <- 40
  return(num1+num2)
}

sum_of_num1 <- function_3()
cat("Sum of two number is :",sum_of_num1)


# 4) With Argument Without Return Value

function_4 <- function(var1,var2)
{
  total <- var1 + var2
  cat("Sum of two number is :",total)
}

function_4(50,100)



# 5) Argument Passing Types

# case 1

function_5 <- function(val_1,val_2,val_3)
{
  sum_avg <- val_1 + val_2 + val_3
  average <- sum_avg / 3
  cat("Average of Three numbers :",average)
}

function_5(val_1 <- 30,val_2 <- 20,val_3 <- 10) # Same Argument Name As to Function Argument Pass


# case 2

#function_5 <- function(val_1 = 20,val_2 = 45,val_3 = 67)  => this not work
function_5 <- function(val_1,val_2,val_3)
{
  sum_avg <- val_1 + val_2 + val_3
  average <- sum_avg / 3
  cat("Average of Three numbers :",average)
}

function_5(val_1 <- 30,val_2 <- 20,val_3 <- 10)



# =============== Square function =============

# Create a function to print squares of numbers in sequence.

square_function <- function(a) {
  for(i in 1:a) {
    b <- i^2
    print(b)
  }
}

square_function(6)

# =======================================
# =======================================
# ====   Sample Functions : for training
# =======================================
# =======================================

# ToDo Example
todo <- 64
while (todo > 30) {
  print("Work harder")
  todo <- todo - 7
}

# Primes example
primes <- c(2, 3, 5, 7, 11, 13)

# primes example 1
for (p in primes) {
  print(p)
}

# primes example 2
for (i in 1:length(primes)) {
  print(primes[i])
}



# sqrt with print
my_sqrt <- function(x, print_info = TRUE) {
  y <- sqrt(x)
  if (print_info) {
    print(paste("sqrt", x, "equals", y))
  }
  return(y)
}


my_sqrt(16)
my_sqrt(16, FALSE)
my_sqrt(16, TRUE)


# sum function
my_sum <- function (x, y) {
  r <- x + y
  r
}

my_sum(5, 10)


# count only numbers == 10
my_count <- function (v, x) {
  count <- 0
  for (i in 1:length(v)) {
    if (v[i] == x) {
      count <- count + 1
    }
  }
  count
}

# my_count(v=c(1:9, rep(10, 100)), x=11)  # [0]
my_count(v=c(1:9, rep(10, 100)), x=10)   # [100]


# calculating statistics
my_stats <- function(x, med = FALSE) {
  mean <- round(mean(x), 1) #avg
  stdv <- round(sd(x), 1)   #standardni odklon
  cat("Mean is:", mean, ", SD is:", stdv, "\n")
  
  if(med){   #if med(ian) is set to TRUE return, else not!
    median <- median(x)
    cat("Median is:", median , "\n")
  }
}

# my_stats(1:10, med=F)
my_stats(1:10, med=TRUE)

