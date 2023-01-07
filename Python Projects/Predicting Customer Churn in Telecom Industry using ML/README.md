# Predicting Customer Churn in Telecom Industry using Machine Learning

<img src="Churn.png" width="1500">

Customer churn is one of the most important metrics for a growing business to evaluate. While it's not the happiest measure, it's a number that can give a company the hard truth about its customer retention. Customer churn is the percentage of customers that stopped using a company's product or service during a certain time frame.

Although unrealistic, a company should aim for a churn rate that is as close to 0% as possible. In order to do this, the company has to be on top of its churn rate at all times and treat it as a top priority. For that, it is of utmost importance that the company identifies any potential customer that may churn soon.

That is where Machine Learning comes in, as it can almost eliminate the human hurdles in identifying churning customers, and take that responsibility upon itself to predict such customers all on its own by understanding the underlying patterns related to such customers who have churned in the past.

## The Project:

Churn is a one of the biggest problem in the telecom industry. Research has shown that the average monthly churn rate among the top 4 wireless carriers in the US is about 1.9% - 2%. Hence, in this project I will be building several ML models that can take as inputs different features related to a customer and predict whether he/she will churn or not in the near future.

## The Dataset:

The dataset used for the project has been collected from Kaggle and an be found <a href="https://www.kaggle.com/datasets/blastchar/telco-customer-churn" target="_blank">here</a>.

The dataset contains 7043 rows of data about unique customers, along 21 columns as follows:

| Column	| Description	|
|---------------|---------------|
| customerID	| Customer ID	|
| gender	| Whether the customer is a male or a female	|
| SeniorCitizen	| Whether the customer is a senior citizen or not (1, 0) |
| Partner	| Whether the customer has a partner or not (Yes, No)	|
| Dependents	| Whether the customer has dependents or not (Yes, No)	|
| tenure	| Number of months the customer has stayed with the company	|
| PhoneService	| Whether the customer has a phone service or not (Yes, No)	|
| MultipleLines	| Whether the customer has multiple lines or not (Yes, No, No phone service)	|
| InternetService	| Customer’s internet service provider (DSL, Fiber optic, No)	|
| OnlineSecurity	| Whether the customer has online security or not (Yes, No, No internet service)	|
| OnlineBackup	| Whether the customer has online backup or not (Yes, No, No internet service)	|
| DeviceProtection	| Whether the customer has device protection or not (Yes, No, No internet service)	|
| TechSupport	| Whether the customer has tech support or not (Yes, No, No internet service)	|
| StreamingTV	| Whether the customer has streaming TV or not (Yes, No, No internet service)	|
| StreamingMovies| Whether the customer has streaming movies or not (Yes, No, No internet service)	|
| Contract	| The contract term of the customer (Month-to-month, One year, Two year)	|
| PaperlessBilling	| Whether the customer has paperless billing or not (Yes, No)	|
| PaymentMethod	| The customer’s payment method (Electronic check, Mailed check, Bank transfer (automatic), Credit card (automatic))	|
| MonthlyCharges	| The amount charged to the customer monthly	|
| TotalCharges	| The total amount charged to the customer	|
| Churn	| Whether the customer churned or not (Yes or No)	|

## Model Results:

| Model	| Test Accuracy	| Recall | AUC Score	|
|-------|---------------|--------|--------------|
| Logistic Regression	|	0.748	|	0.730	|	0.819	|
| Random Forest	|	0.748	|	0.778	|	0.829	|
| KNearest Neighbour	|	0.718	|	0.829	|	0.796	|
| Support Vector Machine	|	0.748	|	0.717	|	0.804	|
| XGBoost	|	0.742	|	0.612	|	0.798	|

Although all the AUC scores are quite similar, we can say the Random Forest Classifier was the best predictor of customer churn. However, if we also consider the recall value together with the AUC, then KNearest Neighbour is the clear winner with an AUC of 0.8 and Recall of 0.83.

The scores can be improved further by tuning the hyperparameters of the models, getting more data instead of oversampling, trying different combinations of models, including ensemble ones etc. However, they are not in the scope of this project and has been left out.

## Suggestions:

As stated previously, churn is a one of the biggest problem in the telecom industry. In order to reduce churning, a company can:

- <b>Focus their attention on the best customers:</b> Rather than simply focusing on offering incentives to customers who are considering churning, it could be even more beneficial to pool resources into the loyal, profitable customers. <br><br>

- <b>Analyze churn as it occurs:</b> Analyze how and when churn occurs in a customer's lifetime with the company, and use that data to put into place preemptive measures.<br><br>

- <b>Show the customers that they care:</b> Instead of waiting to connect with the customers until they reach out, they should try a more proactive approach to show them that the company cares about their experience, and they'll be sure to stick around.