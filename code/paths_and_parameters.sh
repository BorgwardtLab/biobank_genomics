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
# User id
USER_ID=blucie
# List of chromosomes to process
##NOTE: Chromosome X is coded as 23, chromosome Y as 24, and chromosome XY as 25
#CHR_LIST=`echo 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22`
CHR_LIST=`echo 22`

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

# Main project directory
prj_dir=/links/groups/borgwardt/Data/UKBiobank

# Tools
oxford_dir=/links/groups/borgwardt/agkbshare/software/LINUX64/tools/oxford2
oxford_dir2=/links/groups/borgwardt/agkbshare/software/LINUX64/tools/oxford
plink_dir=/links/groups/borgwardt/agkbshare/software/LINUX64/tools/plink2
scripts_dir=$prj_dir/scripts/preprocess_data/Catherine/euler

# Genotype data
geno_dir=$prj_dir/genotype_500k/EGAD00010001497

# Imputed data
imp_dir=$prj_dir/genotype_500k/EGAD00010001474

# Output data
out_dir=$prj_dir/genotype_500k/plink_474_Lucie