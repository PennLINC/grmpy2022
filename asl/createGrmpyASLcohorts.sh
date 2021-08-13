# ---------------------------------- #
# create asl processing cohort files #
# ---------------------------------- #

# create online reconstruction cohort files

## naming format: ASL_3DSpiral_OnlineRecon_ASL
for i in `ls -d /data/joy/BBL/studies/grmpy/rawData/*/*`;do 
bblid=`echo $i | cut -d '/' -f8`
datexscanid=`echo $i | cut -d '/' -f9`
scanid=`echo $datexscanid | cut -d 'x' -f2`
if [ -e /data/joy/BBL/studies/grmpy/rawData/${bblid}/${datexscanid}/ASL_3DSpiral_OnlineRecon_ASL/nifti/*_ASL_3DSpiral_OnlineRecon_ASL.nii.gz ];then
echo "$bblid,$datexscanid,/data/joy/BBL/studies/grmpy/rawData/${bblid}/${datexscanid}/ASL_3DSpiral_OnlineRecon_ASL/nifti/0${scanid}_ASL_3DSpiral_OnlineRecon_ASL.nii.gz,/data/joy/BBL/studies/grmpy/processedData/structural/struct_pipeline_20170716/${bblid}/${datexscanid}/antsCT,/data/joy/BBL/studies/grmpy/rawData/${bblid}/${datexscanid}/ASL_3DSpiral_OnlineRecon_M0/nifti/0${scanid}_ASL_3DSpiral_OnlineRecon_M0.nii.gz" >> onlineASL_cohort.csv
fi
done

## naming format: ASL_3DSPIRAL_V20_GE_ASL
for i in `ls -d /data/joy/BBL/studies/grmpy/rawData/*/*`;do 
bblid=`echo $i | cut -d '/' -f8`
datexscanid=`echo $i | cut -d '/' -f9`
scanid=`echo $datexscanid | cut -d 'x' -f2`
if [ -e /data/joy/BBL/studies/grmpy/rawData/${bblid}/${datexscanid}/ASL_3DSPIRAL_V20_GE_ASL/nifti/*_ASL_3DSPIRAL_V20_GE_ASL.nii.gz ];then
echo "$bblid,$datexscanid,/data/joy/BBL/studies/grmpy/rawData/${bblid}/${datexscanid}/ASL_3DSPIRAL_V20_GE_ASL/nifti/0${scanid}_ASL_3DSPIRAL_V20_GE_ASL.nii.gz,/data/joy/BBL/studies/grmpy/processedData/structural/struct_pipeline_20170716/${bblid}/${datexscanid}/antsCT,/data/joy/BBL/studies/grmpy/rawData/${bblid}/${datexscanid}/ASL_3DSPIRAL_V20_GE_M0/nifti/0${scanid}_ASL_3DSPIRAL_V20_GE_M0.nii.gz" >> onlineASL_cohort.csv
fi
done


# create offline reconstruction cohort files
## these files require us to make the M0 image

## create the m0 image
# fslroi /data/joy/BBL/studies/grmpy/rawData/${bblid}/${datexscanid}/ASL_dicomref/nifti/${bblid}_${datexscanid}_asl_recon.nii.gz /data/joy/BBL/studies/grmpy/rawData/${bblid}/${datexscanid}/ASL_dicomref/nifti/${bblid}_${datexscanid}_asl_recon_M0.nii.gz 80 2

# naming format: ASL_dicomref
for i in `ls -d /data/joy/BBL/studies/grmpy/rawData/*/*`;do 
bblid=`echo $i | cut -d '/' -f8`
datexscanid=`echo $i | cut -d '/' -f9`
if [ -e /data/joy/BBL/studies/grmpy/rawData/${bblid}/${datexscanid}/ASL_dicomref/nifti/${bblid}_${datexscanid}_asl_recon_M0.nii.gz ];then
echo "${bblid},${datexscanid},/data/joy/BBL/studies/grmpy/rawData/${bblid}/${datexscanid}/ASL_dicomref/nifti/${bblid}_${datexscanid}_asl_recon.nii.gz,/data/joy/BBL/studies/grmpy/processedData/structural/struct_pipeline_20170716/${bblid}/${datexscanid}/antsCT,/data/joy/BBL/studies/grmpy/rawData/${bblid}/${datexscanid}/ASL_dicomref/nifti/${bblid}_${datexscanid}_asl_recon_M0.nii.gz" >> offlineASL_cohort.csv
fi
done
