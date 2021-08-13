#!/bin/bash

subjectdir=/data/jux/BBL/studies/grmpy/microbiome/subjectData
bblid=$(cat /data/jux/BBL/studies/grmpy/microbiome/subjectData/bblid.txt)
#scanid=$(cat /data/jux/BBL/studies/grmpy/microbiome/scanid.txt)

echo "bblid, scanid,date,datexscaind" >> microbiomesubjlist.csv

for b  in $bblid;  do 
 	

     img1=$(ls -d $subjectdir/${b}/*/*/*/*.nii.gz) 
     echo $img1
     dd2=$(basename $img1)
     dd=$(ls -d $subjectdir/${b}/*)
     echo $dd
     id2=$(basename $dd)
     s=${id2##*x}
     d=${id2%x*}
     echo "$b,$s,$d,$id2" >>microbiomesubjlist.csv  

done

