#!/bin/sh

###################################################################################################
##########################        GRMPY - Multiple Sequence Audit        ##########################
##########################              Robert Jirsaraie                 ##########################
##########################             rjirsara@upenn.edu                ##########################
##########################                  07/21/2017                   ##########################
###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####   
###################################################################################################
<<Use

This script can determine if subjects are missing images from multiple sequences. A text file will
output which lists all the subjectIDs that are missing a given sequence. 

Use
###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####   
###################################################################################################

input=$1; shift
sequence=$@
sequence=$(echo $sequence|sed s@','@' '@g)

for s in $sequence
do

imgCheck=$(ls ${input}/*/${s}/ 2>/dev/null)

if [[ -n ${imgCheck} ]] ; then 
   
   echo "${s} Image Already Exists"
   
else

echo ${input}/*/>>SubjMissing${s}_20170719.txt
   
fi
done

###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####   
###################################################################################################
<<COMMANDLINE

subjects=/data/joy/BBL/studies/grmpy/rawData/*
sequences='B0_dicoms,B0_dicomsM,B0_dicomsP'

for s in $subjects; do echo ${s}:; ./MultiSeqAudit.sh $s $sequences; done

COMMANDLINE

