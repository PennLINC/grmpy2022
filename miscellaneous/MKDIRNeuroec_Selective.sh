#!/bin/sh

###################################################################################################
##########################      GRMPY - Neuroec Directory Restruct       ##########################
##########################              Robert Jirsaraie                 ##########################
##########################             rjirsara@upenn.edu                ##########################
##########################                  03/24/2017                   ##########################
###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################
<<Use

This script was created to restructure the directories that store the neuroec data, and also assign
identifying information as a prefix of all files.


Use
###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################

####################################################
### On Monstrum, make a list of all the Subjects ###
####################################################

mkdir /import/monstrum/grmpy/subjects/CFNtransfer_20180325/

subjects=/import/monstrum/grmpy/subjects/*_*
GoX=/import/monstrum/grmpy/subjects/GoXSubjects/*

for s in ${subjects}; do 

echo ${s}/behavioral/neuroec/*.*  | cut -d '/' -f6 | cut -d '_' -f1 | grep -v 'CFNtransfer' >> /import/monstrum/grmpy/subjects/CFNtransfer_20180325/Subjects_Monstrum.csv

done 

for g in ${GoX}; do 

echo ${g}/behavioral/neuroec/*.*  | cut -d '/' -f7 >> /import/monstrum/grmpy/subjects/CFNtransfer_20180325/Subjects_Monstrum.csv

done

### Tranfer File to CFN ###

scp rjirsara@medulla:/import/monstrum/grmpy/subjects/CFNtransfer_20180325/Subjects_Monstrum.csv ~/Desktop/
scp ~/Desktop/Subjects_Monstrum1.csv rjirsaraie@chead:/home/rjirsaraie/NeuroX/

#####################################################################
### On chead, make a list of those subjects missing from Monstrum ###
#####################################################################

subjects=$(cat /home/rjirsaraie/NeuroX/Subjects_Monstrum.csv)

for s in $subjects; do 

imgCheck=$(ls /data/jux/BBL/studies/grmpy/rawNeuroec/${s}/*/*.* 2>/dev/null) 

if [[ -n ${imgCheck} ]] ; then 

   echo ${s}" has already been Transfered"

else

   echo ${s}|cut -d'/' -f8,9|sed s@'/'@' '@g>>/home/rjirsaraie/NeuroX/MissingNeuroX.csv

fi
done
### Transfer File to Monstrum ###

scp rjirsaraie@chead:/home/rjirsaraie/NeuroX/MissingNeuroX.csv ~/Desktop/
scp ~/Desktop/MissingNeuroX.csv rjirsara@medulla:/import/monstrum/grmpy/subjects/CFNtransfer_20180325/

##########################################################################
### On Monstrum, Create a Compressed Directory of the Files to Tranfer ###
##########################################################################

Missing=$(cat /import/monstrum/grmpy/subjects/CFNtransfer_20180325/MissingNeuroX.csv)

for m in ${Missing}; do 

mkdir /import/monstrum/grmpy/subjects/CFNtransfer_20180325/${m}

cp /import/monstrum/grmpy/subjects/${m}_*/behavioral/neuroec/*.* /import/monstrum/grmpy/subjects/CFNtransfer_20180325/${m}

done

tar -cvf NeuroXTransfer.tar /import/monstrum/grmpy/subjects/CFNtransfer_20180325/ 

### Transfer File to chead ###

scp rjirsara@medulla:/import/monstrum/grmpy/subjects/CFNtransfer_20180325/NeuroXTransfer.tar ~/Desktop/
scp ~/Desktop/NeuroXTransfer.tar rjirsaraie@chead:/home/rjirsaraie/NeuroX/

##########################################################################################
### Unpack Tar File and Collect Scanids and Date to Make Directories To Transfer Files ###
##########################################################################################

tar -xvf /home/rjirsaraie/NeuroX/NeuroXTransfer.tar
rm /home/rjirsaraie/NeuroX/import/monstrum/grmpy/subjects/CFNtransfer_20180325/*.csv

Missing=$(cat /home/rjirsaraie/NeuroX/MissingNeuroX.csv)

i=0
for m in ${Missing}; do 

subject[i]=$(echo /data/jux/BBL/studies/grmpy/rawData/${m}/* | cut -d '/' -f8,9)

mkdir -p  /data/jux/BBL/studies/grmpy/rawNeuroec/${subject[i]}/

cp /home/rjirsaraie/NeuroX/import/monstrum/grmpy/subjects/CFNtransfer_20180325/${m}/*.* /data/jux/BBL/studies/grmpy/rawNeuroec/${m}/*/

((i++))
done

################################################
### Rename the Files To Have the Same Prefix ###
################################################

Missing=$(cat /home/rjirsaraie/NeuroX/MissingNeuroX.csv)

for m in ${Missing}; do 

NeuroecSubj=/data/joy/BBL/studies/grmpy/rawNeuroec/${m}/*/*

i=0
for n in $NeuroecSubj; do 

directory[i]=$(echo ${n}|cut -d'/' -f1-9)
BBLid[i]=$(echo ${n}|cut -d'/' -f8)
DatexScanID[i]=$(echo ${n}|cut -d'/' -f9)
Files=$(basename ${n})

echo ${directory[i]}
echo ${BBLid[i]}
echo ${DatexScanID[i]}
echo $Files

mv ${n} ${directory[i]}/${BBLid[i]}_${DatexScanID[i]}_$Files


done
((i++))
done

###################################################
### Rename Files by Removing Suffix - Algorithm ###
###################################################

for m in ${Missing}; do 

algorithm=/data/joy/BBL/studies/grmpy/rawNeuroec/${m}/*/*algorithm*

i=0
for a in $algorithm; do

algor[i]=$(echo ${a}|sed s@'-'@'_'@g|cut -d'_' -f1-6)
suffix[i]=$(echo ${a}|cut -d'.' -f2-3)

mv ${a} ${algor[i]}.${suffix[i]}

done
((i++))
done

###################################################
### Rename Files by Removing Suffix - Processed ###
###################################################

for m in ${Missing}; do
 
processed=/data/joy/BBL/studies/grmpy/rawNeuroec/${m}/*/*processed*

for p in $processed; do

algor[i]=$(echo ${p}|cut -d'_' -f1-3)
suffix[i]=$(echo ${p}|cut -d'.' -f2)

mv ${p} ${algor[i]}.${suffix[i]}

done
((i++))
done

######################################################
### Rename Files by Removing Suffix - RiskAversion ###
######################################################

for m in ${Missing}; do 

RiskAversion=/data/joy/BBL/studies/grmpy/rawNeuroec/${m}/*/*RiskAversion*

i=0
for r in $RiskAversion; do

algor[i]=$(echo ${r}|sed s@'-'@'_'@g|cut -d'_' -f1-3)
suffix[i]=$(echo ${r}|cut -d'.' -f2)


mv ${r} ${algor[i]}.${suffix[i]}

done
((i++))
done

######################################################
### Rename Files by Removing Suffix - LossAversion ###
######################################################

for m in ${Missing}; do

LossAversion=/data/joy/BBL/studies/grmpy/rawNeuroec/${m}/*/*LossAversion*

i=0
for l in ${LossAversion}; do

algor[i]=$(echo ${l}|sed s@'-'@'_'@g|cut -d'_' -f1-3)
suffix[i]=$(echo ${l}|cut -d'.' -f2)

mv ${l} ${algor[i]}.${suffix[i]}

done
((i++))
done

##############################################
### Rename Files by Removing Suffix - ITCv ###
##############################################

for m in ${Missing}; do

ITCv=/data/joy/BBL/studies/grmpy/rawNeuroec/${m}/*/*ITCv*

i=0
for l in ${ITCv}; do

algor[i]=$(echo ${l}|sed s@'-'@'_'@g|cut -d'_' -f1-3)
suffix[i]=$(echo ${l}|cut -d'.' -f2)

mv ${l} ${algor[i]}.${suffix[i]}

done
((i++))
done

###############################################
### Rename Files by Removing Suffix - qtask ###
###############################################

for m in ${Missing}; do

qtask=/data/joy/BBL/studies/grmpy/rawNeuroec/${m}/*/*qtask*

i=0
for l in ${qtask}; do

algor[i]=$(echo ${l}|sed s@'-'@'_'@g|cut -d'_' -f1-3)
suffix[i]=$(echo ${l}|cut -d'.' -f2)

mv ${l} ${algor[i]}.${suffix[i]}

done
((i++))
done

###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################
