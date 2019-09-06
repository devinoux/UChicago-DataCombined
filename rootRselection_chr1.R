
## files preparation for SNP selection
## unzip the information files in /ROOT/wgs/imputed_data_filtered: gzip -d Olopade*.info.gz 
## split the file into small pieces for easy processing:
## split -l 100000 -d Olopade_chr22.info /gpfs/data/huo-lab/group/huo-lab/BCAC/DataCombined/Root/intermediate/chr22P.  
## ls chr22P.* > filechr22.txt 

setwd("/gpfs/data/huo-lab/BCAC/DataCombined/Root/intermediate")

## setwd("Y:/BCAC/DataCombined/Root/intermediate")

fname<- read.table("filechr1.txt",sep=" ", header=FALSE, colClass="character")
nfiles=nrow(fname)


for(i in seq(from=1, to=nfiles)){ 
  if (i==1) {
    info <- read.table(fname[i,1], sep=" ", header=TRUE, 
          colClasses=c("character","character","numeric","character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric")) 
  }
  if (i>1) {
    info <- read.table(fname[i,1], sep=" ", header=FALSE, 
         colClasses=c("character","character","numeric","character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))   
  }
  
  sel <- (info[,6]>=0.005 & info[,6]<=0.995 & info[,7]>=0.7) 
  info2 <- info[sel, ] 
  list <-info[sel, 2]
 
  outfileName1 = paste("chr1.info", as.character(i+100), "txt", sep=".")
  outfileName2 = paste("chr1.list", as.character(i+100), "txt", sep=".") 
  
  if (i==1) {
  write.table(info2, file=outfileName1, quote=FALSE, sep=" ", row.name=FALSE, col.name=TRUE)   
  write.table(list,  file=outfileName2, quote=FALSE, sep=" ", row.name=FALSE, col.name=FALSE)       
  }
  if (i>1) {
    write.table(info2, file=outfileName1, quote=FALSE, sep=" ", row.name=FALSE, col.name=FALSE)   
    write.table(list,  file=outfileName2, quote=FALSE, sep=" ", row.name=FALSE, col.name=FALSE)       
  }
}

## combine them with cat
