
for(i in 1:23){

  ghanaInput = paste("/gpfs/data/huo-lab/BCAC/DataCombined/Ghana/intermediate/chr", as.character(i), "Ghana.info", sep="")
  if(i == 23){ghanaInput = "/gpfs/data/huo-lab/BCAC/DataCombined/Ghana/Ghana.MAF005Info7.chr23.metrics"}
  
  RootAmberInput = paste("/gpfs/data/huo-lab/BCAC/DataCombined/Root_Amber/RootAmber.chr", as.character(i), ".metrics", sep="")
  
  ghanaInfo = read.table(file = ghanaInput, sep = " ", header = TRUE, stringsAsFactors = FALSE)
  rootAmberInfo = read.table(file = RootAmberInput, sep = " ", header = TRUE, stringsAsFactors = FALSE)

  betterGhana = ghanaInfo[,-1]
  colnames(betterGhana) = c("SNP_UID","REF.0.Ghana","ALT.1.Ghana","ALT_Frq.Ghana","MAF.Ghana","AvgCall.Ghana","Rsq.Ghana","Genotyped.Ghana","EmpRsq.Ghana")

  RAGInfo = merge(rootAmberInfo, betterGhana, by.x = "snp_uid",by.y = "SNP_UID", all.x = TRUE, all.y = TRUE)

  RANA = (!is.na(RAGInfo[,"info.Root"]))
  GhNA = (!is.na(RAGInfo[,"ALT_Frq.Ghana"]))

  RAGInfo2 = RAGInfo[RANA & GhNA,c(-15,-16)]
  
  outfileName1 = paste("/gpfs/data/huo-lab/BCAC/DataCombined/Root_Amber_Ghana/RootAmberGhana.chr", as.character(i), ".metrics", sep="")
  write.table(RAGInfo2, file=outfileName1 , quote=FALSE, sep=" ", row.name=FALSE, col.name=TRUE)

}

#temp = "22:16055171:G:T"
#splitter = strsplit(temp,":")[[1]]
#ghana$position = strsplit(ghana$SNP_ID,":")[[1]][2]

#   # setwd("/gpfs/data/huo-lab/BCAC/DataCombined/Root")
# 
#   #setwd("Y:/BCAC/DataCombined/Root")
# 
#   inputFN1 = paste("/gpfs/data/huo-lab/BCAC/DataCombined/Root/Root.MAF005Info7.chr", as.character(i), ".metrics.gz", sep="")
#   inputFN2 = paste("/gpfs/data/huo-lab/BCAC/DataCombined/Amber/Amber.MAF005Info7.chr", as.character(i), ".metrics.gz", sep="")
# 
#   rroot <- read.table(inputFN1, sep=" ", header=TRUE, stringsAsFactors = FALSE)
# 
#   aamber<- read.table(inputFN2, sep=" ", header=TRUE, stringsAsFactors = FALSE)
# 
#   rroot$snp_uid <- paste(as.character(i), format(rroot$position, trim=TRUE, scientific=FALSE), rroot$a0, rroot$a1, sep=":")
#   aamber$snp_uid <- paste(as.character(i), format(aamber$position, trim=TRUE, scientific=FALSE), aamber$a0, aamber$a1, sep=":")
# 
#   length(rroot[,"position"])
#   length(unique(rroot[,"position"]))
# 
#   length(aamber[,"position"])
#   length(unique(aamber[,"position"]))
# 
#   length(rroot[,"snp_uid"])
#   length(unique(rroot[,"snp_uid"]))
# 
#   length(aamber[,"snp_uid"])
#   length(unique(aamber[,"snp_uid"]))
# 
#   ## bothA <- merge(rroot, aamber, by.x = "rs_id", by.y="rs_id", all.x = TRUE, all.y = TRUE)
# 
#   both1 <- merge(rroot, aamber, by.x = "snp_uid", by.y="snp_uid", all.x = TRUE, all.y = TRUE)
# 
#   # check # of SNPs matched
#   amberPosNA = (!is.na(both1[,"position.y"]))
#   rootPosNA = (!is.na(both1[,"position.x"]))
#   table(amberPosNA, rootPosNA)
#   # info score for ROOT SNPs that matched
#   summary(both1[rootPosNA, "info.x"])
#   # info score for ROOT SNPs that not matched
#   summary(both1[!amberPosNA, "info.x"])
#   # allele freq for ROOT SNPs that matched
#   summary(both1[rootPosNA, "exp_freq_a1.x"])
#   # allele freq for ROOT SNPs that not matched
#   summary(both1[!amberPosNA, "exp_freq_a1.x"])
# 
#   # info score for AMBER SNPs that matched
#   summary(both1[amberPosNA, "info.y"])
#   # info score for AMBER SNPs that not matched
#   summary(both1[!rootPosNA, "info.y"])
#   # allele freq for AMBER SNPs that matched
#   summary(both1[amberPosNA, "exp_freq_a1.y"])
#   # allele freq for AMBER SNPs that not matched
#   summary(both1[!rootPosNA, "exp_freq_a1.y"])
# 
#   #Filter out not matched SNPs
#   root_amber1 <- both1[amberPosNA & rootPosNA,]
# 
#   #Remove extra position and a0 a1 columns and extra columns
#   info = root_amber1[,c(-2,-9, -12, -13, -15,-16, -17, -20, -23,-24)]
# 
#   columnnames = c("snp_uid", "rs_id.Root", "position", "a0", "a1",
#                   "exp_freq_a1.Root", "info.Root", "type.Root", "info_type0.Root",
#                   "rs_id.Amber", "exp_freq_a1.Amber", "info.Amber", "type.Amber", "info_type0.Amber")
#   colnames(info) = columnnames
#   info2 <- info[, c("snp_uid", "position", "a0", "a1",
#                     "rs_id.Root", "exp_freq_a1.Root", "info.Root", "type.Root", "info_type0.Root",
#                     "rs_id.Amber", "exp_freq_a1.Amber", "info.Amber", "type.Amber", "info_type0.Amber")]

