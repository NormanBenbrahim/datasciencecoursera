# filenames
c_file <- "Source_Classification_Code.rds"
p_file <- "summarySCC_PM25.rds"

# check files exist
if (!file.exists(c_file) | !file.exists(p_file)) {
print("Data files not present, downloading and unzipping...")
dataUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
tmp <- tempfile()
download.file(dataUrl, destfile = tmp)
unzip(tmp, exdir = "./")
unlink(tmp)
}

# load
print("Loading files...")
classif <- readRDS(c_file)
pm25 <- readRDS(p_file)

# cleanup
pm25$year <- as.Date(as.character(pm25$year), format = "%Y")
pm25$type <- as.factor(pm25$type)
print("Done")