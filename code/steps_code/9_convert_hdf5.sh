#!/bin/bash

# -----------------------------------------------------------------------------------
#
# Preprocessing UK Biobank genotype_500k - Step 9 file
#
# -----------------------------------------------------------------------------------
#
# This file contains script to convert data from PLINK formats to .hdf5
#
# First Version: July 2016, D. Roqueiro
#
# Adapted Version for UKBiobank 500K Data: February, 2020 L. Bourguignon
# With the contribution of C. Jutzeler and C. Weis
#
# -----------------------------------------------------------------------------------

source paths_and_parameters.sh

# 9. Convert to HDF5

# # MALE # # 

python ../convert_plink_raw_to_hdf5.py \
	       --plink_prefix $geno_plink_dir/all.onlyrsids.imputed.complete.male.train.filtered \
	       --raw_file $geno_plink_dir/all.onlyrsids.imputed.complete.male.train.filtered.raw \
	       --skip_rows 1 \
	       --naive_impute 0 \
	       --new_hdf5_file $out_dir/all.onlyrsids.imputed.complete.male.train.filtered.hdf5


# # FEMALE # # 

python ../convert_plink_raw_to_hdf5.py \
	       --plink_prefix $geno_plink_dir/all.onlyrsids.imputed.complete.female.train.filtered \
	       --raw_file $geno_plink_dir/all.onlyrsids.imputed.complete.female.train.filtered.raw \
	       --skip_rows 1 \
	       --naive_impute 0 \
	       --new_hdf5_file $out_dir/all.onlyrsids.imputed.complete.female.train.filtered.hdf5