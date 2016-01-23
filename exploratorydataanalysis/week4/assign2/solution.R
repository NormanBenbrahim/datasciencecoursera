# Q. 1: Have total emissions from PM2.5 decreased in the United States from 
# 1999 to 2008? Using the base plotting system, make a plot showing the total
# PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 
# 2008

# libraries
library(dplyr)


# general file i/o
c_file <- "Source_Classification_Code.rds"
p_file <- "summarySCC_PM25.rds"

if (!file.exists(c_file) | !file.exists(p_file)) {
dataUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
tmp <- tempfile()
download.file(dataUrl, destfile = tmp)
unzip(tmp, exdir = "./")
unlink(tmp)
}

# load
classif <- readRDS(c_file)
pm25 <- readRDS(p_file)

# cleanup
pm25$year <- as.Date(as.character(pm25$year), format = "%Y")

# get statistic
sums <- summarise(group_by(pm25, year), sum(Emissions))

# plot and save it 
png("plot1.png")
barplot(sums$`sum(Emissions)`, 
        names = sums$year,
        col = c("darkgreen", "blue", "red", "purple"),
        ylab = "Total Emissions",
        xlab = "Year")
dev.off()
