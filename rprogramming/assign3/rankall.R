rankall <- function(outcome, num = "best") {
    #read in the desired data
    data <- read.csv("rprog-data-ProgAssignment3-data/outcome-of-care-measures.csv", colClasses = "character")
    
    #create a list of states and initialize a character array to hold the
    #required hospital names
    state <- levels(factor(data[, 7]))
    hospital <- vector(mode="character") 
    
    for (i in seq(state)) {
        hospital[i] <- rankhospital(state[i], outcome, num)
    }
    data.frame(hospital, state)
}