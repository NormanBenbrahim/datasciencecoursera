# Quiz 4

## Question 1


```r
if (!file.exists("./data")) {
    dir.create("./data")
}

f1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
f1_c <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf"

if (!file.exists("./data/idaho.csv")) {
    download.file(f1, destfile = "./data/idaho.csv")
}
if (!file.exists("./data/idaho_codebook.pdf")) {
    download.file(f1_c, destfile = "./data/idaho_codebook.pdf")
}

idaho <- read.csv("./data/idaho.csv")
idaho_names <- names(idaho)
sset <- strsplit(idaho_names, "wgtp")
sset[[123]]
```

```
## [1] ""   "15"
```

## Question 2

I did this step in the past quiz, so I'm going to re-use the code to organize the GDP variable as in the previous week


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

mean(gdp_countries$GDP)
```

```
## [1] 377652.4
```

## Question 3


```r
countryNames <- gdp_countries$LongName
length(grep("^United", countryNames))
```

```
## Warning in grep("^United", countryNames): input string 99 is invalid in
## this locale
```

```
## Warning in grep("^United", countryNames): input string 186 is invalid in
## this locale
```

```
## [1] 3
```

## Question 4 


```r
edu_mess <- read.csv("./data/EDU.csv")
both <- join(gdp_countries, edu_mess) 
```

```
## Joining by: CountryCode
```

```r
# the column we want is Source.of.most.recent.Income.and.expenditure.data
dt <- both$Source.of.most.recent.Income.and.expenditure.data

# The values we want are in the form YYYY-06 or YYYY/06
grep("([0-9]*/06)$ | ([0-9]*-06)$", dt)
```

```
## [1]  87 112
```
This value is not found in the answers of the quiz so I must have gotten the wrong column. However, I don't know which one would be the right column??? 2 is not an option in the multiple choice... I got the right regular expression though, so that's good

## Question 5 


```r
library(quantmod)
```

```
## Loading required package: xts
```

```
## Loading required package: zoo
```

```
## 
## Attaching package: 'zoo'
```

```
## The following objects are masked from 'package:base':
## 
##     as.Date, as.Date.numeric
```

```
## 
## Attaching package: 'xts'
```

```
## The following objects are masked from 'package:dplyr':
## 
##     first, last
```

```
## Loading required package: TTR
```

```
## Version 0.4-0 included new data defaults. See ?getSymbols.
```

```r
amzn = getSymbols("AMZN",auto.assign=FALSE)
```

```
##     As of 0.4-0, 'getSymbols' uses env=parent.frame() and
##  auto.assign=TRUE by default.
## 
##  This  behavior  will be  phased out in 0.5-0  when the call  will
##  default to use auto.assign=FALSE. getOption("getSymbols.env") and 
##  getOptions("getSymbols.auto.assign") are now checked for alternate defaults
## 
##  This message is shown once per session and may be disabled by setting 
##  options("getSymbols.warning4.0"=FALSE). See ?getSymbols for more details.
```

```r
sampleTimes = index(amzn)

# how many collected in 2012
length(grep("^2012", sampleTimes))
```

```
## [1] 250
```

```r
# how many were mondays in 2012
twenty_12 <- weekdays(sampleTimes[grep("^2012", sampleTimes)])
length(grep("Monday", twenty_12))
```

```
## [1] 47
```

