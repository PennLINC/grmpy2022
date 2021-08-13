---
layout: default
title: Image Processing Workflow
has_children: false
has_toc: false
nav_order: 4
---

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
*Gear Name*: Flywheel HeuDiConv (fw-heudiconv)

*Version*: 0.2.10_0.2.4

*Inputs*:

*Heuristic*: [grmpy_heuristic_v4.py] (https://github.com/PennLINC/grmpy/blob/gh-pages/inputFiles/grmpy_heuristic_v4.py*)

*Gear Configuration*

*Output*: None. This curates the project in BIDS.

*Note*: When Processing GRMPY_822831, heudiconv was run on each subject individually. This is why do_whole_project was set to false.

## Step 2: fMRIPREP
*Gear Name*: fMRIPREP: A Robust Preprocessing Pipeline for fMRI Data [fw-heudiconv]

*Version*: 0.3.2_20.0.7

*Inputs*: license.txt (This is a [freesurfer] (https://surfer.nmr.mgh.harvard.edu/fswiki/FreeSurferWiki) license)

*Gear Configuration*

*Output*:

An html report: filename.html.zip

Processed Output: fmriprep_filename.zip

Source Code: fmriprep_run.sh

## Step 3: N-Back Task
_N-Back Logfile Scoring_
The n-back task logfiles were scored using [this] (https://github.com/PennLINC/grmpy/blob/gh-pages/grmpy_nback_scoreALL.ipynb )notebook, with [this] (https://github.com/PennLINC/grmpy/blob/gh-pages/grympytemplate.xml) template file. The output csv was uploaded to Flywheel using [this] Custom Info Uploader (https://pennlinc.github.io/docs/flywheel/usingCustomInfoUploader/).

_XCP - Task Functional_
*Gear Name*: XCPENGINE: pipeline for processing of structural and functional data.

*Version*: 0.0.2_1.2.1

*Inputs*:

fMRIPREP Output: fmriprep_filename.zip (This is unique to each subject)

[Design_File] (https://github.com/PennLINC/grmpy/blob/gh-pages/inputFiles/task2.dsn)

Zip of necessary files: [taskfile.zip] (https://github.com/PennLINC/grmpy/blob/gh-pages/inputFiles/taskfile2.zip)

*Gear Configuration*

*Output*:

Processed Output: xcpEngineouput_xcp.zip

Cohort File: cohortfile.csv

## Step 4: XCP - CBF
*Gear Name*: XCPENGINE: pipeline for processing of structural and functional data.

*Version*: 0.0.2_1.2.1

*Inputs*:

fMRIPREP Output: fmriprep_filename.zip (This is unique to each subject)

[Design_File] (https://github.com/PennLINC/grmpy/blob/gh-pages/inputFiles/cbf_new2.dsn)

ASL Nifti: asl_image.nii.gz (This is unique to each subject)

*Gear Configuration*

*Output*:

Processed Output: xcpEngineouput_cbf.zip

Cohort File: cohortfile.csv

## Step 5: XCP - Resting State Functional
*Gear Name*: XCPENGINE: pipeline for processing of structural and functional data.

*Version*: 0.0.2_1.2.1

*Inputs*:

fMRIPREP Output: fmriprep_filename.zip (This is unique to each subject)

[Design_File] (https://github.com/PennLINC/grmpy/blob/gh-pages/inputFiles/fc-36p_despike.dsn)

*Gear Configuration*

*Output*:

Processed Output: xcpEngineouput_xcp.zip

Cohort File: cohortfile.csv