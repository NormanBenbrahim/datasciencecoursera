# Q.1 sigma^2/n

# Q.2 
pnorm(70, mean = 80, sd = 10)

# Q.3 
qnorm(0.95, mean = 1100, sd = 75)

# Q.4
qnorm(0.95, mean = 1100, sd = 75/sqrt(100))

# Q.5
pbinom(3, size=5, prob=0.5, lower.tail=F)

# Q.6 
# 100 people, 100 i.i.d., CLT -> normal, 14 - 16 is +-1 stddev, so 68%

# Q.7
mean(runif(1000))

# Q.8 
ppois(10, lambda=5*3)
