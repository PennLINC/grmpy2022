#!/bin/bash
# TO SETUP:
# git clone <repo_of_ConFixel>
# cd ConFixel
# pip install -e .

# for grmpy project, on cubic:
nsubj=215

cmd="convoxel --group-mask-file stats_ModelArray/tpl-MNI152NLin6Asym_res-02_desc-brain_mask.nii.gz"
cmd+=" --cohort-file stats_ModelArray/GRMPY_convoxel_meanCBF_n${nsubj}.csv"
cmd+=" --relative-root /cbica/projects/GRMPY/project/curation/testing/"
cmd+=" --output-hdf5 stats_ModelArray/GRMPY_meanCBF_n${nsubj}_orig.h5"

echo $cmd
$cmd