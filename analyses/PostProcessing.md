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
- ModelArray (version 0.0.0.9000); ran linear model on ASL data (n = 209; 5 participants from the full 214 with processed ASL were removed after QA checks - basically those with QEI below 0.6 and rmsd over 0.3 were manually inspected for quality, those who did not pass manual inspection were excluded. Analyses and related files at `cbica/projects/GRMPY/project/curation/testing/stats_ModelArray`). 
   1.  Followed documentation from [Model Array demo](https://github.com/PennLINC/ModelArray_tests/blob/main/demo_volume_data/pncNback_readme.md) and [quick start guide](https://pennlinc.github.io/ModelArray/articles/ModelArray_basics.html) 
   2. Used [Confixel](https://github.com/PennLINC/ConFixel) for conversion from .nii to .h5;  final convoxel .csv available at `cbica/projects/GRMPY/project/curation/testing/stats_ModelArray/GRMPY_convoxel_meanCBF_n209_finalversion.csv`
   3. Ran `qsub_call.sh`, which called `runRscript.sh` which called the actual `RScript.R`. This used the singularity image `cbica/projects/GRMPY/project/curation/testing/stats_ModelArray/modelarray.sif`
   4. R script used the formula 
   ```
   CBF ~ age (negligible non-linear effects) + sex + basilQEI + rmsd + als_score/bdi_score/scared_score_total/ari_score
   ``` 
   and function as below: 
   
   ```
   mylm <- ModelArray.lm(formula, data = modelarray, phenotypes = phenotypes, scalar = "CBF",
                     element.subset = element.subset, full.outputs = full.outputs,
                     correct.p.value.terms = c("fdr", "bonferroni"),
                     correct.p.value.model = c("fdr", "bonferroni"),
                     pbar = TRUE, n_cores = num.cores) #n_cores = 4, element.subset = all voxels, full.outputs = TRUE
   ```

   5. Converted from .h5 to results folder named after date, containing all niftis, again using Confixel. 
   6.  No significance found for clinical scales: including fdr_correction images, cluster correction via `easythresh` and viewing via `mricron`. 
   
   Results directories are pointed to in the file `ReadMeResultFolderDescriptions.md` in the `stats_ModelArray` directory.
   
   Results further confirmed by vector testing in R: 
   
   ```
   GM (GMmeanCBF from ASLPREP_QC.csv) ~ age + sex + basilQEI + rmsd + als_score/bdi_score/scared_score_total/ari_score
   ```


* Did you use pennlinckit?  Not yet.
