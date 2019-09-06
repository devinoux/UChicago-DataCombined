for(i in 1:24){ 
  setwd("/gpfs/data/huo-lab/BCAC/Ghana")
#i = 18  

chromosome = paste("chr", as.character(i), ".info.gz", sep="")
if(i == 23){chromosome = "chr23.auto.info.gz"}
if(i == 24){chromosome = "chr23.no.auto_female.info.gz"}

info <- read.table(chromosome, sep="\t", header=TRUE, colClasses = c("character"))
info2 = info[,c(-9,-10,-12,-13)]

info2$CHROM = i
info2$SNP_UID = paste(info2$SNP, ":",info2$REF.0.,":", info2$ALT.1., sep = "") 

if(i >= 23){
  info2$CHROM = 23#i
  info2$SNP_UID = paste("23:",substring(as.character(info2[,1]), 3), ":",info2$REF.0.,":", info2$ALT.1., sep = "")
}

info3dup <- info2[duplicated(info2$SNP_UID),]

for(id in info3dup$SNP_UID){
  info2 = subset(info2, SNP_UID != id)
}

sel <- (info2[,5]>=0.005 & info2[,5]<=0.995 & info2[,7]>=0.7) 
info2 = info2[,c(10,11,2:9)]

info3 <- info2[sel, ] 
list <-info2[sel, 2]  

outfileName1 = paste("chr", as.character(i), "Ghana.info", sep="")
outfileName2 = paste("chr", as.character(i), "Ghana.list", sep="") 

if(i == 24){
  outfileName1 = "chr23par2.Ghana.info"
  outfileName2 = "chr23par2.Ghana.list"}

setwd("/gpfs/data/huo-lab/BCAC/DataCombined/Ghana/intermediate")

write.table(info3, file=outfileName1, quote=FALSE, sep=" ", row.name=FALSE, col.name=TRUE)   
write.table(list,  file=outfileName2, quote=FALSE, sep=" ", row.name=FALSE, col.name=FALSE)

}
  

