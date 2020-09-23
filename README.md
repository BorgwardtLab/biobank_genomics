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

![alt text](https://github.com/lbourguignon/Preprocessing_UKBiobank_genotype500k/blob/master/flowchart/description_steps.jpg?raw=true)

Output examples for each steps can be found under [`./code/README.md`](https://github.com/lbourguignon/Preprocessing_UKBiobank_genotype500k/tree/master/code)


## Contact

This repository is maintained by:
* [Lucie Bourguignon](https://github.com/lbourguignon)
* [Caroline Weis](https://github.com/cvweis)
* [Catherine Jutzeler](https://github.com/jutzca)