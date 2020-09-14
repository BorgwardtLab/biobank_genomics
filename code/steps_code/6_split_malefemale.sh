#!/bin/bash

# -----------------------------------------------------------------------------------
#
# Preprocessing UK Biobank genotype_500k - Step 6 file
#
# -----------------------------------------------------------------------------------
#
# This file contains script to split data into two files based on sex
#
# First Version: July 2016, D. Roqueiro
#
# Adapted Version for UKBiobank 500K Data: February, 2020 L. Bourguignon
# With the contribution of C. Jutzeler and C. Weis
#
# -----------------------------------------------------------------------------------

source paths_and_parameters.sh

# 6. Split into male and female

# Filter out males to have only females
$plink_dir/plink --bfile $geno_dir/plink/all.onlyrsids.imputed.complete \
				 --filter-females \
            	 --make-bed \
            	 --out $geno_dir/plink/all.onlyrsids.imputed.complete.female

# Filter out females to have only males
$plink_dir/plink --bfile $geno_dir/plink/all.onlyrsids.imputed.complete \
				 --filter-males \
            	 --make-bed \
            	 --out $geno_dir/plink/all.onlyrsids.imputed.complete.male
