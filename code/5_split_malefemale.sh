#!/bin/bash

# -----------------------------------------------------------------------------------
#
# Preprocessing UK Biobank genotype_500k - Step 5 file
#
# -----------------------------------------------------------------------------------
#
# This file contains script to split data into two files based on gender
#
# First Version: July 2016, D. Roqueiro
#
# Adapted Version for UKBiobank 500K Data: February, 2020 L. Bourguignon
# With the contribution of C. Jutzeler and C. Weis
#
# -----------------------------------------------------------------------------------

source paths_and_parameters.sh

# 5. Split into male and female

# Filter out males to have only females and recode
$plink_dir/plink --bfile $geno_dir/plink/all.onlyrsids.imputed.correct \
				 --filter-females \
            	 --make-bed \
            	 --out $geno_dir/plink/all.onlyrsids.imputed.correct.female

# Filter out females to have only males and recode
$plink_dir/plink --bfile $geno_dir/plink/all.onlyrsids.imputed.correct \
				 --filter-males \
            	 --make-bed \
            	 --out $geno_dir/plink/all.onlyrsids.imputed.correct.male
