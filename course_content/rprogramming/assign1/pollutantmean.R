## first function for assignment1
pollutantmean <- function(directory, pollutant, id=1:332) {
	cumsum <- 0
	len <- 0 

	for (id_number in id) {
		if (id_number>0 && id_number<=9) {
		id <- toString(id_number)
		fname <- paste(directory, "/00", id, ".csv", sep="")
		}
		else if (id_number>9 && id_number<=99) {
		id <- toString(id_number)
		fname <- paste(directory, "/0", id, ".csv", sep="")
		}
		else {
		id <- toString(id_number)
		fname <- paste(directory, '/', id, ".csv", sep="")
		}

		data <- read.csv(fname)
		if (pollutant=="nitrate") {
			subset <- data$nitrate
		}
		else if (pollutant=="sulfate") {
			subset <- data$sulfate
		}
		use <- subset[!is.na(subset)]
		len <- len + length(use)
		cumsum <- cumsum + sum(use)
	}
	cumsum/len 
}