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
datalad run -i '/cbica/projects/GRMPY/project/curation/testing/concat_ds' -o '${PROJECT_ROOT}/XCP_sub-restmultifsLR_desc-qc_boldQC.csv' --expand inputs --explicit "python code/concatenator.py  /cbica/projects/GRMPY/project/curation/testing/concat_ds /cbica/projects/GRMPY/project/curation/testing/xcp_outputs/XCP/XCP_sub-restmultibandfsLR_desc-qc_boldQC.csv
"
datalad save -m "generated report"
# push changes
datalad push
# remove concat_ds
git annex dead here
cd ..
chmod +w -R concat_ds
rm -rf concat_ds
echo SUCCESS
