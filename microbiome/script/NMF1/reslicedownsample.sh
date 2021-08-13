#Reslice the microbiome images to 2mm isotropic (which also downsamples to 2mm) and smooth 2mm before applying NMF volume weights to it.

# combine bbblid and scanid 

demodir=/data/jux/BBL/studies/grmpy/microbiome/demographics
rm  $demodir/microbiome_bblid_scandid.txt

paste -d ', ' $demodir/bblid.txt $demodir/scanid.txt > $demodir/microbiome_bblid_scandid.txt

cat  $demodir/microbiome_bblid_scandid.txt | while IFS="," read -r a b ;


do



antPath=`ls -d  /data/jux/BBL/studies/grmpy/microbiome/output/structural/${a}/*x${b}/antsCT/*_CorticalThicknessNormalizedToTemplate.nii.gz`;
smoothOutdir=/data/jux/BBL/studies/grmpy/microbiome/output/NMF/ctmooth
resliceOutdir=/data/jux/BBL/studies/grmpy/microbiome/output/NMF/resclice
antPathName=$(echo $antPath|cut -d, -f1)
antFullFileName=$(basename $antPath)
antFileName=$(basename $antPath | cut -d. -f1)



echo " "

echo "Reslicing and downsampling ${a} ${b}"

antsApplyTransforms -e 3 -d 3 -i $antPathName -r /data/joy/BBL/studies/pnc/template/pnc_template_brain_2mm.nii.gz -o $resliceOutdir/${a}_reslice_isotropic2mm.nii.gz

echo " "

echo "Smoothing ${a} ${b}"

#NOTE: fslmaths requires smoothing parameters in sigma                                                                                               
#FWHM = 2.355*sigma                                                                                                                                  
#2mm FWHM = .85 sigma

sig=.85

fslmaths $resliceOutdir/${a}_reslice_isotropic2mm.nii.gz -s $sig $smoothOutdir/${a}_CTsmoothed2mm.nii.gz

done

