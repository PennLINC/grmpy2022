!/bin/bash

path=/data/joy/BBL/studies/grmpy/BIDS/derivatives/antsct
path1=/data/joy/BBL/studies/grmpy/BIDS/derivatives/antsCtLongPostProc_20181130

for SubID in $(ls $path)
do

CaseList=$(cat /data/jux/BBL/projects/grmpyProcessing/grmpyProcessing2017Scripts/structural/antsCtLongPostProcess_mcgaughey/MissingCaseList.txt | grep $SubID)

case_new=$(echo $CaseList | sed 's/ .*//')

echo $case_new
if [[ ${case_new} = ${SubID} ]]
then
echo "Did not process $case_new" >> /data/jux/BBL/projects/grmpyProcessing/grmpyProcessing2017Scripts/structural/antsCtLongPostProcess_mcgaughey/NotProcessedList.txt

else

mkdir /data/joy/BBL/studies/grmpy/BIDS/derivatives/antsCtLongPostProc_20181130/${SubID}
path2=/data/joy/BBL/studies/grmpy/BIDS/derivatives/antsCtLongPostProc_20181130/${SubID}

#Registration (gives you the affine and the warp need to take things from subject space to grmpyTemplate space)

echo "antsRegistrationSyN.sh \
 -d 3 \
 -f /data/joy/BBL/studies/grmpy/grmpyTemplateLong/grmpy_midpointTemplatetemplate0.nii.gz \
 -m $path/$SubID/${SubID}_T1w_SingleSubjectTemplate/T_templateExtractedBrain0N4.nii.gz \
 -o $path2/${SubID}_SSTNormalizedtoGrmpyTemplate

#ANTs composite transform:Creating a CompositeWarp for ses01 to GrmpyTemplate space

antsApplyTransforms \
 -d 3 \
 -e 0 \
 -o [$path2/${SubID}_ses-01_NormalizedtoGrmpyTemplateCompositeWarp.nii.gz, 1] \
 -r /data/joy/BBL/studies/grmpy/grmpyTemplateLong/grmpy_midpointTemplatetemplate0.nii.gz \
 -t $path2/${SubID}_SSTNormalizedtoGrmpyTemplate1Warp.nii.gz \
 -t $path2/${SubID}_SSTNormalizedtoGrmpyTemplate0GenericAffine.mat \
 -t $path/$SubID/${SubID}_ses-01_T1w_0/${SubID}_ses-01_T1wSubjectToTemplate1Warp.nii.gz \
 -t $path/$SubID/${SubID}_ses-01_T1w_0/${SubID}_ses-01_T1wSubjectToTemplate0GenericAffine.mat 

#ANTs composite transform:Creating a CompositeWarp for ses02 to GrmpyTemplate space

antsApplyTransforms \
 -d 3 \
 -e 0 \
 -o [$path2/${SubID}_ses-02_NormalizedtoGrmpyTemplateCompositeWarp.nii.gz, 1] \
 -r /data/joy/BBL/studies/grmpy/grmpyTemplateLong/grmpy_midpointTemplatetemplate0.nii.gz \
 -t $path2/${SubID}_SSTNormalizedtoGrmpyTemplate1Warp.nii.gz \
 -t $path2/${SubID}_SSTNormalizedtoGrmpyTemplate0GenericAffine.mat \
 -t $path/$SubID/${SubID}_ses-02_T1w_1/${SubID}_ses-02_T1wSubjectToTemplate1Warp.nii.gz \
 -t $path/$SubID/${SubID}_ses-02_T1w_1/${SubID}_ses-02_T1wSubjectToTemplate0GenericAffine.mat

#Use GrmpyTemplateCompositeWarp to get logJacobian (ses_01)

CreateJacobianDeterminantImage 3 $path2/${SubID}_ses-01_NormalizedtoGrmpyTemplateCompositeWarp.nii.gz $path2/${SubID}_ses-01_NormalizedtoGrmpyTemplatelogJacobian.nii.gz 1 0

#Use GrmpyTemplateCompositeWarp to get logJacobian (ses_02)

CreateJacobianDeterminantImage 3 $path2/${SubID}_ses-02_NormalizedtoGrmpyTemplateCompositeWarp.nii.gz $path2/${SubID}_ses-02_NormalizedtoGrmpyTemplatelogJacobian.nii.gz 1 0

#Use GrmpyTemplateCompositeWarp to pull skull-stripped, bias corrected images from ses_01/ses_02 space into GrmpyTemplate space

antsApplyTransforms \
 -d 3 \
 -e 0 \
 -i $path/$SubID/${SubID}_ses-01_T1w_0/${SubID}_ses-01_T1wExtractedBrain0N4.nii.gz \
 -o $path2/${SubID}_ses-01_NormalizedtoGrmpyTemplate.nii.gz \
 -r /data/joy/BBL/studies/grmpy/grmpyTemplateLong/grmpy_midpointTemplatetemplate0.nii.gz \
 -t $path2/${SubID}_ses-01_NormalizedtoGrmpyTemplateCompositeWarp.nii.gz

antsApplyTransforms \
 -d 3 \
 -e 0 \
 -i $path/$SubID/${SubID}_ses-02_T1w_1/${SubID}_ses-02_T1wExtractedBrain0N4.nii.gz \
 -o $path2/${SubID}_ses-02_NormalizedtoGrmpyTemplate.nii.gz \
 -r /data/joy/BBL/studies/grmpy/grmpyTemplateLong/grmpy_midpointTemplatetemplate0.nii.gz \
 -t $path2/${SubID}_ses-02_NormalizedtoGrmpyTemplateCompositeWarp.nii.gz

#USe GrmpyTemplate CompositeWarp to pull CorticalThickness images from ses_01/ses_02 space into GrmpyTemplate space

antsApplyTransforms \
 -d 3 \
 -e 0 \
 -i $path/$SubID/${SubID}_ses-01_T1w_0/${SubID}_ses-01_T1w*CorticalThickness.nii.gz \
 -o $path2/${SubID}_ses-01_NormalizedtoGrmpyTemplateCorticalThickness.nii.gz \
 -r /data/joy/BBL/studies/grmpy/grmpyTemplateLong/grmpy_midpointTemplatetemplate0.nii.gz \
 -t $path2/${SubID}_ses-01_NormalizedtoGrmpyTemplateCompositeWarp.nii.gz

antsApplyTransforms \
 -d 3 \
 -e 0 \
 -i $path/$SubID/${SubID}_ses-02_T1w_1/${SubID}_ses-02_T1w*CorticalThickness.nii.gz \
 -o $path2/${SubID}_ses-02_NormalizedtoGrmpyTemplateCorticalThickness.nii.gz \
 -r /data/joy/BBL/studies/grmpy/grmpyTemplateLong/grmpy_midpointTemplatetemplate0.nii.gz \
 -t $path2/${SubID}_ses-02_NormalizedtoGrmpyTemplateCompositeWarp.nii.gz

" >> $path1/${SubID}-script.sh

qsub -m e -M mckar@pennmedicine.upenn.edu -l h_vmem=26G,s_vmem=25G $path1/$SubID-script.sh

fi

done

