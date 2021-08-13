#Get the paths for the microbome files for input to calculateComponentWeightedAverageNIFTI.m
rm /data/jux/BBL/studies/grmpy/microbiome/demographics/microbiome_CTsmooth_Paths.csv

cat /data/jux/BBL/studies/grmpy/microbiome/demographics/microbiome_bblid_scandid.txt  | while IFS="," read -r a b ;

do

#Jacobian paths                                                                                                                                       
filePath=`ls -d /data/jux/BBL/studies/grmpy/microbiome/output/NMF/ctmooth/${a}_CTsmoothed2mm.nii.gz`;

echo $filepath

echo $filePath >> /data/jux/BBL/studies/grmpy/microbiome/demographics/microbiome_CTsmooth_Paths.csv

done

