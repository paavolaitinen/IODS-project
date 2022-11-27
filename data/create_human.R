# Data wrangling, week 4


library(dplyr)
library(tidyverse)

hd <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv")
gii <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv", na = "..")

str(hd)
dim(hd)
# hd - 195 obs, 8 variables
str(gii)
dim(gii)
# gii - 195 obs, 10 variables

# summaries of the variables 
summary(hd)
summary(gii)

# rename the variables
colnames(hd) <- c("hdi_rank", "country", "hdi", "life_exp", "edu_exp", "mean_years_edu", "gni","gni_minus_hdi_rank" )
colnames(gii)
colnames(gii) <- c("gii_rank", "country", "gii", "mat_mor", "ado_birth", "parli_perc", "edu2_f", "edu2_m", "labo_f", "labo_m")
colnames(gii)

# ratio of female and male populations with secondary education 
gii <- mutate(gii, edu2_fm = (edu2_f / edu2_m))
# ratio of female and male populations of labor force participation 
gii <- mutate(gii, labofm = labo_f / labo_m)

#Join together the two datasets using the variable Country as the identifier. 
human <- inner_join(hd, gii, by = "country")
str(human)
# human - 195 obs, 19 variables

# save the dataset  
write_csv(human,"C:/Users/labpaavo/IODS-project/data/human.csv") 
