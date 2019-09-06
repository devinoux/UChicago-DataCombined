

install.packages("tidyverse")
library(dplyr)

ghanaSample  = read.table("ghanaChr1MAF005.gen.samples", sep = " ", header = TRUE, stringsAsFactors = FALSE)
ghana = read.csv("GBHS Manifest PRS Analyses.csv")
cutGhana = ghana[-c(1:6),]
cutGhana = cutGhana[,c(-16,-17,-18)]
colnames(cutGhana) = c("PID", "SB_ID", "Status", "Age", "ER(1+2-)", "EV1", "EV2", "EV3", "EV4", "EV5", "EV6",  "EV7",  "EV8",  "EV9", "EV10")


#write.table(cutGhana, file = "ghanaUnfinishedPheno.sample", quote = FALSE, col.names = TRUE, row.names = FALSE)
#chr <- substr(ghanaSample$ID_1, 1, regexpr("_", ghanaSample$ID_1)-1)

#cut = tbl_df(combined)
cut = tbl_df(cutGhana)
sample = tbl_df(ghanaSample)
sample = sample %>% mutate(SubstrID = substr(ID_1, 1, regexpr("_", ID_1)-1))
sample = sample[-1,]
table = left_join(sample, cut, by=c("SubstrID" = "SB_ID"))
table = table[,c(-4,-5)]

temp = data.frame("0","0","0","0","D","B","C","C","C","C","C","C","C","C","C","C")
colnames(temp) = names(table)
combined = rbind(temp,table)
combined$sex <- 2
combined[1,17] = "B"

write.table(combined, file = "ghana.sample", quote = FALSE, col.names = TRUE, row.names = FALSE)

