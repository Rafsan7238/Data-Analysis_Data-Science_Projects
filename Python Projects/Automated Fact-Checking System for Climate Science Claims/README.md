# Automated Fact-Checking System for Climate Science Claims

## Project Requirement

The impact of climate change on humanity is a significant concern. However, the increase in unverified statements regarding climate science has led to a distortion of public opinion, underscoring the importance of conducting fact-checks on claims related to climate science. Consider the following claim and related evidence:

**Claim**: The Earth’s climate sensitivity is so low that a doubling of atmospheric CO2 will result in a surface temperature change on the order of 1°C or less.

**Evidence:**

1. In his first paper on the matter, he estimated that global temperature would rise by around 5 to 6 °C (9.0 to 10.8 °F) if the quantity of CO 2 was doubled.
2. The 1990 IPCC First Assessment Report estimated that equilibrium climate sensitivity to a doubling of CO2 lay between 1.5 and 4.5 °C (2.7 and 8.1 °F), with a "best guess in the light of current knowledge" of 2.5 °C (4.5 °F).


It should not be difficult to see that the claim is not supported by the evidence passages, and assuming the source of the evidence is reliable, such a claim is misleading. The challenge of the project is to develop an automated fact-checking system where given a claim, the goal is to find related evidence passages from a knowledge source and classify whether the claim is supported by the evidence.

More concretely, you will be provided a list of claims and a corpus containing a large number evidence passages (the “knowledge source”), and your system must: (1) search for the most related evidence passages from the knowledge source given the claim; and (2) classify the status of the claim given the evidence in the following 4 classes: {SUPPORTS, REFUTES, NOT_ENOUGH_INFO, DISPUTED}. To build a successful system, it must be able to retrieve the correct set of evidence passages and classify the claim correctly.

Besides system implementation, you must also write a report that describes your fact-checking system, e.g. how the retrieval and classification components work, the reason behind the choices you made and the system’s performance. We hope that you will enjoy the project. To make it more engaging, **we will run the task as a Codalab competition (participation is optional; more details below)**. You will be competing with other students in the class. The following sections give more details on the data format, system evaluation, grading scheme and use of Codalab. Your assessment will be graded based on your report, your performance in the competition (in the form of bonus marks) and your code.


You are provided with several files for the project:
* [train-claims,dev-claims].json: JSON files for the labelled training and development set; 
* [test-claims-unlabelled].json: JSON file for the unlabelled test set;
* evidence.json: JSON file containing a large number of evidence passages (i.e. the “knowledge source”); 
* dev-claims-baseline.json: JSON file containing predictions of a baseline system on the development set;
* eval.py: Python script to evaluate system performance (see “Evaluation” below for more details).

For the labelled claim files (train-claims.json, dev-claims.json), each instance contains the claim ID, claim text, claim label (one of the four classes: {SUPPORTS, REFUTES, NOT_ENOUGH_INFO, DISPUTED}), and a list of evidence IDs. The unlabelled claim file (test-claims-unlabelled.json) has a similar structure, except that it only contains the claim ID and claim text. More concretely, the labelled claim files has the following format:

```
{
  "claim-2967":
  {
    claim_text: "[South Australia] has the most expensive electricity in the world."
    claim_label: "SUPPORTS"
    evidences: ["evidence-67732", "evidence-572512"]
  },
  "claim-375":
  ...
}
```

The list of evidence IDs (e.g. evidence-67732, evidence-572512) are drawn from the evidence passages in evidence.json:

```
{
  "evidence-0": "John Bennet Lawes, English entrepreneur and agricultural scientist",
  "evidence-1": "Lindberg began his professional career at the age of 16, eventually ...",
  ...
}
```


Given a claim (e.g. claim-2967), your system needs to search and retrieve a list of the most relevant evidence passages from evidence.json, and classify the claim (1 out of the 4 classes mentioned above). You should retrieve at least one evidence passage.

The training set (train-claims.json) should be used for building your models, e.g. for use in development of features, rules and heuristics, and for supervised/unsupervised learning. You are encouraged to inspect this data closely to fully understand the task.

The development set (dev-claims.json) is formatted like the training set. This will help you make major implementation decisions (e.g. choosing optimal hyper-parameter configurations), and should also be used for detailed analysis of your system — both for measuring performance and for error analysis — in the report.

You will use the test set (test-claims-unlabelled.json) to participate in the Codalab competition. For this reason no labels (i.e. the evidence passages and claim labels) are provided for this partition. You are allowed (and encouraged) to train your final system on both the training and development set so as to maximise performance on the test set, but you should not at any time manually inspect the test dataset; any sign that you have done so will result in loss of marks. In terms of the format of the system output, we have provided dev-claims-predictions.json for this. Note: you’ll notice that it has the same format as the labelled claim files (train-claims.json or dev-claims.json), although the claim_text field is optional (i.e. we do not use this field during evaluation) and you’re free to omit it.


**Testing and Leaderboard**

We provide a script (eval.py) for evaluating your system. This script takes two input files, the ground truth and your predictions, and computes three metrics: (1) F-score for evidence retrieval; (2) accuracy for claim classification; and (3) harmonic mean of the evidence retrieval F-score and claim classification accuracy. Shown below is the output from running predictions of a baseline system on the development set:

```
$ python eval.py --predictions dev-claims-baseline.json --groundtruth dev-claims.json
Evidence Retrieval F-score (F)    = 0.3377705627705628
Claim Classification Accuracy (A) = 0.35064935064935066
Harmonic Mean of F and A          = 0.3440894901357093
```

The **three metrics** are computed as follows:

1. **Evidence Retrieval F-score (F)**: computes how well the evidence passages retrieved by the system match the ground truth evidence passages. For each claim, our evaluation considers all the retrieved evidence passages, computes the precision, recall and F-score by comparing them against the ground truth passages, and aggregates the F-scores by averaging over all claims. E.g. given a claim if a system retrieves the following set {evidence-1, evidence-2, evidence-3, evidence-4, evidence-5}, and the ground truth set is {evidence-1, evidence-5, evidence-10}, then precision = 2/5, recall = 2/3, and F-score = 1/2. The aim of this metric is to measure how well the retrieval component of your fact checking system works.

2. **Claim Classification Accuracy (A)**: computes standard classification accuracy for claim label prediction, ignoring the set of evidence passages retrieved by the system. This metric assesses solely how well the system classifies the claim, and is designed to understand how well the classification component of your fact checking system works.

3. **Harmonic Mean of F and A**: computes the harmonic mean of the evidence retrieval F-score and claim classification accuracy. Note that this metric is computed at the end after we have obtained the aggregate (over all claims) F-score and accuracy. This metric is designed to assess both the retrieval and classification components of your system, and as such will be used as **the main metric for ranking systems on Codalab.**


The first two metrics (F-score and accuracy) are provided to help diagnose and develop your system. While they are not used to rank your system on the leaderboard, you should document them in your report and use them to discuss the strengths/weaknesses of your system.

The example prediction file, dev-claims-baseline.json, is the output of a baseline system on the development set. This file will help you understand the required file format for creating your development output (for tuning your system using eval.py) and your test output (for submission to the Codalab competition).

Note that this is not a realistic baseline, and you might find that your system performs worse than it. The reason for this is that this baseline constructs its output in the following manner: (1) the claim labels are randomly selected; and (2) the set of evidence passages combines several randomly selected ground truth passages and several randomly selected passages from the knowledge source. We created such a ‘baseline’ because a true random baseline that selects a random set of evidence passages will most probably produce a zero F-score for evidence retrieval (and consequently zero for the harmonic mean of F-score and accuracy), and it won’t serve as a good diagnostic example to explain the metrics. To clarify, this baseline will not be used in any way for ranking submitted systems on Codalab, and is provided solely to illustrate the metrics and an example system output.

## Project Implementation

This project addresses the pressing issue of misinformation in climate science by developing an automated fact-checking system capable of evaluating the validity of climate-related claims. Using advanced machine learning techniques, our system retrieves relevant evidence and classifies claims based on factual accuracy, thereby supporting informed and trustworthy public discourse on climate issues.

## Key Features
- **Evidence Retrieval with Siamese Network**: Utilizes a Siamese network to assess similarity between claims and potential evidence, employing contrastive loss and cyclical learning rates. This model achieved a development F1-score of 0.665.
- **Claim Classification with Transformer-Encoder**: Classifies claims as **SUPPORTS**, **REFUTES**, **NOT_ENOUGH_INFO**, or **DISPUTES** based on retrieved evidence, with focal loss addressing class imbalance. This model achieved a development accuracy of 0.487.
- **Improved Baseline Performance**: With a harmonic mean score of 0.546, our system outperforms baseline metrics, demonstrating its potential to enhance the reliability of fact-checking in climate science.

## Technology Stack
- **Siamese Network**: For evidence retrieval, leveraging cosine similarity to match claims with relevant evidence.
- **Transformer-Encoder Model**: For classifying claims, applying focal loss to manage class imbalance.
- **Contrastive Loss and Cyclical Learning Rates**: Applied to improve model performance in capturing meaningful patterns in climate-related texts.

## How It Works
1. **Preprocessing**: Claims and evidence are preprocessed with tokenization, stemming, and padding to ensure uniform input for the models.
2. **Evidence Retrieval**: A top-k approach selects the most relevant evidence for each claim based on similarity scores.
3. **Claim Classification**: The system evaluates the collected evidence to classify the claim accurately.

## Results
- **Evidence Retrieval**: Achieved an F1-score of 0.665 on the development set.
- **Claim Classification**: Achieved an accuracy of 0.487 on the development set.
- **Harmonic Mean**: Combined score of 0.546, indicating significant improvement over the baseline.

## Team Members
- Rafsan Al Mamun: Project management, data preprocessing, evidence retrieval model.
- Mengyi Dai: Experimentation with the transformer model, results analysis.
- Tao Peng: Initial work on classification models, report and presentation preparation.
- Yuke Wang: Transformer-Encoder model development and refinement.
