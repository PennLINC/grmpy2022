

bblid=$(cat /data/jux/BBL/studies/grmpy/processedData/basil_asl/scripts/bblid.txt)
datadir=/data/jux/BBL/studies/grmpy
subjdir=outdir=/data/jux/BBL/studies/grmpy/processedData/basil_asl/basil_native
c=0
for b  in $bblid;  do 
     struct2asl=$(ls -d $datadir/processedData/asl/$b/*/coreg/*_struct2seq.txt)
     pncTemplate2subjAffine=$datadir/processedData/structural/struct_pipeline_20170716/$b/*/antsCT/*TemplateToSubject1GenericAffine.mat
     pncTemplate2subjWarp=$datadir/processedData/structural/struct_pipeline_20170716/$b/*/antsCT/*TemplateToSubject1GenericAffine.mat
         

     hippo=$datadir/processedData/basil_asl/subcortmask/Hippo_pnc2mm.nii.gz
     caud=$datadir/processedData/basil_asl/subcortmask/Caudate_pnc2mm.nii.gz
     thal=$datadir/processedData/basil_asl/subcortmask/Thalamus_pnc2mm.nii.gz
     put=$datadir/processedData/basil_asl/subcortmask/Putamen_pnc2mm.nii.gz 
     mask=$(ls -d $datadir/processedData/asl/${b}/*/coreg/*_mask.nii.gz)

     antsApplyTransforms -e 3 -d 3 -i $hippo -r ${mask} -o $subjdir/hippo.nii.gz -t ${struct2asl} -t ${pncTemplate2subjAffine} -t ${pncTemplate2subjWarp} -n MultiLabel
     antsApplyTransforms -e 3 -d 3 -i $caud -r ${mask} -o $subjdir/caud.nii.gz -t ${struct2asl} -t ${pncTemplate2subjAffine} -t ${pncTemplate2subjWarp} -n MultiLabel
     antsApplyTransforms -e 3 -d 3 -i $thal -r ${mask} -o $subjdir/thal.nii.gz -t ${struct2asl} -t ${pncTemplate2subjAffine} -t ${pncTemplate2subjWarp} -n MultiLabel
     antsApplyTransforms -e 3 -d 3 -i $put -r ${mask} -o $subjdir/put.nii.gz -t ${struct2asl} -t ${pncTemplate2subjAffine} -t ${pncTemplate2subjWarp} -n MultiLabel
      
     
    fslmaths  $subjdir/hippo.nii.gz -bin -mul $subjdir/$b/native_space/cbf_calib.nii.gz  $subjdir/hippo1
    fslmaths  $subjdir/caud.nii.gz  -bin -mul $subjdir/$b/native_space/cbf_calib.nii.gz  $subjdir/caud1
    fslmaths  $subjdir/thal.nii.gz   -bin -mul $subjdir/$b/native_space/cbf_calib.nii.gz  $subjdir/thal1
    fslmaths  $subjdir/put.nii.gz -bin -mul $subjdir/$b/native_space/cbf_calib.nii.gz  $subjdir/put1
    fslmaths  $subjdir/native_space/gm_mask.nii.gz  -bin -mul $subjdir/$b/native_space/cbf_calib.nii.gz  $subjdir/gm1
    fslmaths  $subjdir/native_space/wm_mask.nii.gz  -bin -mul $subjdir/$b/native_space/cbf_calib.nii.gz  $subjdir/wm1
    

    gm1=$(fslstats $subjdir/gm1 -M)
    wm1=$(fslstats $subjdir/wm1 -M)
    hp1=$(fslstats $subjdir/hippo1 -M)
    cd1=$(fslstats $subjdir/caud1 -M)
    th1=$(fslstats $subjdir/thal1 -M)
    pt1=$(fslstats $subjdir/put1 -M)
    

    fslmaths  $subjdir/hippo.nii.gz -bin -mul $subjdir/$b/pvcorr/cbf_gm_calib.nii.gz  $subjdir/hippo1
    fslmaths  $subjdir/caud.nii.gz  -bin -mul $subjdir/$b/pvcorr/cbf_gm_calib.nii.gz  $subjdir/caud1
    fslmaths  $subjdir/thal.nii.gz   -bin -mul $subjdir/$b/pvcorr/cbf_gm_calib.nii.gz  $subjdir/thal1
    fslmaths  $subjdir/put.nii.gz -bin -mul $subjdir/$b/pvcorr/cbf_gm_calib.nii.gz  $subjdir/put1
    fslmaths  $subjdir/pvcorr/gm_mask.nii.gz  -bin -mul $subjdir/$b/pvcorr/cbf_gm_calib.nii.gz  $subjdir/gm1
    fslmaths  $subjdir/pvcorr/wm_mask.nii.gz  -bin -mul $subjdir/$b/pvcorr/cbf_gm_calib.nii.gz  $subjdir/wm1

    gm2=$(fslstats $subjdir/gm1 -M)
    wm2=$(fslstats $subjdir/wm1 -M)
    hp2=$(fslstats $subjdir/hippo1 -M)
    cd2=$(fslstats $subjdir/caud1 -M)
    th2=$(fslstats $subjdir/thal1 -M)
    pt2=$(fslstats $subjdir/put1 -M)
