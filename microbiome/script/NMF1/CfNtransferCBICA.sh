#!/bin/sh

###################################################################################################
##########################        Microbiome - Transfer CT Images          ##########################
##########################              Az                                 ##########################
##########################        rjirsara@pennmedicine.upenn.edu        ##########################
##########################                  03/05/2018                   ##########################
###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################
<<Use

These commands were used to transfer the CT masks to CBICA where they will be inputed into the NMF analysis.
In order to log into CBICA you must connect through a VPN; the PennMedicine Network will not work.

Use
###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################

########################################################################
### Create A Zip File that Contains All Smooth the Files to be Moved ###
########################################################################

CfNpath=/data/jux/BBL/studies/grmpy/microbiome/output/NMF/ctSmooth

cd ${CfNpath}/

tar -cvf ${CfNpath}/n30_Smoothed4mm_2018.tar.gz *

########################################################################################
### Log out of CfN and Into CBICA then Get Writing Permission using the Sudo Command ###
########################################################################################

logout

ssh adebimpa@cbica-cluster.uphs.upenn.edu

sudo -u gurlab sudosh

#####################################
### Transfer the Smooth CT Images ###
#####################################

CfNpath=/data/jux/BBL/studies/grmpy/microbiome/output/NMF/ctSmooth
CBICApath=/cbica/projects/GURLAB/microbiome/output/NMF/ctSmooth

mkdir -p ${CBICApath}

scp -r aadebimpe@chead:${CfNpath}/n30_Smoothed4mm_2018.tar.gz ${CBICApath}/

#########################################################################
### Unpack and Remove Zip File while Extending Permissions to the Lab ###
#########################################################################

tar -xvf ${CBICApath}/n30_Smoothed4mm_2018.tar.gz

chmod 777 ${CBICApath}/*

rm -rf ${CBICApath}/n30_Smoothed4mm_2018.tar.gz

#################################
### Transfer the Subject List ###
#################################

CfNsubs=/data/jux/BBL/studies/grmpy/microbiome/output/NMF/ctRaw/microbiome_cohort_2018.csv
CfNraw=/data/jux/BBL/studies/grmpy/microbiome/output/NMF/ctRaw/microbiome_ctRaw_2018.csv

CBICAsubs=/cbica/projects/GURLAB/microbiome/subjectdata

mkdir -p ${CBICAsubs}

scp -r aadebimpe@chead:${CfNsubs} ${CBICAsubs}/
scp -r aadebimpe@chead:${CfNraw} ${CBICAsubs}/

chmod 777 ${CBICAsubs}/*

################################################
### Create a Text File of Smooth Image Paths ###
################################################

subjects=$(cat ${CBICAsubs}/microbiome_cohort_2018.csv | cut -d ',' -f2)

for s in $subjects; do 

ls -d ${CBICApath}/*_*${s}_*4mm.nii.gz* >> ${CBICAsubs}/microbiome_ctSmooth_2018.csv

done

chmod 777 ${CBICAsubs}/*

#######################################################
### Transfer the CT Mask of all Subjects onto CBICA ###
#######################################################

CfNmask=/data/jux/BBL/studies/grmpy/microbiome/output/NMF/ctMasks/microbiome_ctMask_thr9_2mm.nii.gz
CBICAmask=/cbica/projects/GURLAB/microbiome/ctMask

mkdir -p ${CBICAmask}

scp -r aadebimpe@chead:${CfNmask} ${CBICAmask}/

################################################
### Transfer the Scripts to Run NMF on CBICA ###
################################################

CallScript=/data/jux/BBL/studies/grmpy/microbiome/script/NMF1/Run_NMF_CT.sh
RunScript=/data/jux/BBL/studies/grmpy/microbiome/script/NMF1/submit_script_extractBasesMT.sh
basescript=/data/jux/BBL/studies/grmpy/microbiome/script/NMF1/extractBasesMT

CBICAscripts=/cbica/projects/GURLAB/microbiome/scripts
mkdir -p ${CBICAscripts}

scp -r aadebimpe@chead:${CallScript} ${CBICAscripts}/
scp -r aadebimpe@chead:${RunScript} ${CBICAscripts}/
#scp -r aadebimpe@chead:${CBICAscripts} ${CBICAscripts}/

###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################

