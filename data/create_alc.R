#Heidi Hirvonen 15.11.2021, - RStudio exercise #3 for the IODS course

#Data source: https://archive.ics.uci.edu/ml/datasets/Student+Performance 
#Reading both student-mat.csv and student-por.csv into R 
studentmat <- read.table("/Users/heidihirvonen/Documents/OPISKELU 2020/MENETELMAOPINNOT/OpenDataScience/IODS-project/data/student-mat.csv", sep=";",header=TRUE)
studentpor <- read.table("/Users/heidihirvonen/Documents/OPISKELU 2020/MENETELMAOPINNOT/OpenDataScience/IODS-project/data/student-por.csv", sep=";",header=TRUE)
#Exploring the structure and dimensions of the data
str(studentmat)
dim(studentmat)
str(studentpor)
dim(studentpor)
#studentmat includes 395 observations and 33 variables
#studentpor includes 649 observations and 33 variables
# Define own id for both datasets
library(dplyr)
por_id <- studentpor %>% mutate(id=1000+row_number()) 
math_id <- studentmat %>% mutate(id=2000+row_number())

# Which columns vary in datasets
free_cols <- c("id","failures","paid","absences","G1","G2","G3")

# The rest of the columns are common identifiers used for joining the datasets
join_cols <- setdiff(colnames(por_id),free_cols)

pormath_free <- por_id %>% bind_rows(math_id) %>% select(one_of(free_cols))

# Combine datasets to one long data
#   NOTE! There are NO 382 but 370 students that belong to both datasets
#         Original joining/merging example is erroneous!
pormath <- por_id %>% 
  bind_rows(math_id) %>%
  # Aggregate data (more joining variables than in the example)  
  group_by(.dots=join_cols) %>%
  
  # Calculating required variables from two obs  
  summarise(                                                           
    n=n(),
    id.p=min(id),
    id.m=max(id),
    failures=round(mean(failures)),     #  Rounded mean for numerical
    paid=first(paid),                   #    and first for chars
    absences=round(mean(absences)),
    G1=round(mean(G1)),
    G2=round(mean(G2)),
    G3=round(mean(G3))    
  ) %>%
  # Remove lines that do not have exactly one obs from both datasets
  #   There must be exactly 2 observations found in order to joining be succesful
  #   In addition, 2 obs to be joined must be 1 from por and 1 from math
  #     (id:s differ more than max within one dataset (649 here))
  filter(n==2, id.m-id.p>650) %>%  
  # Join original free fields, because rounded means or first values may not be relevant
inner_join(pormath_free,by=c("id.p"="id"),suffix=c("",".p")) %>%
inner_join(pormath_free,by=c("id.m"="id"),suffix=c("",".m")) %>%

#Exploring the structure and dimensions of the joined data.
str()
dim()
