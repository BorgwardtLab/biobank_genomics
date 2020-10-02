#!/bin/bash

# -----------------------------------------------------------------------------------
#
# Preprocessing UK Biobank genotype_500k - Step 8 file
#
# -----------------------------------------------------------------------------------
#
# This file contains script to filter based on project-specific requirements and recode according to the additive model
# This step assumes the existence of a file containing IDs of subjects to keep in project specific analysis 
# This file should be stored in prj_dir directory as specified in paths_and_parameters.sh script
# or modify the paths accordingly on lines 49 and 74
#
# First Version: July 2016, D. Roqueiro
#
# Adapted Version for UKBiobank 500K Data: February, 2020 L. Bourguignon
# With the contribution of C. Jutzeler and C. Weis
#
# -----------------------------------------------------------------------------------

source paths_and_parameters.sh

# 8. Filter based on project-specific requirements

#  Recode the genotypes to the additive model. Assuming that C is the minor allele for a given SNP, the additive model is:
#   SNP      Additive
#   ---      --------
#   A A   ->    0
#   A C   ->    1
#   C C   ->    2
#  It is basically the count of the minor allele
# Source: PLINK's online help page http://pngu.mgh.harvard.edu/~purcell/plink/dataman.shtml

if [ $SAMPLE_FILTER == `echo TRUE` ]; then
    if [ $SNP_FILTER == `echo FALSE` ]; then
      # # MALE # # 
      grep -w -F -f $prj_dir/included_IDs.txt $geno_plink_dir/all.onlyrsids.imputed.complete.male.train.fam > $prj_dir/extended_included_IDs_male.txt

      $plink_dir/plink --bfile $geno_plink_dir/all.onlyrsids.imputed.complete.male.train \
                       --keep $prj_dir/extended_included_IDs_male.txt\
                       --recode A \
                       --make-bed \
                       --out $geno_plink_dir/all.onlyrsids.imputed.complete.male.train.filtered


      # # FEMALE # #
      grep -w -F -f $prj_dir/included_IDs.txt $geno_plink_dir/all.onlyrsids.imputed.complete.female.train.fam > $prj_dir/extended_included_IDs_female.txt

      $plink_dir/plink --bfile $geno_plink_dir/all.onlyrsids.imputed.complete.female.train \
                       --keep $prj_dir/extended_included_IDs_female.txt\
                       --recode A \
                       --make-bed \
                       --out $geno_plink_dir/all.onlyrsids.imputed.complete.female.train.filtered
    fi
fi


if [ $SAMPLE_FILTER == `echo FALSE` ]; then
    if [ $SNP_FILTER == `echo TRUE` ]; then
      # # MALE # # 
      $plink_dir/plink --bfile $geno_plink_dir/all.onlyrsids.imputed.complete.male.train \
                       --snps $SNPS_TO_INCLUDE \
                       --recode A \
                       --make-bed \
                       --out $geno_plink_dir/all.onlyrsids.imputed.complete.male.train.filtered


      # # FEMALE # #
      $plink_dir/plink --bfile $geno_plink_dir/all.onlyrsids.imputed.complete.female.train \
                       --snps $SNPS_TO_INCLUDE \
                       --recode A \
                       --make-bed \
                       --out $geno_plink_dir/all.onlyrsids.imputed.complete.female.train.filtered
    fi
fi


if [ $SAMPLE_FILTER == `echo TRUE` ]; then
    if [ $SNP_FILTER == `echo TRUE` ]; then
      # # MALE # # 
      grep -w -F -f $prj_dir/included_IDs.txt $geno_plink_dir/all.onlyrsids.imputed.complete.male.train.fam > $prj_dir/extended_included_IDs_male.txt

      $plink_dir/plink --bfile $geno_plink_dir/all.onlyrsids.imputed.complete.male.train \
                       --keep $prj_dir/extended_included_IDs_male.txt\
                       --snps $SNPS_TO_INCLUDE \
                       --recode A \
                       --make-bed \
                       --out $geno_plink_dir/all.onlyrsids.imputed.complete.male.train.filtered


      # # FEMALE # #
      grep -w -F -f $prj_dir/included_IDs.txt $geno_plink_dir/all.onlyrsids.imputed.complete.female.train.fam > $prj_dir/extended_included_IDs_female.txt

      $plink_dir/plink --bfile $geno_plink_dir/all.onlyrsids.imputed.complete.female.train \
                       --keep $prj_dir/extended_included_IDs_female.txt\
                       --snps $SNPS_TO_INCLUDE \
                       --recode A \
                       --make-bed \
                       --out $geno_plink_dir/all.onlyrsids.imputed.complete.female.train.filtered
    fi
fi


if [ $SAMPLE_FILTER == `echo FALSE` ]; then
    if [ $SNP_FILTER == `echo FALSE` ]; then
      # # MALE # # 
      $plink_dir/plink --bfile $geno_plink_dir/all.onlyrsids.imputed.complete.male.train \
                       --recode A \
                       --make-bed \
                       --out $geno_plink_dir/all.onlyrsids.imputed.complete.male.train.filtered


      # # FEMALE # #
      $plink_dir/plink --bfile $geno_plink_dir/all.onlyrsids.imputed.complete.female.train \
                       --recode A \
                       --make-bed \
                       --out $geno_plink_dir/all.onlyrsids.imputed.complete.female.train.filtered
    fi
fi
