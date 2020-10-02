#!/bin/bash

# -----------------------------------------------------------------------------------
#
# Preprocessing UK Biobank genotype_500k - Paths and parameters file
#
# -----------------------------------------------------------------------------------
#
# This file contains paths where raw data are stored
#
# First Version: July 2016, D. Roqueiro
#
# Adapted Version for UKBiobank 500K Data: February, 2020 L. Bourguignon
# With the contribution of C. Jutzeler and C. Weis
#
# -----------------------------------------------------------------------------------

# Parameters

# List of chromosomes to process
##NOTE: Chromosome X is coded as 23, chromosome Y as 24, and chromosome XY as 25
CHR_LIST=`echo 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22`

# # List of steps to perform
# STEPS_LIST=`echo 1 2 3 4 5 6 7 8 9`

# Parameters to filter SNPs and samples
SNP_CALLRATE=`echo 0.05`
SNP_MAF=`echo 0.01`
SAMPLE_CALLRATE=`echo 0.05`
LD_WINDOWSIZE=`echo 1000`
LD_STEPSIZE=`echo 500`
LD_R2=`echo 0.04`
HWE=`echo 1e-6`

# Should project-specific filters should be applied?
SNP_FILTER=`echo FALSE` # if TRUE, provide IDs of SNPs to include in SNPS_TO_INCLUDE parameter; supported values are 'TRUE' or 'FALSE'
SNPS_TO_INCLUDE=`echo ` # e.g. SNPS_TO_INCLUDE=`echo rs4970382 rs78164078` 
SAMPLE_FILTER=`echo FALSE` # if TRUE, provide IDs of subjects to be included in .txt file under prj_dir directory; supported values are 'TRUE' or 'FALSE'

# Main project directory
prj_dir=~/UKBiobank

# Tools
oxford_dir=~/software/LINUX64/tools/oxford2 # path to qctool software
oxford_dir2=~/software/LINUX64/tools/oxford # path to gtool software
plink_dir=~/software/LINUX64/tools/plink2 # path to plink software

# Genotype data
# This folder should contain two folders: gen and plink, to store outputs from gctool and plink respectively
geno_dir=$prj_dir/genotype_500k/genome
geno_plink_dir=$geno_dir/plink
geno_gen_dir=$geno_dir/gen

# Imputed data
imp_dir=$prj_dir/genotype_500k/imputed_genome

# Output data
out_dir=$prj_dir/final_output_hdf5