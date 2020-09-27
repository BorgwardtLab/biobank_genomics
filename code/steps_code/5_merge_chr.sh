#!/bin/bash

# -----------------------------------------------------------------------------------
#
# Preprocessing UK Biobank genotype_500k - Step 5 file
#
# -----------------------------------------------------------------------------------
#
# This file contains script to merge chromosomes into one file to process
#
# First Version: July 2016, D. Roqueiro
#
# Adapted Version for UKBiobank 500K Data: February, 2020 L. Bourguignon
# With the contribution of C. Jutzeler and C. Weis
#
# -----------------------------------------------------------------------------------

source paths_and_parameters.sh

# 5. Run PLINK to merge all the individual chromosome files
#  - Create a list of all .bed files created in the previous step
#  - Create one large (combined) .bed file using the list

# STEP 5.1 Create a list of all the .bed files created in the previous step. The list is used in the merging step.
# If the list exists, then delete it and create an empty one

if [ -f "$geno_plink_dir/list_bed_files_to_merge_bis.txt" ]; then
    rm $geno_plink_dir/list_bed_files_to_merge_bis.txt
fi
touch $geno_plink_dir/list_bed_files_to_merge_bis.txt

# Populate the new list with the names of the chromosome files
for chr in $CHR_LIST
do
    ls $geno_plink_dir/c${chr}.onlyrsids.imputed.noduplicates.filtered.3.bed >> $geno_plink_dir/list_bed_files_to_merge_bis.txt
done

# Remove the file extensions in the previously created list
sed -i s/\.bed$//g $geno_plink_dir/list_bed_files_to_merge_bis.txt

# STEP 5.2 Run PLINK to perform the merge

$plink_dir/plink --merge-list $geno_plink_dir/list_bed_files_to_merge_bis.txt \
            	 --make-bed \
            	 --out $geno_plink_dir/all.onlyrsids.imputed.complete