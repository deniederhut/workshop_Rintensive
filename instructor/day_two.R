## ---- echo=FALSE---------------------------------------------------------
knitr::opts_knit$set(root.dir = '../')

## ---- eval=FALSE---------------------------------------------------------
## data(state)
## str(state.x77)

## ------------------------------------------------------------------------
state.division
length(state.division)
levels(state.division)

## ------------------------------------------------------------------------
state <- state.x77
rm(state.x77)
state <- as.data.frame(state)
head(state)

## ------------------------------------------------------------------------
my.data <- data.frame(n = c(1, 2, 3),
                      c=c('one', 'two', 'three'),
                      b=c(TRUE, TRUE, FALSE),
                      d=c(as.Date("2015-07-27"),
                          as.Date("2015-07-27")+7,
                          as.Date("2015-07-27")-7),
                      really.long.and.complicated.variable.name=999)

## ------------------------------------------------------------------------
str(my.data)

## ------------------------------------------------------------------------
read.table("data/mydata.csv", sep=',', header = TRUE)

## ------------------------------------------------------------------------
read.csv("data/mydata.csv")

## ------------------------------------------------------------------------
read.csv("data/mydata.csv", nrows=2)

## ------------------------------------------------------------------------
load("data/mydata.Rda")

## ---- eval=FALSE---------------------------------------------------------
## # WARNING! xlsx package install crashed current version of RStudio
## install.packages("xlsx")
## library(xlsx)
## read.xlsx("data/cpds_excel_new.xlsx")

## ---- eval=FALSE---------------------------------------------------------
## # examples of these?
## install.packages("foreign")
## library(foreign)
## read.dta("data/cpds_stata.dta")
## read.spss()
## read.octave()

## ------------------------------------------------------------------------
dirty <- read.csv('data/dirty.csv')
str(dirty)

## ------------------------------------------------------------------------
dirty <- read.csv('data/dirty.csv',stringsAsFactors = FALSE)
str(dirty)

## ------------------------------------------------------------------------
tail(dirty)
dirty <- dirty[1:5,-6]
dim(dirty)

## ------------------------------------------------------------------------
names(dirty)
names(dirty) <- c("time", "height", "dept", "enroll", "birth.order")

## ------------------------------------------------------------------------
dirty$enroll

## ------------------------------------------------------------------------
table(dirty$enroll)
dirty$enroll[dirty$enroll=="999"] <- NA
table(dirty$enroll, useNA = "ifany")

## ------------------------------------------------------------------------
class(dirty$height)
as.numeric(dirty$height)

## ------------------------------------------------------------------------
dirty$height[grep("’", dirty$height, perl=TRUE)] <- 5*30.48 + 9*2.54
dirty$height[2] <- 70*2.54
dirty$height[3] <- 2.1*100

## ------------------------------------------------------------------------
dirty$dept
dirty$dept <- tolower(dirty$dept)
dirty$dept <- gsub(' ', '', dirty$dept)  # what did we just do?
dirty$dept[4] <- "geology"
dirty[dirty == "999"] <- NA

## ------------------------------------------------------------------------
dirty$time <- as.Date(dirty$time,'%m/%d/%Y')
dirty$height <- as.numeric(dirty$height)
dirty$dept <- as.factor(dirty$dept)
dirty$enroll <- as.factor(dirty$enroll)
dirty$birth.order <- as.numeric(dirty$birth.order)
str(dirty)

## ------------------------------------------------------------------------
na.omit(dirty)

## ------------------------------------------------------------------------
nrow(dirty)
sum(is.na(dirty$height))
sum(is.na(dirty$birth.order))
length(lm(height ~ birth.order,data=dirty)$fitted.values)

## ------------------------------------------------------------------------
library(Amelia)

## ------------------------------------------------------------------------
large <- read.csv('data/large.csv')
summary(large)
nrow(na.omit(large))

## ------------------------------------------------------------------------
a <- amelia(large,m = 1)
print(a)

## ------------------------------------------------------------------------
large.imputed <- a[[1]][[1]]
summary(large.imputed)

## ------------------------------------------------------------------------
a <- amelia(large[990:1000,],m = 1)
print(a)

## ------------------------------------------------------------------------
1 == 2
1 != 1
1 >= 1

## ------------------------------------------------------------------------
1 >= c(0,1,2)

## ------------------------------------------------------------------------
c(1,2) >= c(1,2,3)
c(1,2) >= c(1,2,3,4)     # why no warning this time? R recycles!

## ------------------------------------------------------------------------
my.data$numeric == 2
my.data[my.data$numeric == 2,]

## ------------------------------------------------------------------------
my.data[my.data$b,]

## ------------------------------------------------------------------------
my.data[,'d']

## ------------------------------------------------------------------------
good.things <- c("three", "four", "five")
my.data[my.data$character %in% good.things, ]

## ------------------------------------------------------------------------
str(my.data[!(my.data$character %in% good.things), ])

## ------------------------------------------------------------------------
str(my.data$numeric)

## ---- eval=FALSE---------------------------------------------------------
## install.packages('tidyr')
## install.packages('stringr')
## install.packages('dplyr')

## ------------------------------------------------------------------------
library(tidyr)
library(stringr)
library(dplyr)

## ------------------------------------------------------------------------
abnormal <- data.frame(name = c('Alice','Bob','Eve'),
                       time1 = c(90,90,150),
                       time2 = c(100,95,100))

## ------------------------------------------------------------------------
normal <- gather(abnormal, "time", "score", time1, time2)
normal

## ------------------------------------------------------------------------
normal$id <- seq(1:nrow(normal))
normal$time <- str_replace(normal$time,'time','')
normal$time <- as.numeric(normal$time)

## ------------------------------------------------------------------------
normal[normal$time == 1,]
normal[normal$name == 'Alice',]

## ------------------------------------------------------------------------
t.test(score ~ time, data=normal)

## ------------------------------------------------------------------------
data.1 <- read.csv('data/merge_practice_1.csv')
data.2 <- read.csv('data/merge_practice_2.csv')
str(data.1)
str(data.2)

## ------------------------------------------------------------------------
merge(data.1, data.2, by = 'id')

## ------------------------------------------------------------------------
merge(data.1, data.2, by = 'id', all = TRUE)

## ------------------------------------------------------------------------
lookup <- read.csv('data/merge_practice_3.csv')
str(lookup)

## ------------------------------------------------------------------------
merge(data.1, lookup, by = "location")

## ------------------------------------------------------------------------
lookup[lookup$location == 'Reno', ]

## ------------------------------------------------------------------------
library(dplyr)

## ------------------------------------------------------------------------
normal
arrange(normal, score)

## ------------------------------------------------------------------------
summarise(normal, mean(score), sd(score))

## ------------------------------------------------------------------------
group_by(normal, time)
summarize(group_by(normal, time), mean(score))
mutate(group_by(normal, time), diff=score-mean(score))
ungroup(mutate(group_by(normal, time), diff=score-mean(score)))

## ------------------------------------------------------------------------
normal %>% group_by(time) %>% mutate(diff=score-mean(score)) %>% ungroup() -> super

## ------------------------------------------------------------------------
library(foreign)
pew <- as.data.frame(read.spss("data/pew.sav"))
religion <- pew[c("q16", "reltrad", "income")]
rm(pew)

## ------------------------------------------------------------------------
religion$reltrad <- as.character(religion$reltrad)
religion$reltrad <- str_replace(religion$reltrad, " Churches", "")
religion$reltrad <- str_replace(religion$reltrad, " Protestant", " Prot")
religion$reltrad[religion$q16 == " Atheist (do not believe in God) "] <- "Atheist"
religion$reltrad[religion$q16 == " Agnostic (not sure if there is a God) "] <- "Agnostic"
religion$reltrad <- str_trim(religion$reltrad)
religion$reltrad <- str_replace_all(religion$reltrad, " \\(.*?\\)", "")

religion$income <- c("Less than $10,000" = "<$10k",
  "10 to under $20,000" = "$10-20k",
  "20 to under $30,000" = "$20-30k",
  "30 to under $40,000" = "$30-40k",
  "40 to under $50,000" = "$40-50k",
  "50 to under $75,000" = "$50-75k",
  "75 to under $100,000" = "$75-100k",
  "100 to under $150,000" = "$100-150k",
  "$150,000 or more" = ">150k",
  "Don't know/Refused (VOL)" = "Don't know/refused")[religion$income]

religion$income <- factor(religion$income, levels = c("<$10k", "$10-20k", "$20-30k", "$30-40k", "$40-50k", "$50-75k",
  "$75-100k", "$100-150k", ">150k", "Don't know/refused"))

## ---- eval=FALSE---------------------------------------------------------
## religion <- count(religion, reltrad, income)
## names(religion)[1] <- "religion"

