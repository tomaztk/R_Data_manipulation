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

