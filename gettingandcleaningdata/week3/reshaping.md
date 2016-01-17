# Reshaping Data


```r
library(reshape2)
head(mtcars)
```

```
##                    mpg cyl disp  hp drat    wt  qsec vs am gear carb
## Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
## Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
## Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
## Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
## Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
## Valiant           18.1   6  225 105 2.76 3.460 20.22  1  0    3    1
```

# Melting data frames

Basically it takes a data frame and flips it so it's tall and skinny, based on the id names (`id`) you provide and the variables (`measure.vars()`)

```r
mtcars$carname <- rownames(mtcars)
carMelt <- melt(mtcars, id = c("carname", "gear", "cyl"), 
                        measure.vars = c("mpg", "hp"))
head(carMelt)
```

```
##             carname gear cyl variable value
## 1         Mazda RX4    4   6      mpg  21.0
## 2     Mazda RX4 Wag    4   6      mpg  21.0
## 3        Datsun 710    4   4      mpg  22.8
## 4    Hornet 4 Drive    3   6      mpg  21.4
## 5 Hornet Sportabout    3   8      mpg  18.7
## 6           Valiant    3   6      mpg  18.1
```

# Casting data frames

We can do this using the `dcast()` function. In this way we can see how certain variables vary by factors. E.g. 


```r
cylData <- dcast(carMelt, cyl ~ variable)
```

```
## Aggregation function missing: defaulting to length
```

```r
cylData # basically gives you measure counts
```

```
##   cyl mpg hp
## 1   4  11 11
## 2   6   7  7
## 3   8  14 14
```

You can also give it a metric to summarize, e.g.

```r
dcast(carMelt, cyl ~ variable, mean)
```

```
##   cyl      mpg        hp
## 1   4 26.66364  82.63636
## 2   6 19.74286 122.28571
## 3   8 15.10000 209.21429
```
