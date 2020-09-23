# Pre-processing of genomic data from the UK Biobank

![alt text](https://github.com/lbourguignon/Preprocessing_UKBiobank_genotype500k/blob/master/MLCB_logo.png?raw=true)
![alt text](https://github.com/lbourguignon/Preprocessing_UKBiobank_genotype500k/blob/master/UK_biobank_logo.png?raw=true)

## Software requirement

This pre-processing procedure requires:
* QCTOOL, version 1.0
* GTOOL, version 1.0
* PLINK, version 2.00
* Python, version 3.7.4

## Setup and workflow

Before starting the pre-processing procedure, the script `paths_and_parameters.sh` should be modified to add information about :
* paths:
	* main project directory: `prj_dir`
	* QCTOOL software: `oxford_dir`
	* GTOOL software: `oxford_dir2`
	* PLINK software: `plink_dir`
	* genotype data: `geno_dir`
	* imputed data: `imp_dir`
	* output data: `out_dir`
* parameters:
	* list of chromosomes: `CHR_LIST`
	* SNP call rate: `SNP_CALLRATE`
	* SNP minor allele frequency: `SNP_MAF`
	* sample call rate: `SAMPLE_CALLRATE`
	* window size for linkage disequilibrium analysis: `LD_WINDOWSIZE`
	* step size for linkage disequilibrium analysis: `LD_STEPSIZE`
	* coefficient of correlation squared for linkage disequilibrium analysis: `LD_R2`
	* threshold for Hardy-Weinberg equilibrium analysis: `HWE`

Pre-processing can be performed by running the script `main_script` as follows :

```
bash ./code/main_script.sh
```

It will successively call the scripts for the different steps, which can be found under `./code/steps_code`. Below is a description of each step:

|| **description** | **Software required** | **Input file format** | **Output file format** | **Content output file** |
| --- | --- | --- | --- | --- | --- |
| **STEP 1** | Exclude from the analysis SNPs that do not have IDs of the type &#39;rsXXXX&#39;Imputation step | QCTOOL | .bim.cal.bgen.sample | .gen.log | Raw SNPs data, by chromosome |
| --- | --- | --- | --- | --- | --- |
| **STEP 2** | Convert .gen into .ped and .map | GTOOL | .gen | .ped.map | Raw SNPs data, by chromosome |
| **STEP 3** | Exclude duplicate SNPs, subjects without ambiguous sex and subjects not meeting inclusion criteria | PLINK | .ped.maplist\_ID\_to\_delete.txt (containing IDs of subjects not meeting inclusion criteria) | .bed.bim.fam | Duplicates-free raw SNPs data, by chromosome with only subjects included in the study |
| **STEP 4** | Filter SNPs based on MAF, call rate, LD and HWEFilter subjects based on call rate | PLINK | .bed.bim.fam | .bed.bim.fam | Duplicates-free raw SNPs data, by chromosome with only subjects included in the study |
| **STEP 5** | Merge chromosome files into one | PLINK | .bed.bim.fam | .bed.bim.fam | One file with duplicates-free raw SNPs data |
| **STEP 6** | Split data based on subjects&#39; sex | PLINK | .bed.bim.fam | .bed.bim.fam | 2 files (female and male) with duplicates-free raw SNPs data |
| **STEP 7** | Split data into train and test sets | PLINK | .bed.bim.famlist\_ID\_scotland.txt (containing IDs of subjects part of the test sets) | .bed.bim.fam | 4 files (female train and test; and male train and test) with duplicates-free raw SNPs data |
| **STEP 8** | Filter subjects according to a .txt file (study dependent)Recode SNP data according to additive model | PLINK | .bed.bim.fam.txt (containing IDs of subjects to include in subsequent study) | .bed.bim.fam.raw | Duplicates-free recoded SNPs data |
| **STEP 9** | Convert Plink files into .hdf5 file | Python | .bed.bim.fam | .hdf5 | Duplicates-free recoded SNPs data in .hdf5 format |


Output examples for each steps can be found under [`./code/README.md`](https://github.com/lbourguignon/Preprocessing_UKBiobank_genotype500k/tree/master/code)


## Contact

This repository is maintained by:
* [Lucie Bourguignon](https://github.com/lbourguignon)
* [Caroline Weis](https://github.com/cvweis)
* [Catherine Jutzeler](https://github.com/jutzca)