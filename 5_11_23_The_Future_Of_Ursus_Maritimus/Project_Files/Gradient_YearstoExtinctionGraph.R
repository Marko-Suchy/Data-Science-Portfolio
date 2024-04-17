setwd("P:/nguyenn23/Ecological Modelling/Final Project")
install.packages("popbio")
library(readxl)
library(ggplot2)

totalPop <- read_excel("MC_10000_.01.xlsx", 
                   sheet = "Sheet1", 
                   col_names = TRUE)
View(totalPop)

ggplot(totalPop, aes(x=totalPop$`Death rate`, y=totalPop$Virality, color=totalPop$`Years to extinction:`)) + geom_point()
p1 <- ggplot(totalPop, aes(x=totalPop$`Death rate`, y=totalPop$Virality, color=totalPop$`Years to extinction:`)) + geom_point()
p1+scale_color_gradient(low="red", high="blue")
