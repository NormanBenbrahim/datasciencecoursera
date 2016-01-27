# Q.1
x <- c(0.61, 0.93, 0.83, 0.35, 0.54, 0.16, 0.91, 0.62, 0.62)
y <- c(0.67, 0.84, 0.6, 0.18, 0.85, 0.47, 1.1, 0.65, 0.36)
fit <- lm(y ~ x)
summary(fit)$coefficients[2, 4]

# Q.2 
summary(fit)

# Q.3
data(mtcars)
fit2 <- lm(mpg ~ wt, data = mtcars)
new <- data.frame(wt = mean(mtcars$wt))
predict(fit2, new, interval = "confidence")

# Q.4 The estimated expected change in mpg per 1,000 lb increase in weight.

# Q.5
new <- data.frame(wt = 3.0)
predict(fit2, new, interval = "prediction")

# Q.6
fit3 <- lm(mpg ~ I(2*wt), data = mtcars)
new <- data.frame(wt = mean(2*mtcars$wt))
predict(fit3, new, interval = "confidence")

# Q.7 It would get multiplied by 100.

# Q.8 The new slope would be beta_0 - c*beta_1

# Q.9 
fit4 <- lm(mpg ~ wt, data = mtcars)
fit5 <- lm(mpg ~ 1, data = mtcars)
1 - summary(fit4)$r.squared

# Q.10 If an intercept is included, then they will sum to 0.