#!/bin/bash
set -e -u -x
PROJECT_ROOT=/cbica/projects/GRMPY/project/curation/testing/xcp_outputs/XCP
cd ${PROJECT_ROOT}
# set up concat_ds and run concatenator on it
cd  /cbica/projects/GRMPY/project/curation/testing
datalad clone ria+file://${PROJECT_ROOT}/output_ria#~data concat_ds
cd concat_ds/code
wget https://raw.githubusercontent.com/PennLINC/grmpy2022/master/docs/code/concatenator.py
cd ..
datalad save -m "added concatenator script"
datalad run -i 'sub-*rest*singleband*fsLR_desc-qc_bold.csv' -o '${PROJECT_ROOT}/XCP_sub-*rest*singleband*fsLR_desc-qc_bold.csv_QC.csv' --expand inputs --explicit "python code/concatenator.py  ${PROJECT_ROOT}/XCP_sub-*rest*singleband*fsLR_desc-qc_bold.csv_QC.csv"
datalad save -m "generated report"
# push changes
datalad push
# remove concat_ds
git annex dead here
cd ..
chmod +w -R concat_ds
rm -rf concat_ds
echo SUCCESS