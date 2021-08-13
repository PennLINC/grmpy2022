
bblid=$(cat /data/jux/BBL/studies/grmpy/BIDSOUTPUT/scripts/bblid.txt)
rm cohortfile.csv

for b in $bblid; do 

img1=$(ls -d /data/jux/BBL/studies/grmpy/BIDS/*$b/ses-02/anat/*${b}_ses-02_T1w.nii.gz)


echo "$b,$img1" >>cohortfile.csv

done 

