# A Machine Learning Approach To Classifying Credit Score
The credit score of a person determines the creditworthiness of the person. It helps financial companies 
determine if you can repay the loan or credit you are applying for. Today banks and credit card 
companies use Machine Learning algorithms to classify all the customers in their database based on 
their credit history.

There are three credit scores that banks and credit card companies use to label their customers:

- Good
- Standard
- Poor

A healthy credit score will ease the process of getting a loan or credit card for the 
person applying for it. However, it is always difficult and usually cumbersome to manually 
depict a customer’s score, and that’s where ML comes in. An ML model can, with great accuracy, 
determine a person’s credit score based on several key factors.

## The Project:
Hence, in this project I have built an ML model, more specifically a Random Forest 
classifier to classify the observations in our dataset into 3 credit score groups - 
poor, standard, good. The model is capable of doing it with a quite high accuracy of 82%. 
This can be improved further using advanced techniques, that is not within the scope of this project.

## The Dataset:
For this project, I had used a dataset from <a href="https://statso.io/credit-score-classification-case-study/" target="_blank">Kaggle</a> 
submitted by <a href="https://www.kaggle.com/parisrohan" target="_blank">Rohan Paris</a>. 
The dataset contains info about different customers as follows:

| Column  | Description |
|---------|-------------|
| ID | Unique ID of the record |
| Customer_ID | Unique ID of the customer |
|Month| Month of the year|
|Name| The name of the person|
|Age| The age of the person|
|SSN| Social Security Number of the person|
|Occupation| The occupation of the person|
|Annual_Income| The Annual Income of the person
|Monthly_Inhand_Salary| Monthly in-hand salary of the person|
|Num_Bank_Accounts| The number of bank accounts of the person|
|Num_Credit_Card| Number of credit cards the person is having|
|Interest_Rate| The interest rate on the credit card of the person|
|Num_of_Loan| The number of loans taken by the person from the bank|
|Type_of_Loan| The types of loans taken by the person from the bank|
|Delay_from_due_date| The average number of days delayed by the person from the date of payment|
|Num_of_Delayed_Payment| Number of payments delayed by the person|
|Changed_Credit_Card| The percentage change in the credit card limit of the person|
|Num_Credit_Inquiries| The number of credit card inquiries by the person|
|Credit_Mix| Classification of Credit Mix of the customer|
|Outstanding_Debt| The outstanding balance of the person|
|Credit_Utilization_Ratio| The credit utilization ratio of the credit card of the customer|
|Credit_History_Age| The age of the credit history of the person|
|Payment_of_Min_Amount| Yes if the person paid the minimum amount to be paid only, otherwise no|
|Total_EMI_per_month| The total EMI per month of the person|
|Amount_invested_monthly| The monthly amount invested by the person|
|Payment_Behaviour| The payment behaviour of the person|
|Monthly_Balance| The monthly balance left in the account of the person|
|Credit_Score| The credit score of the person|
