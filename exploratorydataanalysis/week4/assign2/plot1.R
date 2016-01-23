# libraries 
library(dplyr)

if (!exists("pm25")) {
    source("load_data.R")
}

# get statistic
sums <- summarise(group_by(pm25, year), sum(Emissions))

# plot and save it 
png("./plot1.png")
barplot(sums$`sum(Emissions)`, 
        names = sums$year,
        col = c("darkgreen", "blue", "red", "purple"),
        ylab = "Total Emissions",
        xlab = "Year",
        main = "Total Emissions for the US")
dev.off()