# Summarizing Data

We'll be using Baltimore city restaurants as an example (a small subset of them).


```r
if (!file.exists("./data")) {
    dir.create("./data")
}

if (!file.exists("./data/restaurants.csv")) {
    fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accesType=DOWNLOAD"
    download.file(fileUrl, destfile = "./data/restaurants.csv", method = "curl")
}

restdata <- read.csv("./data/restaurants.csv")
str(restdata)
```

```
## 'data.frame':	1327 obs. of  6 variables:
##  $ name           : Factor w/ 1277 levels "#1 CHINESE KITCHEN",..: 9 3 992 1 2 4 5 6 7 8 ...
##  $ zipCode        : int  21206 21231 21224 21211 21223 21218 21205 21211 21205 21231 ...
##  $ neighborhood   : Factor w/ 173 levels "Abell","Arlington",..: 53 52 18 66 104 33 98 133 98 157 ...
##  $ councilDistrict: int  2 1 1 14 9 14 13 7 13 1 ...
##  $ policeDistrict : Factor w/ 9 levels "CENTRAL","EASTERN",..: 3 6 6 4 8 3 6 4 6 6 ...
##  $ Location.1     : Factor w/ 1210 levels "1 BIDDLE ST\nBaltimore, MD\n",..: 835 334 554 755 492 537 505 530 507 569 ...
```

Tabulate conditions in the data frame


```r
table(restdata$zipCode %in% c("21212", "21213"))
```

```
## 
## FALSE  TRUE 
##  1268    59
```

Subsetting using the conditioning of specific variables


```r
restdata[restdata$zipCode %in% c("21212", "21213"), ]
```

```
##                                      name zipCode
## 29                      BAY ATLANTIC CLUB   21212
## 39                            BERMUDA BAR   21213
## 92                              ATWATER'S   21212
## 111            BALTIMORE ESTONIAN SOCIETY   21213
## 187                              CAFE ZEN   21212
## 220                   CERIELLO FINE FOODS   21212
## 266    CLIFTON PARK GOLF COURSE SNACK BAR   21213
## 276                CLUB HOUSE BAR & GRILL   21213
## 289                 CLUBHOUSE BAR & GRILL   21213
## 291                           COCKY LOU'S   21213
## 362       DREAM TAVERN, CARRIBEAN  U.S.A.   21213
## 373                         DUNKIN DONUTS   21212
## 383        EASTSIDE  SPORTS  SOCIAL  CLUB   21213
## 417                      FIELDS OLD TRAIL   21212
## 475                             GRAND CRU   21212
## 545                           RANDY'S BAR   21213
## 604     MURPHY'S NEIGHBORHOOD BAR & GRILL   21212
## 616                                NEOPOL   21212
## 620             NEW CLUB THUNDERBIRD INC.   21213
## 626                    NEW MAYFIELD, INC.   21213
## 678                          IKAN SEAFOOD   21212
## 711                          KAY-CEE CLUB   21212
## 763                                LA'RAE   21213
## 777                  LEMONGRASS BALTIMORE   21213
## 779                   LEN'S SANDWICH SHOP   21213
## 845                            MCDONALD'S   21213
## 852                            MCDONALD'S   21212
## 873                  NEW REX LIQUORS,INC.   21212
## 895                             OK TAVERN   21213
## 919                          PANERA BREAD   21212
## 940                    PEIWEI ASIAN DINER   21212
## 949                   PERGUSA ENTERPRISES   21212
## 957               PHANTOM'S BAR AND GRILL   21213
## 976          POPEYES FAMOUS FRIED CHICKEN   21212
## 994                         ROBBIE'S NEST   21213
## 1017                          RUTLAND BAR   21213
## 1018                      RYAN'S DAUGHTER   21212
## 1022         saigon remembered restaurant   21212
## 1053                SHIRLEY'S  HONEY HOLE   21213
## 1120                     STEEPLE CHASE II   21213
## 1122                               SUBWAY   21213
## 1153                              TAM-TAM   21212
## 1155                                TASTE   21212
## 1159                         TAYLORS EAST   21213
## 1186                THE EDGE BAR & LOUNGE   21213
## 1187 THE EDGE BAR & LOUNGE - KITCHEN AREA   21213
## 1198               THE HOLLOW BAR & GRILL   21212
## 1209             THE NEW BUCKETT'S LOUNGE   21213
## 1232                         THREE  ACE'S   21213
## 1246                 TORAIN'S  HIDE-A-WAY   21213
## 1259                    TSUNAMI BALTIMORE   21213
## 1287                         VITO'S PIZZA   21212
## 1298 WENDY'S OLD FASHIONED HAMBURGERS #96   21212
## 1304                 WHITTEN'S  (4502-04)   21213
## 1312                          wozi lounge   21212
## 1319           YETI RESTAURANT & CARRYOUT   21212
## 1320                     YORK CLUB TAVERN   21212
## 1323            ZEN WEST ROADSIDE CANTINA   21212
## 1325                     ZINK'S CAF\u0090   21213
##                     neighborhood councilDistrict policeDistrict
## 29                      Downtown              11        CENTRAL
## 39                 Broadway East              12        EASTERN
## 92     Chinquapin Park-Belvedere               4       NORTHERN
## 111           South Clifton Park              12        EASTERN
## 187                     Rosebank               4       NORTHERN
## 220    Chinquapin Park-Belvedere               4       NORTHERN
## 266                  Darley Park              14   NORTHEASTERN
## 276  Orangeville Industrial Area              13        EASTERN
## 289  Orangeville Industrial Area              13        EASTERN
## 291                Broadway East              12        EASTERN
## 362                Broadway East              13        EASTERN
## 373                     Homeland               4       NORTHERN
## 383                Broadway East              13        EASTERN
## 417                   Mid-Govans               4       NORTHERN
## 475    Chinquapin Park-Belvedere               4       NORTHERN
## 545                Broadway East              12        EASTERN
## 604                   Mid-Govans               4       NORTHERN
## 616    Chinquapin Park-Belvedere               4       NORTHERN
## 620                  Middle East              13        EASTERN
## 626                Belair-Edison              13   NORTHEASTERN
## 678    Chinquapin Park-Belvedere               4       NORTHERN
## 711                     Homeland               4       NORTHERN
## 763                       Oliver              12        EASTERN
## 777                 Little Italy               1   SOUTHEASTERN
## 779                Broadway East              12        EASTERN
## 845           South Clifton Park              12        EASTERN
## 852               Radnor-Winston               4       NORTHERN
## 873                  Wilson Park               4       NORTHERN
## 895                Biddle Street              13        EASTERN
## 919                  Lake Walker               4       NORTHERN
## 940                   Cedarcroft               4       NORTHERN
## 949                     Rosebank               4       NORTHERN
## 957                Belair-Edison               3   NORTHEASTERN
## 976               Winston-Govans               4       NORTHERN
## 994                Broadway East              12        EASTERN
## 1017               Broadway East              12        EASTERN
## 1018   Chinquapin Park-Belvedere               4       NORTHERN
## 1022                  Mid-Govans               4       NORTHERN
## 1053               Broadway East              13        EASTERN
## 1120               Biddle Street              13        EASTERN
## 1122                      Oliver              12        EASTERN
## 1153                  Mid-Govans               4       NORTHERN
## 1155                  Mid-Govans               4       NORTHERN
## 1159                       Berea              13        EASTERN
## 1186               Broadway East              12        EASTERN
## 1187               Broadway East              12        EASTERN
## 1198                    Rosebank               4       NORTHERN
## 1209               Broadway East              13        EASTERN
## 1232               Belair-Edison               3   NORTHEASTERN
## 1246               Broadway East              12        EASTERN
## 1259                Little Italy               1   SOUTHEASTERN
## 1287                  Cedarcroft               4       NORTHERN
## 1298                    Homeland               4       NORTHERN
## 1304           Claremont-Freedom              13   NORTHEASTERN
## 1312                    Guilford               4       NORTHERN
## 1319                    Rosebank               4       NORTHERN
## 1320                    Homeland               4       NORTHERN
## 1323                    Rosebank               4       NORTHERN
## 1325               Belair-Edison              13   NORTHEASTERN
##                                Location.1
## 29        206 REDWOOD ST\nBaltimore, MD\n
## 39        1801 NORTH AVE\nBaltimore, MD\n
## 92     529 BELVEDERE AVE\nBaltimore, MD\n
## 111       1932 BELAIR RD\nBaltimore, MD\n
## 187    438 BELVEDERE AVE\nBaltimore, MD\n
## 220    529 BELVEDERE AVE\nBaltimore, MD\n
## 266        2701 ST LO DR\nBaltimore, MD\n
## 276      4217 ERDMAN AVE\nBaltimore, MD\n
## 289      4217 ERDMAN AVE\nBaltimore, MD\n
## 291       2101 NORTH AVE\nBaltimore, MD\n
## 362   2300 LAFAYETTE AVE\nBaltimore, MD\n
## 373         5422 YORK RD\nBaltimore, MD\n
## 383  1203 COLLINGTON AVE\nBaltimore, MD\n
## 417         5723 YORK RD\nBaltimore, MD\n
## 475    527 BELVEDERE AVE\nBaltimore, MD\n
## 545       2135 NORTH AVE\nBaltimore, MD\n
## 604         5847 YORK RD\nBaltimore, MD\n
## 616    529 BELVEDERE AVE\nBaltimore, MD\n
## 620        2201 CHASE ST\nBaltimore, MD\n
## 626       3349 BELAIR RD\nBaltimore, MD\n
## 678    529 BELVEDERE AVE\nBaltimore, MD\n
## 711     201 HOMELAND AVE\nBaltimore, MD\n
## 763      1000 HOFFMAN ST\nBaltimore, MD\n
## 777     1300 BANK STREET\nBaltimore, MD\n
## 779   1500 WASHINGTON ST\nBaltimore, MD\n
## 845        2001 BROADWAY\nBaltimore, MD\n
## 852         5100 YORK RD\nBaltimore, MD\n
## 873         4637 YORK RD\nBaltimore, MD\n
## 895       2301 BIDDLE ST\nBaltimore, MD\n
## 919     6307 1 2 YORK RD\nBaltimore, MD\n
## 940         6302 YORK RD\nBaltimore, MD\n
## 949         5928 YORK RD\nBaltimore, MD\n
## 957       3539 BELAIR RD\nBaltimore, MD\n
## 976         5002 YORK RD\nBaltimore, MD\n
## 994       2250 NORTH AVE\nBaltimore, MD\n
## 1017    1508 RUTLAND AVE\nBaltimore, MD\n
## 1018   600 BELVEDERE AVE\nBaltimore, MD\n
## 1022        5857 york rd\nBaltimore, MD\n
## 1053      2300 OLIVER ST\nBaltimore, MD\n
## 1120       2401 CHASE ST\nBaltimore, MD\n
## 1122      1400 NORTH AVE\nBaltimore, MD\n
## 1153        5722 YORK RD\nBaltimore, MD\n
## 1155   510 BELVEDERE AVE\nBaltimore, MD\n
## 1159     1201 POTOMAC ST\nBaltimore, MD\n
## 1186     2015 FEDERAL ST\nBaltimore, MD\n
## 1187     2015 FEDERAL ST\nBaltimore, MD\n
## 1198        5921 YORK RD\nBaltimore, MD\n
## 1209     1432 CHESTER ST\nBaltimore, MD\n
## 1232      3534 belair RD\nBaltimore, MD\n
## 1246   1701 ELLSWORTH ST\nBaltimore, MD\n
## 1259        1300 BANK ST\nBaltimore, MD\n
## 1287        6304 YORK RD\nBaltimore, MD\n
## 1298        5615 YORK RD\nBaltimore, MD\n
## 1304     4502 ERDMAN AVE\nBaltimore, MD\n
## 1312        4515 YORK RD\nBaltimore, MD\n
## 1319        5926 YORK RD\nBaltimore, MD\n
## 1320        5407 YORK RD\nBaltimore, MD\n
## 1323        5916 YORK RD\nBaltimore, MD\n
## 1325   3300 LAWNVIEW AVE\nBaltimore, MD\n
```

that's certainly useful. Another useful thing you can do is cross tabulate. For example, here is the UCB admissions dataset found in base R:

```r
data("UCBAdmissions")
df = as.data.frame(UCBAdmissions)
summary(df)
```

```
##       Admit       Gender   Dept       Freq      
##  Admitted:12   Male  :12   A:4   Min.   :  8.0  
##  Rejected:12   Female:12   B:4   1st Qu.: 80.0  
##                            C:4   Median :170.0  
##                            D:4   Mean   :188.6  
##                            E:4   3rd Qu.:302.5  
##                            F:4   Max.   :512.0
```

We can cross tabulate variables to see what the relationship is. In the equation, the left is the variable that is going to be displayed in the table, and the right is the other variable, which may be broken down by some relationship


```r
xtabs(Freq ~ Gender + Admit, data = df)
```

```
##         Admit
## Gender   Admitted Rejected
##   Male       1198     1493
##   Female      557     1278
```

One fairly useful command is `object.size()`, which gives you the size in bytes of the object in question.


```r
some_data <- rnorm(1e6)
object.size(some_data)
```

```
## 8000040 bytes
```

```r
# in megabytes
print(object.size(some_data), units = "Mb")
```

```
## 7.6 Mb
```

# Creating New Variables

Sometimes you will want to create new variables in your data frame. This is also partly data engineering. One way to do this is creating categorical variables. Here we create categories based on quantiles of the data:


```r
restdata$zipGroups <- cut(restdata$zipCode, breaks = quantile(restdata$zipCode))
table(restdata$zipGroups)
```

```
## 
## (-2.123e+04,2.12e+04]  (2.12e+04,2.122e+04] (2.122e+04,2.123e+04] 
##                   337                   375                   282 
## (2.123e+04,2.129e+04] 
##                   332
```

An easier way to do this is to use the `cut2()` function from the library `Hmisc`.


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
## The following objects are masked from 'package:base':
## 
##     format.pval, round.POSIXt, trunc.POSIXt, units
```

```r
restdata$zipGroups <- cut2(restdata$zipCode, g = 4) # set no. of groups
table(restdata$zipGroups)
```

```
## 
## [-21226,21205) [ 21205,21220) [ 21220,21227) [ 21227,21287] 
##            338            375            300            314
```
