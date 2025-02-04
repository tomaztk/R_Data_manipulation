
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


collatz_sequence <- function(n) {
  if (n <= 0) stop("Input must be a positive integer.")
  sequence <- n
  while (n != 1) {
    n <- ifelse(n %% 2 == 0, n / 2, 3 * n + 1)
    sequence <- c(sequence, n)
  }
  return(sequence)
}