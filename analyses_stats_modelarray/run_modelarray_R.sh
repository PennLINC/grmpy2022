#!/bin/bash
# this is to call .R (or .Rmd) file of running ModelArray

# +++++++++++++++++++++++++ VARIABLES TO CHANGE: ++++++++++++++++++++++++++++++++++++++++++++
folder_main="/cbica/projects/GRMPY/project/curation/testing/stats_ModelArray"

num_voxels=10   # 0 if requesting all voxels
num_subj=215
num_cores=4    # number of CPU cores; the more the faster

#fn_rstudio_singularity="/cbica/projects/GRMPY/software/rstudio_4.1.sif"
fn_rstudio_singularity="/cbica/projects/GRMPY/software/myr_r4.1.0forFixelArray.sif"
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

printf -v date '%(%Y%m%d-%H%M%S)T' -1   # $date, in YYYYmmdd-HHMMSS
echo "date variable: ${date}"

filename_output_body="GRMPY_meanCBF_n${num_subj}_nvoxels-${num_voxels}_wResults_${date}"
fn_R_output="${folder_main}/${filename_output_body}.txt"

#cmd="Rscript ./test_modelarray.R ${num_voxels} ${num_subj} ${num_cores} ${folder_main} ${filename_output_body} > ${fn_R_output} 2>&1 &"
cmd="singularity run --cleanenv ${fn_rstudio_singularity} Rscript ./test_modelarray.R ${num_voxels} ${num_subj} ${num_cores} ${folder_main} ${filename_output_body} > ${fn_R_output} 2>&1 &"
echo $cmd
# copy the $cmd here manually (otherwise there might be issues with output $fn_R_output):
singularity run --cleanenv ${fn_rstudio_singularity} Rscript ./test_modelarray.R ${num_voxels} ${num_subj} ${num_cores} ${folder_main} ${filename_output_body} > ${fn_R_output} 2>&1 &