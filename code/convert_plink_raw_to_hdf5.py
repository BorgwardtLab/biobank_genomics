#!/usr/bin/env python2.7
#-----------------------------------------------------------------------------
# Convert a PLINK file (.bed, .fam and .bim) into an HDF5 file
#
# March 2016 D. Roqueiro
#-----------------------------------------------------------------------------
import sys
import os
import argparse
import numpy as np
import h5py
import IPython as ip

# Constants used to access the input files and to define the datasets in HDF5
COL_NAMES_FAM = ["fid", "iid", "gender", "phenotype"]
COL_IDX_FAM   = [    0,     1,        4,          5 ]

COL_NAMES_BIM = ["chr", "snp_id", "coordinate", "allele_1", "allele_2"]
COL_IDX_BIM   = [    0,        1,            3,          4,         5 ]

def read_fam_bam_files(prefix, ext, col_idx):
    '''
    Read the contents of .fam or .bim files into separate lists.
    The parameter col_idx indicates what columns to take from the file.
    One list per column will be created
    
    Parameters
    ----------
    prefix  : the full path prefix of the PLINK files
    ext     : the extension of the file (.bim or .fam)
    col_idx : the columns (0-based) to be read from the file
    '''

    # Create an empty list of lists
    lst_info = []
    for i in range(len(col_idx)):
        lst_info.append([])

    # Process each file individually
    file_name = "%s.%s" % (prefix, ext)
    try:
        f_in = open(file_name, 'r')
    except IOError:
        print ("Cannot open the file %s\n") % file_name
        exit(1)
    # Create separate lists for the different columns
    for line in f_in:
        parts = line.split()
        for i in range(len(col_idx)):
            lst_info[i].append(parts[col_idx[i]])

    f_in.close()

    return lst_info


def convert_genotype(x):
    '''
    Convert a string to integer. If the value is missing, i.e. NA, then return -1
    
    Parameters
    ----------
    x : an encoded genotype value
    '''
    if x == "NA": return -1
    return int(x)


def read_genotype_file(X, file_name, skip_rows):
    '''
    Read the contents of .raw file that was recoded from a PLINK .bed file.
    The information about the SNPs is recoded as additive, dominant or recessive.
    Each line of the file corresponds to a sample

    Parameters
    ----------
    X         : is the pre-created genoytpe matrix that will be populated
    file_name : the extension of the file (.bim or .fam)
    '''

    FIRST_COL = 6
    # Open the file
    try:
        f_in = open(file_name, 'r')
    except IOError:
        print ("Cannot open the file %s\n") % file_name
        exit(1)
    # Determine the shape of the matrix to display a progress bar
    M = X.shape[0]
    N = X.shape[1]

    # Skip the header but use to determine the count of columns
    if skip_rows:
        line = f_in.readline()

    # Read the file, line by line
    for i, line in enumerate(f_in):
        line = line.replace("NA", "-1")
        parts = line.split()
        # X[i, :] = np.array([convert_genotype(x) for x in parts[FIRST_COL:]])
        X[i, :] = np.array(list(map(np.int8, parts[FIRST_COL:])))    

        # Print progress bar
        sys.stdout.write("\r%.1f%%" % (100.0*i/M))
        sys.stdout.flush()

    f_in.close()


def create_datasets(h5_obj, group_name, dim, lst_data, col_names, data_type):
    '''
    Create datasets inside of the group of an HDF5 object.
    All datasets will be of the same dimension and type, specificied in dim and data_type
    respectively.
    The dimensions dim is a 2-dimensional array where:
      dim[0] specifies the number of columns
      dim[1] is the number of rows
    The names of the datasets are in col_names. The data for each dataset is in
    the list of lists lst_data.
    
    Parameters
    ----------
    h5_obj     : the H5F5 object on which to create the datasets
    group_name : name of the group in which to create the datasets
    lst_data   : list of lists -one list per dataset- with the data to add to each dataset
    col_names  : names of the datasets
    data_type  : string specifying the type of data the dataset will contain
    '''

    for i in range(len(col_names)):
        # Set the name of the dataset
        dataset_name = "%s/%s" % (group_name, col_names[i])
        if dim[1] == 0:
            dset = h5_obj.create_dataset(dataset_name, (dim[0], ), dtype=data_type)
        else:
            dset = h5_obj.create_dataset(dataset_name, (dim[0], dim[1]), dtype=data_type)
        dset[...] = lst_data[i]    

def perform_naive_impute(X):
    '''
    Iterate through all columns of X and replace all -1s with the most common allele.

    Parameters
    ----------
    X : is the pre-created genoytpe matrix that will be imputed
    '''

    # Determine the shape of the matrix to display a progress bar
    N = X.shape[1]

    # Read the file, line by line
    for j in range(N):
        if np.where(X[:, j] == -1)[0].shape[0] == 0:
            # No missing values for this SNP
            continue

        # Get the index to the positions that DO NOT have missing values
        # This is necessary because the function bincount cannot receive
        # negative values
        bool_idx = ~(X[:, j] == -1)

        # Create a new temporary array with the three possible encodings
        tmp_vec = np.concatenate((X[bool_idx, j], [0, 1, 2]))
        # Count the number of elements for each encoding
        bin_vec = np.bincount(tmp_vec)
        # Find the encoding with the maxiumum number of elements
        max_allele = np.argmax(bin_vec)


        # Get the index to the positions with the missing values
        pos = np.where(X[:, j] == -1)[0]
        X[pos, j] = max_allele

        # Print progress bar
        sys.stdout.write("\r%.1f%%" % (100.0*j/N))
        sys.stdout.flush()

# -----------------------------------------------------------------------------
# Main
# -----------------------------------------------------------------------------
# Set up the parsing of command-line arguments
parser = argparse.ArgumentParser(description="Convert a genotype matrix from text format to HDF5")
parser.add_argument("--plink_prefix", required=True, 
                    help="Full path to the PLINK prefix. The .bed, .fam and .bim files are to be found in this path")
parser.add_argument("--raw_file", required=True, 
                    help="Full path file with the genotype data in text format")
parser.add_argument("--skip_rows", required=True, 
                    help="0: no skip; 1: skip the first row")
parser.add_argument("--naive_impute", required=True, type=int,
                    help="0: no imputation, missing values are set to -1; 1: impute missing values with most common allele")
parser.add_argument("--new_hdf5_file", required=True, 
                    help="Full path to the name of the new HDF5 file to be created")
args = parser.parse_args()

# Read the .bim and .fam files to obtain the sample ids and the SNP ids
lst_sample_info = read_fam_bam_files(args.plink_prefix, "fam", COL_IDX_FAM)
lst_snp_info    = read_fam_bam_files(args.plink_prefix, "bim", COL_IDX_BIM)

# Determine the number of samples and of SNPs. The counts will be behave as 
# constants for the remaining of the program
M = len(lst_sample_info[0])
N = len(lst_snp_info[0])

# 1. Create the HDF5 object
h5_obj = h5py.File(args.new_hdf5_file, "w")

# 2. Create the groups
#    2.1 Sample information (FID, IID, and others)
#    2.2 SNP information (SNP Id, location)
#    2.3 Genotype data (genotype matrix)
h5_obj.create_group("sample_info")
h5_obj.create_group("snp_info")
h5_obj.create_group("genotype")

# 3. Create the datasets inside of each group
#    3.1 For the sample and SNP info define a variable-length type for the strings
#    3.2 For the genotype data create a matrix that will contain M-by-N values
print ("Reading the .fam and .bim files...")
dt_str = h5py.special_dtype(vlen=str)
create_datasets(h5_obj, "sample_info", [M, 0], lst_sample_info, COL_NAMES_FAM, dt_str)
create_datasets(h5_obj, "snp_info", [N, 0], lst_snp_info, COL_NAMES_BIM, dt_str)


# # Create the matrix and populate it with the data
print ("Reading the genotype matrix...")
mat = np.ndarray(shape=(M, N), dtype=np.int8)
read_genotype_file(mat, args.raw_file, args.skip_rows)

# Determine if missing values need to be imputed
if args.naive_impute == 1:
    print ("Performing naive imputation...")
    perform_naive_impute(mat)

dset = h5_obj.create_dataset("genotype/matrix", (M, N), dtype='i2')
dset[...] = mat

# Close the HDF5 object
h5_obj.close()


