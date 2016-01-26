# Binomial Distribution

First it is important to mention the Bernoulli distribution. It is defined as $P(X = x) = p^x(1-p)^{1-x}$. X = 1 is called a succes, and X = 0 as a failure.

The binomial is a sum of a bunch of i.i.d. Bernoullis

$P(X = x; n) = {n \choose x}p^x(1-p)^{n-x}$.

Example: Suppose some crazy lady has 8 children, 7 of which are girls. Assume each gender has a 50% chance of occuring in the proceeding births. She decides to have 8 more kids. What's the probability of getting 7 or more girls out of 8 births? 

$P(X\geq 7; n = 8) = P(X=7) + P(X=8) = 0.04$

In `R`, you can use `pbinom` to solve problems of this nature:


```r
pbinom(6, size = 8, prob = .5, lower.tail = F)
```

```
## [1] 0.03515625
```

Lower tail option is because, if it's `TRUE`, which is the default behavior it examines $P(X \leq x)$, otherwise, $P(X > x)$.
