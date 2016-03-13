library(shiny)
library(ggplot2)

# for displaying world maps
library(dplyr)
library(countrycode)
library(rworldmap)
library(RColorBrewer)
library(classInt)

# load the dataset
clean_data <- read.csv('./data/clean_data.csv')

# This will define the server logic required to draw a histogram
shinyServer(function(input, output) {
    
    # the world map
    output$mapPlot <- renderPlot({
        subset_data <- filter(clean_data, 
                              Flow==input$flow,
                              War==input$type,
                              Year==input$year)
        
        # the parameters for rworldmap
        sPDF <- joinCountryData2Map(subset_data,
                                    joinCode = "ISO3",
                                    nameJoinColumn = "Country")
        
        # pick a color palette and stuff
        colorPalette <- brewer.pal(9, 'RdPu')
        #classInt <- classIntervals( sPDF[["EPI"]], n = 5, style="jenks")
        #catMethod = classInt[["brks"]]
        
        # displaying the countries map
        par(mai=c(0,0,0.2,0),xaxs="i",yaxs="i")
        mapCountryData(sPDF, 
                       nameColumnToPlot = input$qty,
                       colourPalette = colorPalette)
    })
    
})