#!/bin/sh

###################################################################################################
##########################         micobiome - NMF CT Mask Creation      ##########################
##########################              Azeez A                          ##########################
##########################                                                ##########################
##########################                  07/31/2018                   ##########################
###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################
<<Use

This script creates the CT masks needed perform Non-Negative Matrix Factorization (NMF) Analysis.
The script first increases the dimensions of Raw Images to 2mm, then computes the masks that will
remove images with too many 0 or <.1 values using Phil's method.

To run this script it is required to have a qlogin session with 50G of memory. Use the Command Below:

qlogin -l h_vmem=50.5G,s_vmem=50.0G -q qlogin.himem.q

Use
###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################

#
################################################
### Create Directories to Transfer Files Too ###
################################################

OutRaw=/data/jux/BBL/studies/grmpy/microbiome/output/NMF/ctRaw
OutMask=/data/jux/BBL/studies/grmpy/microbiome/output/NMF/ctMasks
OutSmooth=/data/jux/BBL/studies/grmpy/microbiome/output/NMF/ctSmooth

mkdir -p ${OutRaw}
mkdir -p ${OutMask}
mkdir -p ${OutSmooth}

######################################################################
### Make Copies of the Raw CT Images To Be Processed  ###
######################################################################
bblid=$(cat  /data/jux/BBL/studies/grmpy/microbiome/subjectData/demographics/bblid.txt)

for s in $bblid; do

   imgList[i]=$(ls /data/jux/BBL/studies/grmpy/microbiome/output/structural/${s}/*/antsCT/*_CorticalThicknessNormalizedToTemplate.nii.gz)

   echo ${imgList[i]}

   cp ${imgList[i]} ${OutRaw}

done

#############################################################################
### Applys Transform to Increase Dimensions of voxels by 2mm ###
#############################################################################

copies=/data/jux/BBL/studies/grmpy/microbiome/output/NMF/ctRaw/*_CorticalThicknessNormalizedToTemplate.nii.gz

i=0
for c in $copies; do 

   bblid=$(echo ${c}|cut -d'_' -f1); 
   datexscanid=$(echo ${c}|cut -d'_' -f2); 

   output[i]=${bblid}_${datexscanid}_CorticalThicknessNormalizedToTemplate_2mm.nii.gz
   
   echo ${output[i]}
   
   antsApplyTransforms -e 3 -d 3 -i ${c} -r /data/joy/BBL/studies/pnc/template/pnc_template_brain_2mm.nii.gz -o ${output[i]}

   (( i++ ))

done

for o in ${output[@]}; do

   if [[ -f ${o} ]] ; then 

      file=$(echo ${o}| sed s@'_2mm'@''@g | sed s@'_'@''@g)

      rm $file

      else 

      echo "Output For This Subject Was Not Successful"

   fi
done

chmod -R a+x ${OutRaw}/*

#############################################
### Create csv's of the Files Information ###
#############################################

ls ${OutRaw}/* >> ${OutRaw}/microbiome_ctRaw_2018.csv

cohort=$(ls ${OutRaw}/* | grep -v '/data/jux/BBL/studies/grmpy/microbiome/output/NMF/ctRaw/microbiome_ctRaw_2018.csv')

for c in $cohort ; do

bblid=$(echo ${c} | cut -d '/' -f11| cut -d '_' -f1)
scanid=$(echo ${c} | cut -d '/' -f11| cut -d '_' -f2 | cut -d 'x' -f2)

echo ${bblid},${scanid} >> ${OutRaw}/microbiome_cohort_2018.csv

done

###################################################
### Smooth the RawCT Images by 4mm for Analysis ###
###################################################

subjects=/data/jux/BBL/studies/grmpy/microbiome/output/NMF/ctRaw/*_CorticalThicknessNormalizedToTemplate_2mm.nii.gz

i=0
for s in ${subjects}; do

basename=$(echo ${s} | cut -d '/' -f11| cut -d '.' -f1)

echo $basename

sig=1.70

fslmaths ${s} -s ${sig} ${OutSmooth}/${basename}_smoothed4mm.nii.gz

(( i++ ))
done

chmod -R a+x ${OutSmooth}/*

#############################################################
### Create the CTmasks now that rawCT Images are Complete ###
#############################################################

subjects=/data/jux/BBL/studies/grmpy/microbiome/output/NMF/ctRaw/*.nii.gz

for s in ${subjects}; do 
                                                                                                                                                              
   fileName=$(echo $s | cut -d'/' -f11  | cut -d'.' -f1)
   echo "file name is ${fileName}"

	ThresholdImage 3 $s ${OutMask}/${fileName}_mask.nii.gz 0.1 Inf

done

AverageImages 3 ${OutMask}/coverageMask.nii.gz 0 ${OutMask}/*mask.nii.gz

fslmaths ${OutMask}/coverageMask.nii.gz -thr .9 -bin ${OutMask}/microbiome_ctMask_thr9_2mm.nii.gz

chmod -R a+x ${OutMask}/*

###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################
