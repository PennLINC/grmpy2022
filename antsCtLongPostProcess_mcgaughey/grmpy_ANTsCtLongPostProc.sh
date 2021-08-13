#!/bin/bash

path=/data/joy/BBL/studies/grmpy/BIDS/derivatives/antsct
path1=/data/joy/BBL/studies/grmpy/BIDS/derivatives/antsCtLongPostProc_20181130

for SubID in $(ls $path)
do

mkdir /data/joy/BBL/studies/grmpy/BIDS/derivatives/antsCtLongPostProc_20181130/${SubID}
path2=/data/joy/BBL/studies/grmpy/BIDS/derivatives/antsCtLongPostProc_20181130/${SubID}

#Registration (gives you the affine and the warp need to take things from subject space to grmpyTemplate space)

echo "antsRegistrationSyN.sh \
 -d 3 \
 -f /data/joy/BBL/studies/grmpy/grmpyTemplate/grmpy_midpointTemplatetemplate0.nii.gz \
 -m $path/$SubID/${SubID}_T1w_SingleSubjectTemplate/T_templateExtractedBrain0N4.nii.gz \
 -o $path2/${SubID}_NormalizedtoGrmpyTemplate

#ANTs composite transform:ses01 CorticalThickness to grmpyTemplate space

antsApplyTransforms \
 -d 3 \
 -e 0 \
 -o [$path2/${SubID}_ses-01_T1wCorticalThicknessNormalizedtogrmpyTemplateCompositeWarp.nii.gz, 1] \
 -r /data/joy/BBL/studies/grmpy/grmpyTemplate/grmpy_midpointTemplatetemplate0.nii.gz \
 -t $path2/${SubID}_NormalizedtoGrmpyTemplate1Warp.nii.gz \
 -t $path2/${SubID}_NormalizedtoGrmpyTemplate0GenericAffine.mat \
 -t $path/$SubID/${SubID}_ses-01_T1w_0/${SubID}_ses-01_T1wSubjectToTemplate1Warp.nii.gz \
 -t $path/$SubID/${SubID}_ses-01_T1w_0/${SubID}_ses-01_T1wSubjectToTemplate0GenericAffine.mat 

#ANTs composite transform:ses02 CorticalThickness to grmpyTemplate space

antsApplyTransforms \
 -d 3 \
 -e 0 \
 -o [$path2/${SubID}_ses-02_T1wCorticalThicknessNormalizedtogrmpyTemplateCompositeWarp.nii.gz, 1] \
 -r /data/joy/BBL/studies/grmpy/grmpyTemplate/grmpy_midpointTemplatetemplate0.nii.gz \
 -t $path2/${SubID}_NormalizedtoGrmpyTemplate1Warp.nii.gz \
 -t $path2/${SubID}_NormalizedtoGrmpyTemplate0GenericAffine.mat \
 -t $path/$SubID/${SubID}_ses-02_T1w_1/sub-080557_ses-02_T1wSubjectToTemplate1Warp.nii.gz \
 -t $path/$SubID/${SubID}_ses-02_T1w_1/sub-080557_ses-02_T1wSubjectToTemplate0GenericAffine.mat

#Use grmpyTemplateCompositeWarp to get logJacobian (ses_01)

CreateJacobianDeterminantImage 3 $path2/${SubID}_ses-01_T1wCorticalThicknessNormalizedtogrmpyTemplateCompositeWarp.nii.gz $path2/${SubID}_ses-01_T1wCorticalThicknessNormalizedtogrmpyTemplatelogJacobian.nii.gz 1 0

#Use grmpyTemplateCompositeWarp to get logJacobian (ses_02)

CreateJacobianDeterminantImage 3 $path2/${SubID}_ses-02_T1wCorticalThicknessNormalizedtogrmpyTemplateCompositeWarp.nii.gz $path2/${SubID}_ses-02_T1wCorticalThicknessNormalizedtogrmpyTemplatelogJacobian.nii.gz 1 0
" >> $path1/${SubID}-script.sh

qsub -m e -M mckar@pennmedicine.upenn.edu -l h_vmem=26G,s_vmem=25G $path1/$SubID-script.sh

done
