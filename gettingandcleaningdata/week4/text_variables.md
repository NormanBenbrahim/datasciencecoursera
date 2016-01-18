# Editing Text Variables

There will be times where you grab a spreadsheet or other kind of data file containing really ugly text variables. Here, we go through how to clean them up and make them usable through examples. We will use the Baltimore camera data (running red lights lol)


```r
if (!file.exists("./data")){
    dir.create("./data")
}

fUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
if (!file.exists("./data/cameras.csv")) {
    download.file(fUrl, destfile = "./data/cameras.csv", method = "curl")
}

camera_data <- read.csv("./data/cameras.csv")
names(camera_data)
```

```
## [1] "address"      "direction"    "street"       "crossStreet" 
## [5] "intersection" "Location.1"
```

One thing we can do is reduce capital letters in strings, use the function `tolower()` to do this. If you wanna make them all upper case you can also use `toupper()`.


```r
tolower(names(camera_data))
```

```
## [1] "address"      "direction"    "street"       "crossstreet" 
## [5] "intersection" "location.1"
```

To split a string into two based on a value, you can use strsplit. This is similar to `.split()` in python. In the lecture he splits the column name "Location.1" into "Location" "1". I don't know why you would want to do that though... whatever, here's how it's done


```r
splitnames <- strsplit(names(camera_data), "\\.")
splitnames[[6]]
```

```
## [1] "Location" "1"
```

You can also use `sub()`, but this function applies only once. This means it'll find the first instance of the string to replace, and then stop. E.g.,

```r
example1 <- "a_string"
example2 <- "yet_another_string"

sub("_", "", example1)
```

```
## [1] "astring"
```

```r
sub("_", "", example2)
```

```
## [1] "yetanother_string"
```

If you wanna replace multiple instances of a character, use `gsub()`


```r
example3 <- "so_many_under_scores"
gsub("_", "", example3)
```

```
## [1] "somanyunderscores"
```

To search for specific values in variable names you can use `grep()` and `grepl()`.


```r
head(camera_data, 8)
```

```
##                          address direction      street  crossStreet
## 1       S CATON AVE & BENSON AVE       N/B   Caton Ave   Benson Ave
## 2       S CATON AVE & BENSON AVE       S/B   Caton Ave   Benson Ave
## 3 WILKENS AVE & PINE HEIGHTS AVE       E/B Wilkens Ave Pine Heights
## 4        THE ALAMEDA & E 33RD ST       S/B The Alameda      33rd St
## 5        E 33RD ST & THE ALAMEDA       E/B      E 33rd  The Alameda
## 6        ERDMAN AVE & N MACON ST       E/B      Erdman     Macon St
## 7        ERDMAN AVE & N MACON ST       W/B      Erdman     Macon St
## 8      N CHARLES ST & E LAKE AVE       S/B     Charles     Lake Ave
##                 intersection                      Location.1
## 1     Caton Ave & Benson Ave (39.2693779962, -76.6688185297)
## 2     Caton Ave & Benson Ave (39.2693157898, -76.6689698176)
## 3 Wilkens Ave & Pine Heights  (39.2720252302, -76.676960806)
## 4     The Alameda  & 33rd St (39.3285013141, -76.5953545714)
## 5      E 33rd  & The Alameda (39.3283410623, -76.5953594625)
## 6         Erdman  & Macon St (39.3068045671, -76.5593167803)
## 7         Erdman  & Macon St  (39.306966535, -76.5593122365)
## 8         Charles & Lake Ave  (39.3690535299, -76.625826716)
```

Find where the intersections that include the alameda as one of the roads


```r
grep("Alameda", camera_data$intersection)
```

```
## [1]  4  5 36
```

So it appears in the 4th, 5th, and 36th `intersection` variable. `grepl()` on the other hand will look for the instances and return a vector of booleans where these values occur


```r
grepl("Alameda", camera_data$intersection)
```

```
##  [1] FALSE FALSE FALSE  TRUE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE
## [12] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [23] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [34] FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [45] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [56] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [67] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [78] FALSE FALSE FALSE
```

```r
# count the instances using a table
table(grepl("Alameda", camera_data$intersection))
```

```
## 
## FALSE  TRUE 
##    77     3
```

In this way we can subset based on instances of variables, which is pretty powerful:


```r
camera_data2 <- camera_data[!grepl("Alameda", camera_data$intersection), ]
str(camera_data2)
```

```
## 'data.frame':	77 obs. of  6 variables:
##  $ address     : Factor w/ 71 levels "E 33RD ST & THE ALAMEDA",..: 49 49 70 14 14 31 5 35 10 11 ...
##  $ direction   : Factor w/ 4 levels "E/B","N/B","S/B",..: 2 3 1 1 4 3 4 1 1 1 ...
##  $ street      : Factor w/ 55 levels "Caton Ave","Charles",..: 1 1 54 8 8 2 26 33 5 6 ...
##  $ crossStreet : Factor w/ 66 levels "33rd St","4th St",..: 6 6 49 40 40 36 7 38 34 12 ...
##  $ intersection: Factor w/ 74 levels " &","Caton Ave & Benson Ave",..: 2 2 73 13 13 3 35 47 8 11 ...
##  $ Location.1  : Factor w/ 76 levels "(39.1999130165, -76.5559766825)",..: 7 6 8 35 36 74 32 29 17 21 ...
```

If you use `value = TRUE` in `grep()` it will return the values that these instances occur, rather than where they occur. Easier than getting the indices and then subsetting


```r
grep("Alameda", camera_data$intersection, value = TRUE)
```

```
## [1] "The Alameda  & 33rd St"   "E 33rd  & The Alameda"   
## [3] "Harford \n & The Alameda"
```

A very useful library to keep in mind is `stringr` (or `stringi`, this one's faster). This allows you to do various string operations in a python-esque way:


```r
library(stringr)
name <- "Norman Benbrahim; the most handsome of all the devils 😈" 
nchar(name)
```

```
## [1] 55
```

```r
substr(name, 1, 9)
```

```
## [1] "Norman Be"
```

```r
str_count(name)
```

```
## [1] 55
```
