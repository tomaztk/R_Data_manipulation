getwd()
#setwd("/Users/tomazkastrun/Documents/tomaztk_github/R_Data_manipulation/Session06")

# install.packages("quarto")
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


#### #### #### #### #### #### #### #### #### ####
#### Short List of YAML Options:
#### #### #### #### #### #### #### #### #### ####


# YAML Settings

## 1. Basic Document Metadata

---
title: "Enterprise Sales Report"
author: "Data Science Team"
date: 2025-04-02
description: "An overview of sales performance in Q1 2025."
lang: en
fontsize: 12pt
---
  
  ## 2. Output Format
  
---
format:
  html:
    toc: true        # Table of contents
    toc-depth: 2     # Number of TOC levels
    number-sections: true
    theme: cosmo     # Themes: cosmo, flatly, darkly, etc.
    highlight-style: github
  pdf:
    documentclass: article
    word: default
---
  
  ## 3. Code Execution Options
  
---
execute:
  eval: true       # Evaluate code (default: true)
  echo: false      # Hide code but show output
  warning: false   # Hide warnings
  message: false   # Hide messages
  error: true      # Show errors (if any)
  freeze: auto     # Reuse previous results if code unchanged
---
  
  ## 4. Table of Contents (TOC)
---
format:
  html:
    toc: true
    toc-depth: 3
    toc-location: left
---

        
## 5. Cross-Referencing Sections, Figures, and Equations
---
format:
  html:
    number-sections: true
    fig-cap-location: top
    eqn-prefix: Eq.
---
  
  
## 6. Custom Styling (CSS and LaTeX)
  
---
format:
  html:
    css: styles.css  # Custom CSS
  pdf:
    include-in-header: custom.tex  # Custom LaTeX settings
---
  
## 7. Citations & References
  
---
bibliography: references.bib
csl: apa.csl  # Citation style (APA, IEEE, etc.)
---
  
  
## 8. Enabling Interactive Features
  
---
format:
  html:
    code-tools: true   # Show/hide code
    code-fold: show    # Default: show code, collapsible
filters:
  - include-code-files
---
  
  ## 9. Parameterized Reports
  
---
params:
  region: "Europe"
  date_range: "Q1 2025"
---
  
print(paste("Region:", params$region))


### Sample - export to word and PDF

install.packages("rmarkdown")
install.packages("knitr")


---
title: "Sample Parameterized Report"
author: "Tomaz Kastrun"
date: 2025-04-02
format:
  pdf: default
params:
  name: "Samo Štonije"
  age: 56
execute:
  echo: false
---
  

#### Short List of Word Options:

# -> https://quarto.org/docs/reference/formats/docx.html
  
### Short List of HTML Options:

# -> https://quarto.org/docs/reference/formats/html.html
# -> https://quarto.org/docs/output-formats/html-themes.html
  
### Short List of PPTX Options:
  
# -> https://quarto.org/docs/reference/formats/presentations/pptx.html

