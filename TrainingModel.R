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

# Load necessary libraries
library(caret)

# Convert categorical variables to factors
loan_data$credit.policy <- as.factor(loan_data$credit.policy)
loan_data$purpose <- as.factor(loan_data$purpose)
loan_data$not.fully.paid <- as.factor(loan_data$not.fully.paid)

# Split the dataset into training and testing sets
set.seed(123)  # Set seed for reproducibility
train_index <- createDataPartition(loan_data$not.fully.paid, p = 0.7, list = FALSE)
train_data <- loan_data[train_index, ]
test_data <- loan_data[-train_index, ]

# Display the dimensions of the training and testing sets
cat("Training set size:", nrow(train_data), "\n")
cat("Testing set size:", nrow(test_data), "\n")
