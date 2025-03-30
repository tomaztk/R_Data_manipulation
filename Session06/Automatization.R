getwd()
setwd("/Users/tomazkastrun/Documents/tomaztk_github/R_Data_manipulation/Session06")

library(quarto)

# Automatization for 600_01_Quarto
# based on defined sets

quarto_render(
  input = "600_01_Quarto.qmd",
  execute_params = list(
    cyl = 4,
    vs = 0
  ), output_format = "docx"
  ,output_file = "report_cyl4_vs0.docx"
)

quarto_render(
  input = "600_01_Quarto.qmd",
  execute_params = list(cyl = 6,vs = 1), 
  output_format = "docx",
  output_file = "report_cyl6_vs1.docx"
)



## Or do it dynamically

data <- expand.grid(
  cyl = c(4,6,8),
  vs = c(0,1), 
  stringsAsFactors = FALSE)


df <- data |> 
  dplyr::mutate(
    output_format = "docx",       
    output_file = paste(          
      "cyl",cyl,"-vs", vs, "-report.docx",
      sep = "-"
    ),
    execute_params = purrr::map2(
      vs, cyl, 
      \(vs, cyl) list(vs = vs, cyl = cyl)
    )
  ) |> 
  dplyr::select(-c(vs, cyl))

df


purrr::pwalk(
  .l = df,                       
  .f = quarto::quarto_render,   
  input = "600_01_Quarto.qmd"
)


# install.packages("reticulate")
library(reticulate)

# Automatization for 600_02_Quarto

quarto_render(
  input = "600_02_Quarto.qmd",
  output_format = "docx",
  output_file = "600_02_Quarto_word.docx"
)


# Automatization for 600_02_A_Quarto

quarto_render(
  input = "600_02_A_Quarto.qmd",
  output_format = "docx",
  output_file = "600_02_Quarto_word_setosa.docx",
  execute_params = list( Species = "setosa")
)

quarto_render(
  input = "600_02_A_Quarto.qmd",
  output_format = "docx",
  output_file = "600_02_Quarto_word_virginica.docx",
  execute_params = list( Species = "virginica")
)

quarto_render(
  input = "600_02_A_Quarto.qmd",
  output_format = "docx",
  output_file = "600_02_Quarto_word_versicolor.docx",
  execute_params = list( Species = "versicolor")
)


# Automatization for 600_03_Quarto

Species <- c("setosa", "versicolor", "virginica")

for (Species in Species) {
  quarto_render(
    input = "600_03_Quarto.qmd",
    output_file = paste0("Iris_Analysis_", Species, ".html"),
    execute_params = list(Species = Species)
  )
}




#### Short List of YAML Options:



#### Short List of Word Options:


### Short List of HTML Options:

# -> https://quarto.org/docs/reference/formats/html.html
# -> https://quarto.org/docs/output-formats/html-themes.html

