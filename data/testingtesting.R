#Heidi Hirvonen 14.11.2021 testingtesting

lrn14<- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)
str(lrn14)
dim(lrn14)

#the dataset contains 183 observations and 60 variables

lrn14$deep <- c(lrn14$D03+lrn14$D11+lrn14$D19+lrn14$D27+lrn14$D07+lrn14$D14+lrn14$D22+lrn14$D30+lrn14$D06+lrn14$D15+lrn14$D23+lrn14$D31)/12
lrn14$surf <- (lrn14$SU02+lrn14$SU10+lrn14$SU18+lrn14$SU26+lrn14$SU05+lrn14$SU13+lrn14$SU21+lrn14$SU29+lrn14$SU08+lrn14$SU16+lrn14$SU24+lrn14$SU32)/12
lrn14$stra <- (lrn14$ST01+lrn14$ST09+lrn14$ST17+lrn14$ST25+lrn14$ST04+lrn14$ST12+lrn14$ST20+lrn14$ST28)/8
lrn14$Attitude <- (lrn14$Da+lrn14$Db+lrn14$Dc+lrn14$Dd+lrn14$De+lrn14$Df+lrn14$Dg+lrn14$Dh+lrn14$Di+lrn14$Dj)/10


# questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

heidindata2 <- data.frame("sukupuoli"=lrn14$gender, lrn14$Age, lrn14$Attitude, lrn14$deep, lrn14$stra, lrn14$surf,  lrn14$Points)
heidindata2 <- subset(heidindata, lrn14.Points != 0)
setwd("/Users/heidihirvonen/Documents/OPISKELU 2020/MENETELMAOPINNOT/OpenDataScience/IODS-project")
write.csv(heidindata,"data/heidindata.csv" )
newdata <- read.csv("data/heidindata.csv")
