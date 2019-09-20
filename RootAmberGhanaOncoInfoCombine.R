
#setwd("/gpfs/data/huo-lab/BCAC/DataCombined/Onco")

#sink("/gpfs/data/huo-lab/BCAC/DataCombined/Onco/RAGO_Duplicates.log", append = TRUE)

for(i in 1:23){

  #print(paste("\nCHROMOSOME #",i,"\n",sep = ""))
  
  oncoInfo = paste("/gpfs/data/huo-lab/BCAC/DataCombined/Onco/intermediate/OncoChr",i,".info", sep = "")
  RAGInfo = paste("/gpfs/data/huo-lab/BCAC/DataCombined/Root_Amber_Ghana/RootAmberGhana.chr",i,".metrics", sep = "")
  
  #RAInfo = paste("/gpfs/data/huo-lab/BCAC/DataCombined/Root_Amber/RootAmber.chr",i,".metrics", sep = "")
  #RInfo = paste("/gpfs/data/huo-lab/BCAC/DataCombined/Root/Root.MAF005Info7.chr",i,".metrics.gz", sep = "")
  
  onco = read.table(oncoInfo, sep = " ", header = TRUE, stringsAsFactors = FALSE)
  
  #R = read.table(RInfo, sep = " ", header = TRUE, stringsAsFactors = FALSE)
  #R$order2Allel = (R$a0 > R$a1)
  #R$snp_uidS[R$order2Allel] <- paste(i, R$position, R$a0, R$a1, sep=":")[R$order2Allel]
  #R$snp_uidS[!R$order2Allel] <- paste(i, R$position, R$a1, R$a0, sep=":")[!R$order2Allel]
  ##PRINTED
  #print("RO duplicated RA$snp_uidS")
  #print(table(duplicated(R$snp_uidS)))
  
  #RO1 <- merge(R, onco, by.x = "snp_uidS", by.y="snp_uidS", all.x = TRUE, all.y = TRUE)
  #oncoUIDSonly = (!is.na(RO1$a0.x))
  #RUIDSonly = (!is.na(RO1$a0.y))
  #RO1Final = RO1[oncoUIDSonly & RUIDSonly,]
  ##PRINT 
  #print("RO Flipped reference and minor alleles")
  #print(table(RO1$a0.x == RO1$a0.y))
  #print(table(duplicated(R$snp_uidS) | duplicated(R$snp_uidS, fromLast = TRUE)))
  
  
  
  #RA = read.table(RAInfo, sep = " ", header = TRUE, stringsAsFactors = FALSE)
  
  #RA$order2Allel = (RA$a0 > RA$a1)
  #RA$snp_uidS[RA$order2Allel] <- paste(i, RA$position, RA$a0, RA$a1, sep=":")[RA$order2Allel]
  #RA$snp_uidS[!RA$order2Allel] <- paste(i, RA$position, RA$a1, RA$a0, sep=":")[!RA$order2Allel]
  
  ##PRINT #duplicated RA$snp_uidS
  #print("RAO duplicated RA$snp_uidS")
  #table(duplicated(RA$snp_uidS))
  
  #RAO <- merge(RA, onco, by.x = "snp_uid", by.y="snp_uid", all.x = TRUE, all.y = TRUE)
  
  #RAO1 <- merge(RA, onco, by.x = "snp_uidS", by.y="snp_uidS", all.x = TRUE, all.y = TRUE)
  #oncoUIDSonly = (!is.na(RAO1$a0.x))
  #RAUIDSonly = (!is.na(RAO1$a0.y))
  #RAO1Final = RAO1[oncoUIDSonly & RAUIDSonly,]
  
  ##PRINT 
  #print("RAO Flipped reference and minor alleles")
  #print(table(RAO1$a0.x == RAO1$a0.y))
  #print(table(duplicated(RA$snp_uidS) | duplicated(RA$snp_uidS, fromLast = TRUE)))
  
  
  
  
  
  RAG = read.table(RAGInfo, sep = " ", header = TRUE, stringsAsFactors = FALSE)
  RAG$order2Allel = (RAG$a0 > RAG$a1)
  RAG$snp_uidS[RAG$order2Allel] <- paste(i, RAG$position, RAG$a0, RAG$a1, sep=":")[RAG$order2Allel]
  RAG$snp_uidS[!RAG$order2Allel] <- paste(i, RAG$position, RAG$a1, RAG$a0, sep=":")[!RAG$order2Allel]
  ##PRINT
  #print("RAGO duplicated RA$snp_uidS")
  #print(table(duplicated(RAG$snp_uidS)))
  #RAGO <- merge(RAG, onco, by.x = "snp_uid", by.y="snp_uid", all.x = TRUE, all.y = TRUE)
  
  RAGO1 <- merge(RAG, onco, by.x = "snp_uid", by.y="snp_uid", all.x = TRUE, all.y = TRUE)
  oncoUIDSonlyG = (!is.na(RAGO1$a0.x))
  RAUIDSonlyG = (!is.na(RAGO1$a0.y))
  RAGO1Final = RAGO1[oncoUIDSonlyG & RAUIDSonlyG,]
  
  #PRINT
  #print("RAGO Flipped reference and minor alleles")
  #print(table(RAGO1$a0.x == RAGO1$a0.y))
  #print(table(duplicated(RAG$snp_uidS) | duplicated(RAG$snp_uidS, fromLast = TRUE)))
  
  #onco2Only = (!is.na(RAGO[,"position.y"]))
  #RAGOnly = (!is.na(RAGO[,"position.x"]))
  #RAGOFinal <- RAGO[onco2Only & RAGOnly,]
  
  colnames(RAGO1Final) =  c("snp_uid", "position", "a0", "a1","rs_id.Root",
                       "exp_freq_a1.Root", "info.Root", "type.Root", "info_type0.Root",
                       "rs_id.Amber", "exp_freq_a1.Amber", "info.Amber", "type.Amber", "info_type0.Amber",
                       "ALT_Frq.Ghana", "MAF.Ghana", "AvgCall.Ghana", "Rsq.Ghana", "Genotyped.Ghana", "EmpRsq.Ghana",
                       "order2Allel", "snp_uidS","rs_id.Onco", "position.2","a0.2","a1.2","exp_fre1_a1.Onco", "info.Onco", "certainty.Onco",
                       "type.Onco", "info_type0.Onco","concord_type0.Onco","r2_type0.Onco", "snp_uidS")
 
  #Remove order2Allel, position a0 a1 2, snp_uid.Onco
  
  RAGO1Formatted = RAGO1Final[,-c(21,22,24,25,26)]
   
  RAOutfile = paste("/gpfs/data/huo-lab/BCAC/DataCombined/Onco/RootAmberGhanaOnco_SNPUID.chr",i,".metrics", sep = "")
  write.table(RAGO1Formatted, file = RAOutfile, quote = FALSE, sep = " ", row.names = FALSE, col.names = TRUE)
}

#sink()
#closeAllConnections()