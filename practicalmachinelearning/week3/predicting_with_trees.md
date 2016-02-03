# Predicting With Trees

The basic idea is that you have a bunch of variables to predict an outcome, you iteratively split the variables into different groups. As you split into groups you may want to evaluate the "homogeneity" within each group, and subsequently split again if necessary. 

Pros:

* Easy to Interpret
* Better performance in nonlinear settings

Cons:

* Without cross validation this can lead to overfitting
* Harder to estimate uncertainty
* Results may be variable

In `R` you do this with the `caret` package. Let's use the iris dataset as an example:


```r
data(iris)
library(ggplot2)
library(caret)

names(iris)
```

```
## [1] "Sepal.Length" "Sepal.Width"  "Petal.Length" "Petal.Width" 
## [5] "Species"
```

```r
# how many different kinds of species of iris flowers:
table(iris$Species)
```

```
## 
##     setosa versicolor  virginica 
##         50         50         50
```

```r
# create train and test set
inTrain <- createDataPartition(y = iris$Species, p = 0.7, list = F)
training <- iris[inTrain, ]
testing <- iris[-inTrain, ]
dim(training)
```

```
## [1] 105   5
```

```r
dim(testing)
```

```
## [1] 45  5
```

```r
# plot petal width vs sepal with for different species 
qplot(Petal.Width, Sepal.Width, colour = Species, data = iris)
```

![](predicting_with_trees_files/figure-html/unnamed-chunk-1-1.png)\

We see in this dataset there are 3 distinct groups, which is a relatively easy classification problem. However, a linear model would have a hard time discriminating between these groups. Which is why we fit a prediction tree model


```r
library(rpart)
modelFit <- train(Species ~ ., method = "rpart", data = training)
print(modelFit$finalModel)
```

```
## n= 105 
## 
## node), split, n, loss, yval, (yprob)
##       * denotes terminal node
## 
## 1) root 105 70 setosa (0.33333333 0.33333333 0.33333333)  
##   2) Petal.Length< 2.45 35  0 setosa (1.00000000 0.00000000 0.00000000) *
##   3) Petal.Length>=2.45 70 35 versicolor (0.00000000 0.50000000 0.50000000)  
##     6) Petal.Length< 4.85 34  1 versicolor (0.00000000 0.97058824 0.02941176) *
##     7) Petal.Length>=4.85 36  2 virginica (0.00000000 0.05555556 0.94444444) *
```

Can also plot the classification tree


```r
plot(modelFit$finalModel, uniform = T, main = "Classification Tree")
text(modelFit$finalModel, use.n = T, all = T, cex = .6)
```

![](predicting_with_trees_files/figure-html/unnamed-chunk-3-1.png)\

Or with `rattle` for a prettier version of the plot


```r
library(rattle)
```

```
## Rattle: A free graphical interface for data mining with R.
## Version 4.1.0 Copyright (c) 2006-2015 Togaware Pty Ltd.
## Type 'rattle()' to shake, rattle, and roll your data.
```

```r
fancyRpartPlot(modelFit$finalModel)
```

![](predicting_with_trees_files/figure-html/unnamed-chunk-4-1.png)\
