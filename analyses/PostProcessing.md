---
layout: default
title: Post Processing
has_children: false
parent: Pipeline Documentation/Data Narrative
has_toc: false
nav_order: 6
---

# Post Processing

## Analyses performed on CUBIC:
- ModelArray, linear model on ASL data (n = 209; analyses and related files at `cbica/projects/GRMPY/project/curation/testing/stats_ModelArray`)
   1.  Followed documentation [here](https://github.com/PennLINC/ModelArray_tests/blob/main/demo_volume_data/pncNback_readme.md) and [here](https://pennlinc.github.io/ModelArray/articles/ModelArray_basics.html) 
   2. Used [confixel](https://github.com/PennLINC/ConFixel) for conversion from .nii to .h5;  final convoxel .csv at `cbica/projects/GRMPY/project/curation/testing/stats_ModelArray/GRMPY_convoxel_meanCBF_n209_finalversion.csv`
   3. Used formula `CBF ~ age (negligible non-linear effects) + sex + basilQEI + rmsd + als_score/bdi_score/scared_score_total/ari_score` 
   4.  No significance found for clinical scales


Did you use pennlinckit? 
   *  Not yet.
