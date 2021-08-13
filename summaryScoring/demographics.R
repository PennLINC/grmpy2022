####################################################
##### This script is meant to be used with the #####
##### psycha1 demographics file found in       #####
##### /data/jux/BBL/studies/grmpy/rawPsycha1/  #####
##### demographics_currentDate.csv             #####
####################################################

## Find the correct date to use (aka use the most recent file):
rawPsycha1 <- list.files("/data/jux/BBL/studies/grmpy/rawPsycha1/")
rawPsycha1_dates <- regmatches(rawPsycha1, regexpr("[0-9].*[0-9]", rawPsycha1))
rawPsycha1_dates <- as.numeric(rawPsycha1_dates)
currentDate <- rawPsycha1_dates[which.max(rawPsycha1_dates)]

############################################
##### Read in the Raw Demographic File #####
############################################

Demo<-read.csv(paste("/data/jux/BBL/studies/grmpy/rawPsycha1/demographics_", currentDate, ".csv", sep = ""))

###################################
##### Remove Unneeded Columns #####
###################################

Demo <- subset(Demo, select = -c(entry,istatus,cstatus,staff,location,phasenum, intake_study,common_enroll,study_coordinator,study_category,study_siteid,study_famid,study_subid,study_entry,deg_rel_proband,study_endreason,study_notes,dointake,dovisit,dohphoneresult,docphoneresult,doestdue,doenroll,doend))

#################################################
##### Recode Variables that Need Processing #####
#################################################

Demo$visitageyears<-Demo$visitagemonths/12
Demo$parent_educ_avg <- (Demo$mom_educ + Demo$dad_educ)/2

#######################
##### Save Output #####
#######################

write.csv(Demo,paste("/data/jux/BBL/studies/grmpy/processedPsycha1/demographics_",currentDate, ".csv", sep = ""))
