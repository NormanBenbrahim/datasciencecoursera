# Variability

## The Variance
Spread around the mean. $Var(X) = E\left[\left(X - \mu \right)^2 \right] = E\left[X^2 \right] - E\left[X \right]^2$. For a given population, the sample variance is $\sigma^2$. If we were to examine the variance of the population mean, i.e. if $\bar{X} = \mu$, then $Var(\bar{X}) = \sigma^2/n$. In turn, the logical estimate will be $s^2/n$, and the only difference being population vs sample. 

The standard error of the mean is defined as $s/\sqrt{n}$. $S$ talks about how variable the population is.

Standard normal distributions have variance 1; means of n standard normal distributions have standard deviation $1/\sqrt{n}$. Here's a simulation example 


```r
n_simulations <- 10000
n <- 10
sd(apply(matrix(rnorm(n_simulations*n), n_simulations), 1, mean))
```

```
## [1] 0.3192352
```

And $1/\sqrt{n}$:


```r
1/sqrt(n)
```

```
## [1] 0.3162278
```

Let's try it again with another type of distributions, namely the standard uniform distribution. A standard uniform distribution has variance $1/12$, and so a standard deviation of $1/\sqrt(12)$; means of n random samples have standard deviation  $1/\sqrt(12\cdot n)$


```r
sd(apply(matrix(runif(n_simulations*n), n_simulations), 1, mean))
```

```
## [1] 0.09170431
```

and $1/\sqrt(12\cdot n)$:


```r
1/sqrt(12*n)
```

```
## [1] 0.09128709
```

# Summarizing what we know

* The sample variance estimates the population variance
* The distribution of the sample variance is centered at what its estimating, a good thing it means it is unbiased
* It gets more concentrated around what its estimating as you collect more data, good thing since more data == better estimates
* The variance of the sample mean is the population variance divided by n ($Var(\bar{X}) = \sigma^2/n$). This summarizes how variable **averages** are
