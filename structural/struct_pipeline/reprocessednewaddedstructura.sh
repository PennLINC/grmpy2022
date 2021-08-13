
## Get the cohort for new added data as at 20180824  
## Azeez A


rawdatadir=/data/jux/BBL/studies/grmpy/rawData/*


for ss in $rawdatadir; do

     b=$(basename $ss) 

     echo "$b">>/data/jux/BBL/projects/grmpyProcessing/grmpyProcessing2017Scripts/structural/struct_pipeline/rawbblid_1028824.txt

done 
#  the processeddir 
processeddir=/data/jux/BBL/studies/grmpy/processedData/structural/struct_pipeline_20170716
bblid=$(cat /data/jux/BBL/projects/grmpyProcessing/grmpyProcessing2017Scripts/structural/struct_pipeline/rawbblid_1028824.txt)
rawdatadir1=/data/jux/BBL/studies/grmpy/rawData

for b  in $bblid;  do      
     #dd=$(ls -d $processeddir/${b})
   
      if [ ! -d $processeddir/${b} ]; then 
          datexscanid=$(basename $rawdatadir1/${b}/*)
          img1=$(ls -d $rawdatadir1/${b}/*/MPRAGE*/nifti/*.nii.gz)
          echo "$b,$datexscanid,$img1" >> /data/jux/BBL/projects/grmpyProcessing/grmpyProcessing2017Scripts/structural/struct_pipeline/structuralcohort_20180824.csv
      fi
          
done

