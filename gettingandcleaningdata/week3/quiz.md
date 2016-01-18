# Quiz 3

## Question 1 


```r
f <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
c <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf"

# download file
if (!file.exists("./data/house_idaho.csv")) {
    download.file(f, destfile = "./data/house_idaho.csv")
} else if (!file.exists("./data/codebook_idaho.pdf")) {
    download.file(c, destfile = "./data/codebook_idaho.pdf")
}

idaho <- read.csv("data/house_idaho.csv")

# according to the codebook
agricultureLogical <- (idaho$ACR==3 & idaho$AGS==6)
which(agricultureLogical)[1:3] 
```

```
## [1] 125 238 262
```

## Question 2


```r
f <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"

if (!file.exists("./data/jeff.jpg")) {
    download.file(f, destfile = "./data/jeff.jpg")
}

library(jpeg)
jeff <- readJPEG("./data/jeff.jpg", native = TRUE)
quantile(jeff, probs = c(0.3, 0.8))
```

```
##       30%       80% 
## -15259150 -10575416
```

## Question 3


```r
f1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
f2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"

if (!file.exists("./data/GDP.csv")) {
    download.file(f1, destfile = "./data/GDP.csv")
}
if (!file.exists("./data/EDU.csv")) {
    download.file(f2, destfile = "./data/EDU.csv")
}

# after reading the data, we see it's all out of whack
# let's fix it 
library(plyr)
library(dplyr)
```

```
## 
## Attaching package: 'dplyr'
```

```
## The following objects are masked from 'package:plyr':
## 
##     arrange, count, desc, failwith, id, mutate, rename, summarise,
##     summarize
```

```
## The following objects are masked from 'package:stats':
## 
##     filter, lag
```

```
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
```

```r
## first gdp
gdp_mess <- read.csv("./data/GDP.csv", header = F, skip = 5, nrows = 231)
gdp2 <- select(gdp_mess, -(V2:V3), -(V6:V10))
colnames(gdp2) <- c("CountryCode", "LongName", "GDP")

# clean up columns 
gdp2$CountryCode <- as.character(gdp2$CountryCode)
gdp2$LongName <- as.character(gdp2$LongName)

gdp2$GDP <- as.character(gdp2$GDP) # first change to character
gdp2$GDP <- gsub(",", "", gdp2$GDP) # replace the commas
gdp2$GDP <- as.numeric(gdp2$GDP) # numeric vector (ignore NA inserted warning)
```

```
## Warning: NAs introduced by coercion
```

```r
# get the gdp for the 190 countries, ignoring the world stats on the bottom
gdp_countries <- gdp2[1:190, ]

# it was already descending order, so order it ascending (top to bottom)
gdp_desc <- arrange(gdp_countries, GDP)

## now edu, this one has a lot of columns, some appear useless
edu_mess <- read.csv("./data/EDU.csv")

# match countries that have the same country code and report the number of matches
edu_subset <- edu_mess[edu_mess$CountryCode %in% gdp_countries$CountryCode, ]

# answer
dim(edu_subset)[1]
```

```
## [1] 189
```

```r
gdp_desc[13, "LongName"]
```

```
## [1] "St. Kitts and Nevis"
```

## Question 4 

First merge the datasets then cleanup the columns we don't want because this is really large. Both this question and the next question will require the "`Income.Group`" variable and that's it.


```r
both <- join(gdp_countries, edu_mess) 
```

```
## Joining by: CountryCode
```

```r
both <- select(both, (CountryCode:Income.Group), -(Long.Name), -(LongName))

# add ranking column, they're already ordered
both <- mutate(both, Ranking = seq(1:dim(both)[1]))

# split by income group
income_group <- split(both$Ranking, both$Income.Group)

# mean GDP per income group
sapply(income_group, mean, na.rm = TRUE)
```

```
##                      High income: nonOECD    High income: OECD 
##                  NaN             91.91304             32.96667 
##           Low income  Lower middle income  Upper middle income 
##            133.72973            107.70370             92.15556
```

## Question 5 


```r
library(Hmisc)
```

```
## Loading required package: lattice
```

```
## Loading required package: survival
```

```
## Loading required package: Formula
```

```
## Loading required package: ggplot2
```

```
## 
## Attaching package: 'Hmisc'
```

```
## The following objects are masked from 'package:dplyr':
## 
##     combine, src, summarize
```

```
## The following objects are masked from 'package:plyr':
## 
##     is.discrete, summarize
```

```
## The following objects are masked from 'package:base':
## 
##     format.pval, round.POSIXt, trunc.POSIXt, units
```

```r
both$GDP_groups <- cut2(both$GDP, g = 5) 
table(both$GDP_groups, both$Income.Group) # pick it out from this table
```

```
##                    
##                        High income: nonOECD High income: OECD Low income
##   [    40,    4264)  0                    2                 0         11
##   [  4264,   15747)  0                    4                 1         16
##   [ 15747,   50972)  0                    8                 1          9
##   [ 50972,  262832)  0                    5                10          1
##   [262832,16244600]  0                    4                18          0
##                    
##                     Lower middle income Upper middle income
##   [    40,    4264)                  16                   9
##   [  4264,   15747)                   8                   8
##   [ 15747,   50972)                  12                   8
##   [ 50972,  262832)                  13                   9
##   [262832,16244600]                   5                  11
```



