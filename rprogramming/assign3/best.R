# function for finding best hospital in a state given outcomes for mortality
source("load_outcomes.R")
best <- function(state, outcome) {
    # load the data
    outcome_data <- load_outcomes(state, outcome)
    
    # susbet based on state
    sub <- outcome_data[outcome_data$State==state, ]
    
    # find where the minimum values occur for each outcome
    mins <- sapply(sub, which.min)[3:5] 
    
    if (outcome=="heart attack") {
        index <- mins$`heart attack`
    }
    if (outcome=="heart failure") {
        index <- mins$`heart failure`
    }
    if (outcome=="pneumonia") {
        index <- mins$pneumonia
    }
    
    # if more than one, report the first alphabetically
    # else return the name
    if (length(index)>1) {
        to_sort <- sub[index, ]$name
        return(sort(to_sort)[1])
    } 
    else {
        return(sub[index, ]$name)
    }
}