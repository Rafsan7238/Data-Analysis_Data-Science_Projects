# Predicting Absenteeism at Workplace using Machine Learning

Absenteeism is a habitual pattern of absence from a duty or obligation without good reason. Generally, absenteeism is unplanned absences. Absenteeism has been viewed as an indicator of poor individual performance, as well as a breach of an implicit contract between employee and employer.

Although people can be absent for various reasons for short/long time, excessive absenteeism in the workplace is an indicator for poor morale. At the same time, such high rate of absenteeism causes:

- Decreased Productivity
- Poor Quality of Work
- Financial Loss For The Company And Employee
- Negative Company Culture
- Demotivated And Demoralised Employees

With so many negative impacts of absenteeism, it is necessary for the HR to predict the possibility of absenteeism of the employees based on several factors. However, keeping track of so many different variables and predicting if a person is going to be excessively absent is a difficult job for a human. That is where Machine Learning comes in which can, without any human intervention, predict the possibility of future absence after training on a large dataset containing factors that can influence an employee's decision. 

## The Project:

Hence, in this project, I have built an ML model, more specifically a Logistic Regression Model, that was trained on a large sample data with various reasons why an employee might be absent for it to find patterns in the data in order to predict if a random person is likely to be absent. The model built has a decent test accuracy of 75%. The predictions made had a pretty high confidence rate. 

A better model could be built using some other inputs as well which were not present in this dataset but might impact classification. Since the test accuracy was close to the training accuracy, I can safely assume that the model did not overfit on the training data, and is pretty generalised in predicting excessive absenteeism from unseen data.

The model and the preprocessing steps were exported as Python modules so that they could be integrated into software products in the future. The results were visualised and analysed through a Tableau dashboard available <a href="https://public.tableau.com/app/profile/rafsan.al.mamun/viz/AbsenteeismVisualisation_16686128369310/AbsenteeismProjectFactorsAffectingExcessiveAbsenceatWorkplace" target="_blank">here</a>.

## The Results:

The results were interpreted in terms of the odds ratio, or how a change in one variable affects the chance of being absent for a random person. I have assumed at least a 5% change in odds to be significant.

According to the results, the `Daily Work Load Average` and `Distance to Work` make no difference, given all features. If people have poisoning (Reason 3), they are 18.23 times more likely to be excessively absent, followed by diseases (Reason 1) at 17.8 times, pregnancy and giving birth (Reason 2) at 2.5 times and light diseases (Reason 4) at 2.4 times.

It is understandable as if a person is poisoned or sick, he/she is more likely to miss work. In the case of pregnancy, a woman might miss work when she visits the gynaecologist, and when she gives birth (which is often paid leave and not absence).

Furthermore, it was seen that a 1 standard deviation increase in Age, Pets and Day of the Week causes the odds of missing work excessively to go down by 17%, 20% and 26% respectively.

It could be interpreted that as a person becomes old (or senior), he/she has a higher responsibility at work and chooses to be absent less frequently. In case of pets, when someone has a lot of pets, he/she might have hire someone to take care of them for which they don't have to miss work if the pets need to visit the vet. Also, as we enter into a new week, people might take an extended weekend and be absent, but as we progress towards the middle of the week, absence is less frequent.

**Sample Dashboard:**
<img src="Visualisation/Absenteeism Project_ Factors Affecting Excessive Absence at Workplace.png">

The complete Tableau visualisation is available <a href="https://public.tableau.com/app/profile/rafsan.al.mamun/viz/AbsenteeismVisualisation_16686128369310/AbsenteeismProjectFactorsAffectingExcessiveAbsenceatWorkplace" target="_blank">here</a>.

## Suggestions:

As stated earlier, excessive absenteeism is bad for a company. Although one can’t control many of the causes of absenteeism, there are a few actions that one can take to decrease their company’s absenteeism rate and improve the employee experience overall, including:

- Increasing Workplace Flexibility
- Keeping Morale And Motivation High
- Recognising And Rewarding Attendance
- Reaching Out To Struggling Employees
- Taking Disciplinary Action etc
