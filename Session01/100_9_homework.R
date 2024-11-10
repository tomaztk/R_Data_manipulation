## ================= =================
## ================= =================
###  
###             Repeat
###
## ================= =================
## ================= =================


# Task 1: Variable Assignment and Basic Arithmetic

# 1. Assign the value 10 to a variable called a and the value 20 to a variable called b.
# 2. Create a new variable c that stores the sum of a and b.
# 3. Divide c by 2 and assign the result to a variable called d.
# 4. Print all variables (a, b, c, and d).


# Solution Task 1:
a <- 10
b <- 20
c <- a + b
d <- c / 2
print(a)
print(b)
print(c)
print(d)


# Task 2: Variable Assignment and Basic Arithmetic

# 1. Create a variable num_var with a numeric value, char_var with a character string, and bool_var with a logical (TRUE/FALSE) value.
# 2. Use the class() function to check the data types of each variable (num_var, char_var, bool_var).
# 3. Convert num_var to character and store it in a new variable num_char.
# 4. Print the data type of num_char to confirm the conversion. And check the class() function for the num_char variable.


# Solution Task 2:
num_var <- 20
char_var <- "Ljubljana"
bool_var <- TRUE

class(num_var)
class(char_var)
class(bool_var)

num_char <- as.character(num_var)
print(num_char)
class(num_char)




#Task 3: Working with Vectors

# 1. Create a numeric vector num_vec with values 2, 4, 6, 8, 10. Create this vector in two different ways.
# 2. Access the third element in num_vec and assign it to a variable third_elem.
# 3. Calculate the sum of all elements in num_vec using the sum() function. Extra points: write your own function using loop
# 4. Add a new element 12 to num_vec using c() and print the updated vector.


num_vec1 <- c(2,4,6,8,10)
num_vec2 <- seq(2,10,2)

third_elem <- num_vec1[3]
sum(num_vec1)
print(paste0("Vsota je: ", sum(num_vec1)))

