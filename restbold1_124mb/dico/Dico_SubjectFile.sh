#!/bin/sh

###################################################################################################
##########################       GRMPY - Create DICO Subject Files       ##########################
##########################              Robert Jirsaraie                 ##########################
##########################             rjirsara@upenn.edu                ##########################
##########################                  10/07/2017                   ##########################
###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################
<<Use

This script was created to identify the subjects of interest and list their information into correct format.
In particular, this cohort script was specifically used to help apply Distortion Correction on RestBold Images.

Use
###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################

subjects=/data/joy/BBL/studies/grmpy/rawData/*/*/bbl1_restbold1_124mb/nifti/*.nii.gz
outdirect=/data/joy/BBL/projects/grmpyProcessing2017/restbold1_124mb

for s in $subjects; do 


bblIDs=$(echo ${s}|cut -d'/' -f8|sed s@'/'@' '@g)
SubjectxDate=$(echo ${s}|cut -d'/' -f9|sed s@'/'@' '@g)
r=$(echo ${s})
rpsmap=$(echo /data/joy/BBL/studies/grmpy/processedData/B0map/${bblIDs}/${SubjectxDate}/*_rpsmap.nii.gz)
magmap=$(echo /data/joy/BBL/studies/grmpy/processedData/B0map/${bblIDs}/${SubjectxDate}/*_mag1_brain.nii.gz)
Mask=$(echo /data/joy/BBL/studies/grmpy/processedData/B0map/${bblIDs}/${SubjectxDate}/*_mask.nii.gz)


echo ${bblIDs},${SubjectxDate},${r},${rpsmap},${magmap},${Mask}>>${outdirect}/n102_DicoCohort_20171007.csv

done

###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################


