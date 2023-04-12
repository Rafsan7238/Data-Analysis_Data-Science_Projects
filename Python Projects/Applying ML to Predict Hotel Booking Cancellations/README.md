# Applying ML to Predict Hotel Booking Cancellations

## The Project:

The hospitality industry relies heavily on accurate demand forecasting to optimize revenue and manage inventory. One significant challenge for hotels is the prediction of cancellations, which can disrupt business operations, lead to lost revenue, and impact customer satisfaction. Machine learning techniques offer a promising solution for predicting cancellations and mitigating their effects.

Hence, in this project, I aim to develop an ML model for hotel cancellation prediction, leveraging historical booking data and other relevant features. I will explore various algorithms and techniques, including Naive Bayes, random forest, gradient boosting, to identify the most effective approach for predicting cancellations. Ultimately, my goal is to provide a valuable tool for hotels to optimize their revenue management and improve customer satisfaction by accurately predicting and managing cancellations.

## The Dataset:

The dataset has been collected from <a href="https://www.sciencedirect.com/science/article/pii/S2352340918315191">ScienceDirect</a> and consists of hotel demand data for 2 hotels (H1 and H2) in Europe. Both datasets share the same structure, with 31 variables describing the 40,060 observations of H1 and 79,330 observations of H2. Each observation represents a hotel booking. More information as to how the dataset has been assembled can be found from the source website.

## Results:

Performed EDA to find the origin of customers, nightly rates per person, change of rates by month, preferred duration of stay, bookings made per market segment and booking cancellations per month.
It has been found that lead time, car parking spaces availability, average daily rate, speial requests and number of booking changes were the 5 most significant features in detrermining hotel cancellations.

I then performed feature selection and built several ML models with their base configurations to predict future hotel cancellations based on the particular features through a 5-fold cross validation. Their test results across the 5-folds are as follows:

| Model | Mean Test Accuracy  | Minimum Test Accuracy | Maximum Test Accuracy |
|-------|---------------------|-----------------------|-----------------------|
| Decisicion Tree | 0.795 | 0.7924  | 0.797 |
| Random Forest  |  0.8419  | 0.8386  | 0.8444  |
| Logistic Regression | 0.7905  | 0.7876  | 0.7965  |
| Light Gradient Boosting | 0.8368  | 0.8353  | 0.8402  |

Since Random Forest gave the highest accuracy, I evaluated its important features to find out they were lead time and average daily rate.
It was seen that bookings made a few days before the arrival date are rarely canceled, whereas bookings made over 300 days in advance are canceled very often. Also, as the nightly rate per person increases, so does the rate of cancellations.

## Conclusion:

In conclusion, my machine learning project on hotel cancellation prediction has demonstrated the potential of data analytics to address critical challenges in the hospitality industry. By leveraging historical booking data and relevant features, I developed and evaluated several ML models for predicting cancellations.

The results indicate that the random forest model outperformed other algorithms, achieving a high accuracy rate and providing valuable insights into cancellation patterns and trends. The development of this model can enable hotels to optimize their revenue management and improve operational efficiency by predicting and managing cancellations effectively.

Moreover, my project highlights the importance of data-driven decision-making in the hospitality industry and the potential of machine learning techniques to support business operations.

With further refinement and application, this approach could lead to a significant improvement in the profitability and competitiveness of hotels, benefiting both customers and stakeholders in the industry.
