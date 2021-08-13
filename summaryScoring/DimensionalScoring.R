###################################################################################################
##########################     GRMPY - Summary Scores - Dimensional      ##########################
##########################               Robert Jirsaraie                ##########################
##########################        rjirsara@pennmedicine.upenn.edu        ##########################
##########################                 06/01/2018                    ##########################
###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################
# Use #

# This script was created to refine and create summary scores for grmpy data that was gathered from
# RedCap. 

###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################

#####################################################################
##### Selects only the Subjects of Interest --- IMAGING SECTION #####
#####################################################################

currentDate<-Sys.Date()

grumpy<-read.csv("/data/jux/BBL/studies/grmpy/subjectData/n144_DataFreeze/BBLSelfreportAndStat_DATA_2018-06-02_2153.csv")
grumpy<-grumpy[ which(grumpy$bbl_protocol %in% "GRMPY") , ]
grumpy<-grumpy[complete.cases(grumpy[,c(14:20)]),]
grumpy[grumpy ==-9999] <- NA 

RDStp2<-readRDS("/data/jux/BBL/projects/jirsaraieStructuralIrrit/data/n141_TP2_NMF/n141_Demo+ARI+QA_20180322.rds")
grumpy<-grumpy[ which(grumpy$bblid %in% RDStp2$bblid),]

###############################################################################
##### Selects only the Subjects of Interest --- Self Report Trait Section #####
###############################################################################

#SWAN-child#
SWAN_SummaryScores<-grumpy[,c('bblid'), drop=FALSE]
swan<-grumpy[,c(grep('swan_[0-9]', names(grumpy), value=T))]
swan<-swan[,c(1:18)]
SWAN_SummaryScores$SWAN_ADHDdim<-rowSums(swan[,c('swan_1','swan_2','swan_3','swan_4','swan_5','swan_6','swan_7','swan_8','swan_9','swan_10',
'swan_11','swan_12','swan_13','swan_14','swan_15','swan_16','swan_17','swan_18')])

#ACES#
ACES_SummaryScores<-grumpy[,c('bblid'), drop=FALSE]
aces<-grumpy[,c(grep('aces_[0-9]', names(grumpy), value=T))]
ACES_SummaryScores$ACEs_ELSdim<-rowSums(aces[,c('aces_1','aces_2','aces_3','aces_4','aces_5','aces_6','aces_7','aces_8','aces_9','aces_10')])

#SCARED#
SCARED_SummaryScores<-grumpy[,c('bblid'), drop=FALSE]
scared<-grumpy[,c(grep('scared_[0-9]', names(grumpy), value=T))]
scared<-scared[,c('scared_1','scared_2','scared_3','scared_4','scared_5','scared_6','scared_7','scared_8','scared_9',
                  'scared_10','scared_11','scared_12','scared_13','scared_14','scared_15','scared_16','scared_17','scared_18',
                  'scared_19','scared_20','scared_21','scared_22','scared_23','scared_24','scared_25','scared_26','scared_27',
                  'scared_28','scared_29','scared_30','scared_31','scared_32','scared_33','scared_34','scared_35','scared_36',
                  'scared_37','scared_38','scared_39','scared_40','scared_41')]
SCARED_SummaryScores$SCARED_ANXITYdim<-rowSums(scared)

#BDI#
BDI_SummaryScores<-grumpy[,c('bblid'), drop=FALSE]
bdi<-grumpy[,c(grep('bdi_[0-9]', colnames(grumpy)))]
bdi<-bdi[, !colnames(bdi) %in% c('bdi_19a')] 
BDI_SummaryScores$BDI_DEPRESSIONdim<-rowSums(bdi)

#######################################################
##### Merge the New Dimensional Measures with ARI #####
#######################################################

master <- merge(RDStp2, SWAN_SummaryScores, by=c('bblid'))
master <- merge(master, SCARED_SummaryScores, by=c('bblid'))
master <- merge(master, BDI_SummaryScores, by=c('bblid'))
master <- merge(master, ACES_SummaryScores, by=c('bblid'))

###################################################
##### Create Logs Of the Dimensional Measures #####
###################################################

master[,27:30]<-log(master[,23:26]+1)
names(master)[27:30] <- c("log_SWAN_ADHDdim","log_SCARED_ANXITYdim","log_BDI_DEPRESSIONdim","log_ACEs_ELSdim")

###################################################################
##### Create a Correlation Matrix of All Dimensional Measures #####
###################################################################

MATRIX<-cor(master[,c(16,23:26)], use = "complete.obs")
round(MATRIX, 2)

logMATRIX<-cor(master[,c(16,27:30)], use = "complete.obs")
round(logMATRIX, 2)

##########################################################################################
##### Read in the Rate RDS To Copy Variables to that Spreadsheet and Save Both Files #####
##########################################################################################

RDSrate<-readRDS("/data/jux/BBL/projects/jirsaraieStructuralIrrit/data/n137_Rate_NMF/n137_Demo+ARI+QA_20180401.rds")
Added<-master[,c(1,23:30)]
RDSrate<-merge(RDSrate,Added, by=c("bblid"))

saveRDS(master, "/data/jux/BBL/projects/jirsaraieStructuralIrrit/data/n141_TP2_NMF/n141_AllDimensions_20180602.rds")
saveRDS(RDSrate, "/data/jux/BBL/projects/jirsaraieStructuralIrrit/data/n137_Rate_NMF/n137_AllDimensions_20180602.rds")

###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################
