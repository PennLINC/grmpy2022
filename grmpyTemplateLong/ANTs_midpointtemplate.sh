#!/bin/bash


path=/home/kmcgaughey/grmpy_midpointtemplate

/share/apps/ANTs/2014-06-23/build/bin/antsMultivariateTemplateConstruction.sh -d 3 -k 1 -c 1 -r 1 -s CC -o $path/ANTs_grmpyTemplate/grmpy_midpointTemplate $path/template_datapaths.txt
