## Data Narrative for GRMPY (based off RBC template, but modified)

# General process
Manually deleted duplicate NIFTIs --> ran BIDS validate on all data --> uploaded to CuBIDS --> added metadata fields --> removed PHI --> checked into datalad --> deleted faulty IntendedFors in fmaps, took care of fieldmaps that had incorrec IntendedFors by fixing the heuristic and recurating on flywheel, then fixing manually IntendedFors on CUBIC --> deleted extra sessions for participants on Flywheel and CUBIC (removed niftis/json for related scans)--> removed ASL data by merging into 0 in summary csv + renamied columns with recommended variant names when applying CuBIDS--> however, the use-datalad flag was not working. Reverted to prior state and ran cubids-apply again without that flag. Was successful. -->  removed participants with BOLD scans under 3 mins, abonrmally small variant num of volumes for DWI --> added ASL in from Azeez --> removed ReconstructionMethod manually from .json since validate/group wouldn't run on the ASL data --> removed perf data for participants who had .json without accompanying niftis --> missing metadata for ASL, had to delete and readd all complete ASL data after realising wrong ASL had been transferred. Restarted validation process. --> manually changed RT prep values in ASL data from 0 to 4 --> manually changed RT Prep values again  to match RT values --> changed tolerance values for ASL RT in grouping so that CuBIDS would not make more variant groups than necessary --> Had to run cubids-apply to rename ASL variants and purge ASL scans with numvol less than 60. --> undid changes as cubids needed to be updated first --> Could not rename ASL variants due to BIDS issues whereby M0 for ASL data had to be renamed the same way as the ASL scan, even though the variant name might not apply to the M0 scan --> decided simply to purge shorter scans (ASL numvol less than 60) via cubids-apply and not rename any variants and then validate again --> started setting up preprocessing for exemplars --> after one ran successfully, ran fmriprep on all 231 subjects and audited, 1 subject not successful (106071) due to no T1- -> began to implement XCP pipeline --> ran on all subjects, reran some subjects who quit halfway through with no explanation --> audited, all 230 successful via grep checks

# BIDS Validation

Upon [first](https://github.com/kahinimehta/GRMPYGithub/blob/main/Validation1/GRMPY-validation.csv) run of the validator, we found 315 errors:

[ERROR CODE1 + Naming Issue]: 314
[ERROR CODE55 + JSON file incorrectly formatted]: 1

Attempts to resolve: 
1. Removed all the files that shouldn't be in the directory from running cubids-group
2. Manually added "Name" back to dataset_description.json

Upon [second](https://github.com/kahinimehta/GRMPYGithub/blob/main/Validation2/GRMPY-validation.csv) run of the validator, we found 311 errors:

[ERROR CODE1 + Naming Issue]: 311
However, these errors are due to ASL files which will later be replaced and can be ignored for now. Warnings of note include: 
[WARNING CODE25 + EVENTS_TSV_MISSING]: 251, chosen to ignore at this point and consider adding the tsvs later
After looking at the summary sheet, worked to fix faulty IntendedFors and other errors regarding unused FieldMaps. Satisfied with validation results, proceeded to optimization. 

Upon [third](https://github.com/kahinimehta/GRMPYGithub/blob/main/Validation3) run of the group, we found some unused fieldmaps to be fixed: fixed these by editing paths manually on cubic, re-running group. 

Upon [fourth](https://github.com/kahinimehta/GRMPYGithub/blob/main/Validation4) run of the group, we fixed most of the errors, but made some changes where the IntendedFors of certain files had some errors. 

Upon [fifth](https://github.com/kahinimehta/GRMPYGithub/blob/main/Validation5/GRMPY-validation.csv) run of the group, we fixed most of the errors - still some typos in some IntendedFors in the fmaps, fixed those after looking at summary sheet. 

Upon [sixth](https://github.com/kahinimehta/GRMPYGithub/blob/main/Validation6/GRMPY-validation.csv) run of the group, one last IntendedFor to fix.  

Upon [seventh](https://github.com/kahinimehta/GRMPYGithub/blob/main/Validation7/GRMPY-validation.csv) run of the group, we were satisfied. 

Performed [eighth](https://github.com/kahinimehta/GRMPYGithub/blob/main/Validation8/GRMPY-validation.csv) run of the group after deleting extra session. Fixed issues of concern. 

Performed [ninth](https://github.com/kahinimehta/GRMPYGithub/blob/main/Validation9/GRMPY-validation.csv) run of the group after deleting ASL data via CuBIDS apply. 

Due to error in applying cubids changes, [tenth](https://github.com/kahinimehta/GRMPYGithub/blob/main/Validation10/GRMPY-validation.csv) run of the group after cubids-undo. However, still some errors. Used git hard --resest to revert to initial state, ran validation again. 

Performed [eleventh](https://github.com/kahinimehta/GRMPYGithub/blob/main/Validation11/GRMPY-validation.csv) run of the group after reverting back; same results as run 8. 

Performed [twelfth](https://github.com/kahinimehta/GRMPYGithub/blob/main/Validation12/GRMPY-validation.csv) run of the group after cubids-apply renaming variants and deleting ASL- seems to have worked well, apart from one variant yet to be renamed. 

Performed [thirteenth](https://github.com/kahinimehta/GRMPYGithub/blob/main/Validation13/GRMPY-validation.csv) run of the group after cubids-apply removing variants with BOLD data under 3 minutes, and 1 dwi variant with an odd number of volumes. 

Performed [fourteenth](https://github.com/kahinimehta/GRMPYGithub/blob/main/Validation14/GRMPY-validation.csv) run of the group after adding ASL data. Removed ReconstructionMethod from .json after validate/group wouldn't run on the data

Performed [fifteenth](https://github.com/kahinimehta/GRMPYGithub/blob/main/Validation15/GRMPY-validation.csv) run of the group. Found repetition time preparation missing as well as some repetition time variants. Some other metadata missing, some niftis too small, and some participants missing niftis for asl data despite jsons being present. Removed those participants' perf data. 

Performed [sixteenth](https://github.com/kahinimehta/GRMPYGithub/blob/main/Validation16/GRMPY-validation.csv) run of the group. Ran add-nifti-info to see if it would fix some of the errors. 

Performed [seventeenth](https://github.com/kahinimehta/GRMPYGithub/blob/main/Validation17/GRMPY-validation.csv) run of the group. Saw some m0scans with 0 numvolums, removed their perf data. Missing metadata problem persisted. 

Performed [eighteenth](https://github.com/kahinimehta/GRMPYGithub/blob/main/Validation18/GRMPY-validation.csv) run of the group. Missing metadata persisted. Had to readd correct, complete ASL and restart process of validation for ASL. 

Performed [nineteenth](https://github.com/kahinimehta/GRMPYGithub/blob/main/Validation19/GRMPY-validation.csv) run of the group. No errors of note. Some variants to consider in summary csv, plus RepetitionTimePreparation set to 0 instead of 4. Manually changed RTPrep. 

Performed [twentieth](https://github.com/kahinimehta/GRMPYGithub/blob/main/Validation20/GRMPY-validation.csv) run of the group, since I had to change RT Prep values. 

Performed [twenty first](https://github.com/kahinimehta/GRMPYGithub/blob/main/Validation21/GRMPY-validation.csv) run of the group, since I had to change RT Prep values from 4 to match RT values. Had to change RT tolerance for variants with RT differences of a small magnitude. 

Performed [twenty second](https://github.com/kahinimehta/GRMPYGithub/blob/main/Validation22) run of the group - just grouping - since I had to change RT tolerance for variants with RT differences of a small magnitude. Had to run cubids-apply to rename variants and purge ASL scans with numvol less than 60.

Performed [twenty third](https://github.com/kahinimehta/GRMPYGithub/blob/main/Validation23) run of the group. Some m0 type errors, variants all renamed. M0 intended fors not changed, changed manually and reran. 

Performed [twenty fourth](https://github.com/kahinimehta/GRMPYGithub/blob/main/Validation24) run of the group. Had to undo all changes - did cubids_undo, datalad save, and undo twice so could apply new version of cubids to asl data.

Performed [twenty fifth](https://github.com/kahinimehta/GRMPYGithub/blob/main/Validation25) run of the group. Reverted back to how things were at Validation22. Could not rename ASL variants due to CuBIDS/BIDS issues, decided simply to purge shorter scans via cubids-apply and not rename any variants and then validate again. 

Performed [twenty sixth](https://github.com/kahinimehta/GRMPYGithub/blob/main/Validation26) run of the group. Satisfied with results!
   
### Plan for the Data 

* Why does PennLINC need this data?
Analysis of GRMPY data. 
* For which project(s) is it intended? Please link to project pages below:
[GRMPY](https://pennlinc.github.io/grmpyproject/)
* What is our goal data format?
   * i.e. in what form do we want the data by the end of the "Curation" step? BIDS? Something else? 
   In BIDS format


### Data Acquisition

* Who is responsible for acquiring this data?
 Acquired previously. 
* Do you have a DUA? Who is allowed to access the data?
-
* Where was the data acquired? 
SC3T, HUP6. Acquired from FlyWheel, collected previously as [specified](https://pennlinc.github.io/grmpyproject/)
* Describe the data. What type of information do we have? Things to specify include:
   - number of subjects: 231 
   - types of images: func, perf, anat, dwi

### Download and Storage 

* Who is responsible for downloading this data?
Kahini Mehta
* From where was the data downloaded?
Flywheel
* Where is it currently being stored?
Flywheel, CUBIC, Datalad
* What form is the data in upon intial download (DICOMS, NIFTIS, something else?)
NIFTIs- BIDS format from Flywheel
* Are you using Datalad? If so, at which point did you check the data into datalad?
Yes. After adding metadata to .jsons and removing sensitive fields. 
* Is the data backed up in a second location? If so, please provide the path to the backup location:
CUBIC: /cbica/projects/GRMPY/project/backup


### Curation Process

* Who is responsible for curating this data?
Kahini Mehta
* GitHub Link to curation scripts/heuristics: 
[https://github.com/PennLINC/Flywheel_Curation/tree/master/Projects/GRMPY_822831](https://github.com/PennLINC/Flywheel_Curation/tree/master/Projects/GRMPY_822831); see heuristic version 4  & pull request for version 5 that fixed BIDS errors in fmap IntendedFors
* GitHub Link to final CuBIDS csvs: [https://github.com/kahinimehta/GRMPYGithub](https://github.com/kahinimehta/GRMPYGithub)
* Describe the Curation Process. Include a list of the initial and final validation errors and warnings.
See general process and BIDS validation list. 
* Describe additions, deletions, and metadata changes (if any).
Used cubids-add-nifti-info, cubids-remove-metadata-fields as described [here](https://pennlinc.github.io/docs/TheWay/CuratingBIDSonDisk/). Metadata fields removed include patient sex, acquisition datetime & weight. Looked at summary.csv to remove faulty IntendedFors as described in the General Process.

### Preprocessing Pipelines 
* For each pipeline (e.g. QSIPrep, fMRIPrep, XCP, C-PAC), please fill out the following information:
   * Pipeline Name: fMRIPrep
   * Who is responsible for running preprocessing pipelines/audits on this data?
   Kahini Mehta
   * Where are you running these pipelines? CUBIC? PMACS? Somewhere else?
   CUBIC
   * Did you implement exemplar testing? If so, please fill out the information below:
      * Path to exemplar dataset: /cbica/projects/GRMPY/project/curation/testing/exemplars_dir (datalad tracked)
      * Path to exemplar outputs: eventually just ran on all participants after one exemplar was successful
      * 231 subjects ran. Acc to grep: 230 successful, 1 failed (106071) due to no T1  
      * Link to audit: https://github.com/kahinimehta/GRMPYGithub/blob/main/FMRIPREP_AUDIT.csv
      * Outputs: /cbica/projects/GRMPY/project/curation/testing/fmriprep_outputs

   * For each pipeline (e.g. QSIPrep, fMRIPrep, XCP, C-PAC), please fill out the following information:
   * Pipeline Name: XCP
   * Who is responsible for running preprocessing pipelines/audits on this data?
   Kahini Mehta
   * Where are you running these pipelines? CUBIC? PMACS? Somewhere else?
   CUBIC
   * Did you implement exemplar testing? If so, please fill out the information below:
      * Path to exemplar dataset: /cbica/projects/GRMPY/project/curation/testing/exemplars_dir (datalad tracked)
      * Path to exemplar outputs: just ran on all subjects
      * Link to audit: https://github.com/kahinimehta/GRMPYGithub/blob/main/XCP_AUDIT.csv
      * Outputs: /cbica/projects/GRMPY/project/curation/testing/xcp_outputs

### Post Processing 

* Who is using the data/for which projects are people in the lab using this data?
Kahini Mehta, GRMPY project
   * Link to project page(s) here: [https://pennlinc.github.io/grmpyproject/](https://pennlinc.github.io/grmpyproject/)
* For each post-processing analysis that has been run on this data, fill out the following
   * Who performed the analysis?
   Kahini Mehta
   * Where it was performed (CUBIC, PMACS, somewhere else)?
   CUBIC
   * GitHub Link(s) to result(s)
   * Did you use pennlinckit?  Not yet.
      * https://github.com/ennLINC/PennLINC-Kit/tree/main/pennlinckit  

