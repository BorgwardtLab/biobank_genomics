#!/bin/bash

# -----------------------------------------------------------------------------------
#
# Preprocessing UK Biobank genotype_500k - Step 7 file
#
# -----------------------------------------------------------------------------------
#
# This file contains script to split files into train and test files
# This step assumes the existence of a file containing 2 identical columns with the IDs of subjects to put in the test set
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

grep -w -F -f $geno_dir/plink/list_ID_scotland.txt $geno_dir/plink/all.onlyrsids.imputed.complete.female.fam > $geno_dir/plink/excluded_scotland_female.txt
grep -w -F -f $geno_dir/plink/list_ID_scotland.txt $geno_dir/plink/all.onlyrsids.imputed.complete.male.fam > $geno_dir/plink/excluded_scotland_male.txt

# Filter out Scottish centers in female file to get female train set
$plink_dir/plink --bfile $geno_dir/plink/all.onlyrsids.imputed.complete.female \
		     --remove $geno_dir/plink/excluded_scotland_female.txt \
                 --make-bed \
                 --out $geno_dir/plink/all.onlyrsids.imputed.complete.female.train

# Only keep Scottish centers in female file to get female test set
$plink_dir/plink --bfile $geno_dir/plink/all.onlyrsids.imputed.complete.female \
		     --keep $geno_dir/plink/excluded_scotland_female.txt \
                 --make-bed \
                 --out $geno_dir/plink/all.onlyrsids.imputed.complete.female.test

# Filter out Scottish centers in male file to get male train set
$plink_dir/plink --bfile $geno_dir/plink/all.onlyrsids.imputed.complete.male \
		     --remove $geno_dir/plink/excluded_scotland_male.txt \
                 --make-bed \
                 --out $geno_dir/plink/all.onlyrsids.imputed.complete.male.train

# Only keep Scottish centers in male file to get male test set
$plink_dir/plink --bfile $geno_dir/plink/all.onlyrsids.imputed.complete.male \
		     --keep $geno_dir/plink/excluded_scotland_male.txt \
                 --make-bed \
                 --out $geno_dir/plink/all.onlyrsids.imputed.complete.male.test