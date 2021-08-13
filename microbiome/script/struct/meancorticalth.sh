#!/bin/bash

subjectdir=/data/jux/BBL/studies/grmpy/microbiome/
bblid=$(cat /data/jux/BBL/studies/grmpy/microbiome/demographics/bblid.txt)
scanid=$(cat /data/jux/BBL/studies/grmpy/microbiome/demographics/scanid.txt)

echo "bblid,meanCT">>/data/jux/BBL/studies/grmpy/microbiome/demographics/meanCT.csv

for b  in $bblid;  do 
     img1=$(ls -d /data/jux/BBL/studies/grmpy/microbiome/output/structural/*$b/*/antsCT/*CorticalThickness.nii.gz)
     ct=$(fslstats $img1 -M)
     echo "$b,$ct" >> /data/jux/BBL/studies/grmpy/microbiome/demographics/meanCT.csv
done

