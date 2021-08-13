#########################################################
# This script is meant to run with psycha1 files, whose names for "read.csv()" will eventually be automated.
#Caluclates summary scores for the BISS and MADRS clinical interviews.

########################################################
#### DATA-ENTRY VARIABLES & SCALES ####

## Find the correct date to use (aka use the most recent file):
rawPsycha1 <- list.files("/data/jux/BBL/studies/grmpy/rawPsycha1/")
rawPsycha1_tracker <- regmatches(rawPsycha1, regexpr("tracker_redcap_manualpull_.*[0-9]", rawPsycha1))
rawPsycha1_tracker <- regmatches(rawPsycha1_tracker, regexpr("[0-9].*[0-9]", rawPsycha1_tracker))
rawPsycha1_tracker_dates <- as.numeric(rawPsycha1_tracker)
currentDate <- rawPsycha1_tracker_dates[which.max(rawPsycha1_tracker_dates)]

grumpy3<-read.csv(paste("/data/jux/BBL/studies/grmpy/rawPsycha1/tracker_redcap_manualpull_", currentDate, ".csv", sep = ""))
grumpy3[grumpy3 ==-9999] <- NA
scored_tracker_redcap_manualpull<-grumpy3[,c('bblid','scanid','group','scan_date'), drop=FALSE]
scored_tracker_redcap_manualpull<-scored_tracker_redcap_manualpull[order(scored_tracker_redcap_manualpull$bblid),]

#BISS#
BISS_SummaryScores<-grumpy3[,c('bblid'), drop=FALSE]
biss<-grumpy3[,c(grep('biss_[0-9]', names(grumpy3), value=T))]
BISS_SummaryScores$biss_depstate<-rowSums(biss[,1:22])
BISS_SummaryScores$biss_manstate<-rowSums(biss[,23:43])
BISS_SummaryScores$biss_naflag<-ifelse(complete.cases(biss),0,1) #flags subjects that have NAs

#MADRS#
MADRS_SummaryScores<-grumpy3[,c('bblid'), drop=FALSE]
madrs<-grumpy3[,c(grep('madrs_[0-9]', colnames(grumpy3)))]
MADRS_SummaryScores$madrs_total<-rowSums(madrs[,1:10])
MADRS_SummaryScores$madrs_naflag<-ifelse(complete.cases(madrs),0,1) #flags subjects that have NAs

biss_madrs_scored <- merge(BISS_SummaryScores, MADRS_SummaryScores, "bblid", all.x = TRUE, all.y = TRUE)

## combine with scored tracker
scored_tracker_redcap_manualpull <- merge(biss_madrs_scored,scored_tracker_redcap_manualpull, "bblid", all.x = TRUE, all.y = TRUE) 
#write csv #
write.csv(scored_tracker_redcap_manualpull, paste('/data/jux/BBL/studies/grmpy/processedPsycha1/scored_tracker_redcap_manualpull_', currentDate, '.csv', sep = ''))          