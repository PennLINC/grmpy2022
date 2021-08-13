#!/bin/bash

path=/data/joy/BBL/studies/grmpy/BIDS/derivatives/antsct

cd $path

for case in sub-*

do

if [ -e $path/$case/${case}_T1w_SingleSubjectTemplate/T_templateExtractedBrain0N4.nii.gz ]
then 
echo "$case SST exists" 
elif [ -e $path/$case/T_templateExtractedBrain0N4.nii.gz ]
then 
echo "$case SST exists"
else
echo "$case SST T_templateExtractedBrain0N4.nii.gz" >> /data/jux/BBL/projects/grmpyProcessing/grmpyProcessing2017Scripts/structural/antsCtLongPostProcess_mcgaughey/MissingCaseList.txt
fi

for ses in ses-01 ses-02
do
if [ -e $path/$case/*${ses}_T1w_*/*${ses}_T1wSubjectToTemplate1Warp.nii.gz ] && [ -e $path/$case/*${ses}_T1w_*/*${ses}_T1wSubjectToTemplate0GenericAffine.mat ] 
then
echo "$case warp and affine exist"
elif [ -e $path/$case/*${ses}_T1wSubjectToTemplate1Warp.nii.gz ] && [ -e $path/$case/*${ses}_T1wSubjectToTemplate0GenericAffine.mat ]
then 
echo "$case warp and affine exist"
else
echo "$case $ses T1wSubjectToTemplate1Warp.nii.gz/T1wSubjectToTemplate0GenericAffine.mat " >> /data/jux/BBL/projects/grmpyProcessing/grmpyProcessing2017Scripts/structural/antsCtLongPostProcess_mcgaughey/MissingCaseList.txt
fi
done

for ses in ses-01 ses-02
do
if [ -e $path/$case/*${ses}_T1w_*/*${ses}_T1wExtractedBrain0N4.nii.gz ]
then
echo "$case T1wExtractedBrain0N4.nii.gz exists"
elif [ -e $path/$case/*${ses}_T1wExtractedBrain0N4.nii.gz ]
then 
echo "$case T1wExtractedBrain0N4.nii.gz exists"
else
echo "$case $ses T1wExtractedBrain0N4.nii.gz" >> /data/jux/BBL/projects/grmpyProcessing/grmpyProcessing2017Scripts/structural/antsCtLongPostProcess_mcgaughey/MissingCaseList.txt
fi
done

for ses in ses-01 ses-02
do
if [ -e $path/$case/*${ses}_T1w_*/*${ses}_T1wCorticalThickness.nii.gz ] || [ -e $path/$case/*${ses}_T1w_*/*${ses}_T1w_CorticalThickness.nii.gz ]
then
echo "$case T1 Cortical Thickness exists"
elif [ -e $path/$case/*${ses}_T1wCorticalThickness.nii.gz ] || [ -e $path/$case/*${ses}_T1w_CorticalThickness.nii.gz ]
then
echo "$case T1 Cortical Thickness exists"
else
echo "$case $ses T1wCorticalThickness.nii.gz (or T1w_CorticalThickness.nii.gz)" >> /data/jux/BBL/projects/grmpyProcessing/grmpyProcessing2017Scripts/structural/antsCtLongPostProcess_mcgaughey/MissingCaseList.txt
fi
done

done

