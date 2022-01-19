
# Image Processing Workflow

This is documentation of how GRMPY_822831 was processed on Flywheel.

## Steps Overview
Each step is a flywheel gear that has been launched on each subject in the project.

1. Heudiconv
2. fMRIPREP
3. XCP - Task Functional
4. XCP - CBF
5. XCP - Resting State Functional

## Step 1: Heudiconv
**Gear Name**: Flywheel HeuDiConv (fw-heudiconv)

**Version**: 0.2.10_0.2.4

**Inputs**:

**Heuristic**: <a href="https://github.com/PennLINC/bpd/blob/master/inputFiles/grmpy_heuristic_v4.py">grmpy_heuristic_v4.py</a>

### Gear Configuration*

**Output**: None. This curates the project in BIDS.

**Note**: When Processing GRMPY_822831, heudiconv was run on each subject individually. This is why do_whole_project was set to false.

## Step 2: fMRIPREP
**Gear Name**: fMRIPREP: A Robust Preprocessing Pipeline for fMRI Data [fw-heudiconv]

**Version**: 0.3.2_20.0.7


**Inputs**: license.txt (This is a <a href="https://surfer.nmr.mgh.harvard.edu/fswiki/FreeSurferWiki">freesurfer</a> license)

### Gear Configuration

**Output**:

An html report: filename.html.zip

Processed Output: fmriprep_filename.zip

Source Code: fmriprep_run.sh

## Step 3: N-Back Task
### **N-Back Logfile Scoring**

The n-back task logfiles were scored using <a href="https://github.com/PennLINC/bpd/blob/master/grmpy_nback_scoreALL.ipynb">this</a> notebook, with <a href="https://github.com/PennLINC/bpd/blob/master/grympytemplate.xml">this</a> template file. The output csv was uploaded to Flywheel using the <a href="https://pennlinc.github.io/docs/flywheel/usingCustomInfoUploader/">Custom Info Uploader</a>.

### **XCP - Task Functional**
**Gear Name**: XCPENGINE: pipeline for processing of structural and functional data.

**Version**: 0.0.2_1.2.1

**Inputs**:

fMRIPREP Output: fmriprep_filename.zip (This is unique to each subject)

<a href="https://github.com/PennLINC/bpd/blob/master/inputFiles/task2.dsn">Design File</a>

<a href="https://github.com/PennLINC/bpd/blob/master/inputFiles/taskfile2.zip"> Zip of necessary files </a>

### Gear Configuration

**Output**:

Processed Output: xcpEngineouput_xcp.zip

Cohort File: cohortfile.csv

## Step 4: XCP - CBF
**Gear Name**: XCPENGINE: pipeline for processing of structural and functional data.

**Version**: 0.0.2_1.2.1

**Inputs**:

fMRIPREP Output: fmriprep_filename.zip (This is unique to each subject)

<a href="https://github.com/PennLINC/bpd/blob/master/inputFiles/cbf_new2.dsn">Design File</a>

ASL Nifti: asl_image.nii.gz (This is unique to each subject)

### Gear Configuration*

**Output**:

Processed Output: xcpEngineouput_cbf.zip

Cohort File: cohortfile.csv

## Step 5: XCP - Resting State Functional
**Gear Name**: XCPENGINE: pipeline for processing of structural and functional data.

**Version**: 0.0.2_1.2.1

**Inputs**:

fMRIPREP Output: fmriprep_filename.zip (This is unique to each subject)

<a href="https://github.com/PennLINC/bpd/blob/master/inputFiles/fc-36p_despike.dsn">Design File</a>

### Gear Configuration

**Output**:

Processed Output: xcpEngineouput_xcp.zip

Cohort File: cohortfile.csv