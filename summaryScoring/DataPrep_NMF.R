###################################################################################################
##########################    GRMPY - Merge Dataset From RedCap - NMF    ##########################
##########################               Robert Jirsaraie                ##########################
##########################        rjirsara@pennmedicine.upenn.edu        ##########################
##########################                 10/19/2017                    ##########################
###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################
# Use #

#This script was created to merge the datasets downloaded from RedCap and to ensure that only the 
#subjects of interest will be included. Data must first be uploaded to CfN.

###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################

#######################################################
##### Reads in the Datasets that Will be Combined #####
#######################################################

subjects<-read.csv("/data/joy/BBL/projects/jirsaraieStructuralIrrit/data/NMF/n115_Cohort_20171015.csv")
Demographics<-read.csv("/data/joy/BBL/projects/jirsaraieStructuralIrrit/data/NMF/Demographics.csv")
ARI<-read.csv("/data/joy/BBL/projects/jirsaraieStructuralIrrit/data/NMF/Irritability.csv")

###################################################################################################
##### Removes Blank Rows, Removes Rows that Don't Match Subject File, Removes Dupilcated Rows #####
###################################################################################################

emptyARI<-na.omit(ARI)
unmatchedARI<-emptyARI[(emptyARI$bblid %in% subjects$bblid),]
rARI<-unmatchedARI[!duplicated(unmatchedARI), ]

#####################################################
##### Removes Rows that Dont Match Subject File #####
#####################################################

rDemo<-Demographics[(Demographics$bblid %in% subjects$bblid),]

#############################################
##### Merges the Datasets by the bblids #####
#############################################

finsubs <- merge(subjects, rDemo, by=c('bblid'))
finalsubs <- merge(finsubs, rARI, by=c('bblid'))

#######################################################
##### Removes Extra Column From the Final Dataset #####
#######################################################

finalSubjects <- subset(finalsubs, select = -c(ari_naflag))

#####################################
##### Outputs the Final Dataset #####
#####################################

write.csv(finalSubjects, paste('/data/joy/BBL/projects/grmpyProcessing2017/structural/struct_data/n115_Demo+ARI_',
format(Sys.Date(), format="%Y%m%d"),'.csv', sep=''), quote=F, row.names=F)

###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################
