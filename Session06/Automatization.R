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




# Automatization for 600_02_Quarto

quarto_render(
  input = "600_02_Quarto.qmd",
  output_format = "docx",
  output_file = "600_02_Quarto_word.docx"
)
