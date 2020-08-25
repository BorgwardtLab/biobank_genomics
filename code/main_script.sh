#!/bin/bash

# -----------------------------------------------------------------------------------
#
# Preprocessing UK Biobank genotype_500k - Main file
#
# -----------------------------------------------------------------------------------
#
# This script prepares the code to create an HDF5 file from the original PLINK data
#
# Steps:
#   1. Convert with GCONV original files in .cal format to .ped
#   2. Create .raw file with an additive encoding
#   3. Convert the .raw file to HDF5
#
# First Version: July 2016, D. Roqueiro
#
# Adapted Version for UKBiobank 500K Data: February, 2020 L. Bourguignon
# With the contribution of C. Jutzeler and C. Weis
#
# -----------------------------------------------------------------------------------

source paths_and_parameters.sh

# -----------------------------------------------------------------------------------

# STEP 1 : select SNPs which have IDs

if [[ " ${STEPS_LIST[*]} " == *1* ]]; then
    bash ./steps_code/1_select_SNPs_with_IDs.sh
fi


# ----------------------------------OUTPUT-------------------------------------

# Note: Output from EULER when executing QCTOOL on chr 1 (largest) and chr 22 (smallest)
#   CHR 1 
#       Resource usage summary:
  
#       CPU time :               9678.50 sec.
#       Max Memory :             62401 MB
#       Average Memory :         47431.16 MB
#       Total Requested Memory : 24576.00 MB
#       Delta Memory :           -37825.00 MB
#       (Delta: the difference between Total Requested Memory and Max Memory.)
#       Max Processes :          3
#       Max Threads :            4
# Summary:
#   Number of samples: 152,249
#   Number of SNPs:     61,969
#   Avg. time per SNP:      ~1 microsecond

#   CHR 22
#       Resource usage summary:
      
#           CPU time :               1791.27 sec.
#           Max Memory :             32772 MB
#           Average Memory :         17599.02 MB
#           Total Requested Memory : 24576.00 MB
#           Delta Memory :           -8196.00 MB
#           (Delta: the difference between Total Requested Memory and Max Memory.)
#           Max Processes :          3
#           Max Threads :            4
# Summary:
#   Number of samples: 152,249
#   Number of SNPs:     12,622
#   Avg. time per SNP:      ~1 microsecond

# -----------------------------------------------------------------------------

# STEP 2 : convert .gen files to .ped and .map

if [[ " ${STEPS_LIST[*]} " == *2* ]]; then
    bash ./steps_code/2_convert_gen_pedmap.sh
fi

# ----------------------------------OUTPUT-------------------------------------



# -----------------------------------------------------------------------------

# STEP 3 : filter SNPs and samples and to convert .ped files to .bed

if [[ " ${STEPS_LIST[*]} " == *3* ]]; then
    bash ./steps_code/3_filter_and_convert.sh
fi

# ----------------------------------OUTPUT-------------------------------------



# -----------------------------------------------------------------------------

# STEP 4 : Run PLINK to merge all the individual chromosome files

if [[ " ${STEPS_LIST[*]} " == *4* ]]; then
    bash ./steps_code/4_merge_chr.sh
fi

# ----------------------------------OUTPUT-------------------------------------



# -----------------------------------------------------------------------------

# STEP 5 : Split into male and female

if [[ " ${STEPS_LIST[*]} " == *5* ]]; then
    bash ./steps_code/5_split_malefemale.sh
fi

# ----------------------------------OUTPUT-------------------------------------



# -----------------------------------------------------------------------------

# STEP 6 : Split into train and test

if [[ " ${STEPS_LIST[*]} " == *6* ]]; then
    bash ./steps_code/6_split_traintest.sh
fi

# ----------------------------------OUTPUT-------------------------------------



# -----------------------------------------------------------------------------

# STEP 7 : Extract based on phenotypes

if [[ " ${STEPS_LIST[*]} " == *7* ]]; then
    bash ./steps_code/7_filter_phenotype.sh
fi

# ----------------------------------OUTPUT-------------------------------------



# -----------------------------------------------------------------------------

# STEP 8 : Recode files

if [[ " ${STEPS_LIST[*]} " == *8* ]]; then
    bash ./steps_code/8_recode_additive.sh
fi

# ----------------------------------OUTPUT-------------------------------------



# -----------------------------------------------------------------------------

# STEP 9 : Convert to HDF5

if [[ " ${STEPS_LIST[*]} " == *9* ]]; then
    bash ./steps_code/9_convert_hdf5.sh
fi

# ----------------------------------OUTPUT-------------------------------------



# -----------------------------------------------------------------------------

