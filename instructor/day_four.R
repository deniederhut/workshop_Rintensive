## ---- echo=FALSE---------------------------------------------------------
knitr::opts_knit$set(root.dir = '../')

## ------------------------------------------------------------------------
## I want to create a matrix of 2 to the power of n where n is 1 to 10.

mat <- c(rep(NA, 10))   # first create a null vector

# There are many ways to do the same task
mat <- c(rep(NA, 6))
for(i in 1:6){   # I want to create a matrix of 2 to the power of n where n is 5 to 10.
  mat[i] <- 2^(i+4)
}                # or

mat <- c(rep(NA, 6))
for(i in 5:10){   
  mat[i-4] <- 2^i
}                # by setting sequence and statement accordingly

## ------------------------------------------------------------------------
a <- c("Berkeley", "SF", "Oakland")
b <- c(20, 18, 22)
city.temp <- data.frame(cbind(a, b))

for(city in c("Berkeley", "Walnut Creek", "Richmond")){
  if(sum(city==city.temp$a)>0){
    print(city.temp[which(city==city.temp$a),])   
    # if we have the city in our data, then print it's temperature and the name of the city
  }
  if(sum(city==city.temp$a)==0){
    print(paste(city, "is NOT in the data. :(", sep=" "))          
    # if not, then just print the name of the city next to "is Not in the data. :("
  }
}   # Loops can be as complicated and long as they could be. Often not so efficient.

## ---- eval=FALSE---------------------------------------------------------
## system.time(
##   for(i in 1:1000){
##   print(i)
##   })
## 
## system.time(
##   for(i in 1:1000){
##     print(i)
##   if(i == 50) break
##   })

## ------------------------------------------------------------------------
x <- 7
if(x > 10){
  print(x)
  
  }else{                     # "else" should not start its own line. 
                             # Always let it be preceded by a closing brace on the same line.
  print("NOT BIG ENOUGH!!")
}

## ------------------------------------------------------------------------
# ifelse(test, yes, no)
gender <- sample(c("male", "female"), 100, replace=TRUE)
gender
gender <- ifelse(gender=="male", 1, 0)
gender

## ---- eval=FALSE---------------------------------------------------------
## # if there are multiple statements, then use ; to separate each statement
## x <- 0
## while(x < 5) {print(x <- x+1)}
## x <- 1
## while(x < 5) {x <- x+1; if (x == 3) break; print(x)}  # break the loop when x=3

## ------------------------------------------------------------------------
f <- function(x) x + 1
class(f)

## ------------------------------------------------------------------------
formals(f)
body(f)
environment(f)

## ------------------------------------------------------------------------
f <- function(x) x + y
y <- 1
f(x = 1)

## ------------------------------------------------------------------------
y <- 9001
f <- function(x) {
  y <- 1
  g <- function (x) {
    x + y
  }
  g(x)
}
f(1)

## ------------------------------------------------------------------------
h <- function(){
  if (!exists('a')) {
    a <- 1
  }
  else {
    a <- 9000
  }
  print(a)
}
h()
h()

## ------------------------------------------------------------------------
in_to_cm <- function(x) x * 2.5
in_to_cm(69)

## ------------------------------------------------------------------------
in_to_m <- function(x){
  in_to_cm(x) / 100
}
in_to_m(69)

## ------------------------------------------------------------------------
in_to_cm <- function(x) x * 2.54
in_to_m(69)

## ------------------------------------------------------------------------
69 == c(69)

## ------------------------------------------------------------------------
heights <- c(69,54,73,82)
in_to_m(heights)

## ---- eval=FALSE---------------------------------------------------------
## heights <- list(69,54,73,82)
## in_to_m(heights)

## ------------------------------------------------------------------------
in_to_m(heights[[1]])
in_to_m(heights[[2]])
in_to_m(heights[[3]])

## ------------------------------------------------------------------------
lapply(heights, in_to_m)

## ------------------------------------------------------------------------
lapply(heights, FUN = function(x) x %/% 12)

## ------------------------------------------------------------------------
dat <- read.csv('data/large.csv')
str(dat)
lapply(dat, mean)

## ---- eval=FALSE---------------------------------------------------------
## lapply(dat, mean(na.rm = TRUE))

## ---- eval=FALSE---------------------------------------------------------
## Map(mean, dat, na.rm=TRUE)

## ------------------------------------------------------------------------
install.packages('parallelMap')
library(parallelMap)
system.time(Map(median, dat, na.rm=TRUE))
system.time(parallelMap(median, dat, na.rm=TRUE))

## ---- eval=FALSE---------------------------------------------------------
## install.packages('devtools')

## ------------------------------------------------------------------------
library(devtools)
# has_devel() # this is currently returning a clang compiler error

## ---- eval=FALSE---------------------------------------------------------
## devtools::create("convertR")

## ---- eval=FALSE---------------------------------------------------------
## install.packages('roxygen2')

## ------------------------------------------------------------------------
library(roxygen2)

## ---- eval=FALSE---------------------------------------------------------
## devtools::document('convertR')

## ---- eval=FALSE---------------------------------------------------------
## devtools::document('convertR')

## ---- eval=FALSE---------------------------------------------------------
## devtools::use_build_ignore("Rproj", pkg = "convertR")

## ---- eval=FALSE---------------------------------------------------------
## devtools::check("convertR")

## ---- eval=FALSE---------------------------------------------------------
## devtools::build('convertR')

## ------------------------------------------------------------------------
RJ <- readLines("http://shakespeare.mit.edu/romeo_juliet/full.html")  

## ------------------------------------------------------------------------
RJ[grep("<title>", RJ, perl=TRUE)]
RJ[grep("<H3>", RJ, perl=TRUE)]
RJ[grep("<h3>", RJ, perl=TRUE)]

## ------------------------------------------------------------------------
x <- list(NA)
y <- grep("<H3>", RJ, perl=TRUE)
for(i in 1:length(y)){
  if(i < length(y)){
  x[[i]]  <- RJ[c(y[i]:(y[i+1]-1))]
  }
  if(i == length(y)){
    x[[i]]  <- RJ[c(y[i]:length(RJ))]
  }
}

## ------------------------------------------------------------------------
countR <- function(z){
  return(c(length(grep("Romeo", z, perl=T)), length(grep("Juliet", z, perl=T)))) 
}
lapply(x, countR)

## ------------------------------------------------------------------------
# now count the lines in each scene
countL <- function(z){
  return(length(grep("</A><br>$", z, perl=T))) 
}
lapply(x, countL)

