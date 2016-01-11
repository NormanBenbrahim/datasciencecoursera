# function to load the outcomes of care file
load_outcomes <- function() {
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
    return(outcome_data)
}