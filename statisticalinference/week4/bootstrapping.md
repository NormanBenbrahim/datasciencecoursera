# Bootstrapping

Useful for constructing confidence intervals and calculating standard errors for difficult statistics.

Consider the father son dataset


```r
library(UsingR)
data(father.son)
x <- father.son$sheight
n <- length(x)
B <- 10000 # number of bootstrap resamples

resamples <- matrix(sample(x, n*B, replace = TRUE), B, n)
medians <- apply(resamples, 1, median)
```

So if you have a statistica that estimates some population parameter, but don't know its sampling distribution, the bootstrap principle suggests using the distribution defined by the data to approximate its sampling distribution. This assumes you conducted your experiment correctly of course. The general procedure follows by first simulating complete data sets by drawing with replacement. This is approximately drawing from the sampling distribution of that statistic, at least as far as the data is able to approximate the true population distribution. You can imagine with big data how this may actually be very true. 

# Bootstrap for confidence interval for the median

Suppose you have a dataset of $n$ observations. The procedure goes like this 

1. Sample $n$ observations **with replacement** from the observed data resulting in one simulated complete data set
2. Take the median of the simulated data set
3. Repeat these two steps $B$ times, resulting in $B$ simulated medians ($B$ is the number of bootsrapping operations)
4. These medians are approximately drawn from the sampling distribution of the median of n observations; therefore we can:
    * Draw a histogram of them
    * Calculate their standard deviation to estimate the standard error of the median
    * Take 2.5th and 97.5th percentiles as a confidence interval for the median

You want $B$ to be large to make actual inferences. This resampling is done via monte carlo resampling. Typically 10000 or more is a good $B$.

# Histogram of bootstrap resamples

With the father son data 


```r
g <- ggplot(data.frame(medians=medians), aes(x = medians)) 
g <- g + geom_histogram(color="black", fill="lightblue", binwidth = 0.05)
g
```

![](bootstrapping_files/figure-html/unnamed-chunk-2-1.png)\

Read the book **An Introduction to the Bootstrap**

# Permutation tests

