
subject=/data/jux/BBL/studies/grmpy/microbiome/structural/*

for s in $subjects; do /data/jux/BBL/studies/grmpy/microbiome/script/struct/JLFAndCTGMMask.sh ${s}/*/jlf/*_Labels.nii.gz ${s}/*/antsCT/*_BrainSegmentation.nii.gz ${s}/*/jlf/ ; done


