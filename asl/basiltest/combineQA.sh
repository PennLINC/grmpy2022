# combine all quality

outputdir=/data/jux/BBL/projects/grmpyProcessing/grmpyProcessing2017Scripts/asl/basiltest



grmdir1=/data/jux/BBL/studies/grmpy/processedData/basil_asl/grmpy/cbf/*
rm -rf  $outputdir/grmpycbfquality.csv
for i in $grmdir1; do 
   bb=$i/*/*quality.csv
   f=$(awk "NR==2" ${bb})
   echo $f >> $outputdir/grmpycbfquality.csv
done 
   
  

grmdir2=/data/jux/BBL/studies/grmpy/processedData/basil_asl/grmpy/basil/*
rm -rf  $outputdir/grmpybasilquality.csv
for i in $grmdir2; do 
   bb=$i/*/*quality.csv
   f=$(awk "NR==2" ${bb})
   echo $f >> $outputdir/grmpybasilquality.csv
done 



pncdir1=/data/jux/BBL/studies/grmpy/processedData/basil_asl/pnc/cbf/*
rm -rf  $outputdir/pnccbfquality.csv
for i in $pncdir1; do 
   bb=$i/*/*quality.csv
   f=$(awk "NR==2" ${bb})
   echo $f >> $outputdir/pnccbfquality.csv
done 
   
  

pncdir2=/data/jux/BBL/studies/grmpy/processedData/basil_asl/pnc/basil/*
rm -rf  $outputdir/pncbasilquality.csv
for i in $pncdir2; do 
   bb=$i/*/*quality.csv
   f=$(awk "NR==2" ${bb})
   echo $f >> $outputdir/pncbasilquality.csv
done 
