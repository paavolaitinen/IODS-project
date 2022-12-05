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

# mutate data, transform GNI to numeric
library(stringr)
numeric_gni <- str_replace(human$gni, pattern=",", replace ="") %>% as.numeric
human <- mutate(human, gni = numeric_gni)

colnames(human)
# Exclude unneeded variables: keep only the columns matching the following variable names:  
# "Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F"
keep <- c("country", "edu2_fm", "labofm", "edu_exp", "life_exp", "gni", "mat_mor", "ado_birth", "parli_perc")
human_new <- human[,keep]

# remove rows with missing values 
human_complete <- filter(human_new, complete.cases(human_new))

# Remove the observations which relate to regions instead of countries.
tail(human_complete, n = 10)
# 7 last observations are regions instead of countries
last <- nrow(human_complete) - 7
human_final <- human_complete[1:last, ]

# define row names by country, remove the column country 
countries <- human_final$country
human_final <- select(human_final, -country)
rownames(human_final) <- countries
# check that rownames are by countries 
print(row.names(human_final))

# results in 155 obs, 8 variables 
write_csv(human_final,"C:/Users/labpaavo/IODS-project/data/human.csv") 


