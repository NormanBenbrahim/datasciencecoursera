# libraries 
library(ggplot2)
library(dplyr)

if (!exists("pm25")) {
    source("load_data.R")
}

# subset it 
baltimore <- filter(pm25, fips == "24510")
sums <- summarise(group_by(baltimore, year, type), sum(Emissions, na.rm = T))

# rename columns
names(sums) <- c("Year", "Type", "Emissions")

# plot and save it 
png("plot3.png")
qplot(Year, Emissions, data = sums, color = Type, geom = "line") + 
ggtitle("Baltimore City Emissions By Type")
dev.off()