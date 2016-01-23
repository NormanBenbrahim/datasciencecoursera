# libraries 
library(ggplot2)
library(dplyr)

if (!exists("pm25") | !exists("classif")) {
    source("load_data.R")
}

# extract names
all_levels <- levels(classif$EI.Sector)
motor_names <- all_levels[grep("Vehicle", all_levels, ignore.case = T)]

# subset only motor vehicles
motor_subset <- subset(classif, EI.Sector %in% motor_names)

# get scc indices
scc <- motor_subset$SCC

# filter based on scc in baltimore and los angeles
pm25_baltimore <- filter(pm25, pm25$SCC %in% as.character(scc), fips == "24510")
pm25_la <- filter(pm25, pm25$SCC %in% as.character(scc), fips == "06037")

# change fips to city name and stack together
pm25_baltimore$fips <- as.factor("Baltimore")
pm25_la$fips <- as.factor("LA")
pm25_subset <- rbind(pm25_baltimore, pm25_la)

# sum the year values by city and fips
sums <- summarise(group_by(pm25_subset, year, fips), sum(Emissions, na.rm = T))

# one more column rename
names(sums) <- c("Year", "City", "Emissions")

# plot 
png("./plot6.png")
qplot(Year, Emissions, data = sums, color = City, geom = "line") + 
    ggtitle("Total Vehicle Related Emissions in Baltimore and Los Angeles (LA)")
dev.off()
    
    