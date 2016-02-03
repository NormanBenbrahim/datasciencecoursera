# T Confidence Intervals

# T Confidence Intervals

Recall previously we discussed creating confidence intervals using the central limit theorem. They are of the form

#### $Est \pm ZQ \cdot {SE}_{Est}$

where $Est$ is the estimate, $ZQ$ is the z distribution quantile, and ${SE}_{Est}$ is the standard error of the estimate. A t interval is applied when we have a small sample. They are of the form

#### $Est \pm TQ \cdot {SE}_{Est}$

where $TQ$ is the t distribution quantile. When given the choice of using the t vs z intervals, always go with t since you can always collect more data and the t quantile will approach that of the z quantile. 

The t interval works fairly well whenever the distribution of the data is roughly symmetric and mound shaped. Paired observations are often analyzed using the t interval by taking differences. When the data are skewed, you can work with the data on a log scale. For highly discrete data, other intervals are preferrable.

Let's take a look at Galton's sleep data, where he looked at sleep variations in subjects on different medications


```r
data(sleep)
sleep
```

```
##    extra group ID
## 1    0.7     1  1
## 2   -1.6     1  2
## 3   -0.2     1  3
## 4   -1.2     1  4
## 5   -0.1     1  5
## 6    3.4     1  6
## 7    3.7     1  7
## 8    0.8     1  8
## 9    0.0     1  9
## 10   2.0     1 10
## 11   1.9     2  1
## 12   0.8     2  2
## 13   1.1     2  3
## 14   0.1     2  4
## 15  -0.1     2  5
## 16   4.4     2  6
## 17   5.5     2  7
## 18   1.6     2  8
## 19   4.6     2  9
## 20   3.4     2 10
```

We see there are two groups, with a subject id for each (1 - 10). 

## Results


```r
g1 <- sleep[sleep$group==1,]
g2 <- sleep[sleep$group==2,]

extra1 <- g1$extra
extra2 <- g2$extra

# compute the difference
difference = extra2 - extra1

# compute the mean and standard deviation of the difference
mn <- mean(difference)
s <- sd(difference)
n <- 10

# compute t confidence interval. qt gives quantile for t distribution
mn + c(-1, 1)*qt(.975, n-1)*s/sqrt(n)
```

```
## [1] 0.7001142 2.4598858
```

```r
# you can also get the t confidence intervals by running a t test on the difference
t.test(difference)
```

```
## 
## 	One Sample t-test
## 
## data:  difference
## t = 4.0621, df = 9, p-value = 0.002833
## alternative hypothesis: true mean is not equal to 0
## 95 percent confidence interval:
##  0.7001142 2.4598858
## sample estimates:
## mean of x 
##      1.58
```

```r
# or you can run a paired t test on both groups
t.test(extra1, extra2, paired = TRUE)
```

```
## 
## 	Paired t-test
## 
## data:  extra1 and extra2
## t = -4.0621, df = 9, p-value = 0.002833
## alternative hypothesis: true difference in means is not equal to 0
## 95 percent confidence interval:
##  -2.4598858 -0.7001142
## sample estimates:
## mean of the differences 
##                   -1.58
```

# Independent group t confidence intervals

Suppose we want to compare mean blood pressure between two groups in a randomized trial; those who received the treatment and those who received a placebo. We can't use the paired t test because the groups are independent and may have different sample sizes. The group confidence interval (t interval) in this case is given by

#### $\bar{Y} - \bar{X} \pm t_{n_x+n_y-2, 1- \alpha/2} \cdot S_p \cdot \left(\frac{1}{n_x} + \frac{1}{n_y} \right)^{1/2}$

where $t_{n_x+n_y-2, 1- \alpha/2}$ is the t quantile for the degrees of freedom of the combined samples ($n_x + n_y - 2$). Additionally, 

#### $S_p^2 = \frac{(n_x - 1)S_x^2 + (n_y - 1)S_y^2}{n_x+n_y-2}$ 

is called the ***pooled variance***. This interval assumes a constant variance across the two groups. If there is some doubt, assume a different variance per group (covered later).

Example: Chick weights


```r
library(datasets)
data("ChickWeight")
library(reshape2)

str(ChickWeight)
```

```
## Classes 'nfnGroupedData', 'nfGroupedData', 'groupedData' and 'data.frame':	578 obs. of  4 variables:
##  $ weight: num  42 51 59 64 76 93 106 125 149 171 ...
##  $ Time  : num  0 2 4 6 8 10 12 14 16 18 ...
##  $ Chick : Ord.factor w/ 50 levels "18"<"16"<"15"<..: 15 15 15 15 15 15 15 15 15 15 ...
##  $ Diet  : Factor w/ 4 levels "1","2","3","4": 1 1 1 1 1 1 1 1 1 1 ...
##  - attr(*, "formula")=Class 'formula' length 3 weight ~ Time | Chick
##   .. ..- attr(*, ".Environment")=<environment: R_EmptyEnv> 
##  - attr(*, "outer")=Class 'formula' length 2 ~Diet
##   .. ..- attr(*, ".Environment")=<environment: R_EmptyEnv> 
##  - attr(*, "labels")=List of 2
##   ..$ x: chr "Time"
##   ..$ y: chr "Body weight"
##  - attr(*, "units")=List of 2
##   ..$ x: chr "(days)"
##   ..$ y: chr "(gm)"
```

```r
# define weight gain or loss
wideCW <- dcast(ChickWeight, Diet + Chick ~ Time, value.var = "weight")

# reshape based on time points in which the weight was measured and rename
names(wideCW)[-(1:2)] <- paste("time", names(wideCW)[-(1:2)], sep = "")
head(wideCW)
```

```
##   Diet Chick time0 time2 time4 time6 time8 time10 time12 time14 time16
## 1    1    18    39    35    NA    NA    NA     NA     NA     NA     NA
## 2    1    16    41    45    49    51    57     51     54     NA     NA
## 3    1    15    41    49    56    64    68     68     67     68     NA
## 4    1    13    41    48    53    60    65     67     71     70     71
## 5    1     9    42    51    59    68    85     96     90     92     93
## 6    1    20    41    47    54    58    65     73     77     89     98
##   time18 time20 time21
## 1     NA     NA     NA
## 2     NA     NA     NA
## 3     NA     NA     NA
## 4     81     91     96
## 5    100    100     98
## 6    107    115    117
```

```r
library(dplyr)
```

```
## 
## Attaching package: 'dplyr'
```

```
## The following objects are masked from 'package:stats':
## 
##     filter, lag
```

```
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
```

```r
# create new variable which measures total weight gain/loss from beginning
# time point to end
wideCW <- mutate(wideCW, gain = time21 - time0)

# let's do a t interval
wideCW14 <- subset(wideCW, Diet %in% c(1, 4))

# bind the results with rbind
rbind(
t.test(gain ~ Diet, paired = F, var.equal = T, data = wideCW14)$conf, # equal variances
t.test(gain ~ Diet, paired = F, var.equal = F, data = wideCW14)$conf # unequal variances
)
```

```
##           [,1]      [,2]
## [1,] -108.1468 -14.81154
## [2,] -104.6590 -18.29932
```

In both cases the intervals are below zero, suggesting less weight gain on diet 1 than on diet 4. For the case when the variances are assumed to be ***unequal***, the t interval is given by 

#### $\bar{Y} - \bar{X} \pm t_{df} \cdot \left(\frac{s_x^2}{n_x} + \frac{s_y^2}{n_y} \right)^{1/2}$

If x and y are IID normal, the relevant statistic does not follow a t. Instead it can be *approximated* to be a t with a complicated degrees of freedom formula which is too long to typeset, nigga. But, as we saw above, all you need to do in `R` is specify `var.equal = F` and you're good.

When we have single observation, or paired observations which we take the diff, we use t intervals to create intervals highly robust to the underlying assumptions of the data. For count data, there's also the chi-squared tests and exact tests.
