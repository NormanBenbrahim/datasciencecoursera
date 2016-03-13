### This script resizes the data frame from 50000 x 9 to two smaller data frames
### of about 1400 x 4 by feature engineering



# data downloaded from 
# http://data.un.org/Data.aspx?q=ammunition&d=ComTrade&f=_l1Code%3a93
library(dplyr)
library(countrycode)
library(rworldmap)

datafile <- "./data/UNdata.csv"
dframe <- read.csv(datafile)

# cleanup the data 

# hunting gear and humane killers and stuff are irrelevant for our purposes as 
# we want to show things on a world map relating to the "war status" and 
# "hunt statust" of a country

war_commodities <- c("Munitions of war, ammunition/projectiles and parts",
                     "Military weapons, other than hand guns, swords, etc")

hunt_commodities <- c("Rifles, sporting, hunting or target-shooting, nes",
                      "Shotguns, shotgun-rifles for sport, hunting or target")

dframe_war <- filter(dframe, Commodity %in% war_commodities)
dframe_hunt <- filter(dframe, Commodity %in% hunt_commodities)

# convert country name to iso3 country code for ease of use in 
dframe_war$Country.or.Area <- as.factor(countrycode(dframe_war$Country.or.Area, 
                                          "country.name", 
                                          "iso3c"))

dframe_hunt$Country.or.Area <- as.factor(countrycode(dframe_hunt$Country.or.Area,
                                                     "country.name",
                                                     "iso3c"))

# remove useless columns
dframe_hunt <- select(dframe_hunt, -Comm..Code, -Commodity, -Quantity.Name)
dframe_war <- select(dframe_war, -Comm..Code, -Commodity, -Quantity.Name)

# rename the columns 
names(dframe_hunt) <- c("Country", "Year", "Flow", "USD", "Weight.kg", "Qty")
names(dframe_war) <- c("Country", "Year", "Flow", "USD", "Weight.kg", "Qty")

# treat re-export as export and re-import as import 
dframe_hunt[dframe_hunt$Flow=="Re-Export", ]$Flow <- "Export"
dframe_hunt[dframe_hunt$Flow=="Re-Import", ]$Flow <- "Import"

dframe_war[dframe_war$Flow=="Re-Export", ]$Flow <- "Export"
dframe_war[dframe_war$Flow=="Re-Import", ]$Flow <- "Import"

# final aggregation by flow, country and year
war_data <- aggregate(. ~ Country + Year + Flow, 
                      dframe_war, FUN = sum, na.rm = TRUE)
hunt_data <- aggregate(. ~ Country + Year + Flow, 
                       dframe_hunt, FUN = sum, na.rm = TRUE)

# remove those countries which contribute less than 1 million dollars to 
# import/export
war_data <- filter(war_data, USD>=1e06)
hunt_data <- filter(hunt_data, USD>=1e06)

# scale USD to be in units of millions, and scale kg to tonnes as well as 
# quantity to quantity in millions of units
war_data <- mutate(war_data, USD.millions = USD/1e06)
war_data <- mutate(war_data, Weight.tonnes = Weight.kg/1000)
war_data <- mutate(war_data, Quantity.millions = Qty/1e06)
hunt_data <- mutate(hunt_data, USD.millions = USD/1e06)
hunt_data<- mutate(hunt_data, Weight.tonnes = Weight.kg/1000)
hunt_data <- mutate(hunt_data, Quantity.millions = Qty/1e06)

# remove the non scaled versions of the data
war_data <- select(war_data, -(USD:Qty))
hunt_data <- select(hunt_data, -(USD:Qty))

# give them one last column to identify as war or not
war_data$War <- 1
hunt_data$War <- 0 

data_final <- rbind(war_data, hunt_data)
# stack the data frames

# save newly created data frames
write.csv(data_final, file="./data/clean_data.csv")
