#!/bin/bash

subjectdir=/data/jux/BBL/studies/grmpy/microbiome/subjectData
bblid=$(cat /data/jux/BBL/studies/grmpy/microbiome/bblid.txt)
scanid=$(cat /data/jux/BBL/studies/grmpy/microbiome/scanid.txt)

for b  in $bblid;  do 
 	

     img1=$(ls -d $subjectdir/${b}/*/*/*/*.nii.gz) 
     echo $img1
     dd2=$(basename $img1)
     dd=$(ls -d $subjectdir/${b}/*)
     echo $dd
     id2=$(basename $dd)
     echo $id2
     echo "$b,$id2,$img1" >> mic_cohort1.csv  

done

