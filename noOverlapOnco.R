AABCsample = read.table("AABC1M_covariates_deidentified.txt",sep = " ", header = TRUE, stringsAsFactors = FALSE)
#OncoSampleOrder = read.table("haiman_503_african_sample_order.txt",sep = " ", header = TRUE, stringsAsFactors = FALSE)
#OncoSampleWOverlap = read.table("Onco_all_african_pheno_v9_haiman_503.txt",sep = "\t", header = TRUE, stringsAsFactors = FALSE)


noOverlaps = read.table("list_noOverlapSamples.txt",sep = "\t", header = TRUE, stringsAsFactors = FALSE)
OncoFormatted = read.table("BCACformatted.sample", sep = " ", header = TRUE, stringsAsFactors = FALSE)

temp = data.frame(noOverlaps[,2],1:3677)
colnames(temp) = c("ID_1","reorder")

OncoNoOverlaps = merge(OncoFormatted[-1,], temp, by.x = "ID_2", by.y = "ID_1", all = TRUE)

final = OncoNoOverlaps[!is.na(OncoNoOverlaps$reorder),]
newFinal = final[order(final$reorder),]

secondrow = data.frame(0,0,0,"D", "B","D","C","C","D","D","C","C","C","C","C","C","C","C","C","C","C","B","B")
colnames(secondrow) = c("ID_1", "ID_2", "missing", "sex", "case", "erfinal_d", "agegroup",  "age", "consortium", "studysite",
                        "PC1", "PC2", "PC3","PC4","PC5","PC6","PC7","PC8","PC9","PC10", "Ancestry", "pheno", "famHist")
anotherone = rbind(secondrow,newFinal[,-c(24)])

write.table(anotherone, file = "OncoNoOverlaps.sample", quote = FALSE, row.names = FALSE, col.names = TRUE, sep = " ")

RAGsample1 = read.table("Root_Amber_Ghana_chr1.sample",sep = " ", header = TRUE, stringsAsFactors = FALSE)
RAGsample1$famHist = NA
RAGsample1[1,23] = "B"

RAGOsample1 = rbind(RAGsample1,anotherone)
write.table(RAGOsample1, file = "RootAmberGhanaOnco.chr1-22.sample", quote = FALSE, row.names = FALSE, col.names = TRUE, sep = " ")


RAGsample23 = read.table("Root_Amber_Ghana_chr1.sample",sep = " ", header = TRUE, stringsAsFactors = FALSE)
RAGsample23$famHist = NA
RAGsample23[1,23] = "B"
RAGOsample23 = rbind(RAGsample23,anotherone)
write.table(RAGOsample23, file = "RootAmberGhanaOnco.chr23.sample", quote = FALSE, row.names = FALSE, col.names = TRUE, sep = " ")
