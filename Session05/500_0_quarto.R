
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

collatz_sequence(240)

ggplot(data, aes(x = step, y = value)) +
  geom_line(color = "blue", size = 1) +
  geom_point(aes(color = value), size = 3) +
  scale_color_gradient(low = "red", high = "green") +
  theme_minimal() +
  labs(
    title = paste("Collatz Explorer - Starting Number:", start),
    subtitle = "A chaotic yet strangely ordered path to 1",
    x = "Step",
    y = "Value"
  ) 



## As funciton

collatz_sequence <- function(n) {
  if (n <= 0) stop("Input must be a positive integer.")
  sequence <- n
  while (n != 1) {
    n <- ifelse(n %% 2 == 0, n / 2, 3 * n + 1)
    sequence <- c(sequence, n)
  }
  return(sequence)
}


collatz_explorer <- function(start, output_file = NULL) {
  collatz_seq <- collatz_sequence(start)
  data <- data.frame(
    step = seq_along(collatz_seq),
    value = collatz_seq
  )
  
  p <- ggplot(data, aes(x = step, y = value)) +
    geom_line(color = "blue", size = 1) +
    geom_point(aes(color = value), size = 3) +
    scale_color_gradient(low = "red", high = "green") +
    theme_minimal() +
    labs(
      title = paste("Collatz Explorer - Starting Number:", start),
      subtitle = "A chaotic yet strangely ordered path to 1",
      x = "Step",
      y = "Value"
    ) +
    theme(
      plot.title = element_text(size = 16, face = "bold", hjust = 0.5),
      plot.subtitle = element_text(size = 12, hjust = 0.5),
      axis.title = element_text(size = 14),
      axis.text = element_text(size = 12)
    )
  
  if (!is.null(output_file)) {
    ggsave(output_file, p, width = 8, height = 6)
    message("Plot saved to ", output_file)
  } else {
    print(p)
  }
}


# Example Usage:
collatz_explorer(27)        
collatz_explorer(200)        