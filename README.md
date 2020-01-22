# UChicago-DataCombined
Code used to merge the genotype, phenotype, and information files from Amber, Root, Ghana, BCAC, and AABC studies together.

Used a combination of R, Python, and Bash scripts to combine and filter the data using a RSquare value of >= .7 and Minor Allele Frequency between 0.005 and 0.995

DZ_vcf2impute_gen.pl is a Perl script that converts VCF files to Oxford (.gen) format that Professor Dezheng and I standardized (chr:position:a0:a1)

The .pbs scripts are a combination of scripts that either sent the filtering or merging files to the BSD Supercomputer. RAGcombine1.pbs merged an already merged Root and Amber study with Ghana.

chr1Amber.py is an inefficient Python script used to cut, filter, and write new .info and .gen files based on our values above.

RootAmberGhanaInfoCombine.R is an R script used to combine the three studies' info files (Root and Amber had already been combined)

rootRselection_chr1.R is an R script used to filter the Root dataset, much faster than the Python script.
ghanaRselectionUpdated.R does the same thing but for Ghana dataset. Filters the info file and used gtool to cut rows in the .gen files.

ghanaSampleExcelConvert.R formatted the phenotype (.sample) ghana file.

contact me at jerryx224j@gmail.com for any questions :)
