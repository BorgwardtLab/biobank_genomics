#!/bin/bash

# ------------------------------------------------------------------------------------
#
# Preprocessing UK Biobank genotype_500k - Main file
#
# ------------------------------------------------------------------------------------
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
# ------------------------------------------------------------------------------------

source paths_and_parameters.sh

# ------------------------------------------------------------------------------------

# STEP 1 : Select SNPs which have IDs

bash ./steps_code/1_select_SNPs_with_IDs.sh

# -----------------------------------EXAMPLE-OUTPUT-----------------------------------

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

# ------------------------------------------------------------------------------------

# STEP 2 : Convert .gen files to .ped and .map

bash ./steps_code/2_convert_gen_pedmap.sh

# -----------------------------------EXAMPLE-OUTPUT-----------------------------------


# ------------------------------------------------------------------------------------

# STEP 3 : Remove duplicate SNPs and subjects excluded from analysis (withdrawal, do not meet inclusion criteria)

bash ./steps_code/3_exclusion_duplicates.sh

# -----------------------------------EXAMPLE-OUTPUT-----------------------------------



# ------------------------------------------------------------------------------------

# STEP 4 : Filter SNPs & subjects based on call rate, minor allele frequency (MAF), linkage disequilibrium (LD) and Hardy-Weinberg equilibrium (HWE)

bash ./steps_code/4_filter_and_convert.sh

# -----------------------------------EXAMPLE-OUTPUT-----------------------------------



# ------------------------------------------------------------------------------------

# STEP 5 : Run PLINK to merge all the individual chromosome files

bash ./steps_code/5_merge_chr.sh

# -----------------------------------EXAMPLE-OUTPUT-----------------------------------



# ------------------------------------------------------------------------------------

# STEP 6 : Split into male and female

bash ./steps_code/6_split_malefemale.sh

# -----------------------------------EXAMPLE-OUTPUT-----------------------------------



# ------------------------------------------------------------------------------------

# STEP 7 : Split into train and test

bash ./steps_code/7_split_traintest.sh

# -----------------------------------EXAMPLE-OUTPUT-----------------------------------



# ------------------------------------------------------------------------------------

# STEP 8 : Extract based on phenotypes

bash ./steps_code/8_filter_phenotype.sh

# -----------------------------------EXAMPLE-OUTPUT-----------------------------------



# ------------------------------------------------------------------------------------

# STEP 9 : Convert to HDF5

bash ./steps_code/9_convert_hdf5.sh

# -----------------------------------EXAMPLE-OUTPUT-----------------------------------



# ------------------------------------------------------------------------------------

