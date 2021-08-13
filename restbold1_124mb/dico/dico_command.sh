#!/bin/bash

###################################################################################################
##########################         GRMPY - Distorition Correction        ##########################
##########################              Robert Jirsaraie                 ##########################
##########################             rjirsara@upenn.edu                ##########################
##########################                  10/07/2017                   ##########################
###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################
<<Use

This wrapper applies distortion correction for all rest bold images that are specified, without the need
of having example dicoms. Prior to running this script a Cohort File is needed, which can be created from
the following script:

/data/joy/BBL/projects/grmpyProcessing2017/grmpyProcessing2017Scripts/restbold1_124mb/Dico_SubjectFile.sh

Use
###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################

###########################
### Locates Cohort File ###
###########################

subjects=$(cat /data/joy/BBL/projects/grmpyProcessing2017/restbold1_124mb/SubjFile_RestingBold124mb.csv)

#############################################
### Reads Cohort File to Define the Input ###
#############################################

for s in $subjects; do 

s=(${s//,/ })
bblid=${s[0]}
datexscanid=${s[1]}
r=${s[2]}
rpsmap=${s[3]}
magmap=${s[4]}
b0mask=${s[5]}

echo ${bblid} ${datexscanid}

###############################################################
### Defines the Output Path and Names of Intermediate Files ###
###############################################################

outdir=/data/joy/BBL/studies/grmpy/processedData/restbold1_124mb/dico/${bblid}/${datexscanid}
magmap_masked=${outdir}/${bblid}_${datexscanid}~TEMP~magmap_masked.nii.gz
magmap_coreg=${outdir}/${bblid}_${datexscanid}~TEMP~_magmap_coreg.nii.gz
magmap_coreg_mask=${outdir}/${bblid}_${datexscanid}~TEMP~_magmap_coreg_mask.nii.gz
rpsmap_coreg=${outdir}/${bblid}_${datexscanid}~TEMP~_rpsmap_coreg.nii.gz
affine_mat=${outdir}/${bblid}_${datexscanid}~TEMP~_coreg.mat

############################################################
### Defines the Output Path and Names of the Final Files ###
############################################################

shiftmap=${outdir}/${bblid}_${datexscanid}_shiftmap.nii.gz
output=${outdir}/${bblid}_${datexscanid}_dico.nii.gz

mkdir -p ${outdir}

###########################################################
### Registers the RestBold Images by Using the RPS Maps ###
###########################################################

fslmaths ${magmap} -mas ${b0mask} ${magmap_masked}
flirt -ref ${r} -in ${magmap_masked} -dof 6 -omat ${affine_mat} -o ${magmap_coreg}
flirt -ref ${r} -in ${rpsmap} -init ${affine_mat} -o ${rpsmap_coreg} -applyxfm
fslmaths ${magmap_coreg} -bin ${magmap_coreg_mask}

#########################################
### Final Call to Generate the Output ###
#########################################

cmd="fugue -i ${r} --loadfmap=${rpsmap_coreg} --mask=${magmap_coreg_mask} --unwarpdir=y- --dwell=.000528 --smooth3=0 --noextend --unmaskshift --saveshift=${shiftmap} -u ${output}"

echo ${cmd}
${cmd}

##################################
### Removes Intermediate Files ###
##################################

rm ${outdir}/${bblid}_${datexscanid}~TEMP~*
        
done
###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################
