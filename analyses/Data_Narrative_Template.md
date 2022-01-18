---
layout: default
title: Pipeline Documentation/Data Narrative
has_children: false
has_toc: false
nav_order: 4
---

# Data Narrative for GRMPY

- (based off RBC template, but modified)

### Plan for the Data 

Why does PennLINC need this data?
* Analysis of GRMPY data. 

For which project(s) is it intended? Please link to project pages below:
* [GRMPY](https://pennlinc.github.io/grmpy2022/)

* What is our goal data format?
   * i.e. in what form do we want the data by the end of the "Curation" step? BIDS? Something else? 
   In BIDS format

### Data Acquisition

Who is responsible for acquiring this data?
 * Acquired previously. 

Where was the data acquired? 
* SC3T, HUP6. Acquired from FlyWheel, collected previously as [specified](https://pennlinc.github.io/grmpy2022/)

Describe the data. What type of information do we have? Things to specify include:
   - number of subjects: 231 
   - types of images: func, perf, anat, diff, fmap

### Download and Storage 

Who is responsible for downloading this data?
* Kahini Mehta

From where was the data downloaded?
* Flywheel

Where is it currently being stored?
* Flywheel, CUBIC, Datalad

What form is the data in upon intial download (DICOMS, NIFTIS, something else?)
* NIFTIs- BIDS format from Flywheel

Are you using Datalad? If so, at which point did you check the data into datalad?
* Yes. 

Is the data backed up in a second location? If so, please provide the path to the backup location:
* CUBIC: /cbica/projects/GRMPY/project/backup


### Curation Process
Who is responsible for curating this data?
* Kahini Mehta

GitHub Link to curation scripts/heuristics: 
* Heuristic at [https://github.com/PennLINC/Flywheel_Curation/tree/master/Projects/GRMPY_822831](https://github.com/PennLINC/Flywheel_Curation/tree/master/Projects/GRMPY_822831); see heuristic version 4,  & the pull request for version 5 that fixed BIDS errors in fmap IntendedFors

* GitHub Link to final CuBIDS csvs: [https://pennlinc.github.io/grmpy2022/analyses](https://pennlinc.github.io/grmpy2022/analyses)

## General process
1. Manually deleted duplicate NIFTIs on Flywheel
2. Ran BIDS validate on all data 
3. Uploaded data to CUBIC
3. Used CuBIDS to add metadata and removed PHI (patient sex, acquisition datetime & weight. incorrectly removed "name" from description.json)
4. Began to run CuBIDS validations:

## 5. BIDS Validation

- Upon [first](https://github.com/PennLINC/grmpy2022/tree/master/analyses/Validation1) run of the validator, we found naming issues and the description.json incorrectly formatted.
Attempts to resolve/ actions: 
1. Removed all the files that shouldn't be in the directory from running cubids-group
2. Manually added "Name" back to dataset_description.json

- Upon [second](https://github.com/PennLINC/grmpy2022/tree/master/analyses/Validation2) run of the validator, we found naming issues and missing events TSV errors:
However, the naming errors were due to ASL files which would later be replaced. Events TSVs were also ignored. 
Attempts to resolve/actions:
1. After looking at the summary sheet, worked to fix faulty IntendedFors and other errors regarding unused FieldMaps. 
2. Created a new heuristic and re-curated subjects on Flywheel Manually fixed IntendedFors on CUBIC. 


- Upon [third](https://github.com/PennLINC/grmpy2022/tree/master/analyses/Validation3) run of the group, unused FieldMaps error persisted. 
Attempts to resolve/actions:
1. After looking at the summary sheet, worked to fix faulty IntendedFors manually on CUBIC.

Upon [fourth](https://github.com/PennLINC/grmpy2022/tree/master/analyses/Validation4) run of the group, unused FieldMaps error persisted. 
Attempts to resolve:
1. After looking at the summary sheet, worked to fix faulty IntendedFors manually on CUBIC.

Upon [fifth](https://github.com/PennLINC/grmpy2022/tree/master/analyses/Validation5) run of the group, unused FieldMaps error persisted. 
Attempts to resolve:
1. After looking at the summary sheet, worked to fix faulty IntendedFors manually on CUBIC.

Upon [sixth](https://github.com/PennLINC/grmpy2022/tree/master/analyses/Validation6) run of the group, 1 unused FieldMap error persisted. 
Attempts to resolve:
1. After looking at the summary sheet, worked to fix faulty IntendedFors manually on CUBIC.

Upon [seventh](https://github.com/PennLINC/grmpy2022/tree/master/analyses/Validation7) run of the group, we were satisfied with the fieldmaps. 

Performed [eighth](https://github.com/PennLINC/grmpy2022/tree/master/analyses/Validation8) run of the group, after noticing that two participants had an extra session. Namely, for BBL 20120, session 10939 was not used. For BBL 95257, session 11191 was dropped. However, BBL 20120 does not have fracback, and BBL 95257 has all imscribe parameters set to 0 for the sessions chosen. 

Performed [ninth](https://github.com/PennLINC/grmpy2022/tree/master/analyses/Validation9) run of the group after deleting ASL data (to add in the data from Aziz's ASLPrep paper) and renaming variants via CuBIDS-apply. 

Due to an error in applying CuBIDS changes, we had a[tenth](https://github.com/PennLINC/grmpy2022/tree/master/analyses/Validation10) run of the group after CuBIDS-undo. However, we still saw some errors. Used git hard --resest to revert to initial state before applying CuBIDS changes, then ran validation again. 

Performed [eleventh](https://github.com/PennLINC/grmpy2022/tree/master/analyses/Validation11) run of the group after reverting back to original ; same results as run 8. 

Performed [twelfth](https://github.com/PennLINC/grmpy2022/tree/master/analyses/Validation12) run of the group after CuBIDS-apply renaming variants and deleting ASL- seems to have worked well this time.

Performed [thirteenth](https://github.com/PennLINC/grmpy2022/tree/master/analyses/Validation13) run of the group after CuBIDS-apply removing variants with BOLD data under 3 minutes, and 1 dwi scan variant with an odd number of volumes. 

Performed [fourteenth](https://github.com/PennLINC/grmpy2022/tree/master/analyses/Validation14 run of the group after adding in ASL data. 

- Decided to remove ReconstructionMethod from .json after validate/group wouldn't run on the data, since there was an invalid character in the field. 

Performed [fifteenth](https://github.com/PennLINC/grmpy2022/tree/master/analyses/Validation15) run of the group. Found RepetitionTimePreparation missing as well as some RepetitionTimewas variants. Some other metadata missing, some niftis had a "too small" error, and some participants were missing niftis for ASL data despite jsons being present. 

Attempts to resolve: 
1. Removed participants' perf data if they were missing the nifts. 

Performed [sixteenth](https://github.com/PennLINC/grmpy2022/tree/master/analyses/Validation16) run of the group. Ran add-nifti-info to see if it would fix some of the errors. 

Performed [seventeenth](https://github.com/PennLINC/grmpy2022/tree/master/analyses/Validation17) run of the group. Saw some m0scans with 0 numvolums, and removed their perf data. However, the missing metadata issue for some fields still persisted despite running add-nifti-info. 

Performed [eighteenth](https://github.com/PennLINC/grmpy2022/tree/master/analyses/Validation18) run of the group. Realised the wrong ASL data had been added in. Had to readd correct, complete ASL and restart process of validation for ASL. 

Performed [nineteenth](https://github.com/PennLINC/grmpy2022/tree/master/analyses/Validation19) run of the group. No errors of note. Some variants to consider in Summary.csv, plus RepetitionTimePreparation to be manually changed to 4 in all cases.

Performed [twentieth](https://github.com/PennLINC/grmpy2022/tree/master/analyses/Validation20) run of the group. Changed RTPrep values to match RT values. 

Performed [twenty first](https://github.com/PennLINC/grmpy2022/tree/master/analyses/Validation21) run of the group. Produced too many perfusion variants: had to change RT tolerance for variants with RT differences of a small magnitude. 

Performed [twenty second](https://github.com/PennLINC/grmpy2022/tree/master/analyses/Validation22) run of the group, only for grouping purposes, since I had to change RT tolerance for variants with RT differences of a small magnitude. Then had to run CuBIDS-apply to rename variants and also purged ASL scans with numvol less than 60.

Performed [twenty third](https://github.com/PennLINC/grmpy2022/tree/master/analyses/Validation23) run of the group. There were some m0 type errors due to the variants being renamed and m0 IntendedFors not being changed by CuBIDS. I changed these manually and re-ran validation. 

Performed [twenty fourth](https://github.com/PennLINC/grmpy2022/tree/master/analyses/Validation24) run of the group. CuBIDS was updated. I had to undo all changes - did cubids_undo, datalad save, and undo twice so I could apply the new version of CuBIDS to the ASL data, which would also look at changing m0 IntendedFors.

Performed [twenty fifth](https://github.com/PennLINC/grmpy2022/tree/master/analyses/Validation25) run of the group. Decided to revert back to how things were at Validation22. Could not rename ASL variants due to CuBIDS/BIDS issues, decided simply to purge shorter scans as before (ASL scans with numvol less than 60) via CuBIDS-apply, and not rename any variants. Then ran validate again.  

Performed [twenty sixth](https://github.com/PennLINC/grmpy2022/tree/master/analyses/Validation26) run of the group. Satisfied with results!


6. Started setting up preprocessing for exemplars for processing pipelines. 


## 6. Preprocessing Pipelines 
#### Path to exemplar dataset: /cbica/projects/GRMPY/project/curation/testing/exemplars_dir (datalad tracked)
   * fMRIPrep run on CUBIC by Kahini Mehta
      * I first ran the pipeline on one exemplar. After this was successful, I proceeded to run all the subjects at once. 
      * 231 subjects ran. Via grep checks, 230 were successful, while 1 failed (BBL 106071) due to having no T1  
      * Link to audit: https://github.com/PennLINC/grmpy2022/tree/master/analyses/FMRIPREP_AUDIT.CSV
      * Outputs: /cbica/projects/GRMPY/project/curation/testing/fmriprep_outputs

   * XCP run on CUBIC by Kahini Mehta
      * Successful on all of the 230 subjects output by fMRIPrep, according to grep checks. Some participants needed to be re-run since the jobs were inexplicably killed halfway. 
      * Link to audit: https://github.com/PennLINC/grmpy2022/tree/master/analyses/XCP_AUDIT.CSV
      * Outputs: /cbica/projects/GRMPY/project/curation/testing/xcp_outputs

   * QSIPrep run on CUBIC by Kahini Mehta
      * According to grep, 175 participants were successful, while there were 54 errors due to no DWI data, 1 error (BBL 106071) due to having no T1, and 1 participant (BBL 92211) needed to be re-run due to the job inexplicably being killed halfway. 
      * Link to audit: https://github.com/PennLINC/grmpy2022/tree/master/analyses/QSIPREP_AUDIT.CSV
      * Outputs: /cbica/projects/GRMPY/project/curation/testing/xcp_outputs

## 7. Post Processing 

Who is using the data/for which projects are people in the lab using this data?
* Kahini Mehta
   * Link to project page(s) here: [https://pennlinc.github.io/grmpy2022/](https://pennlinc.github.io/grmpy2022/)

* Analyses to be performed on CUBIC: 

Did you use pennlinckit? 
   *  Not yet.


