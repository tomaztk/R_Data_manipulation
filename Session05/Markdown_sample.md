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


-------
# Styles

**bold** or __bold__

_italic_ or *italic* 

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
