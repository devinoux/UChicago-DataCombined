
## check variant ID of BCAC/Black dataset:

## 9/6/2019 received update info file

###setwd("/gpfs/data/huo-lab/BCAC/Imputed_prob")

###sink("/gpfs/data/huo-lab/BCAC/DataCombined/Onco/BCAC_Rchr1-23.fixed.log", append = TRUE)

for(i in 9){
  
###inputleft = paste("/gpfs/data/huo-lab/BCAC/DataCombined/Onco/intermediate/left.chr",i,".txt.gz", sep = "")
###infofile = paste("/gpfs/data/huo-lab/BCAC/Imputed_prob/onco_bcac_african_info_chr",i,"_varid.txt.gz", sep = "")
  
inputleft = paste("left.chr",i,".txt.gz", sep = "")
infofile = paste("onco_bcac_african_info_chr",i,"_varid.txt.gz", sep = "")
  

left22 <- read.table(inputleft, sep=" ", header=FALSE, stringsAsFactors = FALSE)
info.new <- read.table(infofile, sep=" ", header=TRUE, stringsAsFactors = FALSE)


info.left <- cbind(info.new, left22)

print(table(info.left$rs_id==info.left$V1))
info.left[!(info.left$rs_id==info.left$V1),]
print(table(info.left$a0==info.left$V3))
print(table(info.left$a1==info.left$V4))

info.left$snp_uid <- paste(i, info.left$V2, info.left$V3, info.left$V4, sep=":") 

table(duplicated(info.left$snp_uid) | duplicated(info.left$snp_uid, fromLast = TRUE))
table(info.left$snp_uid==info.left$V1)

info.left$order2Allel = (info.left$V3 > info.left$V4) 

info.left$snp_uidS[info.left$order2Allel] <- paste(i, info.left$V2, info.left$V3, info.left$V4, sep=":")[info.left$order2Allel]
info.left$snp_uidS[!info.left$order2Allel] <- paste(i, info.left$V2, info.left$V4, info.left$V3, sep=":")[!info.left$order2Allel]

print(table(duplicated(info.left$snp_uidS) | duplicated(info.left$snp_uidS, fromLast = TRUE))) 
## check https://www.ncbi.nlm.nih.gov/projects/SNP/snp_ref.cgi?do_not_redirect&rs=rs143936268: rs200745666 is not correct. 
## undecided on some other indels. We delete them all.  
info.left[(duplicated(info.left$snp_uidS) | duplicated(info.left$snp_uidS, fromLast = TRUE)), c("snp_uidS", "V1", "V2", "V3", "V4", "exp_freq_a1", "info")]  

## if gtool is used for SNP filtering, variable "V1" can be be used. After filtering, a uniformed ID, snp_uidS, can be replaced. 
## alternatively, we can first replace the uniformed ID, snp_uidS, then use "snp_uidS" to do the filtering. 

table(duplicated(info.left$chr_index) | duplicated(info.left$chr_index, fromLast = TRUE)) 
table(duplicated(info.left$varid) | duplicated(info.left$varid, fromLast = TRUE))
table(duplicated(info.left$varname) | duplicated(info.left$varname, fromLast = TRUE)) 
table(duplicated(info.left$rs_id) |  duplicated(info.left$rs_id, fromLast = TRUE)) 
table(duplicated(info.left$V1) | duplicated(info.left$V1, fromLast = TRUE)) 
info.left[duplicated(info.left$V1) | duplicated(info.left$V1, fromLast = TRUE), ] 
#info.left[info.left$V2==39374551, ] 

## check of multi-allelic variants
print(table(duplicated(info.left$position) | duplicated(info.left$position, fromLast = TRUE)))

## check number of variants with rsnum 
table(regexpr("rs", info.left$V1)) 
head( info.left[(regexpr("rs", info.left$V1)>1), c("snp_uidS", "V1", "V2", "V3", "V4", "exp_freq_a1", "info")] )
head( info.left[(regexpr("rs", info.left$V1)==-1), c("snp_uidS", "V1", "V2", "V3", "V4", "exp_freq_a1", "info")] )
table(regexpr("<", info.left$V1)) 
table(regexpr(":", info.left$V1)) 
table(regexpr("_", info.left$V1)) 

## no duplicates, info>=0.7 & MAF>=0.005
info.sel <- info.left[!(duplicated(info.left$snp_uidS) | duplicated(info.left$snp_uidS, fromLast = TRUE))
                      & info.left$info>=0.7 & info.left$exp_freq_a1>=0.005 & info.left$exp_freq_a1<=0.995, ]
print( dim(info.left) )
print( dim(info.sel) )

table(info.sel$rs_id==info.sel$V1)
info.left[!(info.sel$rs_id==info.sel$V1),]
print(table(info.sel$position==info.sel$V2))
print(table(info.sel$a0==info.sel$V3))
print(table(info.sel$a1==info.sel$V4))

info.out <- info.sel[, c("rs_id", "position", "a0", "a1", "exp_freq_a1", "info", "certainty", "type", "info_type0", "concord_type0", "r2_type0", "snp_uid", "snp_uidS")]
list.out <- info.sel[, c("snp_uid")]


infofileout = paste("OncoChr",i,".list", sep = "")
listfileout = paste("OncoChr",i,".info", sep = "")

write.table(info.out, file = infofileout, quote=FALSE, sep=" ", row.name=FALSE, col.name=TRUE)
write.table(list.out, file = listfileout, quote=FALSE, sep=" ", row.name=FALSE, col.name=FALSE)

}

###sink() 
###closeAllConnections()