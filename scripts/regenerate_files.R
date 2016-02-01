#' This script regenerates the .pdf and .R files in the instructor
#' directory

#' function definitions

install <- function(package){
  if ( !( package %in% installed.packages() ) ) {
    install.packages(package, dependencies=TRUE)
  }
}

write_document <- function(document){
  knitr::knit(document, tangle = TRUE)
  rmarkdown::render(document, output_format='all')  
}

#' main call

if ( 'scripts' %in% strsplit(getwd(), '/') ) {
  setwd('../instructor')
} else {
  setwd('instructor')
}

for ( package in c('knitr', 'rmarkdown') ) {
  install(package)
  library(package, character.only=TRUE)
}

document_list = list.files(pattern='*.Rmd')
lapply(document_list, FUN=write_document)

