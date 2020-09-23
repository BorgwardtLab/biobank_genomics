# Output examples

## Step 1

Note: Output from [EULER cluster](https://scicomp.ethz.ch/wiki/Euler) when executing QCTOOL on chr 1 (largest) and chr 22 (smallest)

```
   CHR 1 
       Resource usage summary:
  
       CPU time :               9678.50 sec.
       Max Memory :             62401 MB
       Average Memory :         47431.16 MB
       Total Requested Memory : 24576.00 MB
       Delta Memory :           -37825.00 MB
       (Delta: the difference between Total Requested Memory and Max Memory.)
       Max Processes :          3
       Max Threads :            4
 Summary:
   Number of samples: 152,249
   Number of SNPs:     61,969
   Avg. time per SNP:      ~1 microsecond

   CHR 22
       Resource usage summary:
      
           CPU time :               1791.27 sec.
           Max Memory :             32772 MB
           Average Memory :         17599.02 MB
           Total Requested Memory : 24576.00 MB
           Delta Memory :           -8196.00 MB
           (Delta: the difference between Total Requested Memory and Max Memory.)
           Max Processes :          3
           Max Threads :            4
 Summary:
   Number of samples: 152,249
   Number of SNPs:     12,622
   Avg. time per SNP:      ~1 microsecond
```

## Step 2

```

```

## Step 3

```
PLINK v1.90b3d 64-bit (10 Feb 2015)        https://www.cog-genomics.org/plink2
(C) 2005-2015 Shaun Purcell, Christopher Chang   GNU General Public License v3
Logging to $out_dir/c22.onlyrsids.imputed.makebed.log.
515868 MB RAM detected; reserving 257934 MB for main workspace.
.ped scan complete (for binary autoconversion).
Performing single-pass .bed write (11923 variants, 487409 people).
--file:
$out_dir/c22.onlyrsids.imputed.makebed-temporary.bed
+
$out_dir/c22.onlyrsids.imputed.makebed-temporary.bim
+
$out_dir/c22.onlyrsids.imputed.makebed-temporary.fam
written.
11923 variants loaded from .bim file.
487409 people (223006 males, 264318 females, 85 ambiguous) loaded from .fam.
Ambiguous sex IDs written to
$out_dir/c22.onlyrsids.imputed.makebed.nosex
.
Using 1 thread (no multithreaded calculations invoked).
Before main variant filters, 487409 founders and 0 nonfounders present.
Calculating allele frequencies... done.
11923 variants and 487409 people pass filters and QC.
Note: No phenotypes present.
--make-bed to
$out_dir/c22.onlyrsids.imputed.makebed.bed
+
$out_dir/c22.onlyrsids.imputed.makebed.bim
+
$out_dir/c22.onlyrsids.imputed.makebed.fam
... done.
PLINK v1.90b3d 64-bit (10 Feb 2015)        https://www.cog-genomics.org/plink2
(C) 2005-2015 Shaun Purcell, Christopher Chang   GNU General Public License v3
Logging to $out_dir/c22.log.
515868 MB RAM detected; reserving 257934 MB for main workspace.
11923 variants loaded from .bim file.
487409 people (223006 males, 264318 females, 85 ambiguous) loaded from .fam.
Ambiguous sex IDs written to
$out_dir/c22.nosex
.
Using 1 thread (no multithreaded calculations invoked).
Before main variant filters, 487409 founders and 0 nonfounders present.
Calculating allele frequencies... done.
11923 variants and 487409 people pass filters and QC.
Note: No phenotypes present.
List of variant IDs written to
$out_dir/c22.snplist
.
PLINK v1.90b3d 64-bit (10 Feb 2015)        https://www.cog-genomics.org/plink2
(C) 2005-2015 Shaun Purcell, Christopher Chang   GNU General Public License v3
Logging to $out_dir/c22.onlyrsids.imputed.noduplicates.log.
515868 MB RAM detected; reserving 257934 MB for main workspace.
11923 variants loaded from .bim file.
487409 people (223006 males, 264318 females, 85 ambiguous) loaded from .fam.
Ambiguous sex IDs written to
$out_dir/c22.onlyrsids.imputed.noduplicates.nosex
.
--exclude: 11859 variants remaining.
--remove: 487324 people remaining.
Using 1 thread (no multithreaded calculations invoked).
Before main variant filters, 487324 founders and 0 nonfounders present.
Calculating allele frequencies... done.
11859 variants and 487324 people pass filters and QC.
Note: No phenotypes present.
--make-bed to
$out_dir/c22.onlyrsids.imputed.noduplicates.bed
+
$out_dir/c22.onlyrsids.imputed.noduplicates.bim
+
$out_dir/c22.onlyrsids.imputed.noduplicates.fam
... done.
PLINK v1.90b3d 64-bit (10 Feb 2015)        https://www.cog-genomics.org/plink2
(C) 2005-2015 Shaun Purcell, Christopher Chang   GNU General Public License v3
Logging to $out_dir/c22.onlyrsids.imputed.noduplicates.filtered.log.
515868 MB RAM detected; reserving 257934 MB for main workspace.
11859 variants loaded from .bim file.
487324 people (223006 males, 264318 females) loaded from .fam.
--remove: 429874 people remaining.
Using 1 thread (no multithreaded calculations invoked).
Before main variant filters, 429874 founders and 0 nonfounders present.
Calculating allele frequencies... done.
11859 variants and 429874 people pass filters and QC.
Note: No phenotypes present.
--make-bed to
$out_dir/c22.onlyrsids.imputed.noduplicates.filtered.bed
+
$out_dir/c22.onlyrsids.imputed.noduplicates.filtered.bim
+
$out_dir/c22.onlyrsids.imputed.noduplicates.filtered.fam
... done.
```

## Step 4

```
PLINK v1.90b3d 64-bit (10 Feb 2015)        https://www.cog-genomics.org/plink2
(C) 2005-2015 Shaun Purcell, Christopher Chang   GNU General Public License v3
Logging to $out_dir/c22.onlyrsids.imputed.noduplicates.filtered.1.log.
515868 MB RAM detected; reserving 257934 MB for main workspace.
11859 variants loaded from .bim file.
429874 people (197261 males, 232613 females) loaded from .fam.
0 people removed due to missing genotype data (--mind).
Using 1 thread (no multithreaded calculations invoked).
Before main variant filters, 429874 founders and 0 nonfounders present.
Calculating allele frequencies... done.
0 variants removed due to missing genotype data (--geno).
1546 variants removed due to minor allele threshold(s)
(--maf/--max-maf/--mac/--max-mac).
10313 variants and 429874 people pass filters and QC.
Note: No phenotypes present.
--make-bed to
$out_dir/c22.onlyrsids.imputed.noduplicates.filtered.1.bed
+
$out_dir/c22.onlyrsids.imputed.noduplicates.filtered.1.bim
+
$out_dir/c22.onlyrsids.imputed.noduplicates.filtered.1.fam
... done.
PLINK v1.90b3d 64-bit (10 Feb 2015)        https://www.cog-genomics.org/plink2
(C) 2005-2015 Shaun Purcell, Christopher Chang   GNU General Public License v3
Logging to $out_dir/c22.onlyrsids.imputed.noduplicates.filtered.2.log.
515868 MB RAM detected; reserving 257934 MB for main workspace.
10313 variants loaded from .bim file.
429874 people (197261 males, 232613 females) loaded from .fam.
Using 1 thread (no multithreaded calculations invoked).
Before main variant filters, 429874 founders and 0 nonfounders present.
Calculating allele frequencies... done.
10313 variants and 429874 people pass filters and QC.
Note: No phenotypes present.
--make-bed to
$out_dir/c22.onlyrsids.imputed.noduplicates.filtered.2.bed
+
$out_dir/c22.onlyrsids.imputed.noduplicates.filtered.2.bim
+
$out_dir/c22.onlyrsids.imputed.noduplicates.filtered.2.fam
... done.
Pruned 9097 variants from chromosome 22, leaving 1216.
Pruning complete.  9097 of 10313 variants removed.
Marker lists written to
$out_dir/c22.onlyrsids.imputed.noduplicates.filtered.2.prune.in
and
$out_dir/c22.onlyrsids.imputed.noduplicates.filtered.2.prune.out
.
PLINK v1.90b3d 64-bit (10 Feb 2015)        https://www.cog-genomics.org/plink2
(C) 2005-2015 Shaun Purcell, Christopher Chang   GNU General Public License v3
Logging to $out_dir/c22.onlyrsids.imputed.noduplicates.filtered.2.bis.log.
515868 MB RAM detected; reserving 257934 MB for main workspace.
10313 variants loaded from .bim file.
429874 people (197261 males, 232613 females) loaded from .fam.
--extract: 1216 variants remaining.
Using 1 thread (no multithreaded calculations invoked).
Before main variant filters, 429874 founders and 0 nonfounders present.
Calculating allele frequencies... done.
1216 variants and 429874 people pass filters and QC.
Note: No phenotypes present.
--make-bed to
$out_dir/c22.onlyrsids.imputed.noduplicates.filtered.2.bis.bed
+
$out_dir/c22.onlyrsids.imputed.noduplicates.filtered.2.bis.bim
+
$out_dir/c22.onlyrsids.imputed.noduplicates.filtered.2.bis.fam
... done.
PLINK v1.90b3d 64-bit (10 Feb 2015)        https://www.cog-genomics.org/plink2
(C) 2005-2015 Shaun Purcell, Christopher Chang   GNU General Public License v3
Logging to $out_dir/c22.onlyrsids.imputed.noduplicates.filtered.3.log.
515868 MB RAM detected; reserving 257934 MB for main workspace.
1216 variants loaded from .bim file.
429874 people (197261 males, 232613 females) loaded from .fam.
Using 1 thread (no multithreaded calculations invoked).
Before main variant filters, 429874 founders and 0 nonfounders present.
Calculating allele frequencies... done.
--hwe: 75 variants removed due to Hardy-Weinberg exact test.
1141 variants and 429874 people pass filters and QC.
Note: No phenotypes present.
--make-bed to
$out_dir/c22.onlyrsids.imputed.noduplicates.filtered.3.bed
+
$out_dir/c22.onlyrsids.imputed.noduplicates.filtered.3.bim
+
$out_dir/c22.onlyrsids.imputed.noduplicates.filtered.3.fam
... done.
```

## Step 5

```
PLINK v1.90b3d 64-bit (10 Feb 2015)        https://www.cog-genomics.org/plink2
(C) 2005-2015 Shaun Purcell, Christopher Chang   GNU General Public License v3
Logging to $out_dir/all.onlyrsids.imputed.complete.log.
515868 MB RAM detected; reserving 257934 MB for main workspace.
Performing single-pass merge (429874 people, 62737 variants).
Merged fileset written to                     
$out_dir/all.onlyrsids.imputed.complete-merge.bed
+
$out_dir/all.onlyrsids.imputed.complete-merge.bim
+
$out_dir/all.onlyrsids.imputed.complete-merge.fam
.
62737 variants loaded from .bim file.
429874 people (197261 males, 232613 females) loaded from .fam.
Using 1 thread (no multithreaded calculations invoked).
Before main variant filters, 429874 founders and 0 nonfounders present.
Calculating allele frequencies... done.
62737 variants and 429874 people pass filters and QC.
Note: No phenotypes present.
--make-bed to
$out_dir/all.onlyrsids.imputed.complete.bed
+
$out_dir/all.onlyrsids.imputed.complete.bim
+
$out_dir/all.onlyrsids.imputed.complete.fam
... done.
```

## Step 6

```
PLINK v1.90b3d 64-bit (10 Feb 2015)        https://www.cog-genomics.org/plink2
(C) 2005-2015 Shaun Purcell, Christopher Chang   GNU General Public License v3
Logging to $out_dir/all.onlyrsids.imputed.complete.female.log.
515868 MB RAM detected; reserving 257934 MB for main workspace.
62737 variants loaded from .bim file.
429874 people (197261 males, 232613 females) loaded from .fam.
197261 people removed due to gender filter (--filter-females).
Using 1 thread (no multithreaded calculations invoked).
Before main variant filters, 232613 founders and 0 nonfounders present.
Calculating allele frequencies... done.
62737 variants and 232613 people pass filters and QC.
Note: No phenotypes present.
--make-bed to
$out_dir/all.onlyrsids.imputed.complete.female.bed
+
$out_dir/all.onlyrsids.imputed.complete.female.bim
+
$out_dir/all.onlyrsids.imputed.complete.female.fam
... done.
PLINK v1.90b3d 64-bit (10 Feb 2015)        https://www.cog-genomics.org/plink2
(C) 2005-2015 Shaun Purcell, Christopher Chang   GNU General Public License v3
Logging to $out_dir/all.onlyrsids.imputed.complete.male.log.
515868 MB RAM detected; reserving 257934 MB for main workspace.
62737 variants loaded from .bim file.
429874 people (197261 males, 232613 females) loaded from .fam.
232613 people removed due to gender filter (--filter-males).
Using 1 thread (no multithreaded calculations invoked).
Before main variant filters, 197261 founders and 0 nonfounders present.
Calculating allele frequencies... done.
62737 variants and 197261 people pass filters and QC.
Note: No phenotypes present.
--make-bed to
$out_dir/all.onlyrsids.imputed.complete.male.bed
+
$out_dir/all.onlyrsids.imputed.complete.male.bim
+
$out_dir/all.onlyrsids.imputed.complete.male.fam
... done.
```

## Step 7

```
PLINK v1.90b3d 64-bit (10 Feb 2015)        https://www.cog-genomics.org/plink2
(C) 2005-2015 Shaun Purcell, Christopher Chang   GNU General Public License v3
Logging to $out_dir/all.onlyrsids.imputed.complete.female.train.log.
515868 MB RAM detected; reserving 257934 MB for main workspace.
62737 variants loaded from .bim file.
232613 people (0 males, 232613 females) loaded from .fam.
--remove: 214990 people remaining.
Using 1 thread (no multithreaded calculations invoked).
Before main variant filters, 214990 founders and 0 nonfounders present.
Calculating allele frequencies... done.
62737 variants and 214990 people pass filters and QC.
Note: No phenotypes present.
--make-bed to
$out_dir/all.onlyrsids.imputed.complete.female.train.bed
+
$out_dir/all.onlyrsids.imputed.complete.female.train.bim
+
$out_dir/all.onlyrsids.imputed.complete.female.train.fam
... done.
PLINK v1.90b3d 64-bit (10 Feb 2015)        https://www.cog-genomics.org/plink2
(C) 2005-2015 Shaun Purcell, Christopher Chang   GNU General Public License v3
Logging to $out_dir/all.onlyrsids.imputed.complete.female.test.log.
515868 MB RAM detected; reserving 257934 MB for main workspace.
62737 variants loaded from .bim file.
232613 people (0 males, 232613 females) loaded from .fam.
--keep: 17623 people remaining.
Using 1 thread (no multithreaded calculations invoked).
Before main variant filters, 17623 founders and 0 nonfounders present.
Calculating allele frequencies... done.
62737 variants and 17623 people pass filters and QC.
Note: No phenotypes present.
--make-bed to
$out_dir/all.onlyrsids.imputed.complete.female.test.bed
+
$out_dir/all.onlyrsids.imputed.complete.female.test.bim
+
$out_dir/all.onlyrsids.imputed.complete.female.test.fam
... done.
PLINK v1.90b3d 64-bit (10 Feb 2015)        https://www.cog-genomics.org/plink2
(C) 2005-2015 Shaun Purcell, Christopher Chang   GNU General Public License v3
Logging to $out_dir/all.onlyrsids.imputed.complete.male.train.log.
515868 MB RAM detected; reserving 257934 MB for main workspace.
62737 variants loaded from .bim file.
197261 people (197261 males, 0 females) loaded from .fam.
--remove: 183186 people remaining.
Using 1 thread (no multithreaded calculations invoked).
Before main variant filters, 183186 founders and 0 nonfounders present.
Calculating allele frequencies... done.
62737 variants and 183186 people pass filters and QC.
Note: No phenotypes present.
--make-bed to
$out_dir/all.onlyrsids.imputed.complete.male.train.bed
+
$out_dir/all.onlyrsids.imputed.complete.male.train.bim
+
$out_dir/all.onlyrsids.imputed.complete.male.train.fam
... done.
PLINK v1.90b3d 64-bit (10 Feb 2015)        https://www.cog-genomics.org/plink2
(C) 2005-2015 Shaun Purcell, Christopher Chang   GNU General Public License v3
Logging to $out_dir/all.onlyrsids.imputed.complete.male.test.log.
515868 MB RAM detected; reserving 257934 MB for main workspace.
62737 variants loaded from .bim file.
197261 people (197261 males, 0 females) loaded from .fam.
--keep: 14075 people remaining.
Using 1 thread (no multithreaded calculations invoked).
Before main variant filters, 14075 founders and 0 nonfounders present.
Calculating allele frequencies... done.
62737 variants and 14075 people pass filters and QC.
Note: No phenotypes present.
--make-bed to
$out_dir/all.onlyrsids.imputed.complete.male.test.bed
+
$out_dir/all.onlyrsids.imputed.complete.male.test.bim
+
$out_dir/all.onlyrsids.imputed.complete.male.test.fam
... done.
```

## Step 8

```

```

## Step 9

```

```


