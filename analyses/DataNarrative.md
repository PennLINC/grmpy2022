---
layout: default
title: Pipeline Documentation/Data Narrative
has_children: true
has_toc: false
nav_order: 4
---
1. [Plan for the Data](https://pennlinc.github.io/grmpy2022/analyses/PlanforData/)
2. [Data Acquisition](https://pennlinc.github.io/grmpy2022/analyses/DataAcquisition/)
3. [Download and Storage](https://pennlinc.github.io/grmpy2022/analyses/DownloadStorage/)
4. [Curation Process](https://pennlinc.github.io/grmpy2022/analyses/CurationProcess/)
5. [Image Processing Pipelines](https://pennlinc.github.io/grmpy2022/analyses/ImageProcessingPipelines/)
6. [Post Processing](https://pennlinc.github.io/grmpy2022/analyses/PostProcessing/)

Note: Refaced T1 and T2 data is available at /cbica/projects/GRMPY/project/curation/BIDS_refaced/BIDS on a separate branch:
```
cd /cbica/projects/GRMPY/project/curation/BIDS_refaced/BIDS
git checkout refaced_data
```
Files will be in the format: 
1. sub-X/ses-X/anat/sub-X_ses-X_T1W_reface.nii.gz
2. sub-X/ses-X/anat/sub-X_ses-X_T2W_reface.nii.gz
