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

name_additive=()
name_additive_raw=()
name_hdf5=()
for i in angina any_allowance any_heart_d any_household any_trauma attendance blue_badge cancer child death_partner death_relative diabetes disability divorce finance grandchild grandparent hbp health_fair health_good health_poor heart_attack nb_cars_1 nb_cars_2 nb_cars_3 nb_cars_4 nb_household_1 nb_household_2 oth_related pace_ave pace_brisk pace_none parent partner serious_relative serious_yourself siblings smoke_now_most smoke_now_occ smoke_past_never smoke_past_occ smoke_past_try stroke unrelated ; do
	name_additive_raw[i]="all.onlyrsids.imputed.correct.male.train.$i.raw"
	name_additive[i]="all.onlyrsids.imputed.correct.male.train.$i"
	name_hdf5[i]="all.onlyrsids.imputed.correct.male.train.$i.hdf5"
	python $prj_dir/scripts/preprocess_data/Catherine/convert_plink_raw_to_hdf5.py \
	          --plink_prefix $geno_dir/plink/${name_additive[i]} \
	          --raw_file $geno_dir/plink/${name_additive_raw[i]}\
	          --skip_rows 1 \
	          --naive_impute 0 \
	          --new_hdf5_file $geno_dir/hdf5/${name_hdf5[i]}
done


# # FEMALE # # 

name_additive=()
name_additive_raw=()
name_hdf5=()

for i in any_allowance any_trauma attendance blue_badge cancer death_partner death_relative depression disability divorce finance health_fair health_good health_poor nb_child_1 nb_child_2 nb_child_3 pace_ave pace_brisk pace_none serious_relative serious_yourself smoke_now_most smoke_now_occ smoke_past_never smoke_past_occ smoke_past_try ; do
	name_additive_raw[i]="all.onlyrsids.imputed.correct.female.train.$i.raw"
	name_additive[i]="all.onlyrsids.imputed.correct.female.train.$i"
	name_hdf5[i]="all.onlyrsids.imputed.correct.female.train.$i.hdf5"
	python $prj_dir/scripts/preprocess_data/Catherine/convert_plink_raw_to_hdf5.py \
	          --plink_prefix $geno_dir/plink/${name_additive[i]} \
	          --raw_file $geno_dir/plink/${name_additive_raw[i]}\
	          --skip_rows 1 \
	          --naive_impute 0 \
	          --new_hdf5_file $geno_dir/hdf5/${name_hdf5[i]}
done