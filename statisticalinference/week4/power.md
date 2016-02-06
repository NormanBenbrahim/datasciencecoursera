# Power

Power is the probability of rejecting the null hypothesis when it is false. More power => better! A type II error is failing to reject the null when it's false. If type II error is called $\beta$, we defined power as 

#### $Power = 1 - \beta$

# Calculating Power for Gaussian Data

Assume we are testing the null $H_0:\: \mu=30$ VS $H_a: \: \mu>30$ for Gaussian data (via some valid assumptions ensuring Gaussian data). Then the power is defined as 

#### $P\left(\frac{\bar{x} - 30}{s/\sqrt{n}} > t_{1 - \alpha, n-1}; \mu = \mu_a \right)$

We reject if 

#### $\frac{\bar{X} - 30}{\sigma/\sqrt{n}} > Z_{1 - \alpha}$

or, equivalently,

#### $\bar{X} > 30 + Z_{1-\alpha}\cdot \frac{\sigma}{\sqrt{n}}$

If $\mu_a = \mu_0 = 30$ then Power $= \alpha$

In `R`:


```r
z <- qnorm(1 - alpha)
pnorm(mu0 + z*sigma/sqrt(n), mean = mu0, sd = sigma/sqrt(n), lower.tail = F)
```

Suppose we have an experiment where the $\mu_a = 32$, $\mu_0 = 30$, $n = 16$ and $\sigma=4$. 


```r
alpha = 0.05
mu0 = 30
mua = 32
sigma = 4
n = 16
z <- qnorm(1 - alpha)

# mu = mu0 should give 5%, let's verify
pnorm(mu0 + z*sigma/sqrt(n), mean = mu0, sd = sigma/sqrt(n), lower.tail = F)
```

```
## [1] 0.05
```

```r
# now mu = mua
pnorm(mu0 + z*sigma/sqrt(n), mean = mua, sd = sigma/sqrt(n), lower.tail = F)
```

```
## [1] 0.63876
```

This says there's a 64% probability of detecting a mean as large as 32 or larger if we conduct this experiment.

When testing $H_a:\: \mu>\mu_0$, notice that if the power is $1-\beta$ then

#### $1 - \beta = P\left(\bar{X}> \mu_0 + Z_{1-\alpha} \cdot \frac{\sigma}{\sqrt{n}}; \mu = \mu_a \right)$

where $\bar{X} ~ N(\mu_a, \sigma^2/n)$

Some rules:

* As $\alpha$ gets larger, power gets larger 
* Power of one sided test is larger than power of two sided test
* Power goes up as $\mu_1$ gets further away from $\mu_0$
* Power goes up as $n$ goes up

In reality we calculate t test power since gaussian data is fairly rare in nature. `power.t.test` does this very well. 


```r
power.t.test(n = 16, delta = 2, sd = 4, type="one.sample", alt = "one.sided")$power
```

```
## [1] 0.6040329
```

where $delta = \mu_a - \mu_0$. You can also calculate sample size given the power you want


```r
power.t.test(power = 0.8, delta = 100, sd = 200, type = "one.sample", alt = "one.sided")$n
```

```
## [1] 26.13751
```

So this is power. Makes sense. So power calculations are good for deciding what you will do in terms of experiment design. When in doubt, try to make your question as simple as possible in order to calculate power as simply as possible. This will make it a slightly conservative estimate, but you'll be able to interpret it better.
