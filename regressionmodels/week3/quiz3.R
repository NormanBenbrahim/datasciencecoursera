# Q.1
data(mtcars)
fit <- lm(mpg ~ factor(cyl) + wt, data = mtcars)
summary(fit)$coefficient

# Q.2
# Holding weight constant, cylinder appears to have less of an impact on mpg 
# than if weight is disregarded.

# Q.3
fit2 <- lm(mpg ~ factor(cyl) * wt, data = mtcars)
anova(fit, fit2, test = "Chisq")$Pr
# The P-value is larger than 0.05. So, according to our criterion, we would 
# fail to reject, which suggests that the interaction terms may not be 
# necessary

# Q.4
# The estimated expected change in MPG per one ton increase in weight for a 
# specific number of cylinders (4, 6, 8).

# Q.5
x <- c(0.586, 0.166, -0.042, -0.614, 11.72)
y <- c(0.549, -0.026, -0.127, -0.751, 1.344)
fit4 <- lm(y ~ x)
max(lm.influence(fit4)$hat)

# Q.6
x <- c(0.586, 0.166, -0.042, -0.614, 11.72)
y <- c(0.549, -0.026, -0.127, -0.751, 1.344)
fit5 <- lm(y ~ x)
max(abs(dfbetas(fit5)[, 2]))

# Q.7
# It is possible for the coefficient to reverse sign after adjustment. For 
# example, it can be strongly significant and positive before adjustment and 
# strongly significant and negative after adjustment.