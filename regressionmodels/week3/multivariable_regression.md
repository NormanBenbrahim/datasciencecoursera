# Multivariable regression

The problem setting is simple. Given predictors/features $X_1, X_2, ..., X_n$, we want to build a predictive model $Y$ such that 

#### $Y = \sum_{i=1}^n w_iX_i$

where $w_i$ (also called $\beta_i$) are the weights associated with each predictor. Each weight can be interpreted as the incremental change in one predictor if we hold the others constant.  Let's do a data example


```r
require(datasets)
data(swiss)
str(swiss)
```

```
## 'data.frame':	47 obs. of  6 variables:
##  $ Fertility       : num  80.2 83.1 92.5 85.8 76.9 76.1 83.8 92.4 82.4 82.9 ...
##  $ Agriculture     : num  17 45.1 39.7 36.5 43.5 35.3 70.2 67.8 53.3 45.2 ...
##  $ Examination     : int  15 6 5 12 17 9 16 14 12 16 ...
##  $ Education       : int  12 9 5 7 15 7 7 8 7 13 ...
##  $ Catholic        : num  9.96 84.84 93.4 33.77 5.16 ...
##  $ Infant.Mortality: num  22.2 22.2 20.2 20.3 20.6 26.6 23.6 24.9 21 24.4 ...
```

```r
require(GGally) # even more complicated ggplots 
```

```
## Loading required package: GGally
```

```r
require(ggplot2)
```

```
## Loading required package: ggplot2
```

```r
# this is a cool plot
g <- ggpairs(swiss)
g
```

![](multivariable_regression_files/figure-html/unnamed-chunk-1-1.png)\

```r
# fit a full linear model of fertility rate to all other factors
model <- lm(Fertility ~ ., data = swiss)
```

Notice agriculture is negative. This is strange since you would expect more food -> more fertile humans. 

```r
summary(model)
```

```
## 
## Call:
## lm(formula = Fertility ~ ., data = swiss)
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -15.2743  -5.2617   0.5032   4.1198  15.3213 
## 
## Coefficients:
##                  Estimate Std. Error t value Pr(>|t|)    
## (Intercept)      66.91518   10.70604   6.250 1.91e-07 ***
## Agriculture      -0.17211    0.07030  -2.448  0.01873 *  
## Examination      -0.25801    0.25388  -1.016  0.31546    
## Education        -0.87094    0.18303  -4.758 2.43e-05 ***
## Catholic          0.10412    0.03526   2.953  0.00519 ** 
## Infant.Mortality  1.07705    0.38172   2.822  0.00734 ** 
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 7.165 on 41 degrees of freedom
## Multiple R-squared:  0.7067,	Adjusted R-squared:  0.671 
## F-statistic: 19.76 on 5 and 41 DF,  p-value: 5.594e-10
```

Notice in the summary calculates our t statistics and p values this tells us that this is a statistically significant factor... So what this is saying is our model estimates an expected 0.17 decrease in standardized fertility for every 1% increase in percentage of males involved in agriculture in holding the other factors constant. In the end, regression is a tool that forces you to think about which variables you are including, especially if you haven't protected yourself by randomizing!

 
