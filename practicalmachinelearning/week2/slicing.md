# Data Slicing



```r
library(caret); library(kernlab); data(spam)

inTrain <- createDataPartition(y = spam$type, p = 0.75, list = F)
```


```r
training <- spam[inTrain, ]
testing <- spam[-inTrain, ]

# cross validation instead
set.seed(32323)
folds <- createFolds(y = spam$type, k=10, list = T, returnTrain = T)
sapply(folds, length)
```

```
## Fold01 Fold02 Fold03 Fold04 Fold05 Fold06 Fold07 Fold08 Fold09 Fold10 
##   4141   4140   4141   4142   4140   4142   4141   4141   4140   4141
```
