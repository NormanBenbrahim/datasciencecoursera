# Basic Preprocessing

Some features will contain predictors that are heavily influenced by certain points. It is generally a good idea to preprocess them in order to ensure that one predictor does not overshadow another. One way is to standardize all variables to have mean 0 and standard deviation 1.

# Standardizing the test set

When you train data which is standardized in the training set, you have to standardize the test set. Counter intuitive to what you might believe, you need to standardize using the mean and sd of the **training** set. You can also use the `preProcess` function to do this.

# Missing Data

You can impute missing data using what's called knnImpute in the preProcess function. This will basically interpolated data based on the k nearest neighbors. 


```r
preProcess(training, method = "knnImpute")
```

# Covariate Creation

Two levels of covariate creation. 

1. From raw data to covariate, i.e. paragraph to frequency of words
2. Transforming tidy covariates (squaring, taking sinusoids, etc)
