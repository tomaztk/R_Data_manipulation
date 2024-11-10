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
# 4. Use the add_numbers() function to add 10 and 15 and store the result in sum_10_15.


stevka_kvadrat <- function(stevka){
  
      rezultat <- stevka**2
      return(rezultat)
}

stevka_kvadrat(6)


add_numbers <- function(num1, num2){
  print(sum(num1, num2))
}

add_numbers(112,25.2)

sum_10_15 <- add_numbers(10,15)


# Task 7: For Loops and Basic Iteration

# 1. Create a numeric vector called nums with values from 1 to 5.
# 2. Write a for-loop to iterate over each element in nums and print each element.
# 3. Use a for-loop to calculate the cumulative sum of the vector nums and store it in a variable cum_sum.
#   Print the final value of cum_sum after the loop ends.

nums <- 1:5

class(nums)

nums <- as.numeric(nums)

class(nums)

for (i in 1:length(nums)){
  print(paste0("For position: ",i, " this is the value of nums vector: ", nums[i]))
}

# additinal Loop to check the difference in i and position of nums2 on i
nums2 <- -20:4
for (i in 1:length(nums2)){
  print(paste0("For position: ",i, " this is the value of nums vector: ", nums2[i]))
}


nums <- 1:5
cum_sum <- 0
for (i in 1:length(nums)){
  cum_sum <- cum_sum + nums[i]
  if (i==length(nums)){
    print(cum_sum)
  }
}

# alternatives 1

nums <- 1:5
cum_sum <- cumsum(nums)
print(cum_sum[length(cum_sum)])

# alternatives 2

cum_sum <- numeric(length(nums)) #initialize wheere to store the data

for (i in 1:length(nums)) {
  cum_sum[i] <- ifelse(i == 1, nums[i], cum_sum[i - 1] + nums[i])
}
print(cum_sum)

# alternatives 3

nums <- c(1, 2, 3, 4, 5) # same as 1:5
cum_sum <- Reduce(`+`, nums, accumulate = TRUE)
print(cum_sum)


# Task 8: Conditional Statements and Logical Operations

# 1. Assign a numeric value to a variable temperature (in range from -30 to +50).
# 2. Write an if-else-then statement that prints “Hot” if temperature is above 30, “Warm” if temperature 
#  is between 20 and 30, and “Cold” if temperature is between 10 and 20 and "Ljubljana Cold" if temperature is below 10.
# 3. Create a logical vector temp_check that is TRUE if temperature is above 25 and FALSE otherwise. Print temp_check.

temperature <- 22

# Discuss what could be pitfalls with this solution!
if (temperature > 30) {
  print("Hot")
} else if (temperature >= 20 && temperature <= 30) {
  print("Warm")
} else if (temperature >= 10 && temperature <= 20) {
  print("Ljubljana cold")
} else {
  print("Super Cold")
}

temp_check <- temperature > 25
print(temp_check)



# Tak 9: Working with Strings

# 1. Create a character vector fruit containing "jabolka", "borovnice", "hruške", and "banana".
# 2. Use the paste() function to create a single string fruit_list that combines all the elements of fruit separated by commas.
# 3. Find the length of the string "banana" using the nchar() function.
# 4. Convert the string "hello world" to uppercase and store it in greeting_upper.
# 5. Find all positions of letter "o" in fruit vector, for the second element (word: borovnica).


fruit <- c("jabolka", "borovnice", "hruske", "banana")

fruit
fruit_list <- paste0(fruit, collapse = "")
fruit_list

fruit_list <- paste0(fruit, collapse = ",")
fruit_list

nchar(fruit[4])


string_HW <- "hello world"
string_HW_big_case <- toupper(string_HW)
print(string_HW)
print(string_HW_big_case)


# Extract the second element of `fruit`, which is "borovnica"
sec_word <- fruit[2]

# Use `gregexpr()` 
positions_o <- gregexpr("o", fruit[2])[[1]]
print(positions_o)



# Task 10: Basic Data Manipulation with Data Frames

# 1. Create a data frame grades df_student with columns Student (character), Predmet (character), and Ocena (numeric).
# 2. Populate it with data for 4 students and 2 predmets (each student has one ocena for each subject).
# 3. Calculate the average ocena of each student using tapply() or aggregate().
# 4. Use a subset of grades where Grade is greater than 4.
# 5. Use the order() function to sort grades by Grade in descending order.


df_student <- data.frame(
    Student = c(),
    Predmet = c(),
    Ocena = c()
)
