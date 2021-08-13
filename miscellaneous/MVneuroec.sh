#!/bin/sh 

###################################################################################################
##########################          GRMPY - Move Neuroec Files           ##########################
##########################              Robert Jirsaraie                 ##########################
##########################             rjirsara@upenn.edu                ##########################
##########################                  09/18/2017                   ##########################
###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################
<<Use

This script was created to move downloaded neuroec files from monstrum onto the CFN cluster in
a standardized format. Before this script was run the scp command was used to download the files and
place them on chead, see commands below.

#Download Files from monstrum
scp rjirsara@medulla:/import/monstrum/grmpy/subjects/neuroec/*/* /Users/rjirsaraie/Desktop/NeuroecTemp/
scp rjirsara@medulla:/import/monstrum/grmpy/subjects/*_*/behavioral/neuroec/* /Users/rjirsaraie/Desktop/NeuroecTemp/

#Download Files onto chead
scp /Users/rjirsaraie/Desktop/NeuroecTemp/* rjirsaraie@chead:~/NeuroecTemp/

Use
###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################

###########################
###Remove Unwanted Files###
###########################

rm /home/rjirsaraie/NeuroecTemp/*~
rm /home/rjirsaraie/NeuroecTemp/tmp*

###################################################
###Move Files with algorithum in their file name###
###################################################

OLDalgorithm=/home/rjirsaraie/NeuroecTemp/*algorithm*

for a in ${OLDalgorithm}; do echo ${a}|sed s@'_'@'-'@g|cut -d '-' -f6;done>>SubjIDalgorithm.csv

algorithmIDs=$(cat SubjIDalgorithm.csv)

for a in ${algorithmIDs}; do mkdir -p /data/joy/BBL/studies/grmpy/neuroec/${a}/behavioral/neuroec; done

for Y in ${algorithmIDs};do mv /home/rjirsaraie/NeuroecTemp/*algorithm*${Y}* /data/joy/BBL/studies/grmpy/neuroec/${Y}/behavioral/neuroec/

rm SubjIDalgorithm.csv

########################
###Move the csv files###
########################

OLDcsv=/home/rjirsaraie/NeuroecTemp/*.csv

for a in ${OLDcsv}; do echo ${a}|sed s@'_'@'-'@g|cut -d '-' -f3;done>>SubjIDcsv.csv

csvIDs=$(cat SubjIDcsv.csv)

for a in ${csvIDs}; do mkdir -p /data/joy/BBL/studies/grmpy/neuroec/${a}/behavioral/neuroec; done

for Y in ${csvIDs};do mv /home/rjirsaraie/NeuroecTemp/*${Y}*.csv /data/joy/BBL/studies/grmpy/neuroec/${Y}/behavioral/neuroec/; done

rm SubjIDcsv.csv

##########################
###Move the edat2 files###
##########################

OLDedat2=/home/rjirsaraie/NeuroecTemp/*.edat2

for a in ${OLDedat2}; do echo ${a}|sed s@'_'@'-'@g|cut -d '-' -f2;done>>SubjIDedat2.csv

edat2IDs=$(cat SubjIDedat2.csv)

for a in ${edat2IDs}; do mkdir -p /data/joy/BBL/studies/grmpy/neuroec/${a}/behavioral/neuroec; done

for Y in ${edat2IDs};do mv /home/rjirsaraie/NeuroecTemp/*${Y}*.edat2 /data/joy/BBL/studies/grmpy/neuroec/${Y}/behavioral/neuroec/; done

rm SubjIDedat2.csv

#########################
###Move the .txt files###
#########################

OLDtxt=/home/rjirsaraie/NeuroecTemp/*.txt

for a in ${OLDtxt}; do echo ${a}|sed s@'_'@'-'@g|cut -d '-' -f2;done>>SubjIDtxt.csv

txtIDs=$(cat SubjIDtxt.csv)

for a in ${txtIDs}; do mkdir -p /data/joy/BBL/studies/grmpy/neuroec/${a}/behavioral/neuroec; done

for Y in ${txtIDs};do mv /home/rjirsaraie/NeuroecTemp/*${Y}*.txt /data/joy/BBL/studies/grmpy/neuroec/${Y}/behavioral/neuroec/; done

rm SubjIDtxt.csv

#########################
###Move the .mat files###
#########################

OLDmat=/home/rjirsaraie/NeuroecTemp/*.mat

for a in ${OLDmat}; do echo ${a}|sed s@'_'@'-'@g|cut -d '-' -f3;done>>SubjIDmat.csv

matIDs=$(cat SubjIDmat.csv)

for a in ${matIDs}; do mkdir -p /data/joy/BBL/studies/grmpy/neuroec/${a}/behavioral/neuroec; done

for Y in ${matIDs};do mv /home/rjirsaraie/NeuroecTemp/*${Y}*.mat /data/joy/BBL/studies/grmpy/neuroec/${Y}/behavioral/neuroec/; done

rm SubjIDmat.csv

###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################


