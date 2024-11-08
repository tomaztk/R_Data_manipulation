# Clear the Terminal 
rm(list = ls())



#----------------------------------Conditional Statement ----------------------------------

#----------------If Statement-----------------------------------------------------------------

num1 <- 10
num2 <- 20

if(num1<=num2){
  print("Num1 is less or equal to Num2")
}

x <- 2
repeat {
    x <-  x^2
    print(x)

  if(x>1000) { #exit criterion
    break    
  }
}  

#-------------- If Else IF Statement ----------------------------------------------------------

#Example1:

if (2==1) {
  print("1")
} else if (2==2) {
  print("2")
} else {
  print("3")
}


#Example2: 

Num1 <- 10
Num2 <- 20

if (Num1<Num2) { 
  print("Num1 is lesser than Num2") 
} else if( Num1 > Num2){
  print( "Num2 is lesser than Num1") 
} else {
  print("Num1 and Num2 are Equal") }


#Example3:

x <- 2
if(x>2) {
  print("x is greater than 5")
} else if(x==2) {
  print("x is equal to 2")
} else {
  print("x is not greater than 2")
}


# ---------------------IF Else -----------------------------------------

#Example:
x <- -5

if(x > 0){
  print("Non-negative number")
} else {
  print("Negative number")
}



# ----------------- Switch statement -------


# Switch Statement

# switch(expression ,
#              case1,
#              case2,
#              case3,
#              .....,
#              .....,
#              case-n)


# Case 1: Arithmetic Operations

cat(" 1) Addition\n")
cat(" 2) Subtraction\n")
cat(" 3) Multiplication\n")
cat(" 4) Division\n")
cat(" 5) Modulas\n")
var1 <- readline(prompt = "Enter the First Element :")
var2 <- readline(prompt = "Enter the Second Element :")
choice <- readline(prompt = "Enter Your Choice :")

var1 <- as.integer(var1)
var2 <- as.integer(var2)
choice <- as.numeric(choice)

res <- switch (
  choice,
  
  "1" <- cat("Addtion of Two Number is :",var1+var2),
  "2" <- cat("Subtraction of Two Number is :",var1-var2),
  "3" <- cat("Multiplication of Two Number is :",var1*var2),
  "4" <- cat("Division of Two Number is :",var1/var2),
  "5" <- cat("Mod of Two Number is :",var1%%var2)
)

# case 2: 

var3 <- 4

res1 <- switch(
  var3,
  "Flutter => Application Development",
  "React.js => Web Apllication Front End",
  "Node.js => Web Application Back End",
  "R => Statistical Problem",
  "C# => Game Developement"
)

print(res1)


# case 3:
ch <- 3

res2 <- switch(
  ch,
  "1" <- "Apple",
  "2" <- "Sumsung",
  "3" <- "Nokia",
  "4" <- "Galaxy",
  "5" <- "ROG"
)

print(res2)
