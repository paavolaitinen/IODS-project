library(dplyr)
library(tidyverse)

# reading the datasets
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep =" ", header = T)
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE, sep = '\t')

# BPRS
# checking data 
colnames(BPRS)
dim(BPRS)
str(BPRS)
glimpse(BPRS)
summary(BPRS)
# BPRS has 40 observations and 11 variables, treatment group and subject ID are still int

# convert 'treatment' and 'subject' to factor
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

# convert data to long form 
BPRSL <-  pivot_longer(BPRS, cols=-c(treatment,subject),names_to = "weeks",values_to = "bprs") %>% arrange(weeks)
# add 'week' variable
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(weeks,5,5)))
glimpse(BPRSL)


# RATS
# checking data 
colnames(RATS)
dim(RATS)
str(RATS)
glimpse(RATS)
summary(RATS)
# RATS has 16 observations and 13 variables, ID and group are still int

# convert 'ID' and 'group' to factor
RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

# convert data to long form and add 'Time' variable
RATSL <- pivot_longer(RATS, cols = -c(ID, Group),names_to = "WD",values_to = "Weight") %>% 
  mutate(Time = as.integer(substr(WD, 3,4))) %>% arrange(Time)
glimpse(RATSL)


# write the long form data as csv
write_csv(BPRSL,"C:/Users/labpaavo/IODS-project/data/BPRSL.csv") 
write_csv(RATSL,"C:/Users/labpaavo/IODS-project/data/RATSL.csv") 