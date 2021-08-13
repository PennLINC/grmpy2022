#!/bin/sh

###################################################################################################
##########################       GRMPY - Xnat Download onto cHead        ##########################
##########################              Robert Jirsaraie                 ##########################
##########################        rjirsara@pennmedicine.upenn.edu        ##########################
##########################                03/17/2018                     ##########################
###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####   
###################################################################################################
<<Use

This script is used to download the dicoms from Xnat onto cHead, which will then be converted to nifits 
and stored in their respective directories. 

Use
###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####   
###################################################################################################

######################################################################
#####  For Loop that Tells the Script which Subjects to Download #####   
######################################################################

subjects='list the scanids of the group of subjects to download'

for s in ${subjects}; do 


/share/apps/python/Python-2.7.9/bin/python /data/jux/BBL/applications-from-joy/scripts/bin/dicoms2nifti_bblxnat.py  -scanid ${s} -download 1 -outdir /data/jux/BBL/studies/grmpy/rawData -tmpdir /data/jux/BBL/tmp/ -check_existing 0 -force_unmatched 0 -download_example_dicom 0 -download_dicoms 0 -skip_oblique 0 -seqname mprage &

done

########################################################################################################
#####  Add the Additional Argument Below to the For Loop if you want to Only Download One Sequence #####   
########################################################################################################

#-seqname 'enter the names of the sequence to download'

<<Example

/share/apps/python/Python-2.7.9/bin/python /data/jux/BBL/applications-from-joy/scripts/bin/dicoms2nifti.py -scanid ${o} -download 1 -outdir /data/jux/BBL/studies/grmpy/rawData -tmpdir /data/jux/BBL/tmp/ -check_existing 0 -force_unmatched 0 -download_example_dicom 0 -download_dicoms 0 -skip_oblique 0 -seqname mprage &

Example
###############################################################################################################
##### To Download GRMPY Subjects Stored on the Old Version of Xnat use the Script Below. This is the most #####
#####    likely the solution if the previous script was unable to find a subject that are on Xnat         #####
###############################################################################################################

#OldSubjects='list the scanids of the group of subjects to download'

<<Example

for o in ${OldSubjects}; do 

/share/apps/python/Python-2.7.9/bin/python /data/jux/BBL/applications-from-joy/scripts/bin/dicoms2nifti.py -scanid ${o} -download 1 -outdir /data/jux/BBL/studies/grmpy/rawData -tmpdir /home/rjirsaraie/tmp/ -check_existing 0 -force_unmatched 0 -download_example_dicom 0 -download_dicoms 0 -skip_oblique 0 

done

Example

##############################################################################
##### Use this version of the script to Download all unmatched sequences #####
##############################################################################

<<Example

/share/apps/python/Python-2.7.9/bin/python /data/jux/BBL/applications-from-joy/scripts/bin/dicoms2nifti.py -scanid {scanid} -download 1 -outdir /data/jux/BBL/studies/grmpy/rawData -tmpdir /data/jux/BBL/tmp/ -check_existing 0 -force_unmatched 1 -download_example_dicom 0 -download_dicoms 0 -skip_oblique 0 -seqname {Seq}


Example
###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####   
###################################################################################################
