# Clear the Terminal 
rm(list = ls())


#=================================== Operators in R ==================================================

# There are four main categories of Operators in R programming language.
#1. Arithmetic Operators 2.Relational Operators 3.Logical Operators 4.Assignment Operators

# --------------------------------------- 1. Arithmetic Operators --------------------------------
#  Arithmetic Operators are used to accomplish arithmetic operations.

# R Arithmetic Operators Example for integers
a <- 7.5
b <- 2

print ( a+b ) #addition
print ( a-b ) #subtraction
print ( a*b ) #multiplication
print ( a/b ) #Division
print ( a%%b ) #Reminder
print ( a%/%b ) #Quotient
print ( a^b ) #Power of


# R Operators - R Arithmetic Operators Example for vectors

a <- c(8, 9, 6)
b <- c(2, 4, 5)

print ( a+b ) #addition
print ( a-b ) #subtraction
print ( a*b ) #multiplication
print ( a/b ) #Division
print ( a%%b ) #Reminder a.k.a modulo a.k.a. ostanek pri deljenju
print ( a%/%b ) #Quotient a.k.a. celo število
print ( a^b ) #Power of

#------------------------------------- 2.Relational Operators --------------------------------------
# Relational Operators are those that find out relation between the two operands provided to them.
# The output is boolean (TRUE or FALSE) for all of the Relational Operators in R programming language.

# R Operators - R Relational Operators Example for Numbers

a <- 7.5
b <- 2

print ( a<b ) # less than
print ( a>b ) # greater than
print ( a==b ) # equal to
print ( a<=b ) # less than or equal to
print ( a>=b ) # greater than or equal to
print ( a!=b ) # not equal to


# R Operators - R Relational Operators Example for Numbers

a <- c(7.5, 3, 5)
b <- c(2, 7, 0)

print ( a<b ) # less than
print ( a>b ) # greater than
print ( a==b ) # equal to
print ( a<=b ) # less than or equal to
print ( a>=b ) # greater than or equal to
print ( a!=b ) # not equal to


# ---------------------------------- 3.Logical Operators -----------------------------------------

# Logical Operators in R programming language work only for the basic data types logical, numeric and complex and vectors of these basic data types.

# R Operators - R Logical Operators Example for basic logical elements

a <- 0 # logical FALSE
b <- 2 # logical TRUE

print ( a & b ) # logical AND element wise
print ( a | b ) # logical OR element wise
print ( !a ) # logical NOT element wise
print ( a && b ) # logical AND consolidated for all elements
print ( a || b ) # logical OR consolidated for all elements


# R Operators - R Logical Operators Example for boolean vectors

a <- c(TRUE, TRUE, FALSE, FALSE)
b <- c(TRUE, FALSE, TRUE, FALSE)

print ( a & b ) # logical AND element wise
print ( a | b ) # logical OR element wise
print ( !a ) # logical NOT element wise
print ( a && b ) # logical AND consolidated for all elements
print ( a || b ) # logical OR consolidated for all elements



# ----------------------------------------- R Miscellaneous Operators -----------------------------

# R Operators - R Misc Operators

# semicolon  :  -creates series of numbers from left operand to right operand

a = 23:31 
print ( a )

# matching elements -  Identifies if an element(a) belongs to a vector(b)

a = c(25, 27, 76) 
b = 27
print ( b %in% a )

# Matrix  multiplication (%*%) of a vector with its transpose (t)

M = matrix(c(1,2,3,4), 2, 2, TRUE) 

#multiplication
print (M %*% t(M))


m <- matrix(1:8, nrow=2)
n <- matrix(8:15, nrow=4)
print(m)
print(n)

# Multiplying matrices using operator
print(m %*% n)


# multiplications
crossprod(M,M) 
#same as (M %*% t(M))
tcrossprod(M,M) 

# solve matrix
solve(M)

#eigenvalues
eigen(M)


