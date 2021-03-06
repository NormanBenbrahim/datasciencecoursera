# Population Health and Economic Consequences of Storms in the United States

# Synopsis

In this report I will attempt to answer two questions: 1) across the United States, which types of events are most harmful with respect to population health?, and 2) across the United States, which types of events have the greatest economic consequences? We will be making use of the U.S. National Oceanic and Atmospheric Administration's (NOAA) storm database. The events in this dataset start in the year 1950 and end in November 2011. 

# Loading the Raw Data and Data Preprocessing

First we need to load in the entire dataset. The code below creates a data folder (if it does not already exist), and downloads and stores the `.bz2` file (it it does not already exist). Note that the function `read.csv()` can handle these file types natively, so there is no need to unzip them and take up more disk space. 


```r
if (!file.exists("./data")) {
    dir.create("./data")
}
if (!file.exists("./data/repdata-data-StormData.csv.bz2")){
    fUrl <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2"
    download.file(fUrl, destfile = "./data/repdata-data-StormData.csv.bz2")
}
```

Now we can read the data. This is a very large dataset, it will a take a little under 3 minutes to load so we will cache it using the `cache = TRUE` option in R Markdown to avoid reading the file over and over again. Let's fix the date/time variables (`BGN_DATE`, `BGN_TIME`, `END_DATE`, `END_TIME`). We will only use the begin dates to address the full entirety of events and to make things consistent, as there is a larger amount of missing values for the end dates/end times. The times do not matter as much in the grand scheme of things, so we will ignore this column. This is also due to the fact that times were collected in a different format depending on the decade, i.e. in the 60s they were collected in 2400 format whereas in 2011 they were collected in the standard "digital clock" format (i.e. 24:00:00). This reduces our sample rate to 1 day. 


```r
storms <- read.csv("./data/repdata-data-StormData.csv.bz2") # ~ 3 minutes to load

# Gotta do it for begin dates/times
storms$BGN_DATE <- sub("0:00:00", "", storms$BGN_DATE)
storms$BGN_DATE <- as.Date(storms$BGN_DATE, format = "%m/%d/%Y")
```

# Results

### Effects on Public Health
Let's take a look at the events. First we can find out how many different types of weather events that are included in this dataset:


```r
length(levels(storms$EVTYPE))
```

```
## [1] 985
```

In order to answer the first question, we need to know the variable that is related to population health. Two variables appear to relate population health: `INJURIES` and `FATALITIES`. Let's find out the total number of fatalities and injuries per event type, and print out the event type that corresponded to the highest number.


```r
library(dplyr)

total_fatalities <- summarise(group_by(storms, EVTYPE), sum(FATALITIES, na.rm = T))
total_injuries <- summarise(group_by(storms, EVTYPE), sum(INJURIES, na.rm = T))

# first rename second column 
names(total_fatalities)[2] <- "total"
names(total_injuries)[2] <- "total"

# sort the indices of the maximum
idx_inj <- which.max(total_injuries$total)
idx_fat <- which.max(total_fatalities$total)

# print max value
paste("Highest number of fatalities caused by:", total_fatalities[idx_fat, ]$EVTYPE)
```

```
## [1] "Highest number of fatalities caused by: TORNADO"
```

```r
paste("Highest number of injuries caused by:", total_injuries[idx_inj, ]$EVTYPE)
```

```
## [1] "Highest number of injuries caused by: TORNADO"
```

It seems the most disastrous types of storm to public health, in the grand scheme of things, are tornados. What about the top 5 disastrous types of storms? Let's find out:


```r
highest_fatalities <- arrange(total_fatalities, -total)
highest_injuries <- arrange(total_injuries, -total)
```

**The 5 highest sources of fatalities are:**


```r
head(highest_fatalities, 5)
```

```
## Source: local data frame [5 x 2]
## 
##           EVTYPE total
##           (fctr) (dbl)
## 1        TORNADO  5633
## 2 EXCESSIVE HEAT  1903
## 3    FLASH FLOOD   978
## 4           HEAT   937
## 5      LIGHTNING   816
```

**The 5 highest sources of injuries are:**


```r
head(highest_injuries, 5)
```

```
## Source: local data frame [5 x 2]
## 
##           EVTYPE total
##           (fctr) (dbl)
## 1        TORNADO 91346
## 2      TSTM WIND  6957
## 3          FLOOD  6789
## 4 EXCESSIVE HEAT  6525
## 5      LIGHTNING  5230
```

Let's visualise the top 5 fatalities and injuries on a scale of total time


```r
library(ggplot2)

# extract them
top_injuries <- filter(storms, EVTYPE %in% highest_injuries$EVTYPE[1:5])
top_fatalities <- filter(storms, EVTYPE %in% highest_fatalities$EVTYPE[1:5])

# summary statistics
top_injuries <- summarise(group_by(top_injuries, EVTYPE, BGN_DATE), sum(INJURIES, na.rm = T))
top_fatalities <- summarise(group_by(top_fatalities, EVTYPE, BGN_DATE), sum(FATALITIES, na.rm = T))

# renaming
names(top_injuries) <- c("event", "date", "total")
names(top_fatalities) <- c("event", "date", "total")

# plots 
qplot(date, total, data = top_injuries, color = event, geom = "line") + 
ggtitle("Total injuries from 1950 to 2011 for the top causes of injury")
```

![](solution_files/figure-html/unnamed-chunk-8-1.png)\

```r
qplot(date, total, data = top_fatalities, color = event, geom = "line") + 
ggtitle("Total fatalities from 1950 to 2011 for the top causes of fatality")
```

![](solution_files/figure-html/unnamed-chunk-8-2.png)\

The effects of tornados on the injuries and fatalities overshadows the other storms. There is a high degree of overlap between injuries and fatalities when it comes to the tornados. If I were a government official and was making a decision based on public health, I would best prepare the nation for tornadoes.

### Effects on the economy

Looking through the codebook that is given along with the data (found [here](https://d396qusza40orc.cloudfront.net/repdata%2Fpeer2_doc%2Fpd01016005curr.pdf)), the types of events that have economic consequences are those that damage property. These include things like crop damage and all around general damage to property. These can be found under the variable names `CROPDMG` and `PROPDMG` respectively. In addition there is a multiplicative factor involved for each:


```r
levels(storms$CROPDMGEXP)
```

```
## [1] ""  "?" "0" "2" "B" "k" "K" "m" "M"
```

```r
levels(storms$PROPDMGEXP)
```

```
##  [1] ""  "-" "?" "+" "0" "1" "2" "3" "4" "5" "6" "7" "8" "B" "h" "H" "K"
## [18] "m" "M"
```

Since we are going to want to examine economic effects on a grand scale, we will only focus on the multiplicative factors in thousands (`k` or `K`) or more. Anything below that is negligible (500$ is negligible compared to, say, 50000\$). In this sense we need to remove the data that is less than 1000\$ in damages. Afterwards we convert the units with a function.


```r
# function for converting between numerical code to value
convert <- function(damage, damage_exp) {
    if (damage_exp == "B" | damage_exp == "b") {
        return(1e9*damage)
    }
    if (damage_exp == "k" | damage_exp == "K") {
        return(1e3*damage)
    }
    if (damage_exp == "m" | damage_exp =="M") {
        return(1e6*damage)
    }
}

# filter valid crop and property damage values
damages <- filter(storms, CROPDMGEXP %in% c("B", "b", "K", "k", "M", "m"),
                  PROPDMGEXP %in% c("B", "b", "K", "k", "M", "m"))


damages <- damages %>%
    rowwise() %>%
    mutate(cdmg = convert(CROPDMG, CROPDMGEXP),
           pdmg = convert(PROPDMG, PROPDMGEXP),
           total_dmg = cdmg + pdmg)

# aggregate total damages by event type, ignore the warning
total_damages <- summarise(group_by(damages, EVTYPE), sum(cdmg, na.rm = T), sum(pdmg, na.rm = T),
                           sum(total_dmg, na.rm = T))
```

```
## Warning: Grouping rowwise data frame strips rowwise nature
```

```r
# rename columns
names(total_damages) <- c("event", "crop_damage", "property_damage", "total_damage")
```

Now let's find out what events have the biggest economic consequence through all the years. I'm going to assume that property damages are more consequential to a government official's decisions, due to the fact that buildings are more expensive to rebuild than it is to make a new crop of acres of corn for example. Despite this fact we can take a look at the top 5 events that contribute to economic consequences with the respect to crop and property damage seprately. 

**The 5 highest sources of crop damage are:**


```r
head(select(arrange(total_damages, -crop_damage), event, crop_damage), 5)
```

```
## Source: local data frame [5 x 2]
## 
##               event crop_damage
##              (fctr)       (dbl)
## 1             FLOOD  5170955450
## 2       RIVER FLOOD  5028734000
## 3         ICE STORM  5022110000
## 4         HURRICANE  2688910000
## 5 HURRICANE/TYPHOON  2607872800
```

**The 5 highest sources of property damage are:**


```r
head(select(arrange(total_damages, -property_damage), event, property_damage), 5)
```

```
## Source: local data frame [5 x 2]
## 
##               event property_damage
##              (fctr)           (dbl)
## 1             FLOOD    132836489050
## 2 HURRICANE/TYPHOON     26740295000
## 3           TORNADO     16166771690
## 4         HURRICANE      9716358000
## 5              HAIL      7991783690
```

**The 5 highest sources of total damage are:**


```r
head(select(arrange(total_damages, -total_damage), event, total_damage), 5)
```

```
## Source: local data frame [5 x 2]
## 
##               event total_damage
##              (fctr)        (dbl)
## 1             FLOOD 138007444500
## 2 HURRICANE/TYPHOON  29348167800
## 3           TORNADO  16520148150
## 4         HURRICANE  12405268000
## 5       RIVER FLOOD  10108369000
```

We see the event with the biggest economic consequence is undoubtebly **floods**. Tornados are, surprisingly, not in the top 5 events that cause the most damage to crops. This is an interesting result, since tornados are most frequent in large fields containing crops. Let's create a plot of the total damages per the top 5 events:


```r
# filter by most consequential events
final_names <- arrange(total_damages, -total_damage)$event[1:5]
top_monies <- filter(damages, EVTYPE %in% final_names)
top_monies <- summarise(group_by(top_monies, EVTYPE, BGN_DATE), sum(total_dmg, na.rm = T))
```

```
## Warning: Grouping rowwise data frame strips rowwise nature
```

```r
# rename 
names(top_monies) <- c("event", "date", "economic_damage")
```

**Important note**
It's important to mention that the range of dates used for assessing total damages.


```r
range(damages$BGN_DATE)
```

```
## [1] "1993-01-04" "2011-11-30"
```

This is because we only looked at damages over 1000$. All other multiplicative factors were ignored. 


```r
# plot 
qplot(date, economic_damage, data = top_monies, color = event, geom = "line") + 
ggtitle("Total damages from the 5 most important storm events")
```

![](solution_files/figure-html/unnamed-chunk-16-1.png)\

### Concluding remarks
In conclusion with respect to public health, tornados are the biggest threat. With respect to economic consequences, floods are the biggest threat. If I were a public official, I would place my funds into preparing the public for floods and tornados.
