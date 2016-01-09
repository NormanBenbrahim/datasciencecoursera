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

# create png file 
png(filename="plot4.png", 
    width=480, height=480,
    units="px", bg="transparent")

# initialize the canvas to make a 2 by 2 array of images (4 total)
par(mfrow=c(2, 2))

# (1,1)
plot(DateTime, Global_active_power, 
     type="l",
     xlab="", ylab="Global Active Power")

# (1, 2)
plot(DateTime, Voltage,
     type="l",
     xlab="datetime", ylab="Voltage")

# (2, 1)
plot(DateTime, Sub_metering_1, 
     type="l",
     col="black",
     xlab="", ylab="Energy sub metering")
lines(DateTime, Sub_metering_2, col="red")
lines(DateTime, Sub_metering_3, col="blue")
legend("topright", 
       bty="n",
       col=c("black", "red", "blue"),
       colnames(data_subset)[7:9],
       lwd=1)

# (2, 2)
plot(DateTime, Global_reactive_power, 
     type="l",
     col="black",
     xlab="datetime", ylab = colnames(data_subset)[4])

# close connection
dev.off()








