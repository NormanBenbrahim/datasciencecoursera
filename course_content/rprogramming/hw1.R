# Q.11 In the dataset provided for this Quiz, what are the column names of the dataset?
data <- read.csv("hw1_data.csv")

colnames(data)

# Q.12 Extract the first 2 rows of the data frame and print them to the console. 
# What does the output look like?
head(data)

# Q. 13 How many observations (i.e. rows) are in this data frame?
dim(data)[1]

# Q. 14 Extract the last 2 rows of the data frame and print them to the console. 
# What does the output look like?
tail(data)

# Q. 15 What is the value of Ozone in the 47th row?
data$Ozone[47]

# Q. 16 How many missing values are in the Ozone column of this data frame?
length(ozone[is.na(ozone)])

# Q. 17 What is the mean of the Ozone column in this dataset? Exclude missing values
# (coded as NA) from this calculation.
mean(ozone[!is.na(ozone)])

# Q.18 Extract the subset of rows of the data frame where Ozone values are above 31 
# and Temp values are above 90. What is the mean of Solar.R in this subset?
subset <- data[(data$Ozone>31) & (data$Temp>90),]
solar <- subset$Solar.R[!is.na(subset$Solar.R)]
mean(solar)

# Q.19 What is the mean of "Temp" when "Month" is equal to 6?
subset2 <- data[(data$M==6),]
temp <- subset2$T
mean(temp[!is.na(temp)])

# What was the maximum ozone value in the month of May (i.e. Month is equal to 5)?
subset3 <- data[(data$M==5),]
ozone <- subset3$Ozone
max(ozone[!is.na(ozone)])




