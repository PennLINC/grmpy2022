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
- ModelArray, linear model on ASL data (n = 209; 5 participants from the full 214 with processed ASL were removed after QA checks (basically those with QEI below 0.6 and rmsd over 0.3 were manually inspected for quality, those who did not pass manual inspection were excluded). Analyses and related files at `cbica/projects/GRMPY/project/curation/testing/stats_ModelArray`). 
   1.  Followed documentation [here](https://github.com/PennLINC/ModelArray_tests/blob/main/demo_volume_data/pncNback_readme.md) and [here](https://pennlinc.github.io/ModelArray/articles/ModelArray_basics.html) 
   2. Used [Confixel](https://github.com/PennLINC/ConFixel) for conversion from .nii to .h5;  final convoxel .csv at `cbica/projects/GRMPY/project/curation/testing/stats_ModelArray/GRMPY_convoxel_meanCBF_n209_finalversion.csv`
   3. Used formula `CBF ~ age (negligible non-linear effects) + sex + basilQEI + rmsd + als_score/bdi_score/scared_score_total/ari_score` 
   4. Converted from .h5 to results folder named after date, containing all niftis, again using Confixel. 
   4.  No significance found for clinical scales: including fdr_correction images, cluster correction via `easythresh` and viewing via `mricron`. Confirmed by vector testing in R: `GM (GMmeanCBF from ASLPREP_QC.csv) ~ age + sex + basilQEI + rmsd + als_score/bdi_score/scared_score_total/ari_score`


Did you use pennlinckit? 
   *  Not yet.
