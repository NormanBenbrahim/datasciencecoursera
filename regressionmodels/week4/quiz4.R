# Q.1
library(MASS)
shuttle$usebin <- as.numeric(shuttle$use == "auto") # create a binary variable
fit <- glm(usebin ~ factor(wind) - 1, family = "binomial", data = shuttle)
Coef <- coef(summary(fit))
coef.odds <- exp(c(Coef[1, 1], Coef[2, 1]))
(odds.ratio <- coef.odds[1] / coef.odds[2])

# Q.2 
fit2 <- glm(usebin ~ factor(wind) + factor(magn) - 1, family = "binomial", 
            data = shuttle)
Coef2 <- coef(summary(fit2))
coef2.odds <- exp(c(Coef2[1, 1], Coef2[2, 1]))
coef2.odds[1] / coef2.odds[2]

# Q.3 
# The coefficients reverse their signs

# Q.4
fit3 <- glm(count ~ relevel(spray, "B"), data = InsectSprays, family = "poisson")
exp(coef(fit3))[2] 

# Q.5
# The coefficient estimate is unchanged

# Q.6 
x <- -5:5
y <- c(5.12, 3.93, 2.67, 1.87, 0.52, 0.08, 0.93, 2.05, 2.54, 3.87, 4.97)
z <- (x > 0) * x
fit <- lm(y ~ x + z)
sum(coef(fit)[2:3])
