#!/bin/sh

###################################################################################################
##########################         GRMPY - Struct Pipeline Check         ##########################
##########################              Robert Jirsaraie                 ##########################
##########################             rjirsara@upenn.edu                ##########################
##########################                  08/14/2017                   ##########################
###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################
<<Use

This script was created to check the progress of the structural pipeline as it is processing.
Specifically, this script looks for the JLF output image and records which subjects have the 
image complete and which subjects are still missing the image. 

Use
###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################

subjects=/data/joy/BBL/studies/grmpy/processedData/structural/struct_pipeline_20170*/*
outdirect=/data/joy/BBL/projects/grmpyProcessing2017/Audits/struct_pipeline

for s in $subjects; do 

imgCheck=$(ls ${s}/*/jlf/*Labels.nii.gz 2>/dev/null) 

if [[ -f ${imgCheck} ]] ; then 

   echo "Label Image Complete For This Subject"
   echo ${s}|cut -d'/' -f10|sed s@'/'@' '@g>>${outdirect}/completelabelIMGs.txt

else

   echo "Label Image Missing For This Subject"
   echo ${s}|cut -d'/' -f10|sed s@'/'@' '@g>>${outdirect}/missinglabelIMGs.txt

fi
done

###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################
