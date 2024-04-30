# Load necessary libraries
library(plumber)
library(caret)

# Load the saved GBM model
loaded_gbm_model <- readRDS("models/gbm_model.rds")

# Define your API endpoint
#* @apiTitle Loan Default Prediction Model API
#* @apiDescription Used to predict loan default.

#* @param credit_policy Credit policy status (1 or 0)
#* @param purpose Purpose of the loan
#* @param int_rate Interest rate
#* @param installment Installment
#* @param log_annual_inc Log annual income
#* @param dti Debt-to-income ratio
#* @param fico FICO score
#* @param days_with_cr_line Days with credit line
#* @param revol_bal Revolving balance
#* @param revol_util Revolving utilization
#* @param inq_last_6mths Inquiries in the last 6 months
#* @param delinq_2yrs Number of delinquencies in the past 2 years
#* @param pub_rec Number of derogatory public records

#* @get /loan_default_prediction

predict_loan_default <- function(credit_policy, purpose, int_rate, installment,
                                 log_annual_inc, dti, fico, days_with_cr_line,
                                 revol_bal, revol_util, inq_last_6mths,
                                 delinq_2yrs, pub_rec) {
  
  # Create a data frame using the arguments
  to_be_predicted <- data.frame(
    credit.policy = as.factor(credit_policy),
    purpose = as.factor(purpose),
    int.rate = as.numeric(int_rate),
    installment = as.numeric(installment),
    log.annual.inc = as.numeric(log_annual_inc),
    dti = as.numeric(dti),
    fico = as.numeric(fico),
    days.with.cr.line = as.numeric(days_with_cr_line),
    revol.bal = as.numeric(revol_bal),
    revol.util = as.numeric(revol_util),
    inq.last.6mths = as.numeric(inq_last_6mths),
    delinq.2yrs = as.numeric(delinq_2yrs),
    pub.rec = as.numeric(pub_rec)
  )
  
  # Use the loaded model to make predictions
  prediction <- predict(loaded_gbm_model, newdata = to_be_predicted)
  
  # Return the prediction
  return(as.character(prediction))
}