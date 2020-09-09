#!/bin/bash

# -----------------------------------------------------------------------------------
#
# Preprocessing UK Biobank genotype_500k - Step 8 file
#
# -----------------------------------------------------------------------------------
#
# This file contains script to filter based on project-specific requirements and recode according to the additive model
#
# First Version: July 2016, D. Roqueiro
#
# Adapted Version for UKBiobank 500K Data: February, 2020 L. Bourguignon
# With the contribution of C. Jutzeler and C. Weis
#
# -----------------------------------------------------------------------------------

source paths_and_parameters.sh

# 8. Extract based on phenotypes

#  Recode the genotypes to the additive model. Assuming that C is the minor allele for a given SNP, the additive model is:
#   SNP      Additive
#   ---      --------
#   A A   ->    0
#   A C   ->    1
#   C C   ->    2
#  It is basically the count of the minor allele
# Source: PLINK's online help page http://pngu.mgh.harvard.edu/~purcell/plink/dataman.shtml

# # MALE # # 
groups=()
excluded_participants=()
groups_init=()
excluded_participants_init=()
name=() # declare an empty array; same as: declare -a groups
for i in angina any_allowance any_heart_d any_household any_trauma attendance blue_badge cancer child death_partner death_relative diabetes disability divorce finance grandchild grandparent hbp health_fair health_good health_poor heart_attack nb_cars_1 nb_cars_2 nb_cars_3 nb_cars_4 nb_household_1 nb_household_2 oth_related pace_ave pace_brisk pace_none parent partner serious_relative serious_yourself siblings smoke_now_most smoke_now_occ smoke_past_never smoke_past_occ smoke_past_try stroke unrelated ; do
  groups_init[i]="list_ID_$i"
  groups[i]="${groups_init[i]}_male"
  excluded_participants_init[i]="excluded_participants_$i"
  excluded_participants[i]="${excluded_participants_init[i]}_male"
  name[i]="all.onlyrsids.imputed.complete.male.train.$i"

   echo ${groups[i]}

   grep -w -F -f $geno_dir/plink/${groups[i]}.txt $geno_dir/plink/all.onlyrsids.imputed.complete.male.train.fam > $geno_dir/plink/${excluded_participants[i]}.txt

   $plink_dir/plink --bfile $geno_dir/plink/all.onlyrsids.imputed.complete.male.train \
	                --keep $geno_dir/plink/${excluded_participants[i]}.txt\
	                --recode A \
	                --make-bed \
	                --out $geno_dir/plink/${name[i]}
done


# # FEMALE # # 
groups=()
excluded_participants=()
groups_init=()
excluded_participants_init=()
name=() # declare an empty array; same as: declare -a groups
for i in any_allowance any_trauma attendance blue_badge cancer death_partner death_relative depression disability divorce finance health_fair health_good health_poor nb_child_1 nb_child_2 nb_child_3 pace_ave pace_brisk pace_none serious_relative serious_yourself smoke_now_most smoke_now_occ smoke_past_never smoke_past_occ smoke_past_try ; do
  groups_init[i]="list_ID_$i"
  groups[i]="${groups_init[i]}_female"
  excluded_participants_init[i]="excluded_participants_$i"
  excluded_participants[i]="${excluded_participants_init[i]}_female"
  name[i]="all.onlyrsids.imputed.complete.female.train.$i"

  echo ${groups[i]}

  grep -w -F -f $geno_dir/plink/${groups[i]}.txt $geno_dir/plink/all.onlyrsids.imputed.correct.female.fam > $geno_dir/plink/${excluded_participants[i]}.txt

  $plink_dir/plink --bfile $geno_dir/plink/all.onlyrsids.imputed.correct.female.train \
	               --keep $geno_dir/plink/${excluded_participants[i]}.txt\
	               --recode A \
	               --make-bed \
	               --out $geno_dir/plink/${name[i]}
done