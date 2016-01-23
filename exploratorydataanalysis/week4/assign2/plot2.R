# libraries 
library(dplyr)

if (!exists("pm25")) {
    source("load_data.R")
}

baltimore <- filter(pm25, fips == "24510")
sums2 <- summarise(group_by(baltimore, year), sum(Emissions))
png("./plot2.png")
barplot(sums2$`sum(Emissions)`,
        names = sums$year,
        col = c("darkgreen", "blue", "red", "purple"),
        ylab = "Total Emissions",
        xlab = "Year",
        main = "Total Emissions for Baltimore, Maryland")
dev.off()