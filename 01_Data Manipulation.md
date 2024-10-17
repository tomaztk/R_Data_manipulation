# Data Manipulation 
R, dplyr, tidyr, lubridate

## Main Concepts

### File managemetn


| Category	| Action	| Command |
|----|----|----|
| Paths         | Change directory to another | <font color='lightblue'>setwd</font>(path) |        
| Paths        | Get current working directory | <font color='lightblue'>getwd</font>(() |
| Paths          | Join paths  | <font color='lightblue'>file.path</font>((path_1, ..., path_n) |
| Files     | List files and folders in a given directory | <font color='lightblue'>list.files</font>((path, include.dirs = TRUE) |        
| Files        | Check if path is a file / folder | <font color='lightblue'>file_test</font>(('-f', path)
|  Files    | Check if path is a file / folder | <font color='lightblue'>file_test</font>(('-d', path) |
| Files        |Read / write csv file  | <font color='lightblue'>read.csv</font>((path_to_csv_file) |
| Files        | Read / write csv file    | <font color='lightblue'>write.csv</font>((df, path_to_csv_file) |


### Chaining

ChainingThe symbol %>%, also called "pipe", enables to have chained operations and provides better legibility. Here are its different interpretations:

f(arg_1, arg_2, ..., arg_n) is equivalent to arg_1 %>% f(arg_2, arg_3, ..., arg_n), and also to:
arg_1 %>% f(., arg_2, ..., arg_n)
arg_2 %>% f(arg_1, ., arg_3, ..., arg_n)
arg_n %>% f(arg_1, ..., arg_n-1,  .)

A common use of pipe is when a dataframe df gets first modified by some_operation_1, then some_operation_2, until some_operation_n in a sequential way. It is done as follows:

```
# df gets some_operation_1, then some_operation_2, ..., then some_operation_n
df %>%
  some_operation_1(params_1) %>%
  some_operation_2(params_1) %>%
             ...             %>%
  some_operation_n(params_1)
```

### Exploring data


| Category	| Action	| Command |
|----|----|----|
| Look at data         | Select columns of interest | df %>% select(col_list) |        
| Look at data        | Remove unwanted columns | df %>% select(-col_list) |
| Look at data          | Look at  n first rows / last rows  | df %>% head(n) / df %>% tail(n) |
| Look at data     | Summary statistics of columns |  df %>% summary() |        
| Data types        | CData types of columns | df %>% str() |
|  Data types    | Number of rows / columns | df %>% NROW() / df %>% NCOL() |

### Data Types examples



| Category	| Action	| Command |
|----|----|----|
| character| 	String-related data| 	'teddy bear'| 
| factor| 	String-related data that can be put in bucket, or ordered|  'high', 'medium', 'low' | 
| numeric| 	Numerical data| 	24.0| 
| int	| Numeric data that are integer	| 24| 
| Date	| Dates| 	'2020-01-01'| 
| POSIXct| 	Timestamps| 	'2020-01-01 00:01:00'| 



## Data preprocessing
### Filtering

We can filter rows according to some conditions as follows:

```
df %>%
  filter(some_col some_operation some_value_or_list_or_col)
```

where some_operation is one of the following:

| Category |	Operation |	Command |
|----|----|----|
| Basic |	Equality | / non-equality	== / != |
| Basic  | Inequalities |	<, <=, >=, > |
| Basic  | And  | / or	& / |  |
| Advanced	| Check for missing value | is.na() |
| Advanced | Belonging	| %in% c(val_1, ..., val_n) |
| Advanced  | Pattern matching |x	%like% 'val' |


### Changing columns
 The table below summarizes the main column operations:
 
| Action	| Command |
|----|----|
| Add new columns on top of old ones	| df %>% mutate(new_col = operation(other_cols)) |
| Add new columns and discard old ones | 	df %>% transmute(new_col = operation(other_cols)) |
| Modify several columns in-place	 | df %>% mutate_at(vars, funs) |
| Modify all columns in-place	 | df %>% mutate_all(funs) |
| Modify columns fitting a specific condition |	df %>% mutate_if(condition, funs) |
| Unite columns	| df %>% unite(new_merged_col, old_cols_list) |
| Separate columns	| df %>% separate(col_to_separate, new_cols_list) |