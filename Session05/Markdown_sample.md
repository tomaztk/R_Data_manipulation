# Heading level 1 Title	

or

<h1>Heading level 1 Title with HTML</h1> 	
Heading level 1

## Heading level 2 Title	
Heading level 2


### Heading level 3 Title
Heading level 3


#### Heading level 4 	Title	
Heading level 4


##### Heading level 5 Title 		
Heading level 5


###### Heading level 6 Title
Heading level 6



Heading can also be achieved as


Heading level 1
=============== 		
Heading level 1

Heading level 2
---------------

Heading Level 2


Or we can do it like:

# H1
## H2
### H3
#### H4
##### H5
###### H6

Alternatively, for H1 and H2, an underline-ish style:

Alt-H1
======

Alt-H2
------


-------
# Styles

**bold** or __bold__

_italic_ or *italic* 

~~strike this~~

<del>strike out</del>
</br>
<s>strike out</s>

Or using it in the sentence:

Emphasis, aka italics, with *asterisks* or _underscores_.
Strong emphasis, aka bold, with **asterisks** or __underscores__.
Combined emphasis with **asterisks and _underscores_**.

Strikethrough uses two tildes. ~~Scratch this.~~


# Separators

-
--
---
___


# line breaks


Line and.
new line

Paragraph

re reas rewe
qww

ere
rte </p>
ew


# Tables


| Col1 | Col2 |
| ---- | ---- |
| Val1 | val2 |
| Val3 | Val4 | 


# Code Block

```
jan1 <- filter(flights, month == 1, day == 1)
flights %>% 
  filter(month == 1, day == 1) %>%
  filter(dep_delay>0)
``` 

#  Bullets 

- [x] Write the press release
- [ ] Update the website
- [ ] Contact the media 

## or 

- Write the press release
- Update the website
- Contact the media 


# Notes and foot-notes

# List

## Ordered lists
1. One
2. Two
3. Three

And...

1. First
1. Second item
1. Third item

And ...

1. First item
2. Second item
3. Third item
    1. Indented item
    2. Indented item
4. Fourth item


## Un-Ordered lists

 - One
 - Two
 - Three

Or...

* First item
* Second item
* Third item
* Fourth item

Or...

- First item
- Second item
- Third item
    - Indented item
    - Indented item
- Fourth item

Or ...

+ First item
+ Second item
+ Third item
+ Fourth item



# Code

writing code

This is sentence with `Code`.


We can use escape back tick


``Use `code` in your Markdown file.``


And block of code

```
pearl_jam %>% 
	select (song, title, year) %>%
	filter(year <= 2000)
``` 


# YAML Settings

## 1. Basic Document Metadata

---
title: "Enterprise Sales Report"
author: "Data Science Team"
date: today
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
  region: "North America"
  date_range: "Q1 2025"
---


print(paste("Region:", params$region))



### Sample - export to word and PDF

install.packages("rmarkdown")
install.packages("knitr")


---
title: "Sample Parameterized Report"
author: "Your Name"
date: today
format:
  pdf: default
  docx: default
params:
  name: "John Doe"
  age: 30
  country: "USA"
execute:
  echo: false
---


# Use parameters in the document
name <- params$name
age <- params$age
country <- params$country

cat("### Personal Information\n")
cat("- **Name:**", name, "\n")
cat("- **Age:**", age, "\n")
cat("- **Country:**", country, "\n")


-- render
library(quarto)

#### Render with custom parameters
quarto::quarto_render("sample_report.qmd", execute_params = list(name = "Alice", age = 25, country = "UK"))



Output

This will generate:

    sample_report.docx
    sample_report.pdf
    
-- or
quarto::quarto_render("sample_report.qmd", output_format = "docx")
quarto::quarto_render("sample_report.qmd", output_format = "pdf")