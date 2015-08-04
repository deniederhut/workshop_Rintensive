# creating day_three dataset
library(stringr)

dat <- read.csv('../../feedback-analytics/feedback.csv', stringsAsFactors = FALSE)
dat[dat == ""] <- NA

# get rid of empty or identifying columns
dat <- subset(dat, select = -c(I.will.use.my.new.powers..., Instructor, Date.of.Training, Training.Title, 
                               What.department..school..program..or.organization.at.Berkeley.are.you.associated.with..1))
dat <- Filter(function(x) !all(is.na(x)), dat)

# simplify column names
new.names <- c("timestamp", "course.delivered", "instructor.communicated", "hear", 
               "interest", "department", "verbs", "useful", "gender", "ethnicity", 
               "outside.barriers", "inside.barriers", "what.barriers", "position")
names(dat) <- new.names

# fix timestamp
dat$timestamp <- sub(' [0-9]+:[0-9]+:[0-9]+', '', dat$timestamp)
dat$timestamp <- as.Date(dat$timestamp, "%m/%d/%Y")

# entity resolution on departments
dat$department <- str_trim(dat$department)
dat$department <- str_to_lower(dat$department)
dat$department <- sub('school of ', '', dat$department)
for (pattern in c('afric','aas')) {
  dat[grepl(pattern, dat$department), 'department'] <- "African American Studies"
}
for (pattern in c('are')) {
  dat[grepl(pattern, dat$department), 'department'] <- "Ag & Resource Econ & Pol"
}
for (pattern in c('anth')) {
  dat[grepl(pattern, dat$department), 'department'] <- "Anthropology"
}
for (pattern in c('applied','ast')) {
  dat[grepl(pattern, dat$department), 'department'] <- "App Sci & Tech Grad Grp"
}
for (pattern in c('bio[ ]*stat')) {
  dat[grepl(pattern, dat$department), 'department'] <- "Biostatistics Grad Grp"
}
for (pattern in c('haas', 'business')) {
  dat[grepl(pattern, dat$department), 'department'] <- "Business"
}
for (pattern in c('crp', 'region', 'planning')) {
  dat[grepl(pattern, dat$department), 'department'] <- "City & Regional Planning"
}
for (pattern in c('demo')) {
  dat[grepl(pattern, dat$department), 'department'] <- "Demography"
}
for (pattern in c('econ')) {
  dat[grepl(pattern, dat$department), 'department'] <- "Economics"
}
for (pattern in c('ed.', 'edu', 'gse', 'g.s.e.', 'pome')) {
  dat[grepl(pattern, dat$department), 'department'] <- "Education"
}
for (pattern in c('erg', 'energy')) {
  dat[grepl(pattern, dat$department), 'department'] <- "Energy & Resources Group"
}
for (pattern in c('espm', 'epsm')) {
  dat[grepl(pattern, dat$department), 'department'] <- "Env Sci, Policy, & Mgmt"
}
for (pattern in c('ethnic')) {
  dat[grepl(pattern, dat$department), 'department'] <- "Ethnic Studies Grad Grp"
}
for (pattern in c('geo')) {
  dat[grepl(pattern, dat$department), 'department'] <- "Geography"
}
for (pattern in c('hist')) {
  dat[grepl(pattern, dat$department), 'department'] <- "History"
}
for (pattern in c('ieor')) {
  dat[grepl(pattern, dat$department), 'department'] <- "Industrial Eng & Ops Rsch"
}
for (pattern in c('i school', 'info')) {
  dat[grepl(pattern, dat$department), 'department'] <- "Information"
}
for (pattern in c('ib', 'integrative')) {
  dat[grepl(pattern, dat$department), 'department'] <- "Integrative Biology"
}
for (pattern in c('jsp', 'jurisprudence')) {
  dat[grepl(pattern, dat$department), 'department'] <- "JSP Grad Pgm"
}
for (pattern in c('law$', 'law ')) {
  dat[grepl(pattern, dat$department), 'department'] <- "Law"
}
for (pattern in c('ling')) {
  dat[grepl(pattern, dat$department), 'department'] <- "Linguistics"
}
for (pattern in c('music')) {
  dat[grepl(pattern, dat$department), 'department'] <- "Music"
}
for (pattern in c('hwni', 'neuro', 'helen wills')) {
  dat[grepl(pattern, dat$department), 'department'] <- "Neuroscience"
}
for (pattern in c('pol.', 'poli ', 'politic')) {
  dat[grepl(pattern, dat$department), 'department'] <- "Political Science"
}
for (pattern in c('psych')) {
  dat[grepl(pattern, dat$department), 'department'] <- "Psychology"
}
for (pattern in c('health', 'ph')) {
  dat[grepl(pattern, dat$department), 'department'] <- "Public Health"
}
for (pattern in c('gspp', 'policy', 'goldman')) {
  dat[grepl(pattern, dat$department), 'department'] <- "Public Policy"
}
for (pattern in c('rhet')) {
  dat[grepl(pattern, dat$department), 'department'] <- "Rhetoric"
}
for (pattern in c('iseees', 'slavic')) {
  dat[grepl(pattern, dat$department), 'department'] <- "Slavic Languages & Lit"
}
for (pattern in c('asian')) {
  dat[grepl(pattern, dat$department), 'department'] <- "South and Southeast Asian Studies"
}
for (pattern in c('welfare')) {
  dat[grepl(pattern, dat$department), 'department'] <- "Social Welfare"
}
for (pattern in c('socio', 'soc$', 'soc ')) {
  dat[grepl(pattern, dat$department), 'department'] <- "Sociology"
}
department.levels <- grep('[A-Z]+',unique(dat$department), value=TRUE)
dat$department <- factor(dat$department, levels = department.levels)

# type other columns
dat$hear <- as.factor(dat$hear)
dat$gender <- as.factor(dat$gender)
dat$position <- as.factor(dat$position)

# output
write.csv(dat, 'data/feedback.csv')
