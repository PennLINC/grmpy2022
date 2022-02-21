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

#### Note: refer to [Curation Process](https://pennlinc.github.io/grmpy2022/analyses/CurationProcess/) for information about excluded scans in ASLPrep

{: .no_toc }
1. Started setting up preprocessing for exemplars for processing pipelines. Path to exemplar dataset: /cbica/projects/GRMPY/project/curation/testing/exemplars_dir (datalad tracked)
2. Preprocessing Pipelines 

* TOC
{:toc}

## fMRIPrep 

- Run on CUBIC by Kahini Mehta on 01/05/22

- Path to container: /cbica/projects/GRMPY/project/curation/fmriprep-container

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

- Path to outputs: /cbica/projects/GRMPY/project/curation/testing/fmriprep_outputs

- Link to audit: [https://github.com/PennLINC/grmpy2022/tree/master/analyses/FMRIPREP_AUDIT.CSV](https://github.com/PennLINC/grmpy2022/tree/master/analyses/FMRIPREP_AUDIT.CSV)



## XCP 

- Run on CUBIC by Kahini Mehta on 01/07/22

- Path to container: /cbica/projects/GRMPY/project/curation/xcp-abcd-container

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

- Path to outputs: /cbica/projects/GRMPY/project/curation/testing/xcp_outputs

- Path to QC csvs by subject: /cbica/projects/GRMPY/project/curation/testing/xcp_outputs/XCP_QCs

- Link to audit: [https://github.com/PennLINC/grmpy2022/tree/master/analyses/XCP_AUDIT.CSV](https://github.com/PennLINC/grmpy2022/tree/master/analyses/XCP_AUDIT.CSV)


##  QSIPrep 

- Run on CUBIC by Kahini Mehta on 01/14/22

- Path to container: /cbica/projects/GRMPY/project/curation/qsiprep-container

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

- Path to outputs: /cbica/projects/GRMPY/project/curation/testing/qsiprep_outputs

- Link to audit: [https://github.com/PennLINC/grmpy2022/tree/master/analyses/QSIPREP_AUDIT.CSV](https://github.com/PennLINC/grmpy2022/tree/master/analyses/QSIPREP_AUDIT.CSV)

## ASLPrep 
- Latest QC: GroupQC (see: [ASLPREP_GROUP_QC_LATEST.csv](https://github.com/PennLINC/grmpy2022/blob/master/analyses/ASLPREP_GROUP_QC_LATEST.csv))

- Three groups of grmpy ASL data based on older GroupQC (see: [ASLPREP_GROUP_QC.csv](https://github.com/PennLINC/grmpy2022/blob/master/analyses/ASLPREP_GROUP_QC.csv)):

1. The first group (dominant group; indicated as 1 in "Group" column in [this csv](https://github.com/PennLINC/grmpy2022/blob/master/analyses/ASL_Groups.csv)) needed to be scaled by 10. Their GMmeanCBF was in the order of 400-600 rather than 40-60 before scaling; needed to add the flag --m0_scale 10.
2. The second group (few; indicated as 2 in the "Group" column in the CSV) was alright.
3. The third group (only 1; indicated as 3 in the CSV) had negative GMmeanCBF, which means its aslcontext is different from the other group and the order of label-control needs to be reversed. However, even when reversed, it was in the order of 400-600 and so needed to be re-run with the same flag as in group 1. 

- Run on CUBIC by Kahini Mehta on 

- Path to container: /cbica/projects/GRMPY/project/curation/aslprep-0-2-7-container

- Container version: 0.2.7

- Flags used for Group 2: 

``` 
singularity run --cleanenv -B ${PWD} \
    pennlinc-containers/.datalad/environments/aslprep-0-2-7/image \
    inputs/data \
    prep \
    participant \
    -w ${PWD}/.git/tmp/wkdir \
    --n_cpus $NSLOTS \
    --stop-on-first-crash \
    --skip-bids-validation \
    --output-spaces MNI152NLin6Asym:res-2 \
    --participant-label "$subid" \
    --fs-license-file code/license.txt \
    --force-bbr -v -v 
```
- Flags used for groups 1 and 3 

``` 
singularity run --cleanenv -B ${PWD} \
    pennlinc-containers/.datalad/environments/aslprep-0-2-7/image \
    inputs/data \
    prep \
    participant \
    -w ${PWD}/.git/tmp/wkdir \
    --n_cpus $NSLOTS \
    --stop-on-first-crash \
    --skip-bids-validation \
    --output-spaces MNI152NLin6Asym:res-2 \
    --participant-label "$subid" \
    --fs-license-file code/license.txt \
    --force-bbr --m0_scale 10 -v -v 
```
- No exemplar testing

- Number of Subjects Run: 231

- Finished Successfully: 215

- Failed due to no/ unusuable ASL: 15

- Failed due to Obliquity: 1 (sub-20699)

- Path to outputs: /cbica/projects/GRMPY/project/curation/testing/complete_aslprep_outputs

Further notes about ASLPrep:

1. Sub 20120 had two sessions, as mentioned before, ses-10939 was removed - however, this session is also the only one with usable ASL data. The sessions will be merged, with the ASL coregistered to the T1 from the second session, since all other scans from ses-10939 are unusable. This means the ASL scans and perf dir will be moved to ses-10943 and accordingly renamed. 

