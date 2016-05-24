## ---- echo=FALSE---------------------------------------------------------
knitr::opts_knit$set(root.dir = '../')

## ------------------------------------------------------------------------
load('data/feedback.Rda')
str(dat)

## ------------------------------------------------------------------------
summary(dat)
table(dat$department)

## ------------------------------------------------------------------------
library(psych)
describe(dat)

## ------------------------------------------------------------------------
library(dplyr)
dat %>% group_by(gender) %>% summarize(n())

## ------------------------------------------------------------------------
library(tidyr)
dat %>% filter(!is.na(gender)) %>% group_by(gender, department) %>% 
  summarize(n=n()) %>% spread(gender, n)

## ------------------------------------------------------------------------
install.packages('ggplot2')
library(ggplot2)

## ------------------------------------------------------------------------
dat$wday <- factor(weekdays(dat$timestamp, abbreviate = TRUE), 
                   levels = c('Mon','Tue','Wed','Thu','Fri','Sat','Sun')
                   )
summary(dat$wday)

## ------------------------------------------------------------------------
qplot(instructor.communicated, data = dat)
qplot(wday, course.delivered, data = dat)

## ------------------------------------------------------------------------
ggplot(data=dat, aes(x=wday)) + geom_bar()

## ------------------------------------------------------------------------
ggplot(data=dat, aes(x=course.delivered)) + 
  geom_histogram(binwidth=1)

## ------------------------------------------------------------------------
ggplot(data=dat, aes(x=course.delivered)) + 
  geom_histogram(binwidth=1, fill = 'gold', colour= 'blue')

## ------------------------------------------------------------------------
ggplot(data=dat, aes(x=gender,y=interest)) + geom_boxplot()

## ------------------------------------------------------------------------
ggplot(data=dat, aes(x=instructor.communicated, y=course.delivered)) + geom_point()

## ------------------------------------------------------------------------
ggplot(data=dat, aes(x=instructor.communicated, y=course.delivered)) + 
  geom_jitter()

## ------------------------------------------------------------------------
ggplot(data=dat, aes(x=instructor.communicated, y=course.delivered)) + 
  geom_jitter(aes(colour = wday))

## ------------------------------------------------------------------------
ggplot(data=dat, aes(x=wday, y=course.delivered)) + 
  geom_boxplot(colour = 'gold') + 
  geom_jitter(colour = 'blue')

## ------------------------------------------------------------------------
ggplot(data=dat, aes(x=instructor.communicated, y=course.delivered)) + 
  geom_jitter() + 
  stat_smooth(method = 'lm')

## ------------------------------------------------------------------------
ggplot(data=dat, aes(x=instructor.communicated, y=course.delivered, colour = wday)) + 
  geom_jitter() + 
  stat_smooth(method = 'lm', se = FALSE)

## ------------------------------------------------------------------------
ggplot(data=dat, aes(x=instructor.communicated, y=course.delivered)) + 
  geom_jitter() + 
  stat_smooth(method = 'lm', colour = 'black') + 
  xlab('How well the instructor communicated (1-7)') + 
  ylab('How well the course delivered advertised content (1-7)') + 
  ggtitle("I have no idea what I'm doing") 

## ------------------------------------------------------------------------
ggplot(data=dat, aes(x=instructor.communicated, y=course.delivered)) + 
  geom_jitter() + 
  stat_smooth(method = 'lm') +
  facet_grid(. ~ useful)

## ------------------------------------------------------------------------
t.test(dat$inside.barriers, dat$outside.barriers)

## ------------------------------------------------------------------------
t.test(dat$outside.barriers[dat$gender == "Male/Man"], dat$outside.barriers[dat$gender == "Female/Woman"])

## ------------------------------------------------------------------------
t.test(outside.barriers ~ gender, data = dat, subset = dat$gender %in% c("Male/Man", "Female/Woman"))

## ------------------------------------------------------------------------
aov(outside.barriers ~ gender, data = dat)

## ------------------------------------------------------------------------
model.1 <- aov(outside.barriers ~ gender, data = dat)
summary(model.1)

## ------------------------------------------------------------------------
TukeyHSD(model.1)

## ------------------------------------------------------------------------
cor.test(dat$outside.barriers, dat$inside.barriers)

## ------------------------------------------------------------------------
model.1 <- lm(inside.barriers ~ outside.barriers, data = dat)
summary(model.1)

## ------------------------------------------------------------------------
model.2 <- lm(inside.barriers ~ outside.barriers + department, data = dat)
summary(model.2)

## ------------------------------------------------------------------------
model.3 <- lm(inside.barriers ~ outside.barriers + department + outside.barriers*department, data = dat)
summary(model.3)

## ------------------------------------------------------------------------
model.1$coefficients
model.1$coefficients[[2]]

## ---- eval=FALSE---------------------------------------------------------
## dat$residuals <- model.1$residuals

## ------------------------------------------------------------------------
dat.listwise <- dat[!is.na(dat$inside.barriers) & !is.na(dat$outside.barriers), ]
dat.listwise$resid <- model.1$residuals

## ------------------------------------------------------------------------
ggplot(data = dat.listwise, aes(x=gender,y=resid)) + 
  geom_boxplot()

## ------------------------------------------------------------------------
wilcox.test(dat$outside.barriers, dat$inside.barriers, alternative = "two.sided", paired = FALSE, mu = 0, conf.level = 0.95)

## ------------------------------------------------------------------------
cor.test(dat$outside.barriers, dat$inside.barriers, method = 'spearman')

## ------------------------------------------------------------------------
chisq.test(dat$gender, dat$department)

## ------------------------------------------------------------------------
names(data)

