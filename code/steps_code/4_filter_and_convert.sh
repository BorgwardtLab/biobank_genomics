#!/bin/bash

# -----------------------------------------------------------------------------------
#
# Preprocessing UK Biobank genotype_500k - Step 4 file
#
# -----------------------------------------------------------------------------------
#
# This file contains script to filter SNPs & subjects based on call rate, minor allele frequency (MAF),
# linkage disequilibrium (LD) and Hardy-Weinberg equilibrium (HWE)
#
# First Version: July 2016, D. Roqueiro
#
# Adapted Version for UKBiobank 500K Data: February, 2020 L. Bourguignon
# With the contribution of C. Jutzeler and C. Weis
#
# -----------------------------------------------------------------------------------

source paths_and_parameters.sh

# 4. Run PLINK to filter SNPs and samples

# STEP 4.1 : SNP call rate, MAF & sample call rate

for chr in $CHR_LIST
do
	$plink_dir/plink --file $geno_dir/plink/c${chr}.onlyrsids.imputed.noduplicates.filtered \
        		     --geno $SNP_CALLRATE --maf $SNP_MAF --mind $SAMPLE_CALLRATE \
                   	 --make-bed \
                     --out $geno_dir/plink/c${chr}.onlyrsids.imputed.noduplicates.filtered.1
done

# STEP 4.2 : SNP - LD pruning (determine which SNPs to keep)

for chr in $CHR_LIST
do
	$plink_dir/plink --bfile $geno_dir/plink/c${chr}.onlyrsids.imputed.noduplicates.filtered.1 \
                   	 --indep-pairwise $LD_WINDOWSIZE['kb'] $LD_STEPSIZE['kb'] $LD_R2 \
					 --make-bed \
                 	 --out $geno_dir/plink/c${chr}.onlyrsids.imputed.noduplicates.filtered.2
done

# STEP 4.3 : SNP - LD pruning (remove SNPs that should not be kept in the analysis)
for chr in $CHR_LIST
do
	$plink_dir/plink --bfile $geno_dir/plink/c${chr}.onlyrsids.imputed.noduplicates.filtered.2 \
                   	 --extract $geno_dir/plink/c${chr}.onlyrsids.imputed.noduplicates.filtered.2.prune.in \
                   	 --make-bed \
                   	 --out $geno_dir/plink/c${chr}.onlyrsids.imputed.noduplicates.filtered.2.bis
done


# STEP 4.4 : SNP - HWE

for chr in $CHR_LIST
do
	$plink_dir/plink --bfile $geno_dir/plink/c${chr}.onlyrsids.imputed.noduplicates.filtered.2.bis \
					 --hwe $HWE \
                   	 --make-bed \
                   	 --out $geno_dir/plink/c${chr}.onlyrsids.imputed.noduplicates.filtered.3
done

