#!/bin/bash

# -----------------------------------------------------------------------------------
#
# Preprocessing UK Biobank genotype_500k - Step 3 file
#
# -----------------------------------------------------------------------------------
#
# This file contains script to select SNPs which have IDs
#
# First Version: July 2016, D. Roqueiro
#
# Adapted Version for UKBiobank 500K Data: February, 2020 L. Bourguignon
# With the contribution of C. Jutzeler and C. Weis
#
# -----------------------------------------------------------------------------------

source paths_and_parameters.sh

# 3. Run PLINK to filter SNPs and samples and to convert .ped files to .bed
# Filter SNPs and convert .ped to .bed

# STEP 3.1 : SNP - call rate

for chr in $CHR_LIST
do
    if [[ "$LOCATION" == "cluster" ]]
    then
        bsub -W 3:59 -R "rusage[mem=99328]" -J "c${chr}_plink_ped2bed" "$plink_dir/plink --file $geno_dir/plink/c${chr}.onlyrsids.imputed --geno 0.05 --make-bed --out $geno_dir/plink/c${chr}.onlyrsids.imputed.1"
    else
        $plink_dir/plink --file $geno_dir/plink/c${chr}.onlyrsids.imputed \
        		     	 --geno 0.05 \
                   	     --make-bed \
                    	 --out $geno_dir/plink/c${chr}.onlyrsids.imputed.1
    fi
done


# STEP 3.2 : SNP - MAF

for chr in $CHR_LIST
do
    if [[ "$LOCATION" == "cluster" ]]
    then
        bsub -W 3:59 -R "rusage[mem=99328]" -J "c${chr}_plink_ped2bed" "$plink_dir/plink --bfile $geno_dir/plink/c${chr}.onlyrsids.imputed.1 --maf 0.01 --make-bed --out $geno_dir/plink/c${chr}.onlyrsids.imputed.2"
    else
        $plink_dir/plink --bfile $geno_dir/plink/c${chr}.onlyrsids.imputed.1 \
        		     	 --maf 0.01 \
                   	     --make-bed \
                   	     --out $geno_dir/plink/c${chr}.onlyrsids.imputed.2
    fi
done


# STEP 3.3 : sample - call rate

for chr in $CHR_LIST
do
    if [[ "$LOCATION" == "cluster" ]]
    then
        bsub -W 3:59 -R "rusage[mem=99328]" -J "c${chr}_plink_ped2bed" "$plink_dir/plink --bfile $geno_dir/plink/c${chr}.onlyrsids.imputed.2 --mind 0.05 --make-bed --out $geno_dir/plink/c${chr}.onlyrsids.imputed.3"
    else
        $plink_dir/plink --bfile $geno_dir/plink/c${chr}.onlyrsids.imputed.2 \
        		     	 --mind 0.05 \
                   	     --make-bed \
                   	     --out $geno_dir/plink/c${chr}.onlyrsids.imputed.3
    fi
done


# STEP 3.4 : sample - UK Biobank datafields : heterozygosity, sex discordance and aneuploidy, relatedness

# Filter out all SNPs with 0 or NAs; remove subjects with ambiguous sex
# Create list of SNPs to be filtered out
# 1. Extract SNP column from allrsidsbeforemerge.bim file. 
	awk '{print $2}' $geno_dir/plink/allrsidsbeforemerge.bim > $geno_dir/plink/allrsids.txt

# 2. Filter SNPs duplicates
	sort -m $geno_dir/plink/allrsids.txt | uniq -d > $geno_dir/plink/duplicatestoberemoved.txt

# 3. Extract IDs of subjects with ambiguous sex
	sed -n '1,85p' < $geno_dir/plink/all.onlyrsids.imputed.filtered.pruned.fam > $geno_dir/plink/ambsex.txt

# Remove subjects with ambiguous sex from file using --remove flag. NOTE: The --remove flag only works if the ambsex.txt file has the same number of columns as the all.onlyrsids.imputed.filtered file.
for chr in $CHR_LIST
do
	if [[ "$LOCATION" == "cluster" ]]
	then
		bsub -W 3:59 -J "all_plink_redo" "$plink_dir/plink --bfile $geno_dir/plink/c${chr}.onlyrsids.imputed.3 --remove $geno_dir/plink/ambsex.txt --exclude $geno_dir/plink/duplicatestoberemoved.txt --make-bed --out $geno_dir/plink/c${chr}.onlyrsids.imputed.4"
	else
		$plink_dir/plink --bfile $geno_dir/plink/c${chr}.onlyrsids.imputed.3 \
	            		 --remove $geno_dir/plink/ambsex.txt\
	            		 --exclude $geno_dir/plink/duplicatestoberemoved.txt\
	           			 --make-bed \
	           			 --out $geno_dir/plink/c${chr}.onlyrsids.imputed.4
	fi
done

grep -w -F -f $geno_dir/plink/list_ID_to_delete.txt $geno_dir/plink/all.onlyrsids.imputed.filtered.pruned.fam > $geno_dir/plink/excluded_participants.txt

for chr in $CHR_LIST
do
    if [[ "$LOCATION" == "cluster" ]]
    then
        bsub -W 3:59 -R "rusage[mem=99328]" -J "c${chr}_plink_ped2bed" "$plink_dir/plink --bfile $geno_dir/plink/c${chr}.onlyrsids.imputed.4 --remove $geno_dir/plink/excluded_participants.txt --make-bed --out $geno_dir/plink/c${chr}.onlyrsids.imputed.4.bis"
    else
        $plink_dir/plink --bfile $geno_dir/plink/c${chr}.onlyrsids.imputed.4 \
						 --remove $geno_dir/plink/excluded_participants.txt\
                   	     --make-bed \
                   	     --out $geno_dir/plink/c${chr}.onlyrsids.imputed.4.bis
    fi
done


# STEP 3.5 : SNP - LD pruning

for chr in $CHR_LIST
do
    if [[ "$LOCATION" == "cluster" ]]
    then
        bsub -W 3:59 -R "rusage[mem=99328]" -J "c${chr}_plink_ped2bed" "$plink_dir/plink --bfile $geno_dir/plink/c${chr}.onlyrsids.imputed.4.bis --indep-pairwise 1000['kb'] 500['kb'] 0.04 --make-bed --out $geno_dir/plink/c${chr}.onlyrsids.imputed.5"
    else
        $plink_dir/plink --bfile $geno_dir/plink/c${chr}.onlyrsids.imputed.4.bis \
                   	     --indep-pairwise 1000['kb'] 500['kb'] 0.04 \
						 --make-bed \
                 		 --out $geno_dir/plink/c${chr}.onlyrsids.imputed.5
    fi
done

for chr in $CHR_LIST
do
    if [[ "$LOCATION" == "cluster" ]]
    then
        bsub -W 3:59 -R "rusage[mem=99328]" -J "c${chr}_plink_ped2bed" "$plink_dir/plink --file $geno_dir/plink/c${chr}.onlyrsids.imputed --geno 0.05 --maf 0.01 --hwe 1e-6 --extract $geno_dir/plink/c${chr}.onlyrsids.imputed.filtered.prune.in --make-bed --out $geno_dir/plink/c${chr}.onlyrsids.imputed.filtered.pruned"
    else
        $plink_dir/plink --bfile $geno_dir/plink/c${chr}.onlyrsids.imputed.5 \
                   	     --extract $geno_dir/plink/c${chr}.onlyrsids.imputed.5.prune.in \
                   	     --make-bed \
                   	     --out $geno_dir/plink/c${chr}.onlyrsids.imputed.5.bis
    fi
done


# STEP 3.6 : SNP - HWE

for chr in $CHR_LIST
do
    if [[ "$LOCATION" == "cluster" ]]
    then
        bsub -W 3:59 -R "rusage[mem=99328]" -J "c${chr}_plink_ped2bed" "$plink_dir/plink --bfile $geno_dir/plink/c${chr}.onlyrsids.imputed.5.bis --hwe 1e-6 --make-bed --out $geno_dir/plink/c${chr}.onlyrsids.imputed.6"
    else
        $plink_dir/plink --bfile $geno_dir/plink/c${chr}.onlyrsids.imputed.5.bis \
					 	 --hwe 1e-6 \
                   	     --make-bed \
                   	     --out $geno_dir/plink/c${chr}.onlyrsids.imputed.6
    fi
done

