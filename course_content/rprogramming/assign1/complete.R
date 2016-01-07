complete <- function(directory, id=1:332) {
	df <- data.frame(id=id)
	n_obs <- 0 
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
		# complete cases means both values are not na 
		complete <- subset(data, !is.na(data$nitrate) & !is.na(data$sulfate))
		n <- dim(complete)[1]
		n_obs <- append(n_obs, n)
	}
	df["nobs"] <- n_obs[2:length(n_obs)]
	df 
}