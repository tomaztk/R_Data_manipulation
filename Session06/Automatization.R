library(quarto)
quarto_render("document.qmd") # all formats
quarto_render("document.qmd", output_format = "pdf")