#!/bin/bash

# -----------------------------------------------------------------------------------
#
# Preprocessing UK Biobank genotype_500k - Step 1 file
#
# -----------------------------------------------------------------------------------
#
# This file contains script to select SNPs which have IDs
#
# First Version: July 2016, D. Roqueiro
#
# Adapted Version for UKBiobank 500K Data: February, 2020 L. Bourguignon
# With the contribution of C. Jutzeler and C. Weis
#
# -----------------------------------------------------------------------------------

source paths_and_parameters.sh


# 1. Traverse the .bim files and create a list of SNPs with rs Ids
# Note: Exclude SNPs that do not have rs Ids from the analysis 

# IMPORTANT: <Ctrl.v+TAB> need to be replaced and executed before executing in the command line
 for chr in $CHR_LIST
 do
    grep "${chr}  rs" $geno_dir/ukb_snp_chr${chr}_v2.bim > $out_dir/c${chr}.onlyrsids.bim

    # Create a list of SNPs to be used when extracting genotypes from the imputed data (next step)
    awk '{print $2}' $out_dir/c${chr}.onlyrsids.bim > $out_dir/c${chr}.onlyrsids.txt

    # Get a count of lines before and after
    wc -l $geno_dir/ukb_snp_chr${chr}_v2.bim $out_dir/c${chr}.onlyrsids.txt
done


# Extract from the imputed files the genotypes of the SNPs in the files cXX.onlyrsids.map
# Note: The original .cal files have missing genotypes for certain SNPs and samples. 
#       This step is done to avoid having missing values in the genotype data

# -g -> Path of gen file(s) to input.
# -s -> Path of sample file to input. If specified, this option must occur as often as the -g option to specify one sample file per cohort.
# -incl-rsids -> Exclude all SNPs whose RSID is not in the given file(s) from the analysis.
# -omit-chromosome ->   (This option is specific to output files in the GEN format.) Do not output a chromosome column.
# -og -> Specify that qctool should write an output genotype file with the specified filename. The type of this file will be determined from the filename extension. 
# -log -> Specify that qctool should write a log file to the given file.

#######################################
#### DON'T RUN THIS STEP ON EULER #####
#######################################

for chr in $CHR_LIST

do
    $oxford_dir/qctool\
        -g $imp_dir/ukb_imp_chr${chr}_v3.bgen\
        -s $imp_dir/ukb_imp_chr${chr}_v3.sample\
        -incl-rsids $out_dir/c${chr}.onlyrsids.txt\
        -omit-chromosome\
        -og $geno_dir/gen/c${chr}.onlyrsids.imputed.gen\
        -log $geno_dir/gen/c${chr}.onlyrsids.imputed.log &
done
