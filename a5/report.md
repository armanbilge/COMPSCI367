---
title: COMPSCI 367 Machine Learning Assignment
author: Arman Bilge (`abil933`; 8079403)
date: 19 October 2015
references:
- id: Hal+09
  author:
  - given: Mark
    family: Hall
  - given: Eibe
    family: Frank
  - given: Geoffrey
    family: Holmes
  - given: Bernhard
    family: Pfahringer
  - given: Peter
    family: Reutemann
  - given: Ian H.
    family: Witten
  type: article-journal
  issued:
    year: 2009
  title: "The WEKA data mining software: an update"
  container-title: ACM SIGKDD Explorations Newsletter
  volume: 11
  issue: 1
  page: 10–18
  DOI: 10.1145/1656274.1656278
- id: Hol93
  type: article-journal
  author:
  - given: Robert C.
    family: Holte
  issued:
    year: 1993
  title: Very Simple Classification Rules Perform Well on Most Commonly Used Datasets
  container-title: Machine Learning
  volume: 11
  issue: 1
  page: 63–91
  DOI: 10.1023/A:1022631118932
- id: Qui93
  type: book
  author:
  - given: Ross
    family: Quinlan
  title: "C4.5: Programs for Machine Learning"
  issued:
    year: 1993
  publisher: Morgan Kaufmann
  publisher-places: San Mateo, CA
---

\frenchspacing

In this experiment, I considered the performance of four algorithms, OneR, ZeroR, and (un)pruned J48, as implemented in WEKA 3-6-13 [@Hal+09].

The OneR, or "One Rule", algorithm determines the rule of a single predictor variable that makes the best predictions (i.e., minimises the error) [@Hol93].
@Hol93 calls this model a "1-level decision tree".
This algorithm is particularly interesting to benchmark against because not only does it perform well on many datasets, but often almost as good as more general decision tree models (such as J48).

Alternatively, the ZeroR, or "Zero Rule", algorithm is the simplest of the four algorithms: it identifies the class with the highest frequency and always predicts this class, thereby ignoring all predictor variables.
As a 0-level decision tree, this algorithm is best considered an absolute baseline.

The J48 method is an implementation of the C4.5 algorithm [@Qui93] for generating a (pruned or unpruned) decision tree.
C4.5 is an extension to the ID3 algorithm which minimises the entropy at every node in the tree [@Qui93].
Pruning works to remove nodes from the tree without worsening the model's performance, thus simplifying it.

To compare the algorithms' performance I performed a $10 \times 10$ fold cross-validation followed by a Paired T-Tester analysis on the percent correctly identified.
Statistical significance is an important tool for determining whether the results will hold in general or occurred in this experiment simply due to random chance.
In the context of comparing the performance of various AI algorithms, if the difference in performance between two algorithms is not statistically significant then there is little evidence supporting the hypothesis that one algorithm performs better than the other.

Based on the aforementioned analysis, it seems that dataset 5 is most likely to be the randomised dataset.
The percent correct values had a very large standard deviation ($>30\%$) for all of the algorithms, which suggests that the data are not very self-consistent.

Overall, my observations are compatible with those made by @Hol93:
only for 2 of the 5 non-random datasets did the J48 algorithms significantly out-perform OneR, suggesting that simple classification rules can perform well in practice.
For dataset 5, J48 even performed significantly worse than OneR.
This result may be because the J48 algorithms overfit their models compared to the OneZero algorithm since it is restricted to a single rule.
Dataset 4 in particular consists of many predictor variables ($n = 216$), several of which are missing data and may simply be noise, thus detracting from the prediction accuracy of a multi-level decision tree.

In general, the performances of the pruned and unpruned J48 algorithms were either about equivalent (datasets 2–5) or the pruned version significantly outperformed the unpruned version (datasets 1 and 6).
The difference in performance for the latter datasets is most likely because the unpruned algorithm overfits the model to the training data.

Lastly, and not surprisingly, the ZeroR algorithm was never significantly better than the OneR algorithm.
However, the fact that it was not always significantly worse demonstrates the difficulty of making accurate predictions even when considering the predictor variables.

In conclusion, in this experiment we saw that no one algorithm performs consistently the best and also that overfitting, if not kept in check, can easily degrade the performance of more sophisticated models.

\pagebreak

# Analysis Output

```
Tester:     weka.experiment.PairedCorrectedTTester
Analysing:  Percent_correct
Datasets:   6
Resultsets: 4
Confidence: 0.05 (two tailed)
Sorted by:  -
Date:       19/10/15 12:00


Dataset                   (1) rules.OneR '-B  | (2) rules.ZeroR  (3) trees.J48 '- (4) trees.J48 '-
--------------------------------------------------------------------------------------------------
dataset1                 (100)   66.91( 6.11) |   70.30( 1.37)     74.28( 6.05) v   68.15( 7.55)
dataset2                 (100)   82.28( 5.40) |   64.10( 1.36) *   89.74( 4.38) v   89.83( 4.39) v
dataset3                 (100)   72.07(13.81) |   64.67( 3.07)     78.60(16.58)     79.13(15.62)
dataset4                 (100)   66.49( 1.72) |   63.71( 0.06) *   63.71( 0.06) *   63.71( 0.06) *
dataset5                 (100)   36.00(39.62) |   70.00(33.33) v   66.50(40.86) v   67.50(39.81) v
dataset6                 (100)   69.57( 2.94) |   70.30( 1.37)     70.30( 1.37)     60.24( 8.50) *
--------------------------------------------------------------------------------------------------
                                      (v/ /*) |          (1/3/2)          (3/2/1)          (2/2/2)


Key:
(1) rules.OneR '-B 6' -3459427003147861443
(2) rules.ZeroR '' 48055541465867954
(3) trees.J48 '-C 0.25 -M 2' -217733168393644444
(4) trees.J48 '-U -M 2' -217733168393644444
```

# References
