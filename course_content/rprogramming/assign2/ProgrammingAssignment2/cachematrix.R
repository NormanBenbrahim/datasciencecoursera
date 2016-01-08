# Creates a special cached object if the inverse of a matrix exists,
# otherwise it solves it using 'solve' and caches it for later use

## Assuming our matrix is always square we can find the inverse of A using
## the built in solve(A) function in R
makeCacheMatrix <- function(x = matrix()) {
	m <- NULL # initialize inverse

	# set matrix value
	set <- function(y) {
		x <<- y 
		m <<- NULL
	}

	# get matrix value
	get <- function() x

	# set and get the inverse value respectively
	set_inverse <- function(inverse) m <<- inverse
	get_inverse <- function() m

	# list of all the functions above 
	list(set=set, 
		 get=get, 
		 set_inverse=set_inverse, 
		 get_inverse=get_inverse)
}

## I put the other condition in an 'else' clause because an 'if' without an
## 'else' seems unnatural to me
cacheSolve <- function(x, ...) {
        m <- x$get_inverse() # cached inverse
        
        if (!is.null(m)) {
        	message("Getting cached inverse data ")
        	return(m)
        }
        else { 
        	data <- x$get() # fetch data object from cache
        	m <- solve(x, ...) # solve it
        	x$set_inverse(m) # set new cache object inverse
        	return(m) # return it 
        	# ta-da
        }
}