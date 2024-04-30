# Load the loan dataset
loan_data <-read.csv("data/loan_data.csv" , colClasses = c(
  credit.policy = "factor",
  purpose = "factor",
  int.rate = "numeric",
  installment = "numeric",
  log.annual.inc = "numeric",
  dti = "numeric",
  fico = "numeric",
  days.with.cr.line = "numeric",
  revol.bal = "numeric",
  revol.util = "numeric",
  inq.last.6mths = "numeric",
  delinq.2yrs = "numeric",
  pub.rec = "numeric",
  not.fully.paid = "factor"
), header = TRUE)

# Display the structure of the dataset
str(loan_data)

# View the first few rows of the dataset
head(loan_data)

#View the dataset
View(loan_data)

# Measures of Frequency for Categorical Variables
cat_vars <- c("credit.policy", "purpose", "not.fully.paid")

cat_freq_summary <- lapply(cat_vars, function(var) {
  cat_freq <- table(loan_data[[var]])
  cat_freq_percentage <- prop.table(cat_freq) * 100
  cat_freq_summary <- data.frame(Frequency = cat_freq, Percentage = cat_freq_percentage)
  cat_freq_summary <- cat_freq_summary[order(-cat_freq), ]
  cat_freq_summary$Percentage <- paste0(format(cat_freq_summary$Percentage, digits = 2), "%")
  cat_freq_summary$Category <- factor(row.names(cat_freq_summary))
  
  return(cat_freq_summary)
})

names(cat_freq_summary) <- cat_vars

# Output results
cat_freq_summary

# Define numerical variables
num_vars <- c("int.rate", "installment", "log.annual.inc", "dti", "fico", 
              "days.with.cr.line", "revol.bal", "revol.util", 
              "inq.last.6mths", "delinq.2yrs", "pub.rec")

# Calculate measures of central tendency
central_tendency <- sapply(loan_data[num_vars], function(x) {
  mean_val <- mean(x, na.rm = TRUE)
  median_val <- median(x, na.rm = TRUE)
  mode_val <- as.numeric(names(sort(table(x), decreasing = TRUE)[1]))
  
  return(c(Mean = mean_val, Median = median_val, Mode = mode_val))
})

# Add variable names
rownames(central_tendency) <- c("Mean", "Median", "Mode")

# Output results
central_tendency

# Define numerical variables
num_vars <- c("int.rate", "installment", "log.annual.inc", "dti", "fico", 
              "days.with.cr.line", "revol.bal", "revol.util", 
              "inq.last.6mths", "delinq.2yrs", "pub.rec")

# Calculate measures of distribution
distribution_measures <- sapply(loan_data[num_vars], function(x) {
  range_val <- range(x, na.rm = TRUE)
  variance_val <- var(x, na.rm = TRUE)
  sd_val <- sd(x, na.rm = TRUE)
  
  return(c(Range = paste(range_val, collapse = " - "), 
           Variance = variance_val, 
           SD = sd_val))
})

# Output results
distribution_measures

# Define numerical variables
num_vars <- c("int.rate", "installment", "log.annual.inc", "dti", "fico", 
              "days.with.cr.line", "revol.bal", "revol.util", 
              "inq.last.6mths", "delinq.2yrs", "pub.rec")

# Calculate correlation matrix
correlation_matrix <- cor(loan_data[num_vars], use = "pairwise.complete.obs")

# Output results
correlation_matrix

# Perform ANOVA
anova_result <- aov(int.rate ~ purpose, data = loan_data)

# Summary of ANOVA results
summary(anova_result)

# Univariate Plots
# Histograms for numerical variables
num_vars <- c("int.rate", "installment", "log.annual.inc", "dti", "fico", 
              "days.with.cr.line", "revol.bal", "revol.util", 
              "inq.last.6mths", "delinq.2yrs", "pub.rec")

for (var in num_vars) {
  p <- ggplot(loan_data, aes(x = loan_data[[var]])) +
    geom_histogram(fill = "skyblue", color = "black", bins = 30) +
    labs(title = paste("Histogram of", var), x = var, y = "Frequency") +
    theme_minimal()
  
  print(p)
}

# Bar plots for categorical variables
cat_vars <- c("credit.policy", "purpose", "not.fully.paid")

for (var in cat_vars) {
  p <- ggplot(loan_data, aes(x = loan_data[[var]])) +
    geom_bar(fill = "skyblue", color = "black") +
    labs(title = paste("Bar Plot of", var), x = var, y = "Frequency") +
    theme_minimal()
  
  print(p)
}

# Load necessary libraries
library(ggplot2)

# Multivariate Plots
# Scatter plots for pairs of numerical variables
num_vars <- c("int.rate", "installment", "log.annual.inc", "dti", "fico", 
              "days.with.cr.line", "revol.bal", "revol.util", 
              "inq.last.6mths", "delinq.2yrs", "pub.rec")

num_plots <- combn(num_vars, 2, simplify = FALSE)

scatter_plots <- lapply(num_plots, function(vars) {
  p <- ggplot(loan_data, aes(x = .data[[vars[1]]], y = .data[[vars[2]]])) +
    geom_point(color = "skyblue") +
    labs(title = paste("Scatter Plot of", vars[1], "vs", vars[2]),
         x = vars[1], y = vars[2]) +
    theme_minimal()
  
  return(p)
})

# Grouped bar plots for pairs of categorical variables
cat_vars <- c("credit.policy", "purpose", "not.fully.paid")

cat_plots <- lapply(cat_vars, function(cat_var) {
  p <- ggplot(loan_data, aes(x = .data[[cat_var]], fill = .data[[cat_vars[1]]])) +
    geom_bar(position = "dodge") +
    labs(title = paste("Grouped Bar Plot of", cat_var, "vs", cat_vars[1]),
         x = cat_var, y = "Frequency") +
    theme_minimal() +
    facet_grid(~ cat_vars[2], scales = "free_y")
  
  return(p)
})

# Output results
print(scatter_plots)
print(cat_plots)
