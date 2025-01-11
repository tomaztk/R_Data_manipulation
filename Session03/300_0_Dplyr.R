### Using Tidyverse - Part 4

## Functions:
  # Data reshaping: pivot_longer(), pivot_wider(), nest(), unnest()
  # Row and column operations: reframe, ungroup, bind_cols, bind_rows, row_insert, row_append, row_update, row_delete
  # Set operations: intersect(), union(), union_all()
  # Grouped data operations: group_cols, group_map, group_modify, group_walk

#Helper functions:
  # Column manipulation: pull(), relocate(), rename()
  # Set operations: setdiff()
  # Column transformations: across(), c_across()

# Datasets
  # mtcars
  # iris
  # billboard

mtcars <- mtcars

## ## ## ## ## ## ## ## ## ## ## ##
## Data Reshaping Functions
## ## ## ## ## ## ## ## ## ## ## ##

## ------------
## pivot_longer()
## ------------

# Transforms data from wide format to long format.
# Replacement for reshape() in Base R.


mtcars_long <- mtcars %>%
  pivot_longer(cols = c(mpg, hp), names_to = "metric", values_to = "value")

# is "ok" but we need car names and drop unneeded variables
head(mtcars_long,5)

mtcars_long <- mtcars %>%
  mutate(car_name = rownames(mtcars)) %>%
  pivot_longer(cols = c(mpg, hp), names_to = "car_attribute", values_to = "value") %>%
  select(car_name, car_attribute, value)

head(mtcars_long,5)

#now it is easier to visualize this
ggplot(mtcars_long, aes(x = car_name, y = value, fill = car_attribute)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Car Data comparison: Long Format Example", x = "Car Name", y = "Value") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5)) +
  coord_flip()

#or if we do it in excel :)


## ------------
## pivot_wider()
## ------------

# Transforms data from long format to wide format.
# Replacement for reshape() in Base R.

mtcars_wide <- mtcars %>%
  mutate(car_name = rownames(mtcars)) %>%
  pivot_wider(
      names_from = car_name, 
      values_from = c(mpg,cyl,disp)
    )

colnames(mtcars_wide)

# example 2
# simulating one-hot encoding
mtcars %>%
  mutate(car_name = rownames(mtcars)) %>%
  pivot_wider(
    names_from = cyl, # Column to spread 
    values_from = mpg, 
    names_prefix = "cyl_"
  )

# example 3
mtcars %>%
  mutate(car_name = rownames(mtcars)) %>%
  group_by(gear, am, cyl) %>% 
  #summarize(avg_mpg = mean(mpg), .groups = "drop") %>% # Calculate average mpg
  pivot_wider(
    names_from = cyl,        # Spread by the `cyl` column
    # values_from = avg_mpg,   # Fill values with the `avg_mpg` column
    values_fn = ~ mean(.x, na.rm = TRUE)
    names_prefix = "cyl_"    # Add a prefix for clarity
  )


#example 4

set.seed(2908)
random_data <- data.frame(
  country = rep(c("Slovenia", "Austria", "Portugal", "Germany", "Japan"), each = 5),
  year = rep(2015:2019, times = 5),
  population = rep(c(320, 1300, 200, 80, 125), each = 5) + sample(-10:10, 25, replace = TRUE), 
  cases = sample(5000:50000, 25, replace = TRUE)
)

head(random_data,10)

# wider dataset with year but 
# still not 5x5 table, because of population
random_data %>%
  pivot_wider(
    names_from = year,    
    values_from = cases,  
    names_prefix = "year_" #add prefix
  )

# do this
random_data %>%
  group_by(country) %>% 
  mutate(avg_population = mean(population)) %>% 
  select(country,avg_population,year,cases) %>%
  pivot_wider(
    names_from = year,
    values_from = cases,
    names_prefix = "cases_" #add prefix       
  )

# or
random_data %>%
  group_by(country) %>% 
  mutate(avg_population = mean(population)) %>%   
  ungroup() %>%
  select(-population) %>%                           
  pivot_wider(
    names_from = year,                              
    values_from = cases,                          
    names_prefix = "cases_"                         
  )
