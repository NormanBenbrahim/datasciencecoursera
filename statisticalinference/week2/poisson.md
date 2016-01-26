# Poisson Distribution

We can use this to model counts. This distribution is defined as 

$P(X=x) = \frac{\lambda^x e^{-\lambda}}{x!}$

The mean is $\lambda$ and the variance is $\lambda$. We use the poisson distribution to model count data, especially if they are unbounded. Contingency tables are modeled almost exclusively using poisson. This is when you count the number of times things occur in a population, for example how often you see people with different colors of hair VS their race. 


Example: The number of people that show up at a bus stop is poisson with a mean of 2.5 per hour. If watching the bus stop for 4 hours, what is the probability that 3 or fewer people show up for the whole time?


```r
ppois(3, lambda = 2.5*4)
```

```
## [1] 0.01033605
```

Notice how we handled units. We want to evaluat `ppois` in units of mean and not mean/hour!

# Approximation to the binomial

For large $n$ and small $p$, the binomial distribution can be approximated by the poisson distribution. 

Ex: We flip a coin with success probability 0.01 five hundred times. What's the probability of 2 or fewer successes?


```r
pbinom(2, size = 500, prob = 0.01)
```

```
## [1] 0.1233858
```


```r
ppois(2, lambda = 500*0.01)
```

```
## [1] 0.124652
```

