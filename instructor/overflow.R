## ---- echo=FALSE---------------------------------------------------------
knitr::opts_knit$set(root.dir = '../')

## ------------------------------------------------------------------------
#install.packages('RCurl')
library(RCurl)
#install.packages("XML")
library(XML)

## ------------------------------------------------------------------------
RJ <- readLines("http://shakespeare.mit.edu/romeo_juliet/full.html")  
RJ[1:25]

## ------------------------------------------------------------------------
RJ[grep("<h3>", RJ, perl=T)]
RJ[grep("<h3>", RJ, perl=TRUE)]

## ---- eval=FALSE---------------------------------------------------------
## link <- "http://rss.nytimes.com/services/xml/rss/nyt/HomePage.xml"
## page <- getURL(url = link)
## xmlParse(file = page)

## ------------------------------------------------------------------------
link<-"http://clerk.house.gov/evs/2014/ROLL_000.asp"
readHTMLTable(doc=link, header=T, which=1, stringsAsFactors=F)[1:10, ]

## ---- eval=FALSE---------------------------------------------------------
## #are there websites that allow you to connect to test servers?
## install.packages("RMySQL")
## library(RMySQL)
## con <- dbConnect(MySQL(),
##          user="", password="",
##          dbname="", host="localhost")
## data <- fetch(dbSendQuery(con, "select * from table"), n=10)
## con.exit(dbDisconnect(con))

## ---- eval=FALSE---------------------------------------------------------
## install.packages("RPostgreSQL")
## library(RPostgreSQL)
## con <- dbConnect(dbDriver("PostgreSQL"),
##                  dbname="",
##                  host="localhost",
##                  port=1234,
##                  user="",
##                  password="")
## data <- dbReadTable(con, c("column1","column2"))
## dbDisconnect(con)

## ---- eval=FALSE---------------------------------------------------------
## install.packages("rmongodb")
## library(rmongodb)
## con <- mongo.create(host = localhost,
##                       name = "",
##                       username = "",
##                       password = "",
##                       db = "admin")
## if(mongo.is.connected(con) == TRUE) {
##   data <- mongo.find.all(con, "collection", list("city" = list( "$exists" = "true")))
## }
## mongo.destroy(con)

## ---- eval=FALSE---------------------------------------------------------
## # plyr package
## mydata <- read.csv("http://www.ats.ucla.edu/stat/data/binary.csv")
## # Consider the case where we want to calculate descriptive statistics across admits and not-admits
## # from the dataset and return them as a data.frame
## ddata <- ddply(mydata, c("admit"), summarize,
##                 gpa.over3 = length(gpa[gpa>=3]),
##                 gpa.over3.5 = length(gpa[gpa>=3.5]),
##                 gpa.over3per = length(gpa[gpa>=3])/length(gpa),
##                 gpa.over3.5per = length(gpa[gpa>=3.5])/length(gpa))
## )

## ---- eval=FALSE---------------------------------------------------------
## 
## mydata <- ddply(mydata, c("admit"), transform,
##                 gre.ave=mean(x=gre, na.rm=T),
##                 gre.sd = sd(x=gre, na.rm=T))
## head(mydata)
## unique(mydata$gre.ave)
## )

## ---- eval=FALSE---------------------------------------------------------
## # Another very useful function is arrange, which orders a data frame on the basis of column contents
## # arrange by "rank"
## mydata.rank <- plyr::arrange(mydata, rank)
## # arrange by "rank", descending
## mydata.rank <- plyr::arrange(mydata, desc(rank))
## # arrange by "rank", then "gre", then "gpa
## mydata.comb <- plyr::arrange(mydata, rank, desc(gre), desc(gpa))
## head(mydata.comb)

