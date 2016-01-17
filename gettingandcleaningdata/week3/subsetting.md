# Subsetting and Sorting

Here's a quick review of how we generally subset and sort data frames. 


```r
set.seed(13435)
x <- data.frame("var1" = sample(1:5), "var2" = sample(6:10), 
                "var3" = sample(11:15))
x <- x[sample(1:5), ] # scramble the rows
x$var2[c(1, 3)] = NA # set values for rows 1 and 3 of var2 to be NA
x
```

```
##   var1 var2 var3
## 1    2   NA   15
## 4    1   10   11
## 2    3   NA   12
## 3    5    6   14
## 5    4    9   13
```

To subset a column use 


```r
x[, 1]
```

```
## [1] 2 1 3 5 4
```
or by column name:

```r
# or by colname
x[, "var1"]
```

```
## [1] 2 1 3 5 4
```
specific rows pertaining to column of var2

```r
x[1:2, "var2"]
```

```
## [1] NA 10
```
by logicals

```r
x[(x$var1 <= 3 & x$var2>1), ]
```

```
##      var1 var2 var3
## NA     NA   NA   NA
## 4       1   10   11
## NA.1   NA   NA   NA
```
finding indices where a condition is true in the data frame:

```r
x[which(x$var2>8), ]
```

```
##   var1 var2 var3
## 4    1   10   11
## 5    4    9   13
```

Here's how you order the rows of a data frame by a particular variable

```r
x[order(x$var1), ] # don't forget the comma
```

```
##   var1 var2 var3
## 4    1   10   11
## 1    2   NA   15
## 2    3   NA   12
## 5    4    9   13
## 3    5    6   14
```

You can do the same thing with the `plyr` package and the `arrange` command:

```r
library(plyr)
arrange(x, var1)
```

```
##   var1 var2 var3
## 1    1   10   11
## 2    2   NA   15
## 3    3   NA   12
## 4    4    9   13
## 5    5    6   14
```
or do it in descending order

```r
arrange(x, desc(var1))
```

```
##   var1 var2 var3
## 1    5    6   14
## 2    4    9   13
## 3    3   NA   12
## 4    2   NA   15
## 5    1   10   11
```

Add a row by simply doing:

```r
x$var4 <- rnorm(5)

# or use cbind & make new df
y <- cbind(x, rnorm(5))
x
```

```
##   var1 var2 var3       var4
## 1    2   NA   15  0.1875960
## 4    1   10   11  1.7869764
## 2    3   NA   12  0.4966936
## 3    5    6   14  0.0631830
## 5    4    9   13 -0.5361329
```

```r
y
```

```
##   var1 var2 var3       var4    rnorm(5)
## 1    2   NA   15  0.1875960  0.62578490
## 4    1   10   11  1.7869764 -2.45083750
## 2    3   NA   12  0.4966936  0.08909424
## 3    5    6   14  0.0631830  0.47838570
## 5    4    9   13 -0.5361329  1.00053336
```
https://data.baltimorecity.gov/Community/Restaurants/k5ry-ef3g
