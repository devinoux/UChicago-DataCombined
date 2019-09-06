
#!/usr/bin/python

import gzip#, io

print("Hello World! Running SNP Variant list script!")

minExpFreqA1 = 0.005 # 0.001 Minimum Expected Frequency of A1 [0-1]
minInfoValue= 0.7 #0.7 	 Minimum Info (rSquare) Value [0-1]

f = gzip.open('/gpfs/data/huo-lab/BCAC/Amber/Imputed/Ambrosone2_chr1.metrics.gz', 'rt')
f2 = gzip.open('/gpfs/data/huo-lab/BCAC/Amber/Imputed/Haiman_IDs_Ambrosone2_chr1.gprobs.gz', 'rt')
newFile = gzip.open('/gpfs/data/huo-lab/BCAC/DataCombined/Amber/Amber.MAF005Info7.chr1.metrics.gz', 'wb', compresslevel = 1)
newGeno = gzip.open('/gpfs/data/huo-lab/BCAC/DataCombined/Amber/Tmp.chr1.gen.gz', 'wb', compresslevel = 1)

newFile.writelines("rs_id position a0 a1 exp_freq_a1 info certainty type info_type0 concord_type0 r2_type0\n")

for line in f.readlines():
	data = f2.readline() #Line of f2
	
	#RS_ID[0], Position[1], a0[2], a1[3], exp_freq_a1[4], info[5], certainty[6], type[7]
	ourExpFreq = line.split(' ')[4] #Columns in .gz are split up by spaces
	ourInfoValue =  line.split(' ')[5] 
	data2 = "23 " + data.split(' ')[0] + " " +  line.split(' ')[1] + data[len(data.split(' ')[0]):]
	
	if '.' in ourExpFreq:
		if float(ourInfoValue) >= minInfoValue and float(ourExpFreq)<=(1-minExpFreqA1) and float(ourExpFreq) >= minExpFreqA1:
			newFile.writelines(line)		
			newGeno.writelines(data2)
f.close()
f2.close()
newFile.close()
newGeno.close()
print("Closed all opened and written files.")

