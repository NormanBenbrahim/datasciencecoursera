# libraries 
library(ggplot2)
library(dplyr)

if (!exists("pm25") | !exists("classif")) {
    source("load_data.R")
}

# extract the names
all_levels <- levels(classif$EI.Sector)
coal_names <- all_levels[grep("Coal", all_levels, ignore.case = T)]

# subset out only coal values
coal_subset <- subset(classif, EI.Sector %in% coal_names)

# get scc indices
scc <- coal_subset$SCC

# apply it to the pm25 data
pm25_subset <- filter(pm25, pm25$SCC %in% as.character(scc))

# sum the year values
sums <- summarise(group_by(pm25_subset, year), sum(Emissions, na.rm = T))

# rename columns
names(sums) <- c("Year", "Emissions")

# plot the result
png("./plot4.png")
qplot(Year, Emissions, data = sums, geom = "line") + 
    ggtitle("Total Vehicle Related Emissions in Baltimore")
dev.off()



