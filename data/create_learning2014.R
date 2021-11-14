#Heidi Hirvonen 11.11.2020 this file contains learning2014 data.
lrn14 <- read.table("https://www.mv.helsinki.fi/home/kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)
str(lrn14)
dim(lrn14)
#The data contains 183 variables and 60 observations
attach(lrn14)
lrn14$d_sm <- D03+D11+D19+D27
lrn14$d_ri <- D07+D14+D22+D30
lrn14$d_ue <- D06+D15+D23+D31

lrn14$deep <- (lrn14$d_sm +lrn14$d_ri +lrn14$d_ue) / 12

#Surf     Surface approach          ~su_lp+su_um+su_sb
#su_lp    Lack of Purpose           ~SU02+SU10+SU18+SU26
#su_um    Unrelated Memorising      ~SU05+SU13+SU21+SU29
#su_sb    Syllabus-boundness        ~SU08+SU16+SU24+SU32

#Stra     Strategic approach        ~st_os+st_tm
#st_os    Organized Studying        ~ST01+ST09+ST17+ST25
#st_tm    Time Management           ~ST04+ST12+ST20+ST28

#Attitude Global attitude toward statistics ~Da+Db+Dc+Dd+De+Df+Dg+Dh+Di+Dj

lrn14$surf <- (SU02+SU10+SU18+SU26+SU05+SU13+SU21+SU29+SU08+SU16+SU24+SU32)/12
lrn14$stra <- (ST01+ST09+ST17+ST25+ST04+ST12+ST20+ST28)/8

lrn14$Attitude <- (Da+Db+Dc+Dd+De+Df+Dg+Dh+Di+Dj)/10
detach(lrn14)

heidindata <- data.frame("sukupuoli"=lrn14$gender, lrn14$Age, lrn14$Attitude, lrn14$deep, lrn14$stra, lrn14$surf,  lrn14$Points)
heidindata <- subset(heidindata, lrn14.Points != 0)
setwd("/Users/heidihirvonen/Documents/OPISKELU 2020/MENETELMAOPINNOT/OpenDataScience/IODS-project")
write.csv(heidindata,"data/heidindata.csv" )
newdata <- read.csv("data/heidindata.csv")

