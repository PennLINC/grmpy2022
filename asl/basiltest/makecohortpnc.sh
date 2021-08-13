




pncids=/data/jux/BBL/projects/grmpyProcessing/grmpyProcessing2017Scripts/asl/basiltest/pncids
output=/data/jux/BBL/studies/grmpy/processedData/basil_asl/pnc
struct=/data/jux/BBL/studies/grmpy/processedData/basil_asl/pnc/structural

rawdata=/data/joy/BBL/studies/pnc/rawData

cohortfile=/data/jux/BBL/projects/grmpyProcessing/grmpyProcessing2017Scripts/asl/basiltest/pnccohortimg1.csv
rm $cohortfile
echo id0,id1,img,antsct,ref > $cohortfile
aslid=pcasl_PHC_1200ms_SEQ
 
cat $pncids  | while IFS="," read -r b c ; do 

  rawdata1=$(ls -d $rawdata/${b}/*${c}/ep2d_se_pcasl_PHC_1200ms/nifti/*${aslid}*.nii.gz)
  ss=$(basename  $struct/${b}/*)
  mkdir -p $output/momap/${b}/${ss}
 
  controlfile=$output/momap/${b}/${ss}/${b}_${ss}.M0.nii.gz

  3dcalc -prefix $controlfile -a $rawdata1'[1..$(2)]' -expr "a" 2>/dev/null # odd volumes = controls
  strucfile=$struct/${b}/${ss}/struc
 
  echo $b,$ss,$rawdata1,$strucfile,$controlfile >>  $cohortfile
done


