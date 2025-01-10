### Using Tidyverse - Part 3
### Combining functions: `select`, `filter`,  `slice`, `mutate`, `group_by`, `summarize`,  `arrange`, `join`

# Analyze the mtcars dataset to:
# 1) calculate summary statistics by car cylinders (cyl),  #here we have group_by hidden
# 1A) summary statistics are mean and ratio power to weight (hp / wt)
# 2) filter for specific conditions: wt < 3.5
# 3) combine the results with another dataset using a join
# 4) and show top 2 group of cars by best power to weight ratio #here we have hidden arrange, join, slice
# 5) Store results in a new data.frame


# Generate random additional dataset for joining
car_types <- tibble(
  cyl = c(4, 6, 8),
  type = c("Economy", "Standard", "Performance")
)


df_result <- mtcars %>%
  select(mpg, cyl, hp, wt, gear) %>%   # Step 1: Select specific columns
  filter(wt < 3.5) %>%   # Step 2: Filter rows with weight (wt) less than 3.5
  mutate(power_to_weight = hp / wt) %>%   # Step 3: Create a new column for power-to-weight ratio
  group_by(cyl) %>%   # Step 4: Group by the number of cylinders
  summarize(     # Step 5: Summarize data to calculate mean mpg and mean power-to-weight ratio
    mean_mpg = mean(mpg),
    mean_power_to_weight = mean(power_to_weight),
    total_cars = n()
  ) %>%
  arrange(desc(mean_power_to_weight)) %>%   # Step 6: Arrange by descending mean power-to-weight ratio
  left_join(car_types, by = "cyl") %>%   # Step 7: Join with the car_types dataset
  slice(1:2)   # Step 8: Slice the top 2 rows with the highest power-to-weight ratio


## result will be a tibble showing:
  # The number of cylinders (cyl).
  # The mean miles per gallon (mean_mpg).
  # The mean power-to-weight ratio (mean_power_to_weight).
  # The total number of cars (total_cars).
  # The car type (type).

head(df_result,10)






## Example 2:

# In mtcars create statistics for average hp and wt per transmission type and cylinder.
# remove the row names, drop one outlier, filter the data by hp > 70 and wt < 7.4, 
# calculate efficiency and filter the results that statistics are calculated on groups only by 2 or more cars
# Pick top 2 rows


# Generate additional data.frame
transmission_types <- tibble(
  am = c(0, 1),
  transmission = c("Automatic", "Manual")
)


# check  multiple select, filter commands
df_res <- mtcars %>%
  mutate(carname = rownames(mtcars),
         id = row_number()  
                                 ) %>%
  select(mpg, cyl, hp, wt, am, gear, carname, id) %>%
  filter(id != 7) %>%
  select(mpg, cyl, hp, wt, am, gear) %>%
  filter(hp > 70 & wt < 7.5) %>%
  mutate(efficiency = mpg / wt) %>%
  group_by(cyl, am) %>%
  summarize(
    avg_mpg = mean(mpg, na.rm = TRUE),
    avg_hp = mean(hp, na.rm = TRUE),
    avg_efficiency = mean(efficiency, na.rm = TRUE),
    total_cars = n(),
    .groups = "drop"  # adding .groups -> explanation below; check  with slice(1:2) or without slice()
  ) %>%
  filter(total_cars > 2) %>%
  arrange(desc(avg_efficiency)) %>%
  left_join(transmission_types, by = "am") %>%
  slice(1:2)


# By default, after a summarize() call, the output remains grouped by any grouping 
# variables that are not explicitly summarized. In this case, cyl and am remain grouped.

# If you want the grouping to persist, you don't need to do anything.
# If you want to ungroup the result, you can:
        # 1) Set the .groups argument explicitly.
        # 2) Or use ungroup() afterward.
print(df_res)
