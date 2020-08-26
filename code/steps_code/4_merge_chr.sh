#!/bin/bash

# -----------------------------------------------------------------------------------
#
# Preprocessing UK Biobank genotype_500k - Step 4 file
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

# 4. Run PLINK to merge all the individual chromosome files
#  - Create a list of all .bed files created in the previous step
#  - Create one large (combined) .bed file using the list

# 4.1 Create a list of all the .bed files created in the previous step. The list is used in the merging step.
# If the list exists, then delete it and create an empty one

if [ -f "$geno_dir/plink/list_bed_files_to_merge_bis.txt" ]; then
    rm $geno_dir/plink/list_bed_files_to_merge_bis.txt
fi
touch $geno_dir/plink/list_bed_files_to_merge_bis.txt

# Populate the new list with the names of the chromosome files
for chr in $CHR_LIST
do
    ls $geno_dir/plink/c${chr}.onlyrsids.imputed.6.bed >> $geno_dir/plink/list_bed_files_to_merge_bis.txt
done

# Remove the file extensions in the previously created list
sed -i s/\.bed$//g $geno_dir/plink/list_bed_files_to_merge_bis.txt

# 4.2 Run PLINK to perform the merge
if [[ "$LOCATION" == "cluster" ]]
then
    bsub -W 3:59 -J "c${chr}_plink_merge" "$plink_dir/plink --merge-list $geno_dir/plink/list_bed_files_to_merge.txt --make-bed --out $geno_dir/plink/all.onlyrsids.imputed.correct"
else
    $plink_dir/plink --merge-list $geno_dir/plink/list_bed_files_to_merge_bis.txt \
            		 --make-bed \
            		 --out $geno_dir/plink/all.onlyrsids.imputed.correct
fi