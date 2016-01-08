## looking at plotting systems in detail 

## If you forgot any details, see the base plotting demonstration video
## otherwise just play around with plots, that's the best way to learn

###### Base plotting system ##########
library(datasets)
hist(airquality$Ozone) # histogram
with(airquality, plot(Wind, Ozone)) # scatter

# a boxplot with details, splitting categorically
airquality <- transform(airquality, Month=factor(Month))
boxplot(Ozone ~ Month, airquality, xlab="Month", ylab="Ozone (ppb)")

# par is used to specify global graphics parameters
# e.g. par(mfrow=2, mfcol=3) means 2 plots per row, 3 plots per column

# base plot with annotation
with(airquality, plot(Wind, Ozone)) # basic scatter
title(main="Ozone and Wind in New York City") # title of plot

# if i wanted to color code a specific month (say, May), we do so like this:
# (also you can specify title by using the arg main=title)
with(airquality, plot(Wind, Ozone, main="Ozone and Wind in New York City"))
with(subset(airquality, Month==5), points(Wind, Ozone, col="blue"))

# make one blue, and the other red, and add a legend
# pch tells us which symbol to use, 1=circles
with(airquality, plot(Wind, Ozone, main="Ozone and Wind in New York City",
	 type="n")) # type="n" initializes the plot but doesn't draw it 
with(subset(airquality, Month==5), points(Wind, Ozone, col="blue"))
with(subset(airquality, Month!=5), points(Wind, Ozone, col="red"))
legend("topright", pch=1, col=c("blue", "red"), legend=c("May", "Other"))

# multiple plots
# use par and mfrow and/or mfcol
par(mfrow=c(1, 2))
with(airquality, {
	plot(Wind, Ozone, main="Ozone and Wind")
	plot(Solar.R, Ozone, main="Ozone and Solar Radiation")
	})



