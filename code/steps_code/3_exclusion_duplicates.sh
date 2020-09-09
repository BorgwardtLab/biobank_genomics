#!/bin/bash

# -----------------------------------------------------------------------------------
#
# Preprocessing UK Biobank genotype_500k - Step 3 file
#
# -----------------------------------------------------------------------------------
#
# This file contains script to remove duplicate SNPs and subjects that should be excluded from the analysis 
# (withdrawal from the study or do not meet inclusion criteria)
# This step assumes the existence of a file containing the ID of patients to exclude (list_ID_to_delete.txt)
#
# First Version: July 2016, D. Roqueiro
#
# Adapted Version for UKBiobank 500K Data: February, 2020 L. Bourguignon
# With the contribution of C. Jutzeler and C. Weis
#
# -----------------------------------------------------------------------------------

source paths_and_parameters.sh


# STEP 3.1 : convert files to .bed 
# --exclude and --remove flags require .bed files format

for chr in $CHR_LIST
do
	$plink_dir/plink --file $geno_dir/plink/c${chr}.onlyrsids.imputed \
        		     --make-bed \
                   	 --out $geno_dir/plink/c${chr}.onlyrsids.imputed.makebed
done


# STEP 3.2 : create a list of SNPs present in each chromosome file
for chr in $CHR_LIST
do
	$plink_dir/plink --bfile $geno_dir/plink/c${chr}.onlyrsids.imputed.makebed \
					 --write-snplist \
					 --out $geno_dir/plink/c${chr}
done

# STEP 3.3 : isolate the IDs of duplicates SNPs and sort them in a .txt file
for chr in $CHR_LIST
do
	sort -m $geno_dir/plink/c${chr}.snplist | uniq -d > $geno_dir/plink/c${chr}.duplicatestoberemoved.txt
done

# STEP 3.4 : extract IDs of subjects with ambiguous sex
for chr in $CHR_LIST
do
	sed -n '1,85p' < $geno_dir/plink/c${chr}.onlyrsids.imputed.makebed.fam > $geno_dir/plink/c${chr}.ambsex.txt
done

# STEP 3.5 : exclude subjects with ambiguous sex (--remove) and duplicates SNPs (--exclude)
for chr in $CHR_LIST
do
	$plink_dir/plink --bfile $geno_dir/plink/c${chr}.onlyrsids.imputed.makebed \
        		     --remove $geno_dir/plink/c${chr}.ambsex.txt \
        		     --exclude $geno_dir/plink/c${chr}.duplicatestoberemoved.txt \
        		     --make-bed \
                   	 --out $geno_dir/plink/c${chr}.onlyrsids.imputed.noduplicates
done

# STEP 3.6 : extract the entire information from subjects to delete based on their IDs, stored in list_ID_to_delete.txt
grep -w -F -f $geno_dir/plink/list_ID_to_delete.txt $geno_dir/plink/c1.onlyrsids.imputed.noduplicates.fam > $geno_dir/plink/excluded_participants_start.txt

for chr in $CHR_LIST
do
	$plink_dir/plink --bfile $geno_dir/plink/c${chr}.onlyrsids.imputed.noduplicates \
					 --remove $geno_dir/plink/excluded_participants_start.txt \
                   	 --make-bed \
                   	 --out $geno_dir/plink/c${chr}.onlyrsids.imputed.noduplicates.filtered
done