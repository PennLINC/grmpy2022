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

   * BIDS format

### Data Acquisition

Who is responsible for acquiring this data?
 * Acquired previously. 

Where was the data acquired? 
* SC3T, HUP6. Acquired from Flywheel, collected previously as [specified](https://pennlinc.github.io/grmpy2022/)

Describe the data. What type of information do we have? Things to specify include:
   - Number of subjects: 231 
   - Types of images: func, perf, anat, diff, fmap

### Download and Storage 

Who is responsible for downloading this data?
* Kahini Mehta

From where was the data downloaded?
* Flywheel

Where is it currently being stored?
* Flywheel, CUBIC, Datalad

What form is the data in upon intial download (DICOMS, NIFTIS, something else?)
* niftis - BIDS format from Flywheel

Are you using Datalad? If so, at which point did you check the data into datalad?
* Yes. After removing PHI from metadata fields. 

Is the data backed up in a second location? If so, please provide the path to the backup location:
* CUBIC: /cbica/projects/GRMPY/project/backup


### Curation Process
Who is responsible for curating this data?
* Kahini Mehta

GitHub Link to curation scripts/heuristics: 
* Heuristic at [https://github.com/PennLINC/Flywheel_Curation/tree/master/Projects/GRMPY_822831](https://github.com/PennLINC/Flywheel_Curation/tree/master/Projects/GRMPY_822831); see heuristic version 4,  & pull request for version 5 that fixed BIDS errors in fmap IntendedFors

* GitHub Link to final CuBIDS csvs: [https://pennlinc.github.io/grmpy2022/analyses](https://pennlinc.github.io/grmpy2022/analyses)

## General process
1. Manually deleted duplicate NIFTIs on Flywheel
2. Ran BIDS validate on all data 
3. Uploaded data to CUBIC
4. Used CuBIDS to add metadata and removed PHI (patient sex, acquisition datetime & weight. incorrectly removed "name" from description.json)
5. Began to run CuBIDS validations:
6. BIDS Validation
- Upon [first](https://github.com/PennLINC/grmpy2022/tree/master/analyses/Validation1) run of the validator, found naming issues and description.json incorrectly formatted.

   Attempts to resolve: 
   1. Manually added "Name" back to dataset_description.json

- Upon [second](https://github.com/PennLINC/grmpy2022/tree/master/analyses/Validation2) run of the validator, found naming issues and missing events TSV errors:
However, naming errors were due to ASL files which would later be replaced. Events TSVs also ignored. 

   Attempts to resolve:
   1. After looking at the summary sheet, worked to fix faulty IntendedFors and other errors regarding unused FieldMaps. 
   2. Created a new heuristic and re-curated subjects on Flywheel Manually fixed IntendedFors on CUBIC. 

- Upon [third](https://github.com/PennLINC/grmpy2022/tree/master/analyses/Validation3) run of the group, unused FieldMaps error persisted. 

   Attempts to resolve:
   1. After looking at the summary sheet, worked to fix faulty IntendedFors manually on CUBIC.

- Upon [fourth](https://github.com/PennLINC/grmpy2022/tree/master/analyses/Validation4) run of the group, unused FieldMaps error persisted. 

   Attempts to resolve:
   1. After looking at the summary sheet, worked to fix faulty IntendedFors manually on CUBIC.

- Upon [fifth](https://github.com/PennLINC/grmpy2022/tree/master/analyses/Validation5) run of the group, unused FieldMaps error persisted. 

   Attempts to resolve:
   1. After looking at the summary sheet, worked to fix faulty IntendedFors manually on CUBIC.

- Upon [sixth](https://github.com/PennLINC/grmpy2022/tree/master/analyses/Validation6) run of the group, 1 unused FieldMap error persisted. 

   Attempts to resolve:
   1. After looking at the summary sheet, worked to fix faulty IntendedFors manually on CUBIC.

- Upon [seventh](https://github.com/PennLINC/grmpy2022/tree/master/analyses/Validation7) run of the group, satisfied with the fieldmaps. 

   Actions:
   1. After noticing that two participants had an extra session, deleted niftis and jsons for those sessions on CUBIC. Namely, for BBL 20120, session 10939 was not used. For BBL 95257, session 11191 was dropped. However, BBL 20120 does not have fracback, and BBL 95257 has all imscribe parameters set to 0 for the sessions chosen. 

- Performed [eighth](https://github.com/PennLINC/grmpy2022/tree/master/analyses/Validation8) run of the group. 

   Actions: 
   1. Deleted ASL data (to add in the data from Aziz's ASLPrep paper) and renamed variants via CuBIDS-apply. 

- Performed [ninth](https://github.com/PennLINC/grmpy2022/tree/master/analyses/Validation9) run of the group. Some errors from CuBIDS due to "use datalad" flag; renaming was not successful. 

   Actions: 
   1. Ran CuBIDS-undo. 

- Peformed [tenth](https://github.com/PennLINC/grmpy2022/tree/master/analyses/Validation10). Some errors from the last CuBIDS-apply persisted.

   Actions: 
   1. Ran git hard -- reset. 

- Performed [eleventh](https://github.com/PennLINC/grmpy2022/tree/master/analyses/Validation11) run of the group. Same results as validation 8; successfully reverted to original. 

   Actions: 
   1. Ran CuBIDS apply without the flag; renamed variants and deleted ASL data. 

- Performed [twelfth](https://github.com/PennLINC/grmpy2022/tree/master/analyses/Validation12) run of the group. CuBIDS-apply worked well. 

   Actions: 
   1. Ran CuBIDS apply to remove variants wiht BOLD data under 3 minutes, and 1 DWI scan with an odd number of volumes. 

- Performed [thirteenth](https://github.com/PennLINC/grmpy2022/tree/master/analyses/Validation13) run of the group. 

   Actions: 
   1. Added ASL data in (copied over to GRMPY user from Aziz by Tinashe) the BIDS directory.  

- Performed [fourteenth](https://github.com/PennLINC/grmpy2022/tree/master/analyses/Validation14 run of the group. 

   Actions: 
   1. Removed ReconstructionMethod from .json after validate/group wouldn't run on the data, since there was an invalid character in the field. 

- Performed [fifteenth](https://github.com/PennLINC/grmpy2022/tree/master/analyses/Validation15) run of the group. Found RepetitionTimePreparation and some other fields missing as well as some RepetitionTimewas variants.Some niftis had a "too small" error, and some participants were missing niftis for ASL data despite jsons being present. 

   Attempts to resolve: 
   1. Removed participants' perf data if they were missing the nifts. 

- Performed [sixteenth](https://github.com/PennLINC/grmpy2022/tree/master/analyses/Validation16) run of the group. 

   Actions: 
   1. Ran add-nifti-info to see if it would fix some of the errors. 

- Performed [seventeenth](https://github.com/PennLINC/grmpy2022/tree/master/analyses/Validation17) run of the group. Saw some m0 scans with 0 numvolums, the missing metadata issue for some fields still persisted despite running add-nifti-info. 

   Actions: 
   1. Removed m0 scans in question

- Performed [eighteenth](https://github.com/PennLINC/grmpy2022/tree/master/analyses/Validation18) run of the group. Realised the wrong ASL data had been added in. 

   Actions: 
   1. Readded correct, complete ASL (copied in from Aziz by Tinashe)and restarted process of validation for ASL. 

- Performed [nineteenth](https://github.com/PennLINC/grmpy2022/tree/master/analyses/Validation19) run of the group. No errors of note. Some variants to consider in Summary.csv. 

   Actions: 
   1. RepetitionTimePreparation manually changed from 0 to 4 for ASL data.

- Performed [twentieth](https://github.com/PennLINC/grmpy2022/tree/master/analyses/Validation20) run of the group. 

   Actions: 
   1. Changed RTPrep values to match RT values. 

- Performed [twenty first](https://github.com/PennLINC/grmpy2022/tree/master/analyses/Validation21) run of the group. Produced too many perfusion variants with not that much of a difference between their RepetitionTimes.

   Actions: 
   1. Had to change RT tolerance for variants with RT differences of a small magnitude. 

- Performed [twenty second](https://github.com/PennLINC/grmpy2022/tree/master/analyses/Validation22) run of the group, only for re-grouping purposes, since tolderance values were changed. 

   Actions: 
   1. Ran CuBIDS-apply to rename variants and also purged ASL scans with numvol less than 60.

- Performed [twenty third](https://github.com/PennLINC/grmpy2022/tree/master/analyses/Validation23) run of the group. There were some m0 unused errors due to the variants being renamed and m0 IntendedFors not being changed by CuBIDS. 

   Actions: 
   1. Changed IntendedFors manually. 

- Performed [twenty fourth](https://github.com/PennLINC/grmpy2022/tree/master/analyses/Validation24) run of the group. CuBIDS was updated for ASL data. I had to undo all changes. 

   Actions: 
   1. Did CuBIDS _undo, datalad save, and undo again twice so I could apply the new version of CuBIDS to the ASL data, which would also look at changing m0 IntendedFors.

- Performed [twenty fifth](https://github.com/PennLINC/grmpy2022/tree/master/analyses/Validation25) run of the group. Realized we could not rename ASL variants due to CuBIDS/BIDS issues, as the m0 scan names had to match the ASL scans, but both would not necessarily have their variant renamings corresponding/matched. 

   Actions: 
   1. Revereted back to how things were at Validation22. Proceeded to run CuBIDS-apply, not renaming any ASL variants, but simply purging ASL scans with numvol less than 60. 

- Performed [twenty sixth](https://github.com/PennLINC/grmpy2022/tree/master/analyses/Validation26) run of the group. 
##### Satisfied with results!


7. Started setting up preprocessing for exemplars for processing pipelines. 


8. Preprocessing Pipelines 
## Path to exemplar dataset: /cbica/projects/GRMPY/project/curation/testing/exemplars_dir (datalad tracked)
   * fMRIPrep run on CUBIC by Kahini Mehta
      * First ran  pipeline on one exemplar. Then proceeded to run all the subjects at once. 
      * 231 subjects ran. Via grep checks, 230 were successful, while 1 failed (BBL 106071) due to no T1  
      * Link to audit: [https://github.com/PennLINC/grmpy2022/tree/master/analyses/FMRIPREP_AUDIT.CSV](https://github.com/PennLINC/grmpy2022/tree/master/analyses/FMRIPREP_AUDIT.CSV)
      * Outputs: /cbica/projects/GRMPY/project/curation/testing/fmriprep_outputs

   * XCP run on CUBIC by Kahini Mehta
      * Successful on all 230 subjects output by fMRIPrep, according to grep checks. Some participants re-run as jobs were inexplicably killed halfway. 
      * Link to audit: [https://github.com/PennLINC/grmpy2022/tree/master/analyses/XCP_AUDIT.CSV](https://github.com/PennLINC/grmpy2022/tree/master/analyses/XCP_AUDIT.CSV)
      * Outputs: /cbica/projects/GRMPY/project/curation/testing/xcp_outputs

   * QSIPrep run on CUBIC by Kahini Mehta
      * According to grep, 175 participants successful.  54 errors due to no DWI data, 1 error (BBL 106071) due to  no T1, and 1 participant (BBL 92211) to be re-run due to job inexplicably being killed halfway. 
      * Link to audit: [https://github.com/PennLINC/grmpy2022/tree/master/analyses/QSIPREP_AUDIT.CSV](https://github.com/PennLINC/grmpy2022/tree/master/analyses/QSIPREP_AUDIT.CSV)
      * Outputs: /cbica/projects/GRMPY/project/curation/testing/xcp_outputs

9. Post Processing 
* Analyses to be performed on CUBIC
Did you use pennlinckit? 
   *  Not yet.


