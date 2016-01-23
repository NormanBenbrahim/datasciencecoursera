# libraries 
library(dplyr)

if (!exists("pm25")) {
    source("load_data.R")
}

# get statistic
sums <- summarise(group_by(pm25, year), sum(Emissions, na.rm = T))

# plot and save it 
png("./plot1.png")
plot(sums, 
     col = "purple",
     lwd = 2,
     type = "l",
     ylab = "Total Emissions",
     xlab = "Year",
     main = "Total Emissions for the US")
dev.off()