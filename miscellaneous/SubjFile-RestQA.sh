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

subjects=/data/jux/BBL/studies/grmpy/processedData/restbold1_124mb/restbold_pipeline_20180131/*/*/
outdirect=/data/jux/BBL/projects/grmpyProcessing2017/restbold1_124mb/autoQA/

rm ${outdirect}n101_NormCoverage_20180212.csv

for s in $subjects; do 
bblIDs=$(echo ${s}|cut -d'/' -f10|sed s@'/'@' '@g)
SubjectxDate=$(echo ${s}|cut -d'/' -f11)
scanID=$(echo ${SubjectxDate}|cut -d',' -f2)
Date=$(echo ${SubjectxDate}|cut -d',' -f1)
path=$(echo ${s}norm/${bblIDs}_${SubjectxDate}_maskStd.nii.gz)

echo ${bblIDs},${scanID},${path}>>${outdirect}n101_NormCoverage_20180212.csv

done

###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################
