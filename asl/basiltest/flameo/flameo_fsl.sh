

# read both bblid  to get the images into shape 
bblid=$(cat /data/jux/BBL/projects/grmpyProcessing/grmpyProcessing2017Scripts/asl/basiltest/GPbblid.txt)
wkdir=/data/jux/BBL/projects/grmpyProcessing/grmpyProcessing2017Scripts/asl/basiltest

## read the four covariance
grcov=/data/jux/BBL/projects/grmpyProcessing/grmpyProcessing2017Scripts/asl/basiltest/flameo/grmcov.mat
pncov=/data/jux/BBL/projects/grmpyProcessing/grmpyProcessing2017Scripts/asl/basiltest/flameo/pnccov.mat

## read contrast and group 
contrast=/data/jux/BBL/projects/grmpyProcessing/grmpyProcessing2017Scripts/asl/basiltest/flameo/contrast.con
group=/data/jux/BBL/projects/grmpyProcessing/grmpyProcessing2017Scripts/asl/basiltest/flameo/group.grp
datadir=/data/jux/BBL/studies/grmpy/processedData/basil_asl
maskfile=/data/joy/BBL/studies/pnc/template/pnc_template_brain_2mm.nii.gz

b1=$wkdir/flameo/grcbflist.csv
b2=$wkdir/flameo/pncbflist.csv
rm $b1; rm $b2
for i in $bblid; do 
   img1=$(ls -d $datadir/grmpy/cbf/${i}/*/norm/*_meanPerfusionStd.nii.gz)
   img2=$(ls -d $datadir/pnc/cbf/${i}/*/norm/*_meanPerfusionStd.nii.gz)  
    echo $img1 >> $b1
    echo $img2 >> $b2
done 

rm $wkdir/flameo/grbaslistPV.csv
rm  $wkdir/flameo/pncbaslistPV.csv
 rm $wkdir/flameo/grbaslistPV.csv
 rm $wkdir/flameo/pncbaslistPV.csv
 rm $wkdir/flameo/grbaslistS.csv
 rm $wkdir/flameo/pncbaslistS.csv
rm $wkdir/flameo/grbaslist.csv
rm  $wkdir/flameo/pncbaslist.csv

for i in $bblid; do 
   img1=$(ls -d $datadir/grmpy/basil/${i}/*/norm/*_cbf_pv_calibStd.nii.gz)
   img2=$(ls -d $datadir/pnc/basil/${i}/*/norm/*_cbf_pv_calibStd.nii.gz) 
   img3=$(ls -d $datadir/grmpy/basil/${i}/*/norm/*spatial_calibStd.nii.gz)
   img4=$(ls -d $datadir/pnc/basil/${i}/*/norm/*spatial_calibStd.nii.gz)
   img5=$(ls -d $datadir/grmpy/basil/${i}/*/norm/*cbf_calibStd.nii.gz)
   img6=$(ls -d $datadir/pnc/basil/${i}/*/norm/*cbf_calibStd.nii.gz)  
 
    echo $img1 >> $wkdir/flameo/grbaslistPV.csv
    echo $img2 >> $wkdir/flameo/pncbaslistPV.csv
    echo $img3 >> $wkdir/flameo/grbaslistS.csv
    echo $img4 >> $wkdir/flameo/pncbaslistS.csv
    echo $img5 >> $wkdir/flameo/grbaslist.csv
    echo $img6 >> $wkdir/flameo/pncbaslist.csv
done


## convert the list to line
cbgr=$(paste -s -d ' ' $wkdir/flameo/grcbflist.csv)
cbpn=$(paste -s -d ' ' $wkdir/flameo/pncbflist.csv)


bsgrPV=$(paste -s -d ' ' $wkdir/flameo/grbaslistPV.csv)
bspnPV=$(paste -s -d ' ' $wkdir/flameo/pncbaslistPV.csv)

bsgrS=$(paste -s -d ' ' $wkdir/flameo/grbaslistS.csv)
bspnS=$(paste -s -d ' ' $wkdir/flameo/pncbaslistS.csv)


bsgr=$(paste -s -d ' ' $wkdir/flameo/grbaslist.csv)
bspn=$(paste -s -d ' ' $wkdir/flameo/pncbaslist.csv)

#merge the volume 
mkdir -p $datadir/grmpy/flameo
mkdir -p $datadir/pnc/flameo
fslmerge -t $datadir/grmpy/flameo/grcbf.nii.gz $cbgr

fslmerge -t $datadir/grmpy/flameo/grbas.nii.gz $bsgr

fslmerge -t $datadir/pnc/flameo/pncbf.nii.gz $cbpn

fslmerge -t $datadir/pnc/flameo/pnbas.nii.gz $bspn


fslmerge -t $datadir/pnc/flameo/pnbasPV.nii.gz $bspnPV

fslmerge -t $datadir/grmpy/flameo/grbasPV.nii.gz $bsgrPV

fslmerge -t $datadir/pnc/flameo/pnbasS.nii.gz $bspnS

fslmerge -t $datadir/grmpy/flameo/grbasS.nii.gz $bsgrS



## run the flameo mkdir -p $datadir/grmpy/flameo/cbfstats 
flameo --copefile=$datadir/grmpy/flameo/grcbf.nii.gz  --mask=$maskfile  --dm=$grcov --tc=$contrast --cs=$group --runmode=flame1 --ld=$datadir/grmpy/flameo/cbfstats


flameo --copefile=$datadir/grmpy/flameo/grbas.nii.gz  --mask=$maskfile  --dm=$grcov --tc=$contrast --cs=$group --runmode=flame1 --ld=$datadir/grmpy/flameo/basilstats


flameo --copefile=$datadir/pnc/flameo/pncbf.nii.gz  --mask=$maskfile  --dm=$pncov --tc=$contrast --cs=$group --runmode=flame1 --ld=$datadir/pnc/flameo/cbfstats


flameo --copefile=$datadir/pnc/flameo/pnbas.nii.gz  --mask=$maskfile  --dm=$pncov --tc=$contrast --cs=$group --runmode=flame1 --ld=$datadir/pnc/flameo/basilstats



flameo --copefile=$datadir/grmpy/flameo/grbasPV.nii.gz  --mask=$maskfile  --dm=$grcov --tc=$contrast --cs=$group --runmode=flame1 --ld=$datadir/grmpy/flameo/basilstatsPV


flameo --copefile=$datadir/grmpy/flameo/grbasS.nii.gz  --mask=$maskfile  --dm=$grcov --tc=$contrast --cs=$group --runmode=flame1 --ld=$datadir/grmpy/flameo/basilstatsS


flameo --copefile=$datadir/pnc/flameo/pnbasPV.nii.gz  --mask=$maskfile  --dm=$pncov --tc=$contrast --cs=$group --runmode=flame1 --ld=$datadir/pnc/flameo/basilstatsPV

flameo --copefile=$datadir/pnc/flameo/pnbasS.nii.gz  --mask=$maskfile  --dm=$pncov --tc=$contrast --cs=$group --runmode=flame1 --ld=$datadir/pnc/flameo/basilstatsS


