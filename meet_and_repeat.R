#Heidi Hirvonen
#6.12.2021.
#DATA WRANGLING WEEK 6

#1.  Reading the data sets (BPRS and RATS) into R. 
BPRS <- read.csv("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ",header = TRUE)
RATS <- read.csv("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt",sep  ="\t",header = TRUE)

#BPRS
str(BPRS)
View(BPRS)
summary(BPRS)
names(BPRS)

#RATS
str(RATS)
View(RATS)
summary(RATS)
names(RATS)

# WIDE DATA means that there are multiple measurements of the same subject, across time or using different tools, 
# the data is often described as being in "wide" format if there is one observation row per subject 
# with each measurement present as a different variable and "long" format if there 
# is one observation row per measurement (thus, multiple rows per subject). 

# 2. Converting the categorical variables of both data sets to factors. 

# Access the packages dplyr and tidyr
library(dplyr)
library(tidyr)

# Factor treatment & subject in BPRS data set
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)
# Factor ID & Group in RATS dataset
RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

# 3. Converting the data sets to long form. Adding a week variable to BPRS and a Time variable to RATS. 

# Convert to long form
#BPRS
BPRSlong <-BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)
RATSlong <- RATS %>% gather(key = WD, value = rats, -ID, -Group)

# Adding the "week" variable to BPRSlong dataset, by extracting the week number
BPRSlong <-  BPRSLlong %>% mutate(week = as.integer(substr(weeks,5,5)))

#Adding the "Time" variable to RATSlong dataset by extracting the number of the day from WD
RATSlong <-  RATSlong %>% mutate(Time = as.integer(substr(WD,3,4)))

#4. 
#Taking a look at the long data

str(BPRSlong)
View(BPRSlong)
summary(BPRSlong)
names(BPRSlong)

str(RATSlong)
View(RATSlong)
summary(RATSlong)
names(RATSlong)

#One of the fundamental differences between the wide-form and the long-form is that the wide-form
#displays many measurements from one individual in one row and the column names show what the measurements are.
# the amount of observations in the datasets has increased as every observation per individual per week is  its own row in the long format.

