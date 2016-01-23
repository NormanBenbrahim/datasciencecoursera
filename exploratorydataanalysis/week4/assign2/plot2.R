# libraries 
library(dplyr)

if (!exists("pm25")) {
    source("load_data.R")
}

# subset it 
baltimore <- filter(pm25, fips == "24510")
sums <- summarise(group_by(baltimore, year), sum(Emissions, na.rm = T))

# plot and save it 
png("./plot2.png")
plot(sums, 
     col = "purple",
     lwd = 2,
     type = "l",
     ylab = "Total Emissions",
     xlab = "Year",
     main = "Total Emissions for Baltimore, MD")
dev.off()