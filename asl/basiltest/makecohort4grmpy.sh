
##makecohortfiel for grymp
grmpyids=/data/jux/BBL/projects/grmpyProcessing/grmpyProcessing2017Scripts/asl/basiltest/gryids
cbbfdir=/data/jux/BBL/studies/grmpy/rawData           #/81725/20161004x10356/ASL_3DSpiral_OnlineRecon_ASL/nifti/010356_ASL_3DSpiral_OnlineRecon_ASL.nii.gz
anat=/data/jux/BBL/studies/grmpy/processedData/structural/struct_pipeline_20170716    #/102041/20170907x10603/antsCT

#/data/jux/BBL/studies/grmpy/BIDS/sub-080557/ses-02/asl

echo id0,id1,img,ref,antsct >> grmpycohort2.csv

cat $grmpyids  | while IFS="," read -r a b ; do 

img=$(ls -d  $cbbfdir/${a}/*${b}/ASL_dicomref/nifti/*asl_recon.nii.gz  2>/dev/null)
mo=$(ls -d  $cbbfdir/${a}/*${b}/ASL_dicomref/nifti/*_M0.nii.gz 2>/dev/null)
str=$(ls -d $anat/${a}/*${b}/antsCT)
ss=$(basename  $anat/${a}/*${b})

echo  $a,$ss,$img,$mo,$str >> grmpycohort2.csv
done 


