#!/bin/bash

# -----------------------------------------------------------------------------------
#
# Preprocessing UK Biobank genotype_500k - Step 8 file
#
# -----------------------------------------------------------------------------------
#
# This file contains script to recode SNPs data
#
# First Version: July 2016, D. Roqueiro
#
# Adapted Version for UKBiobank 500K Data: February, 2020 L. Bourguignon
# With the contribution of C. Jutzeler and C. Weis
#
# -----------------------------------------------------------------------------------

source paths_and_parameters.sh


# # Recode to get a .raw file

#  Recode the genotypes to the additive model. Assuming that C is the minor allele for a given SNP, the additive model is:
#   SNP      Additive
#   ---      --------
#   A A   ->    0
#   A C   ->    1
#   C C   ->    2
#  It is basically the count of the minor allele
# Source: PLINK's online help page http://pngu.mgh.harvard.edu/~purcell/plink/dataman.shtml

$plink_dir/plink --bfile $geno_dir/plink/all.onlyrsids.imputed.correct.female.train \
		         --recode A \
            	 --make-bed \
            	 --out $geno_dir/plink/all.onlyrsids.imputed.correct.female.train.recode

$plink_dir/plink --bfile $geno_dir/plink/all.onlyrsids.imputed.correct.female.test \
		         --recode A \
            	 --make-bed \
            	 --out $geno_dir/plink/all.onlyrsids.imputed.correct.female.test.recode

$plink_dir/plink --bfile $geno_dir/plink/all.onlyrsids.imputed.correct.male.train \
		         --recode A \
            	 --make-bed \
            	 --out $geno_dir/plink/all.onlyrsids.imputed.correct.male.train.recode

$plink_dir/plink --bfile $geno_dir/plink/all.onlyrsids.imputed.correct.male.test \
		         --recode A \
            	 --make-bed \
            	 --out $geno_dir/plink/all.onlyrsids.imputed.correct.male.test.recode
