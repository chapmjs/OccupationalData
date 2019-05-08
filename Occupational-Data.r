# OccupationalData.r
# 20190508_1145
# import data into R


library(readxl)

occ_data <- read_excel("~/R/OccupationalData/Occupational-Data.xlsx")
view(occ_data)
head(occ_data)

library(dplyr)
occ_data_growRep <- occ_data %>% filter (OCC_Type == "Line item") %>% arrange(desc(`Grow/Replace`))
head(occ_data_growRep)

occ_data_perInc <- occ_data %>% filter (OCC_Type == "Line item") %>% arrange(desc(`% Incr`))
head(occ_data_perInc)

names.col <- c("occupation","occ_code","occ_type","2014employment","2024employment",