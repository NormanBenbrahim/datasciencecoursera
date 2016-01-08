########## Exploratory graphs ##########

# we will make use of the avgpm25 dataset which is the fine particle pollution
# data from the united states

# read the data
pollution <- read.csv('avgpm25.csv', colClasses=c('numeric', 'character',
											  	  'factor', 'numeric',
											  	  'numeric'))

# do any counties exceed the standard of 12 ug/m^3?
summary(pollution$pm25)

#   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#  3.383   8.549  10.050   9.836  11.360  18.440 

# the median is indeed below the standard, but some are way above it 
# as see nby the third quartile and the max

# make a boxplot to see distribution, overlayed with a horizontal line at 12
# remember 12 is the national standard
boxplot(pollution$pm25, col="blue")
abline(h=12)

# histogram is better of course, more detail on the distribution
# add a rug below so you see the points that make up the histogram
# you can also set the breaks (number of bins)
hist(pollution$pm25, col="green", breaks=40)
rug(pollution$pm25)

# can add vertical line at the median and at the standard, kinda cool
hist(pollution$pm25, col="green", breaks=40)
rug(pollution$pm25)
abline(v=12, lwd=2)
abline(v=median(pollution$pm25), col="magenta", lwd=4)

# bar plots can also be used for categorical data, here we plot the region variable
barplot(table(pollution$region), col="wheat", main= "Number of Counties in Each Region")

## often the most useful techniques are to take 2D plots and array them in order to look
## at the third dimensions avaialable

# here we look at how the pm25 varies by region (east and west) using two boxplots
boxplot(pm25 ~ region, data=pollution, col="red")

# multiple histograms can be used to do the above too
par(mfrow=c(2, 1), mar=c(4, 4, 2, 1)) # more on this later
hist(subset(pollution, region=="east")$pm25, col="green", breaks=40)
hist(subset(pollution, region=="west")$pm25, col="blue", breaks=40)

# the most obvious thing to do would be a scatter plot though
# we can use color to add a dimension! neat!
with(pollution, plot(latitude, pm25, col=region))
abline(h=12, lwd=2, lty=2)

# don't forget to always remark things about your data

######### Plotting systems ############
# The base plotting systems is what comes with base r
# It basically gives you a palette or canvas, to which you add shit
# you use annotations to add/modify things

# drawback: can't go back after you've plotted, need to re-do the plot
# use the cars dataset to demonstrate
library(datasets)
data(cars)
with(cars, plot(speed, dist))

# lattice plots are another type of plot, these are used to make a plot 
# in a single command, making it more reproducible
library(lattice)
state <- data.frame(state.x77, region = state.region)

# We'll plot average life expentancy in a state vs the average per capita 
# income in that state, conditioned by the region
xyplot(Life.Exp ~ Income | region, data=state, layout=c(4, 1))
# pretty plot

##### ggplot2 #########
# this library creates really sexy plots, splits the ideas between base and
# lattice systems, but sooo much more flexible
library(ggplot2)
data(mpg)
qplot(displ, hwy, data=mpg) # so nice







