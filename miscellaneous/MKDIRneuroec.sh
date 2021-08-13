#!/bin/sh

###################################################################################################
##########################      GRMPY - Neuroec Directory Restruct       ##########################
##########################              Robert Jirsaraie                 ##########################
##########################             rjirsara@upenn.edu                ##########################
##########################                  09/24/2017                   ##########################
###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################
<<Use

This script was created to restructure the directories that store the neuroec data, and also assign
identifying information as a prefix of all files.

#rawData/103679/20160409x10110/MPRAGE_TI1100_ipat2/nifti/010110_MPRAGE_TI1100_ipat2.nii.gz 

Use
###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################

###################################
### Define the Subjects to Move ###
###################################

subjects=/data/joy/BBL/studies/grmpy/rawData/*/*/

i=0
for s in $subjects; do 

bblIDs[i]=$(echo ${s}|cut -d'/' -f8 |sed s@'/'@' '@g);
SubjectxDate[i]=$(echo ${s}|cut -d'/' -f9|sed s@'/'@' '@g);

################################
### Make the New Directories ###
################################

mkdir -p /data/joy/BBL/studies/grmpy/neuroec/${bblIDs[i]}/${SubjectxDate[i]}/

#######################################
### Move Files Into New Directories ###
#######################################

cp /data/joy/BBL/studies/grmpy/neuroec/${bblIDs[i]}/behavioral/neuroec/* /data/joy/BBL/studies/grmpy/neuroec/${bblIDs[i]}/${SubjectxDate[i]}/

mv /data/joy/BBL/studies/grmpy/neuroec/${bblIDs[i]}/* /data/joy/BBL/studies/grmpy/neuroec/${bblIDs[i]}/${SubjectxDate[i]}/

##############################
### Remove Old Directories ###
##############################

rm -rf /data/joy/BBL/studies/grmpy/neuroec/${bblIDs[i]}/${SubjectxDate[i]}/behavioral/

((i++))
done

##########################################
### Rename the Files By Adding Prefixs ###
##########################################

NeuroecSubj=/data/joy/BBL/studies/grmpy/neuroec/*/*/*

i=0
for n in $NeuroecSubj; do 

directory[i]=$(echo ${n}|cut -d'/' -f1-9)
BBLid[i]=$(echo ${n}|cut -d'/' -f8)
DatexScanID[i]=$(echo ${n}|cut -d'/' -f9)
Files=$(basename ${n})

mv ${n} ${directory[i]}/${BBLid[i]}_${DatexScanID[i]}_$Files

((i++))
done

###################################################
### Rename Files by Removing Suffix - Algorithm ###
###################################################

algorithm=/data/joy/BBL/studies/grmpy/neuroec/*/*/*algorithm*

i=0
for a in $algorithm; do

algor[i]=$(echo ${a}|sed s@'-'@'_'@g|cut -d'_' -f1-6)
suffix[i]=$(echo ${a}|cut -d'.' -f2-3)

mv ${a} ${algor[i]}.${suffix[i]}

((i++))
done

###################################################
### Rename Files by Removing Suffix - Processed ###
###################################################

processed=/data/joy/BBL/studies/grmpy/neuroec/*/*/*processed*

for p in $processed; do

algor[i]=$(echo ${p}|cut -d'_' -f1-3)
suffix[i]=$(echo ${p}|cut -d'.' -f2)

mv ${p} ${algor[i]}.${suffix[i]}

((i++))
done

######################################################
### Rename Files by Removing Suffix - RiskAversion ###
######################################################

RiskAversion=/data/joy/BBL/studies/grmpy/neuroec/*/*/*RiskAversion*

i=0
for r in $RiskAversion; do

algor[i]=$(echo ${r}|sed s@'-'@'_'@g|cut -d'_' -f1-3)
suffix[i]=$(echo ${r}|cut -d'.' -f2)


mv ${r} ${algor[i]}.${suffix[i]}

((i++))
done

######################################################
### Rename Files by Removing Suffix - LossAversion ###
######################################################

removeSuffix(){
   local l
   local i=0
   shift 2
   for l in ${@}; do

   algor[i]=$(echo ${l}|sed s@'-'@'_'@g|cut -d'_' -f1-3)
   suffix[i]=$(echo ${l}|cut -d'.' -f2)


   mv ${l} ${algor[i]}.${suffix[i]}

   ((i++))
   done
}

LossAversion=/data/joy/BBL/studies/grmpy/neuroec/*/*/*LossAversion*
removeSuffix 1-3 2 ${LossAversion}

ITCv=/data/joy/BBL/studies/grmpy/neuroec/*/*/*ITCv*
removeSuffix ${ITCv}

qtask=/data/joy/BBL/studies/grmpy/neuroec/*/*/*qtask*
removeSuffix ${qtask}

###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################
<<NOTES

removeSuffix(){
   local alg_f=${1} #Must Define Variables as Local So they Reset After Every Use
   local suf_f=${2} 
   local l
   local i=0
   shift 2 # Excludes the First Two Arguments
   for l in ${@}; do

   algor[i]=$(echo ${l}|sed s@'-'@'_'@g|cut -d'_' -f${alg_f})
   suffix[i]=$(echo ${l}|cut -d'.' -f${suf_f})


   mv ${l} ${algor[i]}.${suffix[i]}

   ((i++))
   done
}

LossAversion=/data/joy/BBL/studies/grmpy/neuroec/*/*/*LossAversion*
removeSuffix 1-3 2 ${LossAversion}

ITCv=/data/joy/BBL/studies/grmpy/neuroec/*/*/*ITCv*
removeSuffix ${ITCv}

qtask=/data/joy/BBL/studies/grmpy/neuroec/*/*/*qtask*
removeSuffix ${qtask}

NOTES

