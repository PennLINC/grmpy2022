## Get the cohort for to run for pncxcpengine 
## Azeez A



bblid=$(cat /data/jux/BBL/projects/grmpyProcessing/grmpyProcessing2017Scripts/structural/struct_pipeline/BPDID.csv)

rawdatadir1=/data/jux/BBL/studies/grmpy/rawData

for b  in $bblid;  do      
          datexscanid=$(basename $rawdatadir1/${b}/*)
          img1=$(ls -d $rawdatadir1/${b}/*/MPRAGE*/nifti/*.nii.gz)
          echo "$b,$datexscanid,$img1" >> /data/jux/BBL/projects/grmpyProcessing/grmpyProcessing2017Scripts/structural/struct_pipeline/BPDstructcohort.csv
      
        
done

