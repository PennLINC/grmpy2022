#!/bin/sh

###################################################################################################
##########################     GRMPY - Create Pipeline Subject Files     ##########################
##########################              Robert Jirsaraie                 ##########################
##########################             rjirsara@upenn.edu                ##########################
##########################                   1/17/2018                   ##########################
###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################
<<Use

This script was created to identify the subjects of interest and list their information into correct format. 
In particular, this cohort file was specifically used to initiate the restbold pipeline.

Use
###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################

subjects=/data/jux/BBL/studies/grmpy/processedData/restbold1_124mb/dico/*/*/*dico.nii.gz
outdirect=/data/jux/BBL/projects/grmpyProcessing2017/restbold1_124mb/rest_pipeline


for s in $subjects; do 

bblIDs=$(echo ${s}|cut -d'/' -f10|sed s@'/'@' '@g)
SubjectxDate=$(echo ${s}|cut -d'/' -f11|sed s@'/'@' '@g)
img=$(echo ${s})
antsct=$(echo /data/jux/BBL/studies/grmpy/processedData/structural/struct_pipeline_20170716/${bblIDs}/${SubjectxDate}/)

echo ${bblIDs},${SubjectxDate},${img},${antsct}>>${outdirect}/n101_Cohort_20180119.csv

done

###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################
