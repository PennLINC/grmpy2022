###################################################################################################
##########################          GRMPY - Summary Scores - Drugs       ##########################
##########################               Robert Jirsaraie                ##########################
##########################        rjirsara@pennmedicine.upenn.edu        ##########################
##########################                 06/02/2018                    ##########################
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

Drugs<-read.csv("/data/jux/BBL/studies/grmpy/subjectData/n144_DataFreeze/GRMPYDataEntryInterv_DATA_2018-06-01_0118.csv")
Drugs<-Drugs[,1:3] # Remove Visit 2 because 85 missing Values

TP2covars<-readRDS("/data/jux/BBL/projects/jirsaraieStructuralIrrit/data/n141_TP2_NMF/n141_Demo+ARI+QA_20180322.rds")
Ratecovars<-readRDS("/data/jux/BBL/projects/jirsaraieStructuralIrrit/data/n137_Rate_NMF/n137_Demo+ARI+QA_20180401.rds")

###################################################################################
##### Combines and Selects only the Subjects of Interest for each Spreadsheet #####
###################################################################################

TP2covars<-merge(TP2covars,Drugs, by= c("bblid"))
Ratecovars<-merge(Ratecovars,Drugs, by= c("bblid"))

######################################################
##### Recode Values listed as unk into NA values #####
######################################################

library(car)

TP2covars$drugscreen1<-recode(TP2covars$drugscreen1,"c('unk')=NA")
Ratecovars$drugscreen1<-recode(Ratecovars$drugscreen1,"c('unk')=NA")

###########################################################################
##### Create Another Variables that Excludes Users with More than THC #####
###########################################################################

TP2covars$drugscreenTHC<-TP2covars$drugscreen1
Ratecovars$drugscreenTHC<-Ratecovars$drugscreen1

TP2covars[33,22]<-NA
TP2covars[69,22]<-NA
TP2covars[86,22]<-NA

Ratecovars[33,33]<-NA
Ratecovars[67,33]<-NA
Ratecovars[83,33]<-NA

TP2covars[,21]<-NULL
Ratecovars[,32]<-NULL

##############################################################################
##### Create Another Variable that Excludes People with Current Drug Use #####
##############################################################################

TP2covars$drugscreenEXCLUSION<-TP2covars$drugscreen1
Ratecovars$drugscreenEXCLUSION<-Ratecovars$drugscreen1

TP2covars$drugscreenEXCLUSION<-recode(TP2covars$drugscreenEXCLUSION,"c('1')= 9")
TP2covars$drugscreenEXCLUSION<-recode(TP2covars$drugscreenEXCLUSION,"c('0')= 1")
TP2covars$drugscreenEXCLUSION<-recode(TP2covars$drugscreenEXCLUSION,"c('9',NA)= 0")
Ratecovars$drugscreenEXCLUSION<-recode(Ratecovars$drugscreenEXCLUSION,"c('1')= 9")
Ratecovars$drugscreenEXCLUSION<-recode(Ratecovars$drugscreenEXCLUSION,"c('0')= 1")
Ratecovars$drugscreenEXCLUSION<-recode(Ratecovars$drugscreenEXCLUSION,"c('9',NA)= 0")

###########################################################
##### Write the new RDS files with Drug Use Variables #####
###########################################################

saveRDS(TP2covars, "/data/jux/BBL/projects/jirsaraieStructuralIrrit/data/n141_TP2_NMF/n141_Demo+ARI+QA_20180322.rds")
saveRDS(Ratecovars,"/data/jux/BBL/projects/jirsaraieStructuralIrrit/data/n137_Rate_NMF/n137_Demo+ARI+QA_20180401.rds")

###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################
