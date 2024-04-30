# Loan Default Prediction Model API

This project implements a machine learning model to predict loan default using a Gradient Boosting Machine (GBM) algorithm. The model is exposed as a RESTful API using the Plumber framework in R. The API endpoint `/loan_default_prediction` accepts various input parameters related to loan information, such as credit policy status, loan purpose, interest rate, and borrower's financial metrics. Upon receiving a request, the API leverages the pre-trained GBM model to make real-time predictions on whether a loan is likely to default. The API response provides a binary prediction (1 for default, 0 for no default) based on the input features. This loan default prediction API can be integrated into other applications or services to automate loan risk assessment and decision-making processes.

---

Feel free to customize this paragraph further based on additional details or features of your project!
