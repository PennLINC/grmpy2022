##makecohortfile for pnc structural
pncids=/data/jux/BBL/projects/grmpyProcessing/grmpyProcessing2017Scripts/asl/basiltest/pncbblidscanid.csv
rawdata=/data/joy/BBL/studies/pnc/rawData          #/81725/20161004x10356/ASL_3DSpiral_OnlineRecon_ASL/nifti/010356_ASL_3DSpiral_OnlineRecon_ASL.nii.gz
anat=/data/jux/BBL/studies/grmpy/processedData/structural/struct_pipeline_20170716    #/102041/20170907x10603/antsCT

#/data/jux/BBL/studies/grmpy/BIDS/sub-080557/ses-02/asl

echo id0,id1,img >> pncstructcohort.csv

cat $pncids  | while IFS="," read -r a b c ; do 
anat=$(ls -d $rawdata/${b}/*${c}/mprage/*t1.nii.gz)
ss=$(basename $rawdata/${b}/*${c})

echo  $b,$ss,${anat}>> pncstructcohort.csv
done 
