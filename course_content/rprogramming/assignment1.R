## data that accompanies is found in specdata/ in this dir,
## not pushed to github since it's too large. It is 332 csv
## files

# first make a function to account for the filenames
proper_name <- function(directory, id_number) {
	if (id_number>0 && id_number<=9) {
		id <- toString(id_number)
		paste(directory, "/00", id, ".csv", sep="")
	}
	else if (id_number>9 && id_number<=99) {
		id <- toString(id_number)
		paste(directory, "/0", id, ".csv", sep="")
	}
	else {
		id <- toString(id_number)
		paste(directory, '/', id, ".csv", sep="")
	}
}

pollutantmean <- function(directory, pollutant, id=1:332) {
	cumsum <- 0
	len <- 0 

	for (id_number in id) {
		fname <- proper_name(directory, id_number)
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