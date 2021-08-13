###################################################################################################
##########################        GRMPY Cortical Thickness Script        ##########################
##########################              Robert Jirsaraie                 ##########################
##########################             rjirsara@upenn.edu                ##########################
##########################                  08/05/2017                   ##########################
###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################

# This script is used to combine CT data from all subjects into a single spreadsheet

###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################

#######################################################################################
### Combines all Output into a Single Directory then moves it into the outdirectory ###
#######################################################################################

system("$XCPEDIR/utils/combineOutput -p /data/joy/BBL/studies/grmpy/processedData/structural/struct_pipeline_20170716/ -f *_JLF_val_corticalThickness.1D -o antsCT_JLF_vals.1D")

system("mv /data/joy/BBL/studies/grmpy/processedData/structural/struct_pipeline_20170716/antsCT_JLF_vals.1D /data/joy/BBL/projects/grmpyProcessing2017/structural/autoQA/") 

#########################################################################
### Subject File needs to be created manually using the command below ###
#########################################################################

#system("for s in $subjects; do id=$(echo $s|cut -d'/' -f8); sd=$(echo $s|cut -d'/' -f9|sed 's@x@,@g'); tp=$(echo $s|cut -d'/' -f9); echo $id,$sd,$tp>>n118_BBLid_datexscanID.csv; done") 

########################################################
### Load data and identify the variables of interest ###
########################################################

source('/home/arosen/adroseHelperScripts/R/afgrHelpFunc.R')
columnValues <- read.csv("/data/joy/BBL/projects/grmpyProcessing2017/grmpyProcessing2017Scripts/structural/autoQA/prepinclusionCheck.csv")
ctValues <- read.table("/data/joy/BBL/projects/grmpyProcessing2017/structural/autoQA/antsCT_JLF_vals.1D", header=T)

#################################
### Limit to just the NZmeans ###
#################################
 
nzCols <- grep('NZMean', names(ctValues))
nzCols <- append(c(1, 2), nzCols)
ctValues <- ctValues[,nzCols]

#########################################
### Take only the columns of interest ###
#########################################

colsOfInterest <- columnValues$Label.Number[which(columnValues$CT==0)] +2
colsOfInterest <- append(c(1,2), colsOfInterest)

##############################################################
### limit the PCASL Values to just the columns of interest ###
##############################################################

ctValues <- ctValues[,colsOfInterest]

##################################################
### Change columns to their approperiate names ###
##################################################

columnNames <- gsub(x=gsub(x=columnValues$JLF.Column.Names, pattern='%MODALITY%', replacement='mprage'), pattern='%MEASURE%', replacement='ct')[which(columnValues$CT==0)]
colnames(ctValues)[3:length(ctValues)] <- as.character(columnNames)

##################################
### Order and rename the files ###
##################################

ctValues[,2] <- strSplitMatrixReturn(ctValues$subject.1., 'x')[,2]
colnames(ctValues)[1:2] <- c('bblid', 'scanid')

#####################
### Write the csv ###
#####################

write.csv(ctValues, paste('/data/joy/BBL/projects/grmpyProcessing2017/grmpyProcessing2017Scripts/structural/autoQA/n118_jlfAntsCTIntersectionCT_',format(Sys.Date(), format="%Y%m%d"),'.csv', sep=''), quote=F, row.names=F)

###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################
