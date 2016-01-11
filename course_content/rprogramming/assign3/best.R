# function for finding best hospital in a state given outcomes for mortality
best <- function(state, outcome) {
    # read outcome data
    # we need State [2], 30-day heart attack mortality[11], 30-day heart failure
    # mortality [17], 30-day pneumonia mortality [23]
    f <- "rprog-data-ProgAssignment3-data/outcome-of-care-measures.csv"
    outcome_data <- read.csv(f, na="Not Available",
                        colClasses = c("NULL",
                                       "character",
                                       rep("NULL", 4),
                                       "character",
                                       rep("NULL", 3),
                                       NA,
                                       rep("NULL", 5),
                                       NA,
                                       rep("NULL", 5),
                                       NA,
                                       rep("NULL", 22)
                                       ))
    # rename the columns 
    names(outcome_data) <- c("name", "State", "heart attack", "heart failure", "pneumonia")
    outcome_name <- c("heart attack", "heart failure", "pneumonia")
    
    # check that state and outcomes are valid
    if (!state %in% outcome_data$State) {
        stop("invalid state")
    } else if (!outcome %in% outcome_name) {
        stop("invalid outcome")
    }
    
    # return hospital name in state with lowest 30-day death
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