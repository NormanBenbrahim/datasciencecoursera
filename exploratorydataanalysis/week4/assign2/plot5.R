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

# filter based on scc in baltimore
pm25_subset <- filter(pm25, pm25$SCC %in% as.character(scc), fips == "24510")

# sum the year values
sums <- summarise(group_by(pm25_subset, year), sum(Emissions, na.rm = T))

# rename columns
names(sums) <- c("Year", "Emissions")
