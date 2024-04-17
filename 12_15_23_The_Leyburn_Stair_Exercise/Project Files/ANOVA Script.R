#12/12/23
#2 way ANOVA Test for effect of BP

library(tidyverse)
library(ggpubr)
library(rstatix)


#Try the whole thing:
data <- read.csv(file.choose())

attach(data)

MAP_results <- aov(MAP ~ Gender*LSE + Error(Subject.ID/(LSE)), data = data)
Systolic_results <- aov(Systolic ~ Gender*LSE, data = data)
Diastolic_results <- aov(Diastolic ~ Gender*LSE + Error(Subject.ID/(LSE)), data = data)

summary(MAP_results)

summary(Systolic_results)
summary(Diastolic_results)


#try one more time
data$Gender = as.factor(data$Gender)
data$LSE = as.factor(data$LSE)
attach(data)

model.aov <- aov(MAP ~ Gender * LSE + Error(Subject.ID / (Gender * LSE)))

summary(model.aov)



#Try with the other packages
data <- read.csv(file.choose())
attach(data)

res.aov <- anova_test(
  data = data, dv = MAP, wid = Subject.ID,
  within = LSE, between = Gender)

get_anova_table(res.aov)

res.aov_sys <- anova_test(
  data = data, dv = Systolic, wid = Subject.ID,
  within = LSE, between = Gender)
get_anova_table(res.aov_sys)

res.aov_dia <- anova_test(
  data = data, dv = Diastolic, wid = Subject.ID,
  within = LSE, between = Gender)
get_anova_table(res.aov_dia)


#another



