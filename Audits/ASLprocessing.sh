#!/bin/sh

###################################################################################################
##########################         GRMPY - ASL Offline Processing        ##########################
##########################              Robert Jirsaraie                 ##########################
##########################       rjirsara@pennmedicine.upenn.edu         ##########################
##########################                  03/04/2018                   ##########################
###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################
<<Use

This script was used to complete offline processing of the ASL dicom files (.dat) and place the nifitis 
in their respective directories.

Use
###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################

subjects=$(cat /data/jux/BBL/projects/grmpyProcessing2017/Audits/n145_SubjectIDs_20180216/rTRUELYMissingASL.csv | grep -v '82063/20151201x9980' | grep -v '129354/20161006x10357' | grep -v '121476/20160810x10280'| sed s@' '@','@g )

for s in ${subjects}; do 

echo 'Now Working on Subject:' ${s}

bblid=$(echo ${s}| cut -d '/' -f1)
scanid=$(echo ${s}| cut -d 'x' -f2)
date=$(echo ${s}| sed s@'x'@'/'@g | cut -d '/' -f2)


echo 'bblid:' ${bblid}
echo 'scanid:' ${scanid}
echo 'date:' ${date}

#mkdir -p /data/jux/BBL/studies/grmpy/rawData/${bblid}/${date}x${scanid}/ASL_dicomref/nifti

dicoms=$(ls /data/jux/BBL/projects/grmpyProcessing2017/asl/monstrumDicoms/${bblid}_${scanid}_*.dat)
output=$(echo /data/jux/BBL/studies/grmpy/rawData/${bblid}/${date}x${scanid}/ASL_dicomref/nifti)

echo 'Dicom Input:' ${dicoms}
echo 'Dicom Output Path:' ${output}
echo ' '

/home/rciric/projects/aslRecon/fullConformASL -t /home/rciric/projects/aslRecon/aslSpiral.traj -d ${dicoms} -r /data/jux/BBL/projects/jirsaraieStructuralIrrit/ASL_monstrum/exampledicom/ASL_dicomref_S012_I000000.dcm -o ${output}/${bblid}_${date}x${scanid}_asl_recon.nii.gz

done

###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################
