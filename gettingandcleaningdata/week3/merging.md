---
output: pdf_document
---
# Merging Data

Sometimes when you're bringing datasets into R you want to be able to merge them. Usually you'll want to match them based on an idea. This is the same idea as having a link set of tables in a database like mysql. Example data will be the peer review experiment data (conducted by Jeff Leek)


```r
fileUrl1 <- "https://dl.dropboxusercontent.com/u/7710864/data/reviews-apr29.csv"
fileUrl2 <- "https://dl.dropboxusercontent.com/u/7710864/data/solutions-apr29.csv"

if (!file.exists("./data/reviews.csv")) {
    download.file(fileUrl1, destfile = "./data/reviews.csv")
}
if (!file.exists("./data/solutions.csv")) {
    download.file(fileUrl2, destfile = "./data/solutions.csv")
} 

reviews <- read.csv("./data/reviews.csv")
solutions <- read.csv("./data/solutions.csv")

str(reviews)
```

```
## 'data.frame':	199 obs. of  7 variables:
##  $ id         : int  1 2 3 4 5 6 7 8 9 10 ...
##  $ solution_id: int  3 4 5 1 10 2 9 8 7 11 ...
##  $ reviewer_id: int  27 22 28 26 29 29 25 23 29 26 ...
##  $ start      : int  1304095698 1304095188 1304095276 1304095267 1304095456 1304095471 1304095343 NA 1304095520 1304095428 ...
##  $ stop       : int  1304095758 1304095206 1304095320 1304095423 1304095469 1304095513 1304095382 NA 1304095613 1304095488 ...
##  $ time_left  : int  1754 2306 2192 2089 2043 1999 2130 NA 1899 2024 ...
##  $ accept     : int  1 1 1 1 1 1 1 NA 1 1 ...
```

```r
str(solutions)
```

```
## 'data.frame':	205 obs. of  7 variables:
##  $ id        : int  1 2 3 4 5 6 7 8 9 10 ...
##  $ problem_id: int  156 269 34 19 605 384 538 312 327 194 ...
##  $ subject_id: int  29 25 22 23 26 27 28 24 22 23 ...
##  $ start     : int  1304095119 1304095119 1304095127 1304095127 1304095127 1304095131 1304095133 1304095134 1304095151 1304095152 ...
##  $ stop      : int  1304095169 1304095183 1304095146 1304095150 1304095167 1304095270 1304095201 1304095198 1304095184 1304095175 ...
##  $ time_left : int  2343 2329 2366 2362 2345 2242 2311 2314 2328 2337 ...
##  $ answer    : Factor w/ 6 levels "","A","B","C",..: 3 4 4 5 2 4 4 5 6 2 ...
```

By default, the merge function merges by the datasets that have identical column names. So for this example,


```r
names(reviews)
```

```
## [1] "id"          "solution_id" "reviewer_id" "start"       "stop"       
## [6] "time_left"   "accept"
```

```r
names(solutions)
```

```
## [1] "id"         "problem_id" "subject_id" "start"      "stop"      
## [6] "time_left"  "answer"
```

It would try to merge by "id", "start", "stop", and "time_left". We can specify how to merge though:


```r
mergedData <- merge(reviews, solutions, by.x = "solution_id", by.y = "id", all = TRUE)
head(mergedData)
```

```
##   solution_id id reviewer_id    start.x     stop.x time_left.x accept
## 1           1  4          26 1304095267 1304095423        2089      1
## 2           2  6          29 1304095471 1304095513        1999      1
## 3           3  1          27 1304095698 1304095758        1754      1
## 4           4  2          22 1304095188 1304095206        2306      1
## 5           5  3          28 1304095276 1304095320        2192      1
## 6           6 16          22 1304095303 1304095471        2041      1
##   problem_id subject_id    start.y     stop.y time_left.y answer
## 1        156         29 1304095119 1304095169        2343      B
## 2        269         25 1304095119 1304095183        2329      C
## 3         34         22 1304095127 1304095146        2366      C
## 4         19         23 1304095127 1304095150        2362      D
## 5        605         26 1304095127 1304095167        2345      A
## 6        384         27 1304095131 1304095270        2242      C
```

`by.x` refers to the id in the reviews dataframe while the `by.y` refers to the id in the solutions dataframe. `all = TRUE` refers to rows where one value would be missing for one variable, it would replace it with `NA`, naturally. 

You can also do this using the `join()` function of the plyr package, which is faster but less full featured. In particular you can only join things that have the same id name. This could be countered by simply renaming the columns, however I have not tried this (yet).


```r
library(plyr)

# create 2 sample data frames
df1 <- data.frame(id = sample(1:1e3), x = rnorm(1e3))
df2 <- data.frame(id = sample(1:1e3), y = rnorm(1e3))
new_df <- arrange(join(df1, df2), id)
```

```
## Joining by: id
```

```r
head(new_df)
```

```
##   id          x           y
## 1  1  0.6851604  1.81969872
## 2  2 -0.5632909 -1.44437597
## 3  3  0.9592439 -1.44842401
## 4  4 -1.4003285  0.01295775
## 5  5  0.5886808 -0.78661510
## 6  6 -0.1815535 -0.36589004
```
