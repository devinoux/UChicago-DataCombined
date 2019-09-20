
for(i in 1){
  pbsname = paste("OncoFormatRAGOCombineChr",i,".pbs", sep = "")
  code = paste("#!/bin/bash

#PBS -N chr",i,"OncoRAGO
### Select the shell you would like the script to execute within
#PBS -S /bin/bash
### Inform the scheduler of the expect run time
#PBS -l walltime=20:00:00
### Inform the scheduler of the number of CPU cores for your job
#PBS -l nodes=1:ppn=1
### Inform the scheduler of the amount of memory for  your job
#PBS -l mem=4gb
### Set the destination for output
#PBS -o ${PBS_JOBNAME}.o${PBS_JOBID}
#PBS -e ${PBS_JOBNAME}.e${PBS_JOBID}
###

module load gcc/6.2.0

pathA=/gpfs/data/huo-lab/BCAC/DataCombined/Root_Amber_Ghana_Onco/intermediate
pathB=/gpfs/data/huo-lab/BCAC/DataCombined/Onco
pathC=/gpfs/data/huo-lab/BCAC/DataCombined/Root_Amber_Ghana_Onco
pathD=/gpfs/data/huo-lab/BCAC/DataCombined/Root_Amber_Ghana


zcat $pathB/Onco.MAF005R07.chr",i,".gen.gz | awk '{FS=\" \"; OFS=\" \"} {$1 = $2; $2=$3=$4=$5=\"\"; print $0}' | sed 's/ \\{1,\\}/ /g' | gzip > $pathA/Onco.Formatted.MAF005R07.chr",i,".gen.gz

join -1 1 -2 1 <(zcat $pathD/Root_Amber_Ghana.Fixed.MAF005Info7.chr",i,".gen.gz | sort -k 1) <(zcat $pathA/Onco.Formatted.MAF005R07.chr",i,".gen.gz | sort -k 1 ) | gzip > $pathC/Root_Amber_Ghana_Onco.MAF005Info7.chr",i,".gen.gz 

zcat $pathC/Root_Amber_Ghana_Onco.MAF005Info7.chr",i,".gen.gz | wc >> $pathD/RAGOchr",i,".log

               ", sep = "")
  
  write(code, file = pbsname)
  
}


##Creates bash script that qsub all pbs scripts for us
text = "#!/bin/bash\n"
bashname = "/gpfs/data/huo-lab/BCAC/DataCombined/Root_Amber_Ghana_Onco/codes/qsubRAGO.sh"
for(i in 1:23){
  #Copy qsub name from end of line 4, name of pbs files
  text = paste(text, "qsub OncoFormatRAGOCombineChr",i,".pbs\n",sep = "")
}
write(text, file = bashname)
