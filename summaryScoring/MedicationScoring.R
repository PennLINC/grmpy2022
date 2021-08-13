###################################################################################################
##########################      GRMPY - Summary Scores - Medication      ##########################
##########################               Robert Jirsaraie                ##########################
##########################        rjirsara@pennmedicine.upenn.edu        ##########################
##########################                 06/01/2018                    ##########################
###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################
# Use #

# This script was created to generate a CSV of Drug Use the subsample of 144 GRMPY subjects. Data must first 
# be downloaded from RedCap and SCP onto CfN before running this script.

# scp ~/Desktop/GRMPYDataEntryInterv_DATA_2018-06-01_0118.csv rjirsaraie@chead:/data/jux/BBL/studies/grmpy/subjectData/n144_DataFreeze/

###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################

##############################################################
##### Read in the Drugs Data and Covariates Spreadsheets #####
##############################################################

Meds<-read.csv("/data/jux/BBL/studies/grmpy/subjectData/n144_DataFreeze/Medications.csv")
Meds<-Meds[,c(1,4:5)] # Remove Visit 2 because 85 missing Values
names(Meds)<-c("bblid","Medications","Psychotropics")

TP2covars<-readRDS("/data/jux/BBL/projects/jirsaraieStructuralIrrit/data/n141_TP2_NMF/n141_Demo+ARI+QA_20180322.rds")
Ratecovars<-readRDS("/data/jux/BBL/projects/jirsaraieStructuralIrrit/data/n137_Rate_NMF/n137_Demo+ARI+QA_20180401.rds")

###################################################################################
##### Combines and Selects only the Subjects of Interest for each Spreadsheet #####
###################################################################################

TP2covars<-merge(TP2covars,Meds, by= c("bblid"))
Ratecovars<-merge(Ratecovars,Meds, by= c("bblid"))

####################################################
##### Reclassify into Factors for New Varibles #####
####################################################

TP2covars$medications<-as.factor(TP2covars$Medications)
TP2covars$psychotropics<-as.factor(TP2covars$Psychotropics)

Ratecovars$medications<-as.factor(Ratecovars$Medications)
Ratecovars$psychotropics<-as.factor(Ratecovars$Psychotropics)

################################
##### Remove Old Variables #####
################################

TP2covars$Medications<-NULL
TP2covars$Psychotropics<-NULL
Ratecovars$Medications<-NULL
Ratecovars$Psychotropics<-NULL

###########################################################
##### Write the new RDS files with Drug Use Variables #####
###########################################################

saveRDS(TP2covars, "/data/jux/BBL/projects/jirsaraieStructuralIrrit/data/n141_TP2_NMF/n141_Demo+ARI+QA_20180322.rds")
saveRDS(Ratecovars,"/data/jux/BBL/projects/jirsaraieStructuralIrrit/data/n137_Rate_NMF/n137_Demo+ARI+QA_20180401.rds")

###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################
