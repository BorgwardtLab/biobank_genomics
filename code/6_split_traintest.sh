#!/bin/bash

# -----------------------------------------------------------------------------------
#
# Preprocessing UK Biobank genotype_500k - Step 6 file
#
# -----------------------------------------------------------------------------------
#
# This file contains script to split files into train and test files
#
# First Version: July 2016, D. Roqueiro
#
# Adapted Version for UKBiobank 500K Data: February, 2020 L. Bourguignon
# With the contribution of C. Jutzeler and C. Weis
#
# -----------------------------------------------------------------------------------

source paths_and_parameters.sh

# 6. Split into train and test
# Test : Scottish centers
# Train : All the other centers

# Filter out Scottish centers in female file
$plink_dir/plink --bfile $geno_dir/plink/all.onlyrsids.imputed.correct.female \
		         --remove $geno_dir/plink/list_ID_scotland.txt \
            	 --make-bed \
            	 --out $geno_dir/plink/all.onlyrsids.imputed.correct.female.train

$plink_dir/plink --bfile $geno_dir/plink/all.onlyrsids.imputed.correct.female \
		         --keep $geno_dir/plink/list_ID_scotland.txt \
            	 --make-bed \
            	 --out $geno_dir/plink/all.onlyrsids.imputed.correct.female.test

# Filter out Scottish centers in male file
$plink_dir/plink --bfile $geno_dir/plink/all.onlyrsids.imputed.correct.male \
				 --remove $geno_dir/plink/list_ID_scotland.txt \
            	 --make-bed \
            	 --out $geno_dir/plink/all.onlyrsids.imputed.correct.male.train

$plink_dir/plink --bfile $geno_dir/plink/all.onlyrsids.imputed.correct.male \
				 --keep $geno_dir/plink/list_ID_scotland.txt \
            	 --make-bed \
            	 --out $geno_dir/plink/all.onlyrsids.imputed.correct.male.test