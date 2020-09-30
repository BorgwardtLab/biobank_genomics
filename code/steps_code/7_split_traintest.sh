#!/bin/bash

# -----------------------------------------------------------------------------------
#
# Preprocessing UK Biobank genotype_500k - Step 7 file
#
# -----------------------------------------------------------------------------------
#
# This file contains script to split files into train and test files
# This step assumes the existence of a file containing IDs of subjects being part of the test set
# This file should be stored in $geno_plink_dir folder as specified in paths_and_parameters.sh script
# or modify the paths accordingly on lines 27 and 28
#
# First Version: July 2016, D. Roqueiro
#
# Adapted Version for UKBiobank 500K Data: February, 2020 L. Bourguignon
# With the contribution of C. Jutzeler and C. Weis
#
# -----------------------------------------------------------------------------------

source paths_and_parameters.sh

# 7. Split into train and test
# Test : Scottish centers
# Train : All the other centers

grep -w -F -f $geno_plink_dir/list_ID_test.txt $geno_plink_dir/all.onlyrsids.imputed.complete.female.fam > $geno_plink_dir/excluded_test_female.txt
grep -w -F -f $geno_plink_dir/list_ID_test.txt $geno_plink_dir/all.onlyrsids.imputed.complete.male.fam > $geno_plink_dir/excluded_test_male.txt

# Filter out Scottish centers in female file to get female train set
$plink_dir/plink --bfile $geno_plink_dir/all.onlyrsids.imputed.complete.female \
		 --remove $geno_plink_dir/excluded_test_female.txt \
                 --make-bed \
                 --out $geno_plink_dir/all.onlyrsids.imputed.complete.female.train

# Only keep Scottish centers in female file to get female test set
$plink_dir/plink --bfile $geno_plink_dir/all.onlyrsids.imputed.complete.female \
		 --keep $geno_plink_dir/excluded_test_female.txt \
                 --make-bed \
                 --out $geno_plink_dir/all.onlyrsids.imputed.complete.female.test

# Filter out Scottish centers in male file to get male train set
$plink_dir/plink --bfile $geno_plink_dir/all.onlyrsids.imputed.complete.male \
		 --remove $geno_plink_dir/excluded_test_male.txt \
                 --make-bed \
                 --out $geno_plink_dir/all.onlyrsids.imputed.complete.male.train

# Only keep Scottish centers in male file to get male test set
$plink_dir/plink --bfile $geno_plink_dir/all.onlyrsids.imputed.complete.male \
		 --keep $geno_plink_dir/excluded_test_male.txt \
                 --make-bed \
                 --out $geno_plink_dir/all.onlyrsids.imputed.complete.male.test