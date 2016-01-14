#1. Register an application with the Github API here https://github.com/settings/applications. 
# Access the API to get information on your instructors repositories (hint: this is the url you want 
# "https://api.github.com/users/jtleek/repos"). Use this data to find the time that the datasharing 
# repo was created. What time was it created?

# This tutorial may be useful (https://github.com/hadley/httr/blob/master/demo/oauth2-github.r). 
# You may also need to run the code in the base R package and not R studio.

## NOTE you have to run this using R not RStudio
library(httr)
require(httpuv)
require(jsonlite)
oauth_endpoints("github")
myapp <- oauth_app("first_app",
                   key = "ac51c2629a4273d01541",
                   secret = "dded3d7b08bf89f3e565fcf3077f0e5defc76f9e")

github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

request <- GET("https://api.github.com/users/jtleek/repos", config(token = github_token))
stop_for_status(request)
output <- content(request)
list(output[[4]]$created_at)


# 2. The sqldf package allows for execution of SQL commands on R data frames. 
# We will use the sqldf package to practice the queries we might send with the dbSendQuery 
# command in RMySQL.
# Download the American Community Survey data and load it into an R object called acs
# Which of the following commands will select only the data for the probability weights 
# pwgtp1 with ages less than 50?

# this one's easy, no need to download anything, just basic sql command within sqldf
# A: sqldf("select pwgtp1 from acs where AGEP < 50")



# 3. Using the same data frame you created in the previous problem, what is the equivalent
# function to unique(acs$AGEP)

# also easy
# A: sqldf("select distinct AGEP from acs")



# 4. How many characters are in the 10th, 20th, 30th and 100th lines of HTML from this page:
# http://biostat.jhsph.edu/~jleek/contact.html
# (Hint: the nchar() function in R may be helpful)
hurl <- "http://biostat.jhsph.edu/~jleek/contact.html"
con <- url(hurl)
htmlCode <- readLines(con)
close(con)
sapply(htmlCode[c(10, 20, 30, 100)], nchar)


# Read this data set into R and report the sum of the numbers in the fourth of the nine columns.
# https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for
# Original source of the data: http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for
# (Hint this is a fixed width file format)

# simple read.csv to read this
dat <- read.csv("getdata-wksst8110.for")
head(dat)
dim(dat)
file_name <- "getdata-wksst8110.for"
# use the fixed with format reading function. open the file and count the widths
df <- read.fwf(file=file_name,widths=c(-1,9,-5,4,4,-5,4,4,-5,4,4,-5,4,4), skip=4)
sum(df[, 4])



