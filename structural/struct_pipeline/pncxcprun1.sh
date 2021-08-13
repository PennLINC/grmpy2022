

FULL_COHORT=/data/jux/BBL/projects/grmpyProcessing/grmpyProcessing2017Scripts/structural/struct_pipeline/pncxcpcohort1.csv

NJOBS=$(wc -l <  ${FULL_COHORT})
num=$(expr $NJOBS - 1);

SNGL=/share/apps/singularity/2.5.1/bin/singularity
SIMG=/data/joy/BBL/applications/bids_apps/pncxcp.simg
DESIGN=/data/jux/BBL/projects/grmpyProcessing/grmpyProcessing2017Scripts/structural/struct_pipeline/dockerpncxcp.dsn
OUTPUT=/data/jux/BBL/studies/grmpy/processedData/structural/struct_pncxcp_20181225



HEADER=$(head -n 1 ${FULL_COHORT})
bb=$(seq 1 $num)

for j in $bb; do  
    l=$(expr $j + 1)
    LINE=$(awk "NR==$l" ${FULL_COHORT})
    TEMP_COHORT=${FULL_COHORT}.${j}.csv

    echo $HEADER > ${TEMP_COHORT}
    echo $LINE>> ${TEMP_COHORT}
 
    echo ${SNGL} run -B /data:/home/aadebimpe/data ${SIMG}  -c /home/aadebimpe${TEMP_COHORT}  -d /home/aadebimpe$DESIGN -o /home/aadebimpe$OUTPUT  -r /home/aadebimpe > xcpRun_${j}.sh
  
    qsub xcpRun_${j}.sh

done 
