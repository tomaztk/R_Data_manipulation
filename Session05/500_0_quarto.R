
### What is R Quarto?
  # Quarto is an open-source, next-generation publishing system that allows users to create dynamic, 
  # high-quality reports, documents, presentations, and interactive dashboards using R( and also for Python, Julia, and JS). 
   # It is the successor to R Markdown, offering enhanced features for scientific and business reporting.


### Why is Quarto Great?
  
# Offers:  Generate PDFs, HTML reports, Word documents, dashboards, and even books or websites.
# Consistency and Reproducibility: Integrates with RStudio for seamless, version-controlled reporting.
# Interactivity: Supports Shiny and Observable for dynamic content.
# Enterprise-Ready: Can be automated and integrated with CI/CD pipelines, making it ideal for automated reporting.

### 
# open new Quarto: File -> new Quarto document


#-----
### Basics of Markdown
#-----

# Heading level 1 Title	

## Heading level 2 Title	

### Heading level 3 Title

#### Heading level 4 	Title	

##### Heading level 5 Title 		

###### Heading level 6 Title


# Table

 | Col1 | Col2 |
 | ---- | ---- |
 | Val1 | val2 |
 | Val3 | Val4 |




# This is a Quarto document has three parts:
#   
# Metadata (YAML)
# Text (markdown formatting)
# Code (code formatting)


## YAML

---
title: "An example document"
author: "Tomaz Kastrun"
format: docx
---

  
## Code

#### Check for backtick
# on mac - option + "</>"
# on windows - Alt GR + 7
  
```{r}
#| label: r-chunk-name
# a code chunk
```


# The code chunks you need to know:
  
## eval: true/false Do you want to evaluate the code?
## echo: true/false Do you want to print the code?
## cache: true / false Do you want to save the output of the chunk so it doesn’t have to run next time?
## include: Do you want to include code output in the final output document? Setting to false means nothing is put into the output document, but the code is still run.

```{r}
#| label: read-iris
#| eval: false
iris_data <- iris
```

# Using inline code
# Code is executed
```{r}
kg_tk <- c(91, 90, 91, 90.5, 89.5, 91.2, 90.7)
kg_mean <- mean(r_heights)
```

# Code is used in print 
The mean of my kilos in 2025 is `{r} kg_mean`

## Create a new R QMMD file
