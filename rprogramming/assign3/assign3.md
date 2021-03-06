# R Programming Assignment 3

These are my solutions to the third programming assignment of Coursera's R Programming Course. The instructions for this assignment can be found in the file "instructions.pdf" of this repo.

## 1. Plot the 30-day mortality rates for heart attack


```r
# name of files
fname_outcome <- "rprog-data-ProgAssignment3-data/outcome-of-care-measures.csv"
fname_hospital <- "rprog-data-ProgAssignment3-data/hospital-data.csv"

# loading outcomes
outcome <- read.csv(fname_outcome, colClasses="character")

# head() creates too much info, so let's use other tools
# print number of columns
ncol(outcome)
```

```
## [1] 46
```

As you can see, there's a shitload of information in this file. Let's plot the 30 day death rates from heart attack (column 11). We need to coerce this as a numeric before doing so. I will do the plotting using the base plotting system.


```r
outcome[, 11] <- as.numeric(outcome[, 11])
```

```
## Warning: NAs introduced by coercion
```

```r
hist(outcome[, 11], col="red", breaks = 25, 
     main = "30-Day Mortality Rates From Heart Attack",
     xlab = "Mortality Rates",
     ylab = "Frequency")
rug(outcome[, 11])
abline(v = mean(outcome[, 11], na.rm=T), lwd=2, col="green")
```

![](assign3_files/figure-html/unnamed-chunk-2-1.png)\

## 2. Finding the best hospital in a state

For this part of the assignment we are instructed to write a function called `best()` to find the best hospital given a state and outcome name. The function is found in the file `best.R`, and the contents are shown below (not evaluated)


```r
# function for finding best hospital in a state given outcomes for mortality
best <- function(state, outcome) {
    # read outcome data
    # we need State [2], 30-day heart attack mortality[11], 30-day heart failure
    # mortality [17], 30-day pneumonia mortality [23]
    f <- "rprog-data-ProgAssignment3-data/outcome-of-care-measures.csv"
    outcome_data <- read.csv(f, na="Not Available",
                        colClasses = c("NULL",
                                       "character",
                                       rep("NULL", 4),
                                       "character",
                                       rep("NULL", 3),
                                       NA,
                                       rep("NULL", 5),
                                       NA,
                                       rep("NULL", 5),
                                       NA,
                                       rep("NULL", 22)
                                       ))
    # rename the columns 
    names(outcome_data) <- c("name", "State", "heart attack", "heart failure", "pneumonia")
    outcome_name <- c("heart attack", "heart failure", "pneumonia")
    
    # check that state and outcomes are valid
    if (!state %in% outcome_data$State) {
        stop("invalid state")
    } else if (!outcome %in% outcome_name) {
        stop("invalid outcome")
    }
    
    # return hospital name in state with lowest 30-day death
    sub <- outcome_data[outcome_data$State==state, ]
    
    # find where the minimum values occur for each outcome
    mins <- sapply(sub, which.min)[3:5] 
    
    if (outcome=="heart attack") {
        index <- mins$`heart attack`
    }
    if (outcome=="heart failure") {
        index <- mins$`heart failure`
    }
    if (outcome=="pneumonia") {
        index <- mins$pneumonia
    }
    
    # if more than one, report the first alphabetically
    # else return the name
    if (length(index)>1) {
        to_sort <- sub[index, ]$name
        return(sort(to_sort)[1])
    } 
    else {
        return(sub[index, ]$name)
    }
}
```

## 3. Ranking hospitals by outcome in a state

The desired file is found in rankhospital.R. I will not paste it as these functions take up too much space, instead here is the output produced by the test cases:


```r
source("rankhospital.R")
rankhospital("TX", "heart failure", 4)
```

```
## Warning in rankhospital("TX", "heart failure", 4): NAs introduced by
## coercion
```

```
## [1] "DETAR HOSPITAL NAVARRO"
```

```r
rankhospital("MD", "heart attack", "worst")
```

```
## Warning in rankhospital("MD", "heart attack", "worst"): NAs introduced by
## coercion
```

```
## [1] "HARFORD MEMORIAL HOSPITAL"
```

```r
rankhospital("MN", "heart attack", 5000)
```

```
## [1] NA
```

## 4. Ranking hospitals in all states

Here we have the sample output from a single test call of rank all (it is slow)


```r
source("rankall.R")
tail(rankall("pneumonia", "worst"), 3)
```

```
## Warning in rankhospital(state[i], outcome, num): NAs introduced by coercion

## Warning in rankhospital(state[i], outcome, num): NAs introduced by coercion

## Warning in rankhospital(state[i], outcome, num): NAs introduced by coercion

## Warning in rankhospital(state[i], outcome, num): NAs introduced by coercion

## Warning in rankhospital(state[i], outcome, num): NAs introduced by coercion

## Warning in rankhospital(state[i], outcome, num): NAs introduced by coercion

## Warning in rankhospital(state[i], outcome, num): NAs introduced by coercion

## Warning in rankhospital(state[i], outcome, num): NAs introduced by coercion

## Warning in rankhospital(state[i], outcome, num): NAs introduced by coercion

## Warning in rankhospital(state[i], outcome, num): NAs introduced by coercion

## Warning in rankhospital(state[i], outcome, num): NAs introduced by coercion

## Warning in rankhospital(state[i], outcome, num): NAs introduced by coercion

## Warning in rankhospital(state[i], outcome, num): NAs introduced by coercion

## Warning in rankhospital(state[i], outcome, num): NAs introduced by coercion

## Warning in rankhospital(state[i], outcome, num): NAs introduced by coercion

## Warning in rankhospital(state[i], outcome, num): NAs introduced by coercion

## Warning in rankhospital(state[i], outcome, num): NAs introduced by coercion

## Warning in rankhospital(state[i], outcome, num): NAs introduced by coercion

## Warning in rankhospital(state[i], outcome, num): NAs introduced by coercion

## Warning in rankhospital(state[i], outcome, num): NAs introduced by coercion

## Warning in rankhospital(state[i], outcome, num): NAs introduced by coercion

## Warning in rankhospital(state[i], outcome, num): NAs introduced by coercion

## Warning in rankhospital(state[i], outcome, num): NAs introduced by coercion

## Warning in rankhospital(state[i], outcome, num): NAs introduced by coercion

## Warning in rankhospital(state[i], outcome, num): NAs introduced by coercion

## Warning in rankhospital(state[i], outcome, num): NAs introduced by coercion

## Warning in rankhospital(state[i], outcome, num): NAs introduced by coercion

## Warning in rankhospital(state[i], outcome, num): NAs introduced by coercion

## Warning in rankhospital(state[i], outcome, num): NAs introduced by coercion

## Warning in rankhospital(state[i], outcome, num): NAs introduced by coercion

## Warning in rankhospital(state[i], outcome, num): NAs introduced by coercion

## Warning in rankhospital(state[i], outcome, num): NAs introduced by coercion

## Warning in rankhospital(state[i], outcome, num): NAs introduced by coercion

## Warning in rankhospital(state[i], outcome, num): NAs introduced by coercion

## Warning in rankhospital(state[i], outcome, num): NAs introduced by coercion

## Warning in rankhospital(state[i], outcome, num): NAs introduced by coercion

## Warning in rankhospital(state[i], outcome, num): NAs introduced by coercion

## Warning in rankhospital(state[i], outcome, num): NAs introduced by coercion

## Warning in rankhospital(state[i], outcome, num): NAs introduced by coercion

## Warning in rankhospital(state[i], outcome, num): NAs introduced by coercion

## Warning in rankhospital(state[i], outcome, num): NAs introduced by coercion

## Warning in rankhospital(state[i], outcome, num): NAs introduced by coercion

## Warning in rankhospital(state[i], outcome, num): NAs introduced by coercion

## Warning in rankhospital(state[i], outcome, num): NAs introduced by coercion

## Warning in rankhospital(state[i], outcome, num): NAs introduced by coercion

## Warning in rankhospital(state[i], outcome, num): NAs introduced by coercion
```

```
##                                      hospital state
## 52 MAYO CLINIC HEALTH SYSTEM - NORTHLAND, INC    WI
## 53                     PLATEAU MEDICAL CENTER    WV
## 54           NORTH BIG HORN HOSPITAL DISTRICT    WY
```


