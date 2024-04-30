# Saving the best Gradient Boosting model
saveRDS(gbm_model$finalModel, "./models/gbm_model.rds")

# Load the saved model
loaded_gbm_model <- readRDS("./models/gbm_model.rds")

# Prepare new data for prediction
new_data <- data.frame(
  credit.policy = 1,
  purpose = "debt_consolidation",
  int.rate = 0.1189,
  installment = 829.1,
  log.annual.inc = 11.35040654,
  dti = 19.48,
  fico = 737,
  days.with.cr.line = 5639.958333,
  revol.bal = 28854,
  revol.util = 52.1,
  inq.last.6mths = 0,
  delinq.2yrs = 0,
  pub.rec = 0
)

# Use the loaded model to make predictions
predictions_loaded_model <- predict(loaded_gbm_model, newdata = new_data)

# Print predictions
print(predictions_loaded_model)
