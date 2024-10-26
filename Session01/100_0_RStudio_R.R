
# ================================= R and R Studio =====================================

## -------------------------
## What are R and RStudio?
## -------------------------

# R refers to a programming language as well as the software that runs R code.
# It is a statistical computing language that is open source, and hence freely available to anyone. 
# You do not need a special license or set of permissions to use and develop code in R. This makes this langauge also super popular 
# and broadly available.

# R language is itself is an interpreted computer language and comes with functionality that comes bundled with the language itself, 
# known as “base R”. But there is also rich additional functionality provided by external packages, or libraries of code for 
# accomplishing certain tasks and can be freely downloaded and loaded for use. Normally, these packages are available through CRAN.


#  RStudio (now Posit Software, PBC) is a software interface that can make it easier to write R scripts and interact with the R software.
# R Studio is an integrated development environment(IDE) for R
# It’s a very popular platform,  and RStudio also maintains the tidyverse series of packages we will use. 
# R Studio is available as both Open source and Commercial software.
# R Studio is also available as both Desktop and Server versions.
# R Studio is also available for various platforms such as Windows, Linux, and macOS.


## Walk through the program

#  1. The Editor pane is where you can write R scripts and other documents. 
# Each tab here is its own document. This is your text editor, which will allow you to save your R code for future use. 
# Note that change code here will not run automatically until you run it.

# 2. The Console pane is where you can interactively run R code.

# 2.B There is also a Terminal tab here which can be used for running programs outside R on your computer

# 3. The Environment pane primarily displays the variables, sometimes known as objects that are defined 
# during a given R session, and what data or values they might hold. Tabs are:

    # Environment tab - will show you all the variables that are generated in  a workspace that is temporary (unless stored / Persisted otherwise).
         # Global environment / Packages / Languages (R, Python)
    # History tab -  will give you all the commands that are were or are used in current usage of  R Studio session.
    # Connection tab - will give you all external connections to different source (e.g.: databases)


# 4. The pane for Files, Plots, Help, Viewer, .. has several pretty important tabs:
 #  The Files tab shows the structure and contents of files and folders (also known as directories) on your computer. 
 #  The Plots tab will reveal plots when you make them
 #  The Packages tab shows which installed packages have been loaded into your R session
 #  The Help tab will show the help page when you look up a function (use it!)
 #  The Viewer tab will reveal compiled R Markdown documents



## R Studio commands
# ------------------------------------

# Short-hands

# Execute the current line
## Control + Enter

234+123

## clear the terminal
## Control + L


# Installing the package
install.packages('package_name')
install.packages("ggplot2")

# Loading R package
library(package_name)
library(ggplot2)

# About package
help("geom_area")


## Some environment variables

#: Returns the current working directory.
getwd()

# Set the working directory.
setwd("/Users/tomazkastrun/Documents/AoC2020")
# setwd("c:\\Users\\tomazkastrun\\Documents")


# Content of the current file folder
dir()

# Information on R version, loaded packages, environmental variables
sessionInfo()

# Returns date and Time
date()

# Clear the Terminal 
rm(list = ls())

a=1
b=2

# returns the list of all the environmental variables
ls()

# remove an object
rm()

# Eg:
a <- 20
rm(a)


# help
sum(1,2,3)

#hit F1
sum()

# or :)
help("sum")
#help(sum)



## R Language syntax rules and history
# ------------------------------------

# The R language is a dialect of S (S language) which was designed in the 1980s and has been 
# in widespread use in the statistical community since. Its principal designer, John M. Chambers, 
# was awarded the 1998 ACM Software Systems Award for S.

# The language syntax has a superficial similarity with C, 
# but the semantics are of the FPL (functional programming language) variety with stronger affinities with Lisp and APL. 
# In particular, it allows “computing on the language”, which in turn makes it possible to write functions that take expressions
# as input, something that is often useful for statistical modeling and graphics. 


# R is case-sensitive

MyVariable <- 10
myVariable <- 10

print(MyVariable == myVariable)

a <- 100

a_1 <- 200


# R uses a "less than" sign and a dash (<-) for assignment values to variables
# R Operators - R Assignment Operators

a <- 100
print ( a )

# you can also use
aa = 1000
print (aa)


#logical values
a <- TRUE
print ( a )

#left to right (not prefered way)
454 -> a
print ( a )

# double arrows (not prefered way)
a <<- 2.9
print ( a )

#left to right (not prefered way)
c(6, 8, 9) -> a
print ( a )



# R quoting convention (single vs. double)

text1 <- "Tomaz's laptop"
text2 <- 'Tomaz\'s laptop2'

print(text1)
print(text2)

# path specifications and exiting the backslash (double)
path <- "c:\\users\\Tomazkastrun\\MyDocuments" #for windows
path <- "/Users/tomazkastrun"

# adding new line in print
data <- c(1,2,3,4)

cat("\nCases in Split: ", data[1])
print("\nCases in Split: ", data[1])


# commenting

# single 

# r <- 12
# b <- 444


# for multiple lines use

#  Select the lines of code that we want to comment out.
#  Press Ctrl + Shift + C (on Mac: Cnt + Shift + C) on your keyboard and toggle 

test
test
test


