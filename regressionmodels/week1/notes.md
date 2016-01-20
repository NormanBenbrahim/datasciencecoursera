# Week 1 Notes

The idea behind linear regression is centered behind minimizing the residual sum of squares, i.e. finding parameters $w_0$ and $w_1$ such that we have $Min\left(\sum_{i=1}^{n} \left(Y_i - (w_0 + w_1X_i)\right)^2\right)$. The analytical solutions for these parameters is simply:

1. $w_1 = Cor(Y, X) \cdot \frac{\sigma(y)}{\sigma(x)}$
2. $w_0 = \bar{Y} - w_1\bar{X}$

Here's an example using Galton's height data.


```r
library(UsingR)
```

```
## Loading required package: MASS
```

```
## Loading required package: HistData
```

```
## Loading required package: Hmisc
```

```
## Loading required package: lattice
```

```
## Loading required package: survival
```

```
## Loading required package: Formula
```

```
## Loading required package: ggplot2
```

```
## 
## Attaching package: 'Hmisc'
```

```
## The following objects are masked from 'package:base':
## 
##     format.pval, round.POSIXt, trunc.POSIXt, units
```

```
## 
## Attaching package: 'UsingR'
```

```
## The following object is masked from 'package:survival':
## 
##     cancer
```

```r
library(ggplot2)
data(galton)

# get x and y variables
x <- galton$child
y <- galton$parent

w_1 <- cor(y, x)*sd(y)/sd(x)
w_0 <- mean(y) - w_1*mean(x)
lm(y ~ x) # equivalent 
```

```
## 
## Call:
## lm(formula = y ~ x)
## 
## Coefficients:
## (Intercept)            x  
##     46.1353       0.3256
```

```r
plot(x, y) # dirty plots
```

![](notes_files/figure-html/unnamed-chunk-1-1.png)\

```r
plot(x, w_0 + w_1*x, type = "l")
```

![](notes_files/figure-html/unnamed-chunk-1-2.png)\
