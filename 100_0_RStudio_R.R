

## -------------------------
## What are R and RStudio?
## -------------------------

# R refers to a programming language as well as the software that runs R code.


# RStudio is a software interface that can make it easier to write R scripts and interact with the R software.
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

# Short-hands

# Execute the current line
## Control + Enter

## clear the terminal
## Control + L

# Installing the package
install.packages('package_name')

# Loading R package
library(package_name)

# About package
help(package_name)


## Some environment variables

#: Returns the current working directory.
getwd()

# Set the working directory.
setwd(add_path)

# Content of the current file folder
dir()

# Information on R version, loaded packages, environmental variables
sessionInfo()

# Returns date and Time
date()

# Clear the Terminal 
rm(list = ls())

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
