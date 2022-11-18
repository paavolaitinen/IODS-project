# Paavo Laitinen
# 15/11/2022

# IODS course, data wrangling for assignment 3

# Student performance data in two Portuguese schools, collected by reports and questionnaires. 
# https://archive.ics.uci.edu/ml/datasets/Student+Performance

library(dplyr)
library(tidyverse)

student_mat <- read.csv("C:/Users/labpaavo/IODS-project/data/student-mat.csv", sep = ";")
str(student_mat)

student_por <- read.csv("C:/Users/labpaavo/IODS-project/data/student-por.csv", sep = ";")
str(student_por)


#Join the two data sets using all other variables than "failures", "paid", "absences", "G1", "G2", "G3" as (student) identifiers. 
free_cols <- c("failures", "paid", "absences", "G1", "G2", "G3")
join_cols <- setdiff(colnames(student_por), free_cols)
math_por <- inner_join(student_mat, student_por, by = join_cols, suffix = c(".math", ".por"))
str(math_por)

#Get rid of the duplicate records in the joined data set. 
# create a new data frame with only the joined columns
alc <- select(math_por, all_of(join_cols))

# for every column name not used for joining...
for(col_name in free_cols) {
  # select two columns from 'math_por' with the same original name
  two_cols <- select(math_por, starts_with(col_name))
  # select the first column vector of those two columns
  first_col <- select(two_cols, 1)[[1]]
  
  # then, enter the if-else structure!
  # if that first column vector is numeric...
  if(is.numeric(first_col)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[col_name] <- round(rowMeans(two_cols))
  } else { # else (if the first column vector was not numeric)...
    # add the first column vector to the alc data frame
    alc[col_name] <- first_col
  }
}

str(alc)

# a new column alc_use by combining weekday and weekend alcohol use
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

# a new logical column 'high_use', TRUE if alc_use > 2
alc <- mutate(alc, high_use = (alc_use > 2))


#Glimpse at the joined and modified data to make sure everything is in order. The joined data should now have 370 observations. 
#Save the joined and modified data set to the ‘data’ folder, using for example write_csv() function (readr package, part of tidyverse)
glimpse(alc)

# write to csv 
#write_csv(alc,"C:/Users/labpaavo/IODS-project/data/alc.csv") 

