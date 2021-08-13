







mask=/home/aadebimpe/pncgreymask.nii.gz

bblid=$(cat /data/jux/BBL/projects/grmpyProcessing/grmpyProcessing2017Scripts/asl/basiltest/GPbblid.txt)

grcor=/data/jux/BBL/projects/grmpyProcessing/grmpyProcessing2017Scripts/asl/basiltest/grmpyspatialcor.csv
pncor=/data/jux/BBL/projects/grmpyProcessing/grmpyProcessing2017Scripts/asl/basiltest/pncspatialcor.csv

grmpyroi=//data/jux/BBL/projects/grmpyProcessing/grmpyProcessing2017Scripts/asl/basiltest/grmpyroi.csv
pncroi=/data/jux/BBL/projects/grmpyProcessing/grmpyProcessing2017Scripts/asl/basiltest/pncroi.csv
rm -rf $grcor $pncor $grmpyroi $pncroi

for i in $bblid; do 

 cbfgr=$(ls -d /data/jux/BBL/studies/grmpy/processedData/basil_asl/grmpy/cbf/$i/*/norm/*_meanPerfusionStd.nii.gz)
 cbfpn=$(ls -d /data/jux/BBL/studies/grmpy/processedData/basil_asl/pnc/cbf/$i/*/norm/*_meanPerfusionStd.nii.gz)
 
 basgr=$(ls -d /data/jux/BBL/studies/grmpy/processedData/basil_asl/grmpy/basil/$i/*/norm/*_cbf_calibStd.nii.gz)
 baspn=$(ls -d /data/jux/BBL/studies/grmpy/processedData/basil_asl/pnc/basil/$i/*/norm/*_cbf_calibStd.nii.gz)
 
  /home/aadebimpe/spatialcorr $cbfgr $basgr $mask >> $grcor
  /home/aadebimpe/spatialcorr $cbfpn $baspn $mask >> $pncor

cbf1=$(ls -d /data/jux/BBL/studies/grmpy/processedData/basil_asl/grmpy/cbf/$i/*/roiquant/segmentation/*_mean_meanPerfusion.csv)
 
bas=$(ls -d /data/jux/BBL/studies/grmpy/processedData/basil_asl/grmpy/basil/$i/*/roiquant/segmentation/*mean_cbf_calib.csv)
basgm=$(ls -d /data/jux/BBL/studies/grmpy/processedData/basil_asl/grmpy/basil/$i/*/roiquant/segmentation/*mean_cbf_pvgm_calib.csv)
baspv=$(ls -d /data/jux/BBL/studies/grmpy/processedData/basil_asl/grmpy/basil/$i/*/roiquant/segmentation/*mean_cbf_pv_calib.csv)
basker=$(ls -d /data/jux/BBL/studies/grmpy/processedData/basil_asl/grmpy/basil/$i/*/roiquant/segmentation/*mean_cbf_spatial_calib.csv)
c1=$(awk "NR==2" ${cbf1})
f=$(awk "NR==2" ${bas})
f2=$(awk "NR==2" ${basgm}) 
f3=$(awk "NR==2" ${baspv})
f4=$(awk "NR==2" ${basker})

echo $c1,$f,$f4,$f2,$f3 >> $grmpyroi
 
cbf2=$(ls -d /data/jux/BBL/studies/grmpy/processedData/basil_asl/pnc/cbf/$i/*/roiquant/segmentation/*_mean_meanPerfusion.csv)
bas2=$(ls -d /data/jux/BBL/studies/grmpy/processedData/basil_asl/pnc/basil/$i/*/roiquant/segmentation/*mean_cbf_calib.csv)
bas2gm=$(ls -d /data/jux/BBL/studies/grmpy/processedData/basil_asl/pnc/basil/$i/*/roiquant/segmentation/*mean_cbf_pvgm_calib.csv)
bas2pv=$(ls -d /data/jux/BBL/studies/grmpy/processedData/basil_asl/pnc/basil/$i/*/roiquant/segmentation/*mean_cbf_pv_calib.csv)
bas2ker=$(ls -d /data/jux/BBL/studies/grmpy/processedData/basil_asl/pnc/basil/$i/*/roiquant/segmentation/*mean_cbf_spatial_calib.csv)


c2=$(awk "NR==2" ${cbf2})
d=$(awk "NR==2" ${bas2}) 
d2=$(awk "NR==2" ${bas2gm})
d3=$(awk "NR==2" ${bas2pv})
d4=$(awk "NR==2" ${bas2ker})

echo $c2,$d,$d4,$d2,$d3 >> $pncroi

done 

