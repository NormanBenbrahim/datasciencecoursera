source("complete.R")
corr <- function(directory, threshold=0) {
	correlations <- 0
	compl <- complete(directory)
	
	nobs <- compl$nobs
	ids <- compl$id
	true <- nobs>threshold
	use <- ids[true]

	for (i in use) {
		if (i<10) {
			id <- toString(i)
			fname <- paste(directory, "/00", id, ".csv", sep="")
		}
		else if (i<100) {
			id <- toString(i)
			fname <- paste(directory, "/0", id, ".csv", sep="")
		}
		else {
			id <- toString(i)
			fname <- paste(directory, '/', id, ".csv", sep="")
		}

		data <- read.csv(fname)	
		all <- subset(data, !is.na(data$nitrate) & !is.na(data$sulfate))
		c <- cor(all$nitrate, all$sulfate)
		correlations <- append(correlations, c)
	}
	truth <- correlations[2:length(correlations)]
	truth
}