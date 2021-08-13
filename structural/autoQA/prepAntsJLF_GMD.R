# AFGR August 10 2016

###################################################################################################
##########################        GRMPY Grey Matter Density Script       ##########################
##########################              Robert Jirsaraie                 ##########################
##########################             rjirsara@upenn.edu                ##########################
##########################                  08/05/2017                   ##########################
###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################

# This script is used to combine GMD data into a spreadsheet with the correct headers

###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################

source('/home/arosen/adroseHelperScripts/R/afgrHelpFunc.R')

#######################################################################################
### Combines all Output into a Single Directory then moves it into the outdirectory ###
#######################################################################################

system("$XCPEDIR/utils/combineOutput -p /data/joy/BBL/studies/grmpy/processedData/structural/struct_pipeline_20170716/ -f *_JLF_val_gmSegIntersect.1D -o antsGMD_JLF_vals.1D")
system("mv /data/joy/BBL/studies/grmpy/processedData/structural/struct_pipeline_20170716/antsGMD_JLF_vals.1D")

#################
### Load data ###
#################

columnValues <- read.csv("/data/joy/BBL/projects/grmpyProcessing2017/grmpyProcessing2017Scripts/structural/autoQA/prepinclusionCheck.csv")
gmdValues <- read.table("/data/joy/BBL/projects/grmpyProcessing2017/structural/autoQA/antsGMD_JLF_vals.1D", header=T)
n118.subjs <- read.csv('/data/joy/BBL/projects/grmpyProcessing2017/structural/autoQA/n118_BBL_ScanID_Date_DatexScanID.csv')
n118.subjs <- n118.subjs[,c(2,1)]

#################################
### Limit to just the NZmeans ###
#################################

nzCols <- grep('NZMean', names(gmdValues))
nzCols <- append(c(1, 2), nzCols)
gmdValues <- gmdValues[,nzCols]

################################
### Prepare the Column Names ###
################################

colsOfInterest <- columnValues$Label.Number[which(columnValues$GMD==0)] + 2
colsOfInterest <- append(c(1,2), colsOfInterest)

##############################################################
### Limit the PCASL values to just the columns of interest ###
##############################################################

gmdValues <- gmdValues[,colsOfInterest] 

##########################################
### Change the name of the gmd columns ###
##########################################

columnNames <- gsub(x=gsub(x=columnValues$JLF.Column.Names, pattern='%MODALITY%', replacement='mprage'), pattern='%MEASURE%', replacement='gmd')[which(columnValues$GMD==0)]
colnames(gmdValues)[3:length(gmdValues)] <- as.character(columnNames)

#####################################################
### Prepare the subject fields with bblid, scanid ###
#####################################################

gmdValues[,2] <- strSplitMatrixReturn(gmdValues$subject.1., 'x')[,2]
colnames(gmdValues)[1:2] <- c('bblid', 'scanid')

#####################
### Write the csv ###
#####################

n118.gmd.values <- merge(n118.subjs, gmdValues, by=c('bblid', 'scanid'))
write.csv(n118.gmd.values, paste('/data/joy/BBL/projects/grmpyProcessing2017/structural/autoQA/n118_jlfAtroposIntersectionGMD_',format(Sys.Date(), format="%Y%m%d"),'.csv', sep=''), quote=F, row.names=F)

###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################
