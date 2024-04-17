#Import package and set up WD

setwd("C:/Users/suchym24/Box/BIOL 325/Final Project")
install.packages("popbio")
install.packages("readxl")
library(popbio)
library(readxl)

PM <- as.matrix(read_excel("Excel.xlsx", 
                           sheet = "Projection Matrix", col_names = FALSE))
#Calculate lambda and r
lambda <- lambda(PM)
r <- log(lambda, base = exp(1))

SAD <- stable.stage(PM)
init <- 1526*SAD #Initilize with 500 polar bears
pop <- pop.projection(PM, init, 40)

plot(pop$pop.sizes)
stage.vector.plot(pop$stage.vectors, proportions = FALSE, legend.coords = "topright")

#Calculate sensitivity and elasticity
sensitivity<- sensitivity(PM, zero = TRUE)
elasticiy <- elasticity(PM)