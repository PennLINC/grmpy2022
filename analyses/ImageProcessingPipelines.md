---
layout: default
title: Image Processing Pipelines
has_children: false
parent: Pipeline Documentation/Data Narrative
has_toc: true 
nav_order: 5
---

# Image Processing Pipelines
{: .no_toc }

1. Started setting up preprocessing for exemplars for processing pipelines. Path to exemplar dataset: /cbica/projects/GRMPY/project/curation/testing/exemplars_dir (datalad tracked)
2. Preprocessing Pipelines 

   ### fMRIPrep run on CUBIC by Kahini Mehta
      - First ran  pipeline on one exemplar. Then proceeded to run all the subjects at once. 
      - 231 subjects ran. Via grep checks, 230 were successful, while 1 failed (BBL 106071) due to no T1  
      - Link to audit: [https://github.com/PennLINC/grmpy2022/tree/master/analyses/FMRIPREP_AUDIT.CSV](https://github.com/PennLINC/grmpy2022/tree/master/analyses/FMRIPREP_AUDIT.CSV)
      *-Outputs: /cbica/projects/GRMPY/project/curation/testing/fmriprep_outputs

   ### XCP run on CUBIC by Kahini Mehta
      - Successful on all 230 subjects output by fMRIPrep, according to grep checks. Some participants re-run as jobs were inexplicably killed halfway. 
      - Link to audit: [https://github.com/PennLINC/grmpy2022/tree/master/analyses/XCP_AUDIT.CSV](https://github.com/PennLINC/grmpy2022/tree/master/analyses/XCP_AUDIT.CSV)
      - Outputs: /cbica/projects/GRMPY/project/curation/testing/xcp_outputs

   ### QSIPrep run on CUBIC by Kahini Mehta
      - According to grep, 175 participants successful.  54 errors due to no DWI data, 1 error (BBL 106071) due to  no T1, and 1 participant (BBL 92211) to be re-run due to job inexplicably being killed halfway. 
      - Link to audit: [https://github.com/PennLINC/grmpy2022/tree/master/analyses/QSIPREP_AUDIT.CSV](https://github.com/PennLINC/grmpy2022/tree/master/analyses/QSIPREP_AUDIT.CSV)
      - Outputs: /cbica/projects/GRMPY/project/curation/testing/xcp_outputs