#########################################################
#In order to run properly, must change all three csv paths to most current csv -- download these csv's from the projects on RedCap. GRMPY Summary scores only uses data from banshee, and not from selkie.
#The csv for this scoring code is downloaded from the "GRMPY DataEntry Interviews #tracker" project. Download the "Grmpy Summary Score Demos" report.
#^^This is the csv you will use for this scoring code.
#Caluclates summary scores for the BISS and MADRS clinical interviews.

########################################################
#### DATA-ENTRY VARIABLES & SCALES ####

currentDate<-Sys.Date()

grumpy3<-read.csv("/import/monstrum/grmpy/n103DataFreeze/rawData/n103grmpyBissMadrsScales20170131.csv")
grumpy3[grumpy3 ==-9999] <- NA
demos<-grumpy3[,c('bblid','scanid','dob','group','scan_date'), drop=FALSE]
demos<-demos[order(demos$bblid),]

#BISS#
BISS_SummaryScores<-grumpy3[,c('bblid'), drop=FALSE]
biss<-grumpy3[,c(grep('biss_[0-9]', names(grumpy3), value=T))]
BISS_SummaryScores$biss_depstate<-rowSums(biss[,1:22])
BISS_SummaryScores$biss_manstate<-rowSums(biss[,23:43])
BISS_SummaryScores$biss_naflag<-ifelse(complete.cases(biss),0,1) #flags subjects that have NAs
write.csv(BISS_SummaryScores, paste('/import/monstrum/grmpy/n103DataFreeze/summaryScores/n103grmpyBISSSummaryScores_', currentDate, '.csv', sep=''), row.names=F)

#MADRS#
MADRS_SummaryScores<-grumpy3[,c('bblid'), drop=FALSE]
madrs<-grumpy3[,c(grep('madrs_[0-9]', colnames(grumpy3)))]
MADRS_SummaryScores$madrs_total<-rowSums(madrs[,1:10])
MADRS_SummaryScores$madrs_naflag<-ifelse(complete.cases(madrs),0,1) #flags subjects that have NAs
write.csv(MADRS_SummaryScores, paste('/import/monstrum/grmpy/n103DataFreeze/summaryScores/n103grmpyMADRSSummaryScores_', currentDate, '.csv', sep=''), row.names=F)
