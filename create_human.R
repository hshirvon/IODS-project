# Heidi Hirvonen
# 29.11.2021
# data source http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt
#metafiles for the original datasets:
# http://hdr.undp.org/en/content/human-development-index-hdi
# http://hdr.undp.org/sites/default/files/hdr2015_technical_notes.pdf

# Set the working directory of you R session the iods project folder
setwd("/Users/heidihirvonen/Documents/OPISKELU 2020/MENETELMAOPINNOT/OpenDataScience/IODS-project/data")

#1. Creating this new R script called create_human.R

#2.. Reading the “Human development” and “Gender inequality” datas into R. 
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F, na.strings = "..")
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")
#The Human Development Index (HDI) is a summary measure of average achievement in key dimensions of human development: a long and healthy life, being knowledgeable and have a decent standard of living. 
#The Gender inequality index (GII) measures the dimensions of health, empowerment and labour market participation for men and women.

# 3. Exploring the data
str(hd)
dim(hd)
summary(hd)

str(gii)
dim(gii)
summary(gii)

# 4. Having Look at the meta files and renaming the variables with (shorter) descriptive names.
colnames(hd)
colnames(hd)[1] <- "hdrank"
colnames(hd)[2] <- "country"
colnames(hd)[3] <- "hdi"
colnames(hd)[4] <- "lifeexpectancy"
colnames(hd)[5] <- "expectededucation"
colnames(hd)[6] <- "meaneducation"
colnames(hd)[7] <- "gni"
colnames(hd)[8] <- "gniminushdi"
colnames(hd)

colnames(gii)[1] <-"giirank"
colnames(gii)[2] <-"country"
colnames(gii)[3] <-"gii"
colnames(gii)[4] <-"maternalmortality"
colnames(gii)[5] <-"adolescentbirthrate"
colnames(gii)[6] <-"parliament"
colnames(gii)[7] <-"femaleeducation"
colnames(gii)[8] <-"maleeducation"
colnames(gii)[9] <- "femalelabour"
colnames(gii)[10] <- "malelabour"
colnames(gii)
 
# 5. Mutating the “Gender inequality” data and create two new variables. 
# first, the ratio of Female and Male populations with secondary education in each country. (i.e. edu2F / edu2M).

library(dplyr)
gii <- mutate(gii, femaletomaleeduc = femaleeducation / maleeducation)

# second, the ratio of labour force participation of females and males in each country (i.e. labF / labM).
gii <- mutate(gii, femaletomalelabour = femalelabour / malelabour)

colnames(gii)

# 6. Joining together the two datasets using the variable Country as the identifier and keeping only the countries in both data sets 
 
join_by <- "country"

# join the two datasets by the selected identifier country
human <- inner_join(hd, gii, by = join_by, suffix = c(".hd", ".gii"))

# see the new column names
colnames(human)

# glimpse at the data
glimpse(human)

# The joined data has 195 observations and 19 variables as expected

# Set the working directory of you R session the iods project folder
setwd("/Users/heidihirvonen/Documents/OPISKELU 2020/MENETELMAOPINNOT/OpenDataScience/IODS-project/data")

##Saving the analysis dataset to the ‘data’ folder
write.csv(human, file = "human.csv",row.names= FALSE)



# Data wrangling, week 5
#Heidi Hirvonen
#29.11.2021

#This we will be working with the "human" data.

#This is a data combined from two datasets including variables related to gender inequality and 
#human development by country. It includes variables such as life expectancy at birth and 
#labour force participation by gender as well as gender inequality and human development ranks by country.

human <- read.csv("data/human.csv", sep=",", header=TRUE)
str(human)
dim(human)

#Sometimes a variable is coded in a way that is not natural for R to understand. 
#For example,  large integers can sometimes be coded with a comma to separate thousands. 
#In these cases, R interprets the variable as a factor or a character. 
#This is the case with the Gross National Income (gni) variable, 
#so we need to transform it to numeric using string manipulation to get rid of the unwanted commas.
#I will mutate the "human" data which means that I will add this new Gross Nationa Income variable (newgni)  
#as a mutation of the existing ones. 

# access the stringr and dplyr packages
library(stringr)
library(dplyr); 

# look at the structure of the gni column in 'human'
str(human$gni)

# define a new column new gni by changing gni to numeric
gninew <- str_replace(human$gni, pattern=",", replace ="") %>% as.numeric
human <- mutate(human, gninew = gninew)
str(human)


#When a variable you wish to analyse contains missing values, there are usually two main options:
#Remove the observations with missing values
#Replace the missing values with actual values using an imputation technique.
#I will use the first option, which is the simplest solution. So next,I will exclude unneeded variables from the human data. 

#I will only keep the columns:
#"country" 
#"femaletomaleeduc" 
#"femaletomalelabour" 
#"expectededucation" 
#"lifeexpectancy" 
#"gni" 
#"maternalmortality" 
#"adolescentbirthrate"
#"parliament"

colnames(human)
# columns to keep
keep <- c("country", "femaletomaleeduc", "femaletomalelabour","lifeexpectancy", "expectededucation", "gni" , "maternalmortality" , "adolescentbirthrate",  "parliament")

# select the 'keep' columns
human <- select(human, one_of(keep))

str(human)
#The "human" data now only includes the 9 variables mentioned above and 195 observations.

#Then I will remove all rows with missing values and save to human_
#The human_ data includes 162 observations of the 9 variables

# print out a completeness indicator of the 'human' data
complete.cases(human)

# print out the data along with a completeness indicator as the last column
data.frame(human[-1], comp = complete.cases(human))

# filter out all rows with NA values
human_ <- filter(human, complete.cases(human))

str(human_)

human_

# Besides missing values, there might be other reasons to exclude observations. 
# I will remove the observations which relate to regions instead of countries. 

# look at the last 10 observations
tail(human_, 10)

# last indice we want to keep
last <- nrow(human_) - 7

# choose everything until the last 7 observations
human_ <- human_[1:155, ]

# 5. I will define the row names of the data by the country names and remove the country name column from the data. The data should now has 155 observations and 8 variables. I will ave the human data in my data folder including the row names. 

# add countries as rownames
rownames(human_) <- human_$country

# remove the Country variable
human_ <- select(human_, -country)

#the human_ data now has 8 variables and 155 observations
str(human_)
human_

write.csv(human_, file = "human.csv",row.names= TRUE)


