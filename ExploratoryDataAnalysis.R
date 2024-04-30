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
