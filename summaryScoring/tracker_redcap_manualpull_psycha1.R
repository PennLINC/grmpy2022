#########################################################
# This script is meant to run with psycha1 files, whose names for "read.csv()" will eventually be automated.
#Caluclates summary scores for the BISS and MADRS clinical interviews.

########################################################
#### DATA-ENTRY VARIABLES & SCALES ####

currentDate<-Sys.Date()

grumpy3<-read.csv("/data/jux/BBL/studies/grmpy/rawPsycha1/tracker_redcap_manualpull_20180622.csv")
grumpy3[grumpy3 ==-9999] <- NA
demos<-grumpy3[,c('bblid','scanid','dob','group','scan_date'), drop=FALSE]
demos<-demos[order(demos$bblid),]

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

#write csv #
write.csv(biss_madrs_scored, paste('/data/jux/BBL/studies/grmpy/rawPsycha1/scored_StateTrait_', currentDate, '.csv', sep = '')
