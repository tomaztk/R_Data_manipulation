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