#!/bin/bash

# -----------------------------------------------------------------------------------
#
# Preprocessing UK Biobank genotype_500k - Step 2 file
#
# -----------------------------------------------------------------------------------
#
# This file contains script to convert files into .ped and .map
#
# First Version: July 2016, D. Roqueiro
#
# Adapted Version for UKBiobank 500K Data: February, 2020 L. Bourguignon
# With the contribution of C. Jutzeler and C. Weis
#
# -----------------------------------------------------------------------------------

source paths_and_parameters.sh

# 2. Convert the .gen files to .ped and .map
# Run GTOOL to perform the conversion

for chr in $CHR_LIST
do

        $oxford_dir2/gtool \
            -G --g $geno_dir/gen/c${chr}.onlyrsids.imputed.gen \
            --s $imp_dir/ukb_imp_chr${chr}_v3.sample\
            --ped $geno_dir/plink/c${chr}.onlyrsids.imputed.ped \
            --map $geno_dir/plink/c${chr}.onlyrsids.imputed.map \
            --threshold 0.1
  
done