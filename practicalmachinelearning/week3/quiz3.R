# Q.1
library(AppliedPredictiveModeling)
data(segmentationOriginal)
library(caret)
library(rattle)

seg <- segmentationOriginal

training <- seg[seg$Case=="Train", ]
testing <- seg[seg$Case=="Test", ]

set.seed(125)

modfit <- train(Class ~ ., method="rpart", data = training)

fancyRpartPlot(modfit$finalModel)

# Q.2 The bias is larger and the variance is smaller. Under leave one out cross 
# validation K is equal to the sample size.

# Q.3 
library(pgmm)
data(olive)
olive = olive[,-1]

modfit2 <- train(Area ~ ., data = olive, method="rpart2")
newdata = as.data.frame(t(colMeans(olive)))
predict(modfit2, newdata)

# Q.4 
library(ElemStatLearn)
data(SAheart)
set.seed(8484)
train = sample(1:dim(SAheart)[1],size=dim(SAheart)[1]/2,replace=F)
trainSA = SAheart[train,]
testSA = SAheart[-train,]
set.seed(13234)

modfit3 <- train(chd ~ age + alcohol + obesity + tobacco + typea + ldl, 
                 method = "glm", data = trainSA, family = "binomial")

missClass = function(values,prediction){ 
    sum(((prediction > 0.5)*1) != values)/length(values)
}

predictTrain <- predict(modfit3, trainSA)
predictTest <- predict(modfit3, testSA)

missClass(testSA$chd, predictTest)
missClass(trainSA$chd, predictTrain) 

# Q.5
library(ElemStatLearn)
data(vowel.train)
data(vowel.test)

vowel.train$y <- as.factor(vowel.train$y)
vowel.test$y <- as.factor(vowel.test$y)
set.seed(33833)
modelRf <- randomForest(y ~ ., data = vowel.train, importance = FALSE)
order(varImp(modelRf), decreasing=T)