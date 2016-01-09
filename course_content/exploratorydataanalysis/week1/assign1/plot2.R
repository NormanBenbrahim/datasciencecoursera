############################## THE LOAD PART ################################
# read the data, takes about 30 seconds with 8gb ram macbook pro retina
# to read the full data

# we'll skipp the first 21976 entries to speed things up and only include up
# to some values in march to be safe. I found these numbers by simply 
# opening the text file in an editor and picking them manually.

# for column names
nm <- read.table("household_power_consumption.txt",
							 sep=";",
							 header=TRUE,
							 nrows=1)

data <- read.table("household_power_consumption.txt", sep=";", 
				   skip=21976, nrows=91557, na="?",
				   colClasses=c("character", "character", rep("numeric",7)))

colnames(data) <- names(nm) # set column names properly

# subset within the two days we are interested in
use <- data$Date == "1/2/2007" | data$Date == "2/2/2007"
data_subset <- data[use, ]

# Fix our date and time columns to contain only one DateTime column 
dt <- paste(data_subset$Date, data_subset$Time)
data_subset$DateTime <- strptime(dt, "%d/%m/%Y %H:%M:%S")
rownames(data_subset) <- 1:nrow(data_subset) # re-number the rows







############################## THE PLOT PART ################################
# use the attach function for easier subsetting
attach(data_subset)

# create the png file 
png(filename="plot2.png", 
    width=480, height=480, 
    units="px", bg="transparent")

# plot the result with labels
plot(DateTime, Global_active_power, 
     type="l",
     xlab="",
     ylab="Global Active Power (kilowatts)")

# close the connection
dev.off()

