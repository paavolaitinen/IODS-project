# Paavo Laitinen
# 10/11/2022
# data wrangling for learning2014 dataset

library(tidyverse)

lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)
# variables that are needed
# gender, age, attitude, deep, stra, surf and points 

# combine questions for deep, stra and surf 

# select the columns related to deep learning 
deep_columns <- select(lrn14, one_of(deep_questions))
# and create column 'deep' by averaging
lrn14$deep <- rowMeans(deep_columns)

# select the columns related to surface learning 
surface_columns <- select(lrn14, one_of(surface_questions))
# and create column 'surf' by averaging
lrn14$surf <- rowMeans(surface_columns)

# select the columns related to strategic learning 
strategic_columns <- select(lrn14, one_of(strategic_questions))
# and create column 'stra' by averaging
lrn14$stra <- rowMeans(strategic_columns)


keep_columns <- c("gender","Age","Attitude", "deep", "stra", "surf", "Points")

# select the 'keep_columns' to create a new dataset
learning2014 <- select(lrn14, one_of(keep_columns)) 

# change the name of columns
colnames(learning2014)[2] <- "age"
colnames(learning2014)[3] <- "attitude"
colnames(learning2014)[7] <- "points"

learning2014 <- filter(learning2014, points > 0)

str(learning2014)

#write_csv(learning2014,"C:/Users/labpaavo/IODS-project/learning2014.csv") 
#str(read_csv("C:/Users/labpaavo/IODS-project/learning2014.csv"))