#!/bin/sh

###################################################################################################
##########################            GRMPY - Move B0dicoms              ##########################
##########################              Robert Jirsaraie                 ##########################
##########################             rjirsara@upenn.edu                ##########################
##########################                  08/28/2017                   ##########################
###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################
<<Use

This script was created to move downloaded B0dicoms from Xnat onto the CFN cluster and in the correct format. 
Prior to using this script images should be manually downloaded from Xnat and put into a single .zip file, 
then placed in your home directory using the scp command, example below.Then you can use this script to move 
the dicoms into their given directories, but you must double check that the files are renamed properly, as seen
on xnat.

Example: imac:~ rjirsaraie$ scp ~/Desktop/010110.zip rjirsaraie@chead:~   

Use
###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################

subjects='10134 10136 10142 10145 10156 10158 10280 10333 10357 10577'
directorys=
'/data/joy/BBL/studies/grmpy/rawData/106071/*x10333/
/data/joy/BBL/studies/grmpy/rawData/110828/*x10134/
/data/joy/BBL/studies/grmpy/rawData/118990/*x10156/
/data/joy/BBL/studies/grmpy/rawData/121476/*x10280/
/data/joy/BBL/studies/grmpy/rawData/121670/*x10158/
/data/joy/BBL/studies/grmpy/rawData/129354/*x10357/
/data/joy/BBL/studies/grmpy/rawData/129405/*x10136/
/data/joy/BBL/studies/grmpy/rawData/85083/*x10577/
/data/joy/BBL/studies/grmpy/rawData/90683/*x10142/
/data/joy/BBL/studies/grmpy/rawData/93292/*x10145/'

############################################################################
###Unzip the commpressed file and manually remove 0 in front of directory###
############################################################################

unzip ~/*.zip

######################################################################
###Makes standard directories for subjects that were missing dicoms###
######################################################################

for d in $directorys; do mkdir ${d}/B0_dicomsM ${d}/B0_dicomsP; done

################################################################
###Moves the M and P dicoms into their respective directories###
################################################################

for s in $subjects; do mv ~/*${s}/SCANS/*/DICOM/B0map_P*.dcm /data/joy/BBL/studies/grmpy/rawData/*/*x${s}/B0_dicomsP/; done
for s in $subjects; do mv ~/*${s}/SCANS/*/DICOM/B0map_M*.dcm /data/joy/BBL/studies/grmpy/rawData/*/*x${s}/B0_dicomsM/; done

#######################################################
###Cleans up some extra files in your home directory###
#######################################################

rm ~/*__MACOSX* ~/*.zip

###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################
<<TROUBLESHOOT

If some subjects did not transfer it is likely because they had different names on Xnat and need to be manually adjusted
The commands below can be used to adjust names, but you must doublecheck which sequence the imges are before renaming and 
why they were named differently on xnat. 

#dicoms=$(ls *um0008*.dcm); for d in $dicoms; do d_new=${d//001_um0008_/B0map_M_S008_I}; mv ${d} ${d_new}; done
#dicoms=$(ls *um009*.dcm); for d in $dicoms; do d_new=${d//001_um0009_/B0map_P_S009_I}; mv ${d} ${d_new}; done
#dicoms=$(ls *000009*.dcm); for d in $dicoms; do d_new=${d//001_000009_/B0map_M_S009_I}; mv ${d} ${d_new}; done
#dicoms=$(ls *000010*.dcm); for d in $dicoms; do d_new=${d//001_000010_/B0map_P_S010_I}; mv ${d} ${d_new}; done

TROUBLESHOOT
