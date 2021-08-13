



scriptdir=/data/joy/BBL/applications/scripts/bin
outputdir=/data/jux/BBL/studies/grmpy/microbiome/subjectData
scanid=$(cat /data/jux/BBL/studies/grmpy/microbiome/scanid.txt)


for b  in $scanid;  do 

python $scriptdir/dicoms2nifti_bblxnat.py -scanid $b -download 1  -outdir  $outputdir  -configfile /home/aadebimpe/.xnat.cfg  -scantype MPRAGE

done
echo "Done"
exit 
