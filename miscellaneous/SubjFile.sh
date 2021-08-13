#!/bin/sh

###################################################################################################
##########################         GRMPY - Create Subject Files          ##########################
##########################              Robert Jirsaraie                 ##########################
##########################             rjirsara@upenn.edu                ##########################
##########################                  09/18/2017                   ##########################
###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################
<<Use

This script was created to identify the subjects of interest and list their information into correct format.
The output file of this script in multiple other scripts to run the structural pipeline and B0dicoms into
rps.nii.gz images. 

Use
###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################

subjects=/data/joy/BBL/studies/grmpy/processedData/structural/struct_pipeline_20170716/*/*/
outdirect=outdirect=/data/joy/BBL/projects/grmpyProcessing2017/

rm ${outdirect}/SubjFile.csv

for s in $subjects; do 
bblIDs=$(echo ${s}|cut -d'/' -f10|sed s@'/'@' '@g)
SubjectxDate=$(echo ${s}|cut -d'/' -f11|sed s@'/'@' '@g|sed s@'x'@','@g)
scanID=$(echo ${SubjectxDate}|cut -d',' -f2)
Date=$(echo ${SubjectxDate}|cut -d',' -f1)

echo ${bblIDs},${scanID},${Date},${Date}x${scanID}>>${outdirect}/SubjFile.csv

done

###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################
