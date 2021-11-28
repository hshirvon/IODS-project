# 1. Creating this new R script called create_human.R

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
write.csv(human, file = "human.csv")




