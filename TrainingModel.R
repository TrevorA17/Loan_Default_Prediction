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

library(boot)
# Define a function to compute the statistic of interest
# For example, let's calculate the mean of the 'int.rate' variable
mean_statistic <- function(data, indices) {
  return(mean(data[indices, "int.rate"], na.rm = TRUE))
}

# Perform bootstrapping
set.seed(123)  # Set seed for reproducibility
boot_result <- boot(data = loan_data, statistic = mean_statistic, R = 1000)

# Display the bootstrap results
print(boot_result)

# Define control parameters for repeated k-fold cross-validation
ctrl <- trainControl(method = "repeatedcv",  # Use repeated k-fold cross-validation
                     number = 10,            # Number of folds
                     repeats = 3,            # Number of repeats
                     verboseIter = TRUE)     # Show iteration progress

# Train a classification model using repeated k-fold cross-validation
set.seed(123)  # Set seed for reproducibility
model <- train(not.fully.paid ~ .,         # Predict 'not.fully.paid' based on all other variables
               data = loan_data,           # Training data
               method = "glm",             # Use Generalized Linear Model (logistic regression)
               trControl = ctrl)           # Use defined control parameters

# Display the model
print(model)

# Train gradient boosting model
set.seed(123)  # Set seed for reproducibility
gbm_model <- train(not.fully.paid ~ .,         # Predict 'not.fully.paid' based on all other variables
                   data = loan_data,           # Training data
                   method = "gbm",            # Use Gradient Boosting Machine
                   trControl = ctrl,          # Use defined control parameters
                   verbose = FALSE)           # Suppress verbose output

# Display the gradient boosting model
print(gbm_model)

# Train neural network model
set.seed(123)  # Set seesd for reproducibility
nnet_model <- train(not.fully.paid ~ .,       # Predict 'not.fully.paid' based on all other variables
                    data = loan_data,         # Training data
                    method = "nnet",          # Use Neural Networks
                    trControl = ctrl)        # Use defined control parameters

# Display the neural network model
print(nnet_model)

# Define models
models <- list(
  "Logistic Regression" = caret::train(not.fully.paid ~ ., data = loan_data, method = "glm", trControl = ctrl),
  "Gradient Boosting" = caret::train(not.fully.paid ~ ., data = loan_data, method = "gbm", trControl = ctrl, verbose = FALSE),
  "Neural Network" = caret::train(not.fully.paid ~ ., data = loan_data, method = "nnet", trControl = ctrl)
)

# Compare model performance using resamples
model_resamples <- resamples(models)

# Summarize model performance
summary(model_resamples)
