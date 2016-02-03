# Bagging

The basic idea is that we resample and recalculate predictions, then average or "majority vote". This is more useful for non-linear functions. Here's an example with the Ozone data


```r
library(ElemStatLearn)
data(ozone, package = "ElemStatLearn")
ozone <- ozone[order(ozone$ozone),] # order by the outcome
```

Try to predict temperature as a function of ozone

```r
# initialize 
ll <- matrix(NA, nrow = 10, ncol = 155)

for (i in 1:10) {
    ss <- sample(1:dim(ozone)[1], replace=T)
    ozone0 <- ozone[ss, ]
    # loess is a smooth curve you can fit to the data, similar to spline
    loess0 <- loess(temperature ~ ozone, data=ozone0, span = 0.2)
    ll[i, ] <- predict(loess0, newdata = data.frame(ozone=1:155))
}
```

```
## Warning in simpleLoess(y, x, w, span, degree = degree, parametric =
## parametric, : pseudoinverse used at 20
```

```
## Warning in simpleLoess(y, x, w, span, degree = degree, parametric =
## parametric, : neighborhood radius 2
```

```
## Warning in simpleLoess(y, x, w, span, degree = degree, parametric =
## parametric, : reciprocal condition number 1.2274e-16
```

Basically this resamples the data 10 different times, fit a smooth function 10 different times, and then we average the fits. Here is a plot illustrating this


```r
plot(ozone$ozone, ozone$temperature, pch = 10, cex = 0.5)
for (i in 1:10) {
    lines(1:155, ll[i, ], col = "grey", lwd = 2)
}
lines(1:155, apply(ll, 2, mean), col="red", lwd = 2)
```

![](bagging_files/figure-html/unnamed-chunk-3-1.png)\

The red line is called the bagged loess curve. I didn't like this at all.
