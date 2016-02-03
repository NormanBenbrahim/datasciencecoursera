# Q.1
library(AppliedPredictiveModeling)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
trainIndex = createDataPartition(diagnosis, p = 0.50,list=FALSE)
training = adData[trainIndex,]
testing = adData[-trainIndex,]


# Q.2 There is a non-random pattern in the plot of the outcome versus index 
# that does not appear to be perfectly explained by any predictor suggesting a 
# variable may be missing.
library(AppliedPredictiveModeling)
library(Hmisc)
library(dplyr)
data(concrete)
library(caret)
set.seed(1000)
inTrain = createDataPartition(mixtures$CompressiveStrength, p = 3/4)[[1]]
training = mixtures[ inTrain,]
testing = mixtures[-inTrain,]

# feature plot
featurePlot(x = select(training, -CompressiveStrength),
            y = training$CompressiveStrength,
            plot = "pairs")

index <- 1:dim(training)[1]
qplot(index, CompressiveStrength, data = training, colour = cut2(Cement))

# Q.3 
hist(training$Superplasticizer, breaks = 50)
rug(training$Superplasticizer)


# Q.4
set.seed(3433); data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]training = adData[ inTrain,]
testing = adData[-inTrain,]

# subset
all_names <- names(training)
name_indices <- grep("^IL", all_names)
training_subset <- training[, name_indices]

# pca
preProcess(training_subset, method = "pca", thresh = 0.8)


# Q.5
library(caret)
library(AppliedPredictiveModeling)
set.seed(3433)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

# subset
all_names <- names(training)
name_indices <- grep("^IL", all_names)
training_subset <- training[, name_indices]

preprocessed <- preProcess(training_subset, method = "pca", thresh = 0.8)
trainPC <- predict(preprocessed, training_subset)
modelFitPC <- train(training$diagnosis ~., method = "glm", data = trainPC)

no_pca <- preProcess(training_subset)
train_reg <- predict(no_pca, training_subset)
modelFitnoPC <- train(training$diagnosis ~., method = "glm", data = train_reg)

modelFitnoPC
modelFitPC

