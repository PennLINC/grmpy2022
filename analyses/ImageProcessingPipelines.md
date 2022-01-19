---
layout: default
title: Image Processing Pipelines
has_children: false
parent: Pipeline Documentation/Data Narrative
has_toc: true 
nav_order: 5
---

# Image Processing Pipelines
<img src="/grmpy2022/assets/images/grmpyflowchart.png" alt="Processing Flowchart"> 

{: .no_toc }
1. Started setting up preprocessing for exemplars for processing pipelines. Path to exemplar dataset: /cbica/projects/GRMPY/project/curation/testing/exemplars_dir (datalad tracked)
2. Preprocessing Pipelines 

* TOC
{:toc}

## fMRIPrep run on CUBIC by Kahini Mehta
- Date run: 01/05/22

- Link to container on CUBIC: /cbica/projects/GRMPY/project/curation/fmriprep-container

- Container version: 20.2.3

- Flags used: 

    ```
singularity run --cleanenv -B ${PWD} \
    pennlinc-containers/.datalad/environments/fmriprep-20-2-3/image \
    inputs/data \
    prep \
    participant \
    -w ${PWD}/.git/tmp/wkdir \
    --n_cpus 1 \
    --stop-on-first-crash \
    --fs-license-file code/license.txt \
    --skip-bids-validation \
    --output-spaces MNI152NLin6Asym:res-2 \
    --participant-label "$subid" \
    --force-bbr \
    --cifti-output 91k -v -
    ```

- First ran  pipeline on one exemplar. Then proceeded to run all the subjects at once. 

- Number of Subjects Run: 231

- Finished Successfully: 230

- Failed due to no TW1: 1

- Link to outputs on CUBIC: /cbica/projects/GRMPY/project/curation/testing/fmriprep_outputs

- Link to audit: [https://github.com/PennLINC/grmpy2022/tree/master/analyses/FMRIPREP_AUDIT.CSV](https://github.com/PennLINC/grmpy2022/tree/master/analyses/FMRIPREP_AUDIT.CSV)



## XCP run on CUBIC by Kahini Mehta

- Date run: 01/07/22

- Link to container on CUBIC: /cbica/projects/GRMPY/project/curation/xcp-abcd-container

- Container version: 0.0.8 

- Flags used: 

``` 
singularity run --cleanenv -B ${PWD} pennlinc-containers/.datalad/environments/xcp-abcd-0-0-8/image inputs/data/fmriprep xcp participant \
--despike --lower-bpf 0.01 --upper-bpf 0.08 --participant_label $subid -p 36P -f 10 -w ${PWD}/.git/tmp/wkdir
singularity run --cleanenv -B ${PWD} pennlinc-containers/.datalad/environments/xcp-abcd-0-0-8/image inputs/data/fmriprep xcp participant \
--despike --lower-bpf 0.01 --upper-bpf 0.08 --participant_label $subid -p 36P -f 10 -w ${PWD}/.git/tmp/wkdir --cifti 
```

- No exemplar testing

- Number of Subjects Run: 230

- Finished Successfully: 230

- Link to outputs on CUBIC: /cbica/projects/GRMPY/project/curation/testing/xcp_outputs

- Link to audit: [https://github.com/PennLINC/grmpy2022/tree/master/analyses/XCP_AUDIT.CSV](https://github.com/PennLINC/grmpy2022/tree/master/analyses/XCP_AUDIT.CSV)


##  QSIPrep run on CUBIC by Kahini Mehta

- Date run:  01/14/22

- Link to container on CUBIC: /cbica/projects/GRMPY/project/curation/qsiprep-container

- Container version: 0.14.3

- Flags used: 

  ```
singularity run --cleanenv -B ${PWD} \
    pennlinc-containers/.datalad/environments/qsiprep-0-14-3/image \
    inputs/data \
    prep \
    participant \
    -v -v \
    -w ${PWD}/.git/wkdir \
    --n_cpus $NSLOTS \
    --stop-on-first-crash \
    --fs-license-file code/license.txt \
    --skip-bids-validation \
    --participant-label "$subid" \
    --unringing-method mrdegibbs \
    --output-resolution 1.5
    ```

- No exemplar testing.

- Number of Subjects Run: 231

- Finished Successfully: 176

- Failed due to no TW1: 1

- Failed due to no DWI: 54

- Link to outputs on CUBIC: /cbica/projects/GRMPY/project/curation/testing/qsiprep_outputs

- Link to audit: [https://github.com/PennLINC/grmpy2022/tree/master/analyses/QSIPREP_AUDIT.CSV](https://github.com/PennLINC/grmpy2022/tree/master/analyses/QSIPREP_AUDIT.CSV)

## ASLPrep run on CUBIC by Kahini Mehta

- Date run: 01/20/22

- Link to container on CUBIC: /cbica/projects/GRMPY/project/curation/aslprep-container

- Container version: 0.2.7

- Flags used: 

``` 

```

- No exemplar testing

- Number of Subjects Run: 231

- Finished Successfully: 

- Failed due to no T1: 1

- Failed due to no ASL: 

- Link to outputs on CUBIC: /cbica/projects/GRMPY/project/curation/testing/xcp_outputs

- Link to audit: [https://github.com/PennLINC/grmpy2022/tree/master/analyses/ASLPREP_AUDIT.CSV](https://github.com/PennLINC/grmpy2022/tree/master/analyses/ASLPREP_AUDIT.CSV)


