###################################################################################################
##########################            GRMPY Volume Script                ##########################
##########################              Robert Jirsaraie                 ##########################
##########################             rjirsara@upenn.edu                ##########################
##########################                  08/04/2017                   ##########################
###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################

#This script combines all of the volume data from the antsCT and intersect images into spreadsheets
#with correct headers

###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################

#######################
### Load library(s) ###
#######################

source('/home/arosen/adroseHelperScripts/R/afgrHelpFunc.R')
install_load('tools')

#################
### Load data ###
#################

jlfVals <- read.csv('/data/jux/BBL/studies/grmpy/microbiome/script/struct/autoQA/jlfVolValues_20160805properSubjFieldsProperColNames.csv')
ctVals <- read.csv('/data/jux/BBL/studies/grmpy/microbiome/script/struct/autoQA/ctVolValues_20160805properSubjFieldsProperColNames.csv')
voxelDim <- read.csv('/data/jux/BBL/studies/grmpy/microbiome/script/struct/autoQA/voxelVolume_20160805properSubjFields.csv')
voxelDim <- voxelDim[which(duplicated(voxelDim)=='FALSE'),]
micsubj.subjs <- read.csv('/data/jux/BBL/studies/grmpy/microbiome/script/struct/microbiomesubjlist.csv')
micsubj.subjs <- micsubj.subjs[,c(2,1)]

##############################################
### Convert all of our voxel counts to mm3 ###
##############################################

jlfVals <- merge(jlfVals, voxelDim, by=c('subject.0.', 'subject.1.'))
jlfVals[,3:131] <- apply(jlfVals[,3:131], 2, function(x) (x * jlfVals$output))
jlfVals <- jlfVals[,-132]
ctVals <- merge(ctVals, voxelDim, by=c('subject.0.', 'subject.1.'))
ctVals[,3:9] <- apply(ctVals[,3:9], 2, function(x) (x * ctVals$output))
ctVals <- ctVals[,-10]

############################
### Fix the Column Names ###
############################
colnames(jlfVals)[1:2] <- c('bblid', 'scanid')
colnames(ctVals)[1:2] <- c('bblid', 'scanid')

##################
### Fix Scanid ###
##################

jlfVals[,2] <- strSplitMatrixReturn(charactersToSplit=jlfVals[,2], splitCharacter='x')[,2]
ctVals[,2] <- strSplitMatrixReturn(charactersToSplit=ctVals[,2], splitCharacter='x')[,2]

#####################################
### Merge Files with Subject File ###
#####################################

micsubj.vol.vals <- merge(micsubj.subjs, jlfVals, by=c('bblid', 'scanid'))
micsubj.vol.ct.vals <- merge(micsubj.subjs, ctVals, by=c('bblid', 'scanid'))

########################
### Write the Output ###
########################

write.csv(micsubj.vol.vals, paste('/data/jux/BBL/studies/grmpy/microbiome/script/struct/autoQA/micsubj_jlfAntsCTIntersectionVol_',format(Sys.Date(), format="%Y%m%d"),'.csv', sep=''), quote=F, row.names=F)
write.csv(micsubj.vol.ct.vals, paste('/data/jux/BBL/studies/grmpy/microbiome/script/struct/autoQA/micsubj_AntsCTVol_',format(Sys.Date(), format="%Y%m%d"), '.csv', sep=''), quote=F, row.names=F)

###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################
