# Q.1
df <- data.frame(subject = c(1,2,3,4,5),
                 baseline = c(140,138,150,148,135),
                 week2 = c(132,135,151,146,130))

result <- t.test(x = df$baseline, y = df$week2, alternative = "two.sided", paired = T)
round(result$p.value, 3)

# Q.2
n <- 9 
mu <- 1100
s <- 30

mu + c(-1, 1)*qt(0.975, n-1)*s/sqrt(n)

# Q.3
n <- 4
x <- 3
test <- binom.test(x=x, n=n, alt="greater")
test$p.value

# Q.4
rate <- 1/100
errors <- 10
days <- 1787
test <-  poisson.test(errors, T = days, r = rate, alt="less")
round(test$p.value,2)

# Q.5
n_y <- 9 
n_x <- 9 
s_y <- 1.5
s_x <- 1.8
mu_y <- -3
mu_x <- 1

s_p <- (((n_x - 1) * s_x^2 + (n_y - 1) * s_y^2)/(n_x + n_y - 2))
pval <- pt((mu_y - mu_x) / (s_p * (1 / n_x + 1 / n_y)^.5), df=n_y + n_x -2)
pval

# Q.6
# you would not reject, 1078 is in your confidence interval

# Q.7 
n <- 100
mu_a <- 0.1
mu_0 <- 0
d <- mu_a - mu_0
s <- 0.4
power.t.test(delta = d, n = n, sd = s, type="one.sample", alt = "one.sided")$power

# Q.8
ceil(power.t.test(delta = d, power = 0.9, sd = s, type="one.sample", alt = "one.sided")$n)
