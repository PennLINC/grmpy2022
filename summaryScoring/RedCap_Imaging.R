#### IMAGING SCALES ####
currentDate<-Sys.Date()

grumpy2<-read.csv("/import/monstrum/grmpy/n103DataFreeze/rawData/n103grmpyImagingScales20170131.csv")
grumpy2<-grumpy2[ which(grumpy2$bbl_protocol %in% "GRMPY") , ] #removes subjects not listed as GRMPY protcol
grumpy2[grumpy2 ==-9999] <- NA #replaces -9999 with NAs
grumpy2<-grumpy2[order(grumpy2$bblid),]

grumpy2.1<-grumpy2[which(grumpy2$admin_prepost %in% "1"), ] #removes post data coded as "2"
grumpy2.1<-grumpy2.1[which(grumpy2.1$stai_trait_vcode == "V"),] #removes pre data not coded as "V"
grumpy2.2<-grumpy2[which(grumpy2$admin_prepost %in% "2"), ] #removes pre data coded as "1"
grumpy2.2<-grumpy2.2[which(grumpy2.2$stai_state_vcode == "V"),] #removes post data not coded as "V"

#STAXI-2 C/A#
STAXI2CA_SummaryScores<-grumpy2.1[,c('bblid'), drop=FALSE]
staxi2<-grumpy2.1[,c(grep('staxi2_ca_[0-9]', names(grumpy2), value=T))]
STAXI2CA_SummaryScores$stateanger_total<-rowSums(staxi2[,c('staxi2_ca_1','staxi2_ca_2','staxi2_ca_3','staxi2_ca_4','staxi2_ca_5','staxi2_ca_6','staxi2_ca_7','staxi2_ca_8','staxi2_ca_9','staxi2_ca_10')])
STAXI2CA_SummaryScores$stateanger_feelings<-rowSums(staxi2[,c('staxi2_ca_1','staxi2_ca_2','staxi2_ca_3','staxi2_ca_8','staxi2_ca_10')])
STAXI2CA_SummaryScores$stateanger_expression<-rowSums(staxi2[,c('staxi2_ca_4','staxi2_ca_5','staxi2_ca_6','staxi2_ca_7','staxi2_ca_9')])
STAXI2CA_SummaryScores$traitanger_total<-rowSums(staxi2[,c('staxi2_ca_11','staxi2_ca_12','staxi2_ca_13','staxi2_ca_14','staxi2_ca_15','staxi2_ca_16','staxi2_ca_17','staxi2_ca_18','staxi2_ca_19','staxi2_ca_20')])
STAXI2CA_SummaryScores$traitanger_temperament<-rowSums(staxi2[,c('staxi2_ca_11','staxi2_ca_12','staxi2_ca_13','staxi2_ca_16','staxi2_ca_19')])
STAXI2CA_SummaryScores$traitanger_reaction<-rowSums(staxi2[,c('staxi2_ca_14','staxi2_ca_15','staxi2_ca_17','staxi2_ca_18','staxi2_ca_20')])
STAXI2CA_SummaryScores$angerexpression_out<-rowSums(staxi2[,c('staxi2_ca_21','staxi2_ca_24','staxi2_ca_27','staxi2_ca_31','staxi2_ca_34')])
STAXI2CA_SummaryScores$angerexpression_in<-rowSums(staxi2[,c('staxi2_ca_22','staxi2_ca_25','staxi2_ca_28','staxi2_ca_33','staxi2_ca_35')])
STAXI2CA_SummaryScores$angercontrol<-rowSums(staxi2[,c('staxi2_ca_23','staxi2_ca_26','staxi2_ca_29','staxi2_ca_30','staxi2_ca_32')])
STAXI2CA_SummaryScores$staxi2_naflag<-ifelse(complete.cases(staxi2),0,1) #flags subjects that have NAs
write.csv(STAXI2CA_SummaryScores, paste("/import/monstrum/grmpy/n103DataFreeze/summaryScores/n103grmpySTAXI2CASummaryScores_", currentDate, ".csv", sep=""), row.names=F)

#STAI-Trait#
STAITRAIT_SummaryScores<-grumpy2.1[,c('bblid'), drop=FALSE]
stai<-grumpy2.1[,c(grep('stai_q_(.+)', colnames(grumpy2.1)))]
stai1<-stai[,c('stai_q_22','stai_q_24','stai_q_25','stai_q_28','stai_q_29','stai_q_31','stai_q_32','stai_q_35','stai_q_37','stai_q_38','stai_q_40')]
stai2<-stai[,c('stai_q_21','stai_q_23','stai_q_26','stai_q_27','stai_q_30','stai_q_33','stai_q_34','stai_q_36','stai_q_39')]
stai2<-(4-stai2)+1 #reverse code items in stai2
stai3<-cbind(stai1,stai2) 
STAITRAIT_SummaryScores$staitrait_total<-rowSums(stai3)
STAITRAIT_SummaryScores$staitrait_avg<-rowMeans(stai3)
STAITRAIT_SummaryScores$staitrait_naflag<-ifelse(complete.cases(stai),0,1) #flags subjects that have NAs
write.csv(STAITRAIT_SummaryScores, paste("/import/monstrum/grmpy/n103DataFreeze/summaryScores/n103grmpySTAITRAITSummaryScores_", currentDate, ".csv", sep=""), row.names=F)

#STAI-State Pre-Scan#
##NEED TO WRITE SUMMARY SCORE CODE FOR STAI STATE PRE/POST##
stai<-grumpy2.2[,c(grep('stai_q_(.+)', colnames(grumpy2.2)))]
#STAI-State Post-Scan#
stai<-grumpy2.2[,c(grep('stai_q_(.+)', colnames(grumpy2.2)))]