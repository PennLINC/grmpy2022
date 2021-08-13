#!/bin/bash
SNGL=/share/apps/singularity/2.5.1/bin/singularity
XCP=/data/joy/BBL/applications/bids_apps/xcpEngine.simg
SNGL_BIND=/home/aadebimpe



cohort_file=${SNGL_BIND}/data/jux/BBL/studies/grmpy/BIDSOUTPUT/scripts/cohortfile.csv
design_file=${SNGL_BIND}/data/jux/BBL/studies/grmpy/BIDSOUTPUT/scripts/anat-antsct.dsn 
temp_dir=/tmp/2477491.1.qlogin.himem.q
output_dir=${SNGL_BIND}/data/jux/BBL/studies/grmpy/BIDSOUTPUT/structural  



HEADER=$(head -n 1 ${FULL_COHORT})
bb=$(seq 1 $num)

for j in $bb; do  
    l=$(expr $j + 1)
    LINE=$(awk "NR==$l" ${FULL_COHORT})
    TEMP_COHORT=${FULL_COHORT}.${j}.csv

    echo $HEADER > ${TEMP_COHORT}
    echo $LINE>> ${TEMP_COHORT}
 
    echo ${SNGL} run -B /data:/home/aadebimpe/data ${SIMG}  -c /home/aadebimpe${TEMP_COHORT}  -d /home/aadebimpe$DESIGN -o /home/aadebimpe$OUTPUT  -r /home/aadebimpe > xcpRunm_${j}.sh
  
    qsub xcpRunm_${j}.sh

done 
=======

