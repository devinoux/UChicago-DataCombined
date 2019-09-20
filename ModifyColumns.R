

for(i in 1:23){
  filename = paste("/gpfs/data/huo-lab/BCAC/Root_Amber_Ghana/codes/FixingRAGCombine",i,".pbs", sep = "")
  code = paste("#!/bin/bash

#PBS -N chr",i,"GhanaFC
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

pathB=/gpfs/data/huo-lab/BCAC/DataCombined/Ghana
pathC=/gpfs/data/huo-lab/BCAC/DataCombined/Root_Amber
pathD=/gpfs/data/huo-lab/BCAC/DataCombined/Root_Amber_Ghana

zcat $pathB/Ghana.MAF005Info7.chr",i,".gen.gz| awk '{FS=\" \"; OFS=\" \"} {$1 = $2; $2=$3=$4=$5=\"\"; print $0}' | sed 's/ \\{1,\\}/ /g' | gzip > $pathB/Ghana.FormatCombine.MAF005Info7.chr",i,".gen.gz

join -1 2 -2 1 <(zcat $pathC/Root_Amber.MAF005R07.chr",i,".gen.gz | sort -k 2) <(zcat $pathB/Ghana.FormatCombine.MAF005Info7.chr",i,".gen.gz | sort -k 1 ) | gzip > $pathD/Root_Amber_Ghana.Fixed.MAF005Info7.chr",i,".gen.gz 
zcat $pathD/Root_Amber_Ghana.Fixed.MAF005Info7.chr",i,".gen.gz | wc >> $pathD/RAGchr",i,".log


  ", sep = "")
  write(code, file = filename)
  
}
##Creates bash script that qsub all pbs scripts for us
text = "#!/bin/bash\n"
bashname = "qsubFixes.sh"
for(i in 1:23){
  #Copy qsub name from end of line 4, name of pbs files
  text = paste(text, "qsub FixingRAGCombine",i,".pbs\n",sep = "")
}
write(text, file = bashname)
