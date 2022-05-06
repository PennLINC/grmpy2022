#!/bin/bash

# conda activate test_confixel   # only run this on Chenying's vmware

# +++++++++++++++++++++++++++++
#date_hdf5="20220504-180709"
date_hdf5="20220505-224603"
nsubj=209
# +++++++++++++++++++++++++++++

# GRMPY ASL CBF data, on Chenying's vmware:
filename_hdf5_woext="GRMPY_meanCBF_n209_indmask_nvoxels-0_wResults_${date_hdf5}"
cmd="volumestats_write --group-mask-file tpl-MNI152NLin6Asym_res-02_desc-brain_mask.nii.gz"
cmd+=" --cohort-file GRMPY_convoxel_meanCBF_n${nsubj}_indmask.csv"
cmd+=" --relative-root /home/chenying/Desktop/fixel_project/data/data_voxel_grmpy"  # local vmware
#cmd+=" --analysis_name lm_fullOutputs"
cmd+=" --analysis_name gam_fullOutputs"
cmd+=" --input-hdf5 ${filename_hdf5_woext}.h5"  
cmd+=" --output-dir ${filename_hdf5_woext}"
cmd+=" --output-ext .nii.gz"


echo $cmd
$cmd