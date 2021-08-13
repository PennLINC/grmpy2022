#!/bin/bash

###################################################################################################
##########################         GRMPY - Distorition Correction        ##########################
##########################              Robert Jirsaraie                 ##########################
##########################             rjirsara@upenn.edu                ##########################
##########################                  10/07/2017                   ##########################
###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################
<<Use

This wrapper was intended to apply distortion correction, but since the example dicoms are not availabe,
This script was not able to successfully call the secound dico script. Instead the missing parameters 
were extrapolated from the reward dataset and the script below performed Distortion Correction.

/data/joy/BBL/projects/grmpyProcessing2017/grmpyProcessing2017Scripts/restbold1_124mb/dico_command.sh 

Use
###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################

###########################################################################################
### Preforms Error Catching and Ensures that the Inputs Exist and are Entered Correctly ###
###########################################################################################

checkFileStatus(){
  fileToCheck=${1}
  logFile=${2}
  subj=${3}
  if [ ! -f "${fileToCheck}" ] ; then
    if [ ! -f "${logFile}" ] ; then
      echo "Error Image, Error Status" >> ${logFile} ; 
    fi
    echo "One of the dico correction images was not present"
    echo "Skipping ${subj}"
    echo "Check ${logFile} for more information"
    echo "${fileToCheck}, Image Not Found" >> ${logFile} 
    continue; 
  else
    return 0;
  fi
}

#####################################################################################
### Informs About the Usage of this Script in Case Inputs are Entered Incorrectly ###
#####################################################################################

usage(){
echo
echo "Script Usage:"
echo "  This script should be used to call: /data/joy/BBL/applications/scripts/bin/dico_correct_v2.sh"
echo "  It will used to perform dico on all of the images in the rawData directory that requires dico: /data/joy/BBL/studies/grmpy/rawData/*/*/bbl1_restbold1_124mb/nifti/*.nii.gz " 
echo "	Required input is a text file of the rps images and the respective paths"
echo "	dicoCorrectWrapper.sh -r <rpsmaps.txt>"
echo "  Optional arguments:"
echo "		-e: error output from sge directory"
echo "		-o: output directory for sge output"
echo "		-l: error log file"
echo "		-h: Output usage function"
echo
exit 2
}
#############################
### Reads Input Arguments ###
#############################

while getopts "r:e:o:l:h" OPTION ; do
  case ${OPTION} in
    r)
      rpsImageText=${OPTARG}
      ;;
    e)
      errorOutputDir=${OPTARG}
      ;;
    o)
      outputDir=${OPTARG}
      ;;
    h)
      usage
      ;;
    l)
      logDir=${OPTARG}
      ;;
    *)
      usage
      ;;
    esac
done

#######################################################
### Calls the Usage Function if No Input is Entered ###
#######################################################

if [ $# == 0 ] ; then
  usage ; 
fi

#####################################################
### Check to Ensure the Script is Called on chead ###
#####################################################

if [ ! `hostname` == "chead.uphs.upenn.edu" ] ; then
  echo "This script needs to be run from cfn's chead cluster"
  echo "This script is written to submit jobs to the grid"
  echo "chead is the cfn compute node with access to submit jobs"
  exit 2 ;
fi

#############################################################################################
### Checks for Optional Inputs and Declears Home Directory as Default If None are Inputed ###
#############################################################################################

if [ -z "${errorOutputDir}" ] ; then
  errorOutputDir="~/temp/" ; 
fi

if [ -z "${outputDir}" ] ; then
  outputDir="~/temp/" ; 
fi

if [ -z "${logDir}" ] ; then
  u=`whoami`
  logDir="/home/${u}/" ; 
fi

############################################
### DEFINES THE INPUT FILES TO REFERENCE ###
############################################

timeOfExecution=`date +%y_%m_%d_%H_%M_%S`
logFile="${logDir}dicoCorrectionErrorLog_${timeOfExecution}.csv"
finishedFile="${logDir}dicoCorrectionSubmittedLog_${timeOfExecution}.csv"
scriptToCall="/data/joy/BBL/applications/scripts/bin/dico_correct_v2.sh"
rawDataBase="/data/joy/BBL/studies/grmpy/rawData/"
processedDataBase="/data/joy/BBL/studies/grmpy/processedData/"
b0DataBase="${processedDataBase}B0map/"
baseQSubCall="qsub -V -q all.q -S /bin/bash -o ${outputDir} -e ${errorOutputDir}"
fileLength=`cat ${rpsImageText} | wc -l`
direction="-y"

#######################################################################
### Double Checks to ensure that the provided text input is correct ###
#######################################################################

fileExtensionCheck=`echo ${rpsImageText} | rev | cut -f 1 -d '.' | rev`
if [ ! "${fileExtensionCheck}" == "txt" ]   ; then 
  echo "Provided file type for ${rpsImageText} is not a .txt file"
  echo "This file should be a text file which contains the paths to the rps images"
  echo "would you like to continue running this script?"
  read -r -p "Enter a y or n:" answer
  answer=${answer,,}
  if [[ ${answer} =~ ^(no|n)$ ]] ; then  
    echo "rpsmaps.txt can be created with either the ls command by running:"
    echo "ls /data/joy/BBL/studies/grmpy/processedData/B0map/<BBLID>/<SCANDATE>x<SCANID>/<BBLID>_<SCANDATE>x<SCANID>_rpsmap.nii.gz > example.txt"
    echo "OR:"
    echo "find /data/joy/BBL/studies/grmpy/processedData/B0map/<BBLID>/<SCANDATE>x<SCANID>/ -type f -name '*rps*'" 
    exit 2; 
  fi
fi

#################################################################################
### Triple Check to Make Sure that the Provided Input File uses Correct Paths ###
#################################################################################

providedFilePathCheck=`sed -n "1p" ${rpsImageText} | cut -f 1-8 -d /`
if [ ! "${providedFilePathCheck}" == "/data/joy/BBL/studies/grmpy/processedData/B0map" ] ; then
  echo "The provided file path for the rps image was not correct"
  echo "RPS images must be stored in '/data/joy/BBL/studies/grmpy/processedData/B0map'"
  echo "Following the <BBLID>/<SCANDATE>x<SCANID> file structure"
  echo "RPS images should be created, and then stored in the proper directory using the script seen below:"
  echo "/data/joy/BBL/applications/scripts/bin/dico_correct_v2.sh"
  echo "Creating the proper text file can be performed by following the logic of one of these script calls:"
  echo "ls /data/joy/BBL/studies/grmpy/processedData/B0map/<BBLID>/<SCANDATE>x<SCANID>/<BBLID>_<SCANDATE>x<SCANID>_rpsmap.nii > example.txt"
  echo "OR:"
  echo "find /data/joy/BBL/studies/grmpy/processedData/B0map/<BBLID>/<SCANDATE>x<SCANID>/ -type f -name '*rps*' > example.txt" 
  echo
  echo
  echo "Script will now exit"
  exit 2 ; 
fi

####################################
### Primes the Output Finish Log ###
####################################

echo "BBLID, SCANID, SEQUENCE, STATUS, QSUB_CALL" > ${finishedFile}

################################################################################
### Cycles through Each RPS Image in the Input File & Finds Specific Details ###
################################################################################

for indexValue in `seq 1 ${fileLength}` ; do
 
  rpsImage=`sed -n "${indexValue}p" ${rpsImageText}`
  allSubjInfo=`basename ${rpsImage} | xargs remove_ext`
  bblid=`echo ${allSubjInfo} | cut -f 1 -d '_'`
  scanid=`echo ${allSubjInfo} | cut -f 2 -d 'x' | cut -f 1 -d '_'`
  dateid=`echo ${allSubjInfo} | cut -f 1 -d 'x' | cut -f 2 -d '_'`
  magImage="${b0DataBase}${bblid}/${dateid}x${scanid}/${bblid}_${dateid}x${scanid}_mag1_brain.nii.gz"
  rpsMaskImage="${b0DataBase}${bblid}/${dateid}x${scanid}/${bblid}_${dateid}x${scanid}_mask.nii.gz"
  
  ##################################################
  ### Checks to Ensure all Variables are Present ###
  ##################################################
  
  checkFileStatus ${magImage} ${logFile} ${bblid}
  checkFileStatus ${rpsMaskImage} ${logFile} ${bblid}
  checkFileStatus ${rpsImage} ${logFile} ${bblid}
  scanIdentifiers=( restbold )
  forLoopLength=`echo ${#scanIdentifiers[@]}-1 | bc`
  for seriesID in `seq 0 ${forLoopLength}` ; do 
    indScan=${scanIdentifiers[${seriesID}]}
    
    #################################################
    ### Prepares the Steps to Submit the qsub Job ###
    #################################################
    
    if [ "${indScan}" == "restingBOLD" ] ; then
      tmpScanCheck=`find ${rawDataBase}${bblid}/${dateid}x${scanid}/ -maxdepth 1 -name "*${indScan}*" -type d` ; 
    elif [ "${indScan}" == "pcasl" ] ; then
      tmpScanCheck=`find ${rawDataBase}${bblid}/${dateid}x${scanid}/ -maxdepth 1 -name "*${indScan}*1200*" -type d` ;
    else
      tmpScanCheck=`find ${rawDataBase}${bblid}/${dateid}x${scanid}/ -maxdepth 1 -name "*${indScan}*" -type d` ; 
    fi
    outputDir="${processedDataBase}${indScan}/dico/${bblid}/${dateid}x${scanid}/"
    output="${outputDir}${bblid}_${dateid}x${scanid}"
    if [[ -d ${tmpScanCheck} ]] ; then
      mkdir -p ${outputDir}
      niftiSeries=`ls ${tmpScanCheck}/nifti/*.nii.gz` 
      if [ "${indScan}" == "pcasl" ] ; then
        niftiSeries=`ls ${tmpScanCheck}/nifti/*SEQ*.nii.gz` >/dev/null
        if [ ${?} -ne 0 ] ; then
          niftiSeries=`ls ${tmpScanCheck}/nifti/*.nii.gz` ;
        fi ;
      fi
      if [ -f "${output}_dico.nii" ] ; then
        echo
        echo "Dico correction file is already present"
        echo "Skipping job submission for:"
        echo "BBLID: ${bblid}"
        echo "SCANID: ${scanid}"
        echo "DATE: ${dateid}"
        echo "SERIES: ${indScan}"
        echo "FINISHED DICO:${output}_dico.nii"
        echo "Check ${finishedFile} for more input"
        echo
        echo "${bblid}, ${scanid}, ${indScan}, File Already Present ${output}_dico.nii, N/A" >> ${finishedFile}
      else
        
        ##############################################
        ### Calls the Script that Submits the Jobs ###
        ##############################################
           
        qSubCall="${baseQSubCall} ${scriptToCall} -n -FS -e ${direction} -f ${magImage} ${output} ${rpsImage} ${rpsMaskImage} ${niftiSeries}"

        ${qSubCall}
        echo ${qSubCall}>> ~/1strobertcall.txt 
       
        ${baseQSubCall} /share/apps/fsl/5.0.8/bin/fslchfiletype NIFTI_GZ ${output}_dico.nii
        ${baseQSubCall} /share/apps/fsl/5.0.8/bin/fslchfiletype NIFTI_GZ ${output}_shiftmap.nii
        echo "${bblid}, ${scanid}, ${indScan}, Submitted @ `date +%y_%m_%d_%H_%M_%S`, ${qSubCall}" >> ${finishedFile}; 
      fi
    fi
    unset tmpScanCheck
  done
done

echo "Done with job submission"

exit 0

###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################
