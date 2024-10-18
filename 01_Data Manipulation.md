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


### Conditional column

A column can take different values with respect to a particular set of conditions with the `case_when()` command as follows:

```
case_when(condition_1 ~ value_1,  # If condition_1 then value_1
          condition_2 ~ value_2,  # If condition_2 then value_2
                ...
          TRUE ~ value_n)         # Otherwise, value_n
```

Remark: the `ifelse(condition_if_true, value_true, value_other)` function can be used and is easier to manipulate if there is only one condition.


### Datetime conversion
Fields containing datetime values can be stored in two different POSIXt data types:

| Action	| Command |
|----|----|
| Converts to datetime with seconds since origin |	as.POSIXct(col, format) |
| Converts to datetime with attributes (e.g. time zone) |	as.POSIXlt(col, format) |

where `format` is a string describing the structure of the field and using the commands summarized in the table below:

|Category	| Command	| Description |	Example | 
|----|----|----|----|
|Year	| `%Y` / `%y`	| With / without century | 2020 / 20 |
|Month	| `%B` / `%b`  / `%m`	| Full / abbreviated / numerical | August / Aug / 8 |
| Weekday	| `%A` / `%a`	| Full / abbreviated | Sunday / Sun |
| Weekday | `%u` / `%w`	 | Number (1-7) / Number (0-6) | 7 / 0 |
| Day	| `%d` / `%j` |	Of the month / of the year | 09 / 222 |
| Time	| `%H` / `%M` 	| Hour / minute | 09 / 40 |
| Timezone	| `%Z` / `%z` | 	String / Number of hours from UTC | EST / -0400 |


Remark: data frames only accept datetime in `POSIXct` format.

### Date properties
In order to extract a date-related property from a datetime object, the following command is used:

```
format(datetime_object, format)
```

where `format` follows the same convention as in the table above.

## Data frame transformation

### Merging data frames 
We can merge two data frames by a given field as follows:

```
merge(df_1, df_2, join_field, join_type)
```

where `join_field` indicates fields where the join needs to happen with option
for the same field names	: `by = 'field'` and for different field names
`by.x = 'field_name_1', by.y = 'field_name_2'`


and where join_type indicates the join type, and is one of the following:



|Join type | Option| Join draw|
|----|----|---|
|Inner join	|default	| Inner join|
|Left join	|all.x = TRUE	 | Left join|
|Right join	|all.y = TRUE	 | Right join|
|Full join	|all = TRUE	| Full outer join|
