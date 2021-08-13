---
layout: default
title: ASL Source Documentation
has_children: false
has_toc: false
nav_order: 4
---
# ASL Source Documentation
The ASL sequences in GRMPY were acquired in distinct ways throughout data collection. Resultantly, the ASL acquisitions in GRMPY can be divided into 2 groups based on their origin, and method of acquisition.

## Group 1
While the majority of ASL sequences in GRMPY were acquired as dicoms and converted to niftis, some were collected as unreconstructed .dat files and subsequently converted to niftis. Those subjects who had their ASL sequences collected as .dat files and converted to niftis had their M0 attached as the last two slices. These M0 slices were cut into their own nifti file, and were uploaded to Flywheel along with the ASL nifti, to an acquisition called ‘ASL’. The asl nifti was named ‘asl_reconstructed’, and the m0 nifti was named “m0_reconstructed”.

The original .dat files could not be uploaded to Flywheel, but they can be found in the following CUBIC directory:
    /cbica/projects/diego_networks/ASL_recon_backup/DAT

<a href="https://github.com/PennLINC/bpd/blob/master/referenceFiles/grmpy_asl_reconlist.csv">This</a> list of subjects had their ASL and M0 derived from .dat files:

## Group 2 (PROBLEMATIC)
<a href="https://github.com/PennLINC/bpd/blob/master/referenceFiles/grmpy_asl_group2.csv">This list</a> of subjects’ ASL sequences have associated dicoms. This group has several names within each acquisiton that do not distinguish between images. These sequences were uploaded to Flywheel from several sources including XNAT and Stellar Chance 3T.

In order to differentiate between ASL, M0, and Mean Perfusion, refer to BIDS view in the GUI, or BIDS Info via the SDK. <a href="https://github.com/PennLINC/bpd/blob/master/referenceFiles/multiple_m0.csv">This</a> subset also has two M0 images per acquisiton. However, one M0 is nominal, and another is low quality. As of 6/2/20, the only way of determining which M0 to use is by sight. Some M0s do not have proper associated metadata.

Solution as of 6/2/2020, as per meeting with Ted, Diego, and Azeez:

Refer users to BIDS info or BIDS view to differentiate between ASL, M0, and Mean Perfusion images.
Determine the “bad” M0 images and delete them manually.
Copy over proper associated metadata onto the correct M0s, from the ASL metadata.