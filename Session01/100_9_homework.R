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

num_vec <- c(num_vec1, 12)
print(num_vec)


# Task 4: Matrix Creation and Basic Operations

# 1. Create a 3x3 matrix mat with values from 1 to 9 using the matrix() function and orientation by rows.
# 2. Calculate the row-wise sum and column-wise sum of mat using rowSums() and colSums(). 
#     Extra points: write your own function for sum of columns or rows.
# 3. Access the element in the second row and third column and store it in matrix_el23.
# 4. Multiply each element in the matrix by 2 and print the updated matrix.
#     Extra points:  Multiply the matrix with the vector 2,4,6.


mat <- matrix(1:9, 3, 3, TRUE)

row_wise_sum <- rowSums(mat)
col_wise_sum <- colSums(mat)

matrix_el23 <- mat[2,3]

update_mat <- mat*2




# Task 5: Data Frames and Slicing

# 1. Create a data frame df wwith the following three columns:
#           Ime           : a character vector of 5 values.
#           Starost       : a integer vector of 5 values.
#           Kredit_sposob : a numeric vector of 5 values. (from 0 to 1; eg.: 0.42)
# Hint: total of 5 rows and 3 columns.

# 2. Return / Print the first 3 rows of the data frame.
# 3. Select only the 'Ime' and 'Kredit_sposob' columns and assign them to a new data frame df_subset.
# 4. Extract and print the value from original df from column  'Starost' of the third person.
# 5. Show the dataframe from solution! 
#   Select all the dows where 'Kredit_sposob' is equal or bigger than 0.52  and the name ('Ime') starts with "Ti" and 
#   return only  columns 'Ime' and 'Starost' and create a new dataframe named df_subset2


df <- data.frame(
    Ime = c("Tone", "Tina", "Tomaz", "Tilen", "Tia"),
    Starost = c(30,40,35,42,32),
    Kredit_sposob = c(0.32, 0.54, 0.66, 0.52, 0.51)
)

head(df, 3)

df_subset <- df[, c("Ime", "Starost")]
print(df_subset)

df[3, "Starost"]


df_subset2 <-  df[df$Kredit_sposob >= 0.52 & substr(df$Ime, 1,2) == "Ti", c("Ime", "Starost")]

print(df_subset2)
 
 
 
# Task 6: Creating Functions
 
# 1. Write a function to calculate the square of a single numeric argument called 'stevka' and returns its square. 
#     Call this function "stevka_kvadrat" :-)
#     Hint: check the input argument data type
# 2. Write a function add_numbers() that takes two arguments and returns their sum.
# 3. Use the square() function to calculate the square of 5 and store the result in sq_5.
# 4. Use the add_numbers() function to add 10 and 15 and store the result in sum_10_15.


stevka_kvadrat <- function(stevka){
  
      rezultat <- stevka**2
      return(rezultat)
}

stevka_kvadrat(6)


 