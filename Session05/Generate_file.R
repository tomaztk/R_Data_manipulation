setwd("/Users/tomazkastrun/Documents/tomaztk_github/R_Data_manipulation/Session05")
getwd()
#install.packages("quarto")
library(quarto)


# Define parameters
year_input <- 2025
country_input <- "Canada"


# Construct filename dynamically
output_file <- paste0("Regression_Report_", country_input, "_", year_input, ".pdf")

# Render report with specific parameters
quarto::quarto_render("Report.qmd", 
                      execute_params = list(year = year_input, country = country_input),
                      output_file = output_file)
