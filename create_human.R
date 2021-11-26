# 1. Reading the “Human development” and “Gender inequality” datas into R. 
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

#The Human Development Index (HDI) is a summary measure of average achievement in key dimensions of human development: a long and healthy life, being knowledgeable and have a decent standard of living. 
#The Gender inequality index (GII) measures the dimensions of health, empowerment and labour market participation for men and women.

str(hd)
dim(hd)
summary(hd)

str(gii)
dim(gii)
summary(gii)

hdrank <- hd$HDI.Rank    
hdcountry <- hd$Country
hd <- hd$Human.Development.Index..HDI. 
hdlife <- hd$Life.Expectancy.at.Birth 
hdexpeducation <- hd$Expected.Years.of.Education 
hdmeaneducation <- hd$Mean.Years.of.Education  
hdGNIpercapita <- hd$Gross.National.Income..GNI..per.Capita:

 