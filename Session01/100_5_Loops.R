# Clear the Terminal 
rm(list = ls())


# ================================= Loops and Functions ============================================

# R programming language provides three looping statements. They are :
# 1.Repeat Loop  2.While Loop  3.For Loop

# ----------------------------------1. Repeat Loop :-----------------------------------------------
#  A block of statements are repeated forever. 
# A breaking condition has to be provided inside the repeat block to come out of the loop.

#Syntax of R Repeat Loop
#repeat {   
#  statements  
# if(stop_condition) {    
#  break   } }


a = 1
repeat {
  # statement
  print(a)
  a = a+1
  if(a>5){
    break
  }
}

# ------------------------------------------ R while loop ---------------------------------------
# A block of statements are executed repeatedly in a loop till the condition 
# provided to while statement returns TRUE.

# Syntax : while (expression is true) { 
#         statements}

# R while loop statement Example

a = 1

while(a<=5) {
  print(a)
  a<- a+1
}


# ----------------------------------------- For loop --------------------------------------------- 
# A block of statements are executed for each of the items in the list provided to the for loop.

# Syntax: for (xin vector) {statements}

# R for loop Example

mat <- matrix(16:31,4,4,T)

for( i in 1:4){
  for (j in 1:4){
    print(mat[i,j])
    if (mat[i,j] %% 2 == 0){
      print("ostanek deljenje z 2 = 0")
    }
  }
}



# --------------------------------------Function in R ----------------------------------------

# nonsense functions; but it shows you can use multiple functions

x <- 10

f1 <- function(x) {
  function() {
    function() {
    x + 10
    }
  }
}

f1(1)()()

