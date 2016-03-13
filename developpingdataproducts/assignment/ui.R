library(shiny)

# here we define the user interface for our application
shinyUI(
    navbarPage("Worldwide Firearm Trades Explorer",
               tabPanel("About",
                        mainPanel(
                           HTML('<img src="https://s-media-cache-ak0.pinimg.com/736x/eb/c7/08/ebc70881fe53959a188f597ed8f7e330.jpg">')
                        ),
                        mainPanel(
                            h1("Worldwide Firearm Trades Explorer"),
                            p("This application is based on the United Nations (UN) gathered data on the trade of goods of arms, ammunitions, parts, and accessories thereof."),
                            p("This dataset has been obtained from the ", 
                              a("United Nations Database website ", href="http://data.un.org/Default.aspx"), 
                              "and processed as part of a peer assessment project for the Coursera",
                              a("Developping Data Products course ", href="https://www.coursera.org/learn/data-products"),
                              "offered by Johns Hopkins Bloomberg School of Public Health"),
                            p('To explore the data via visualizations, please click the "Visualization" tab'),
                            h2("A few assumptions"),
                            p("In the exploration of this dataset I have chosen to include data with the following criteria: "),
                            HTML('<ul><li>Any country which contribute less than 1 million USD for any given year/flow was not included</li><li>Re-import and re-export were treated as import and export respectively</li><li>Only data pertaining to war, war munitions, projectiles, hunting gear and guns for sport/target shooting were included</li></ul>'),
                            h2("How to use this application"),
                            p("It is pretty simple, change the slider bar to whichever year you would like to see, and toggle between Export, Import, and the type of goods traded (war equipment or hunting equipment)")
                        )),
               tabPanel("Visualization",
                        sidebarPanel(
                            sliderInput("year",
                                        "Year:",
                                        min = 1988,
                                        max = 2014,
                                        value = 1988,
                                        format = "####"),
                            radioButtons("flow",
                                         "Flow of goods: ",
                                         c("Export" = "Export",
                                         "Import" = "Import")),
                            radioButtons("type",
                                         "Type of goods: ",
                                         c("War and War Munitions" = 1,
                                           "Hunting Equipment" = 0)),
                            radioButtons("qty",
                                         "Quantity type: ",
                                         c("Millions of USD" = "USD.millions",
                                           "Weight in Tonnes" = "Weight.tonnes",
                                           "Millions of Units" = "Quantity.millions"))
                        ),
                        mainPanel(
                            plotOutput("mapPlot")
                        )
)))