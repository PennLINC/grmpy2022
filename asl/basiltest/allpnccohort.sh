
rawdata=/data/joy/BBL/studies/pnc/rawData


ids=/data/jux/BBL/projects/grmpyProcessing/grmpyProcessing2017Scripts/asl/basiltest/grmpypncIDS.csv

cat $ids  | while IFS="," read -r a b c d ; do 

    rawdata1=$(ls -d $rawdata/${b}/*${d}/mprage/*_t1.nii.gz)
    ss=$(basename  $rawdata/${b}/*${d})
    echo $b,$ss,$rawdata1 >> allpncstructcohort.csv
done
   

