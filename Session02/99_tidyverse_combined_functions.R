library(tidyverse)


# 1. Combining map() (from purrr), nest(), and mutate() for grouped transformations
mtcars

mtcars %>%
  group_by(cyl) %>%
  nest() %>%
  mutate(
    summary_stats_for_cyl = map(data, ~ summarise(.x, 
                                          mean_mpg_per_cyl_group = mean(mpg), 
                                          sd_mpg_per_cyl_group = sd(mpg)
                                          )
                        )
  ) %>% 
 unnest(.) 
# or
# unnest(summary_stats)



# 2. pivot_longer() + separate() + mutate(across()) for reshaping and engineering

df <- tibble(
  id = 1:3,
  scores_math = c("90_pass", "85_pass", "70_fail"),
  scores_science = c("95_pass", "88_pass", "65_fail")
)

df


df %>%
  pivot_longer(cols = starts_with("scores"), names_to = "subject", values_to = "result") %>%
  separate(result, into = c("score", "status"), sep = "_") %>%
  mutate(across(c(score), as.numeric))



# 3. filter(across()) + case_when() for complex filtering and flag creation

set.seed(2908)
df <- tibble(
  id = 1:10,
  var1 = rnorm(10),
  var2 = rnorm(10),
  var3 = rnorm(10)
)

df

df %>%
  filter(if_any(starts_with("var"), ~ .x > 0)) %>%
  mutate(flag = case_when(
    var1 > 1 & var2 > 1 ~ "High",
    var1 < -1 & var2 < -1 ~ "Low",
    TRUE ~ "Medium"
  ))



# 4. 4. rowwise() + c_across() for row-wise aggregation or calculation

set.seed(2908)

df <- tibble(
  id = 1:5,
  var1 = runif(5),
  var2 = runif(5),
  var3 = runif(5)
)

df

df %>%
  rowwise() %>%
  mutate(mean_value = mean(c_across(starts_with("var")), na.rm = TRUE))



# 5. cur_data() + cur_group() for custom group-wise operations

df <- tibble(
  group = rep(1:2, each = 5),
  value = rnorm(10)
)

df

df %>%
  group_by(group) %>%
  mutate(
    group_summary = list(cur_data()),
    group_label = cur_group()
  ) 
# %>%  unnest(.)



iris %>%
  group_by(Species) %>%
  group_map(~ tibble(
    mean_sepal = mean(.x$Sepal.Length),
    median_sepal = median(.x$Sepal.Width)
  )) %>%
  bind_rows(.id = "Species") %>%
  unnest_wider()


# Example: Filter and reshape variables containing "disp" or "hp"
mtcars %>%
  pivot_longer(cols = everything(), names_to = "variable", values_to = "value") %>%
  filter(str_detect(variable, "disp|hp")) %>%
  mutate(value_scaled = scale(value)) %>%
  pivot_wider(names_from = variable, values_from = value_scaled)



# Example: Add the mean of each column's name length to its values
mt <- mtcars
mtt<- mtcars %>%
  mutate(across(everything(), ~ .x + nchar(cur_column())))


# 5. mutate() + rowwise() + c_across() + summarise() for applying row-wise functions
df <- tibble(
  id = 1:5,
  var1 = c(1, 2, 3, 4, 5),
  var2 = c(6, 7, 8, 9, 10)
)

df %>%
  rowwise() %>%
  mutate(
    total = sum(c_across(starts_with("var")), na.rm = TRUE)
  ) %>%
  summarise(mean_total = mean(total))



# 2. tidyr::extract() + mutate(across()) + regular expressions for feature extraction

df <- tibble(
  id = 1:4,
  info = c("A_12345_X", "B_67890_Y", "C_13579_Z", "D_24680_W")
)

df

df %>%
  extract(info, into = c("group", "number", "code"), regex = "([A-Z])_(\\d+)_(\\w)") %>%
  mutate(across(number, as.integer)) %>%
  mutate(category = case_when(
    group %in% c("A", "B") ~ "Type1",
    TRUE ~ "Type2"
  ))



# 1. Frequency Table with Row and Column Percentages


df <- tibble(
  gender = c("Male", "Female", "Male", "Female", "Male"),
  preference = c("A", "B", "A", "A", "B")
)


df

# Frequency table with row and column percentages
df %>%
  count(gender, preference) %>%
  group_by(gender) %>%
  mutate(row_pct = n / sum(n) * 100) %>%
  ungroup() %>%
  group_by(preference) %>%
  mutate(col_pct = n / sum(n) * 100) %>%
  ungroup()


# 3. Crosstab with Margins and Total Percentages

df <- tibble(
  group = c("A", "B", "A", "A", "B", "B", "A", "D", "C", "A", "C"),
  category = c("X", "X", "Y", "Y", "Y", "X", "Y", "X", "X", "Y", "X")
)

df

df %>%
  count(group, category) %>%
  pivot_wider(names_from = category, values_from = n, values_fill = 0) %>%
  rowwise() %>%
  mutate(Total = sum(c_across(starts_with("X"):starts_with("Y")))) %>%
  ungroup() %>%
  mutate(across(starts_with("X"):Total, ~ . / sum(.) * 100, .names = "pct_{.col}"))




df <- tibble(
  id = 1:4,
  year_2021 = c(100, 200, NA, 400),
  year_2022 = c(150, NA, 300, 450)
)

df

df %>%
  pivot_longer(cols = starts_with("year"), names_to = "year", values_to = "value") %>%
  mutate(value = replace_na(value, median(value, na.rm = TRUE))) %>%
  pivot_wider(names_from = year, values_from = value)



# 5. Hierarchical Pivoting and Imputation

df <- tibble(
  region = rep(c("North", "South"), each = 3),
  year = c(2020, 2021, 2022, 2020, 2021, 2022),
  value = c(130, NA, 220, 170, 255, NA)
)

df

df %>%
  group_by(region) %>%
  summarise(across(value, list(mean = ~ mean(., na.rm = TRUE)), .names = "mean_{.col}")) %>%
  pivot_longer(cols = starts_with("mean"), names_to = "stat", values_to = "value") %>%
  mutate(value = replace_na(value, 0)) %>%
  pivot_wider(names_from = stat, values_from = value)



#  Time-Series Interpolation and Rolling Aggregates
library(zoo)

df <- tibble(
  date = as.Date("2024-01-01") + c(0, 2, 4, 6, 8, 10, 11, 12, 13),
  value = c(10, NA, 30, NA, 50, 60, 50, NA, 40)
)

df

df %>%
  complete(date = seq.Date(min(date), max(date), by = "day")) %>%
  mutate(value = zoo::na.approx(value, na.rm = FALSE)) %>%
  mutate(rolling_avg = rollapply(value, width = 3, align = "right", fill = NA, FUN = mean))



#add purrr
# example
library(purrr)

mtcars |> 
  split(mtcars$cyl) |>  
  map(\(df) lm(mpg ~ wt, data = df)) |> 
  map(summary) %>%
  map_dbl("r.squared")



###############################
library(tidyverse)

# Using lapply (base R)
numbers <- list(1, 2, 3, 4, 5)
squared_lapply <- lapply(numbers, function(x) x^2)

# Using map (purrr)
squared_map <- map(numbers, ~ .x^2)

print(squared_lapply)


# Using lapply with a built-in dataset
iris_split <- split(iris, iris$Species)
mean_sepal_length_lapply <- lapply(iris_split, function(df) mean(df$Sepal.Length))

# Using map with a built-in dataset
mean_sepal_length_map <- map(iris_split, ~ mean(.x$Sepal.Length))

print(mean_sepal_length_lapply)


iris %>%
  select(-Species) %>%
  map_dbl(mean)



df <- tibble(
  a = 1:3,
  b = 4:6,
  c = 7:9
)

df

# Summing corresponding elements of multiple lists
sum_pmap <- pmap(df, ~ ..1 + ..2 + ..3)
sum_pmap


# A named list of scores
named_scores <- list(math = 90, science = 85, history = 78)

# Create descriptive strings for each score
score_descriptions <- imap(named_scores, ~ paste(.y, "score is", .x))
score_descriptions



# Mixed list of numbers and characters
mixed_list <- list(1, "a", 3, "b", 5)

# Double only the numeric elements
doubled_numbers <- map_if(mixed_list, is.numeric, ~ .x * 2)
doubled_numbers


dir.create("plots")

# Save histograms of each numeric column to files
walk(names(mtcars), ~ {
  if (is.numeric(mtcars[[.x]])) {
    plot_path <- paste0("plots/", .x, "_histogram.png")
    png(plot_path)
    hist(mtcars[[.x]], main = paste("Histogram of", .x), xlab = .x)
    dev.off()
  }
})

normalized_iris <- iris %>%
  modify_at(vars(Sepal.Length, Sepal.Width, Petal.Length, Petal.Width),  ~ .x / max(.x))

head(normalized_iris)



# Check if all cars have more than 10 miles per gallon (mpg)
all_mpg_above_10 <- mtcars %>%
  select(mpg) %>%
  map_lgl(~ every(.x, ~ .x > 10))
all_mpg_above_10


# Check if some cars have more than 150 horsepower (hp)
some_hp_above_150 <- mtcars %>%
  select(hp) %>%
  map_lgl(~ some(.x, ~ .x > 150))
some_hp_above_150


# Check if no car has more than 8 cylinders
none_cyl_above_8 <- mtcars %>%
  select(cyl) %>%
  map_lgl(~ none(.x, ~ .x > 8))
none_cyl_above_8



numbers <- list(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)

# Keep only the even numbers
even_numbers <- keep(numbers, ~ .x %% 2 == 0)
even_numbers

# Discard the even numbers
odd_numbers <- discard(numbers, ~ .x %% 2 == 0)
odd_numbers


# Keep rows where Sepal.Length is greater than 5.0
iris_keep <- iris %>%
  split(1:nrow(.)) %>%
  keep(~ .x$Sepal.Length > 5.0) %>%
  bind_rows()
head(iris_keep)

# Keep cars with mpg greater than 20 and discard cars with hp less than 100
filtered_cars <- mtcars %>%
  split(1:nrow(.)) %>%
  keep(~ .x$mpg > 20) %>%
  discard(~ .x$hp < 100) %>%
  bind_rows()

filtered_cars


# A list of numbers
numbers <- list(1, 2, 3, 4, 5)

# Cumulative sum of the numbers
cumulative_sum <- accumulate(numbers, `+`)
cumulative_sum


# Cumulative sum of mpg values
cumulative_mpg <- mtcars %>%
  pull(mpg) %>%
  accumulate(`+`)
cumulative_mpg



# Define scaling and log functions
scale_by_10 <- function(x) x * 10
safe_log <- safely(log, otherwise = NA)

# Compose them into a single function
scale_and_log <- compose(safe_log, scale_by_10)

# Apply the composed function to the hp column
mtcars <- mtcars %>%
  mutate(log_scaled_hp = map_dbl(hp, ~ scale_and_log(.x)$result))

head(mtcars)



apply_funs <- function(x, ...) purrr::map_dbl(list(...), ~ .x(x))
number <- 1:48
results <- apply_funs(number, mean, median, sd)
results

