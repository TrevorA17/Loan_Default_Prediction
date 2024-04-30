# Load the loan dataset
loan_data <- read.csv("data/loan_data.csv", colClasses = c(
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

# Check for missing values
missing_values <- colSums(is.na(loan_data))

# Display the presence of missing values
print(missing_values)

# Convert categorical variables to factors
loan_data$credit.policy <- as.factor(loan_data$credit.policy)
loan_data$purpose <- as.factor(loan_data$purpose)
loan_data$not.fully.paid <- as.factor(loan_data$not.fully.paid)

# Apply label encoding
loan_data$credit.policy <- as.numeric(loan_data$credit.policy)
loan_data$purpose <- as.numeric(loan_data$purpose)
loan_data$not.fully.paid <- as.numeric(loan_data$not.fully.paid)

# Display the transformed dataset
head(loan_data)
