###################################################################################################
##########################        GRMPY - Summary Scores - Imaging       ##########################
##########################               Robert Jirsaraie                ##########################
##########################        rjirsara@pennmedicine.upenn.edu        ##########################
##########################                 12/10/2017                    ##########################
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

grumpy2<-read.csv("/home/rjirsaraie/ImagingScalesSTAISTA_DATA_2017-12-06_2132.csv")
grumpy2<-grumpy2[ which(grumpy2$bbl_protocol %in% "GRMPY") , ] 
grumpy2[grumpy2 ==-9999] <- NA 
subs<-read.csv("/data/joy/BBL/projects/grmpyProcessing2017/structural/struct_pipeline/n118_Cohort_20170911.csv", header=FALSE)
grumpy2<-grumpy2[ which(grumpy2$bblid %in% subs$V1) , ]

########################################################
##### Split Data Frames into Before and After Scan #####
########################################################

grumpy2<-grumpy2[order(grumpy2$bblid),]
grumpy2.1<-grumpy2[which(grumpy2$admin_prepost %in% "1"), ] 
grumpy2.1<-grumpy2.1[which(grumpy2.1$stai_trait_vcode == "V"),] 
grumpy2.2<-grumpy2[which(grumpy2$admin_prepost %in% "2"), ] 
grumpy2.2<-grumpy2.2[which(grumpy2.2$stai_state_vcode == "V"),] 

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
STAXI2CA_SummaryScores$staxi2_naflag<-ifelse(complete.cases(staxi2),0,1) 
write.csv(STAXI2CA_SummaryScores, paste("/data/joy/BBL/studies/grmpy/n118DataFreeze/summaryScores/n102grmpySTAXI2CASummaryScores_", currentDate, ".csv", sep=""), row.names=F)

#STAI-Trait#
STAITRAIT_SummaryScores<-grumpy2.1[,c('bblid'), drop=FALSE]
stai<-grumpy2.1[,c(grep('stai_q_(.+)', colnames(grumpy2.1)))]
stai1<-stai[,c('stai_q_22','stai_q_24','stai_q_25','stai_q_28','stai_q_29','stai_q_31','stai_q_32','stai_q_35','stai_q_37','stai_q_38','stai_q_40')]
stai2<-stai[,c('stai_q_21','stai_q_23','stai_q_26','stai_q_27','stai_q_30','stai_q_33','stai_q_34','stai_q_36','stai_q_39')]
stai2<-(4-stai2)+1 
stai3<-cbind(stai1,stai2) 
STAITRAIT_SummaryScores$staitrait_total<-rowSums(stai3)
STAITRAIT_SummaryScores$staitrait_avg<-rowMeans(stai3)
STAITRAIT_SummaryScores$staitrait_naflag<-ifelse(complete.cases(stai),0,1) 
write.csv(STAITRAIT_SummaryScores, paste("/data/joy/BBL/studies/grmpy/n118DataFreeze/summaryScores/n102grmpySTAITRAITSummaryScores_", currentDate, ".csv", sep=""), row.names=F)

#STAI-State Pre-Scan#
##NEED TO WRITE SUMMARY SCORE CODE FOR STAI STATE PRE/POST##
stai<-grumpy2.2[,c(grep('stai_q_(.+)', colnames(grumpy2.2)))]
#STAI-State Post-Scan#
stai<-grumpy2.2[,c(grep('stai_q_(.+)', colnames(grumpy2.2)))]

###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################

###############################################################################
##### Selects only the Subjects of Interest --- Self Report Trait Section #####
###############################################################################

grumpy<-read.csv("/home/rjirsaraie/BBLSelfreportAndStat_DATA_2018-05-10_1919.csv")
grumpy<-grumpy[ which(grumpy$bbl_protocol %in% "GRMPY") , ] 
grumpy<-grumpy[ which(grumpy$statetrait_vcode %in% "V" | grumpy$statetrait_vcode %in% "U") , ]
grumpy[grumpy ==-9999] <- NA 
grumpy<-grumpy[order(grumpy$bblid),]
subs<-read.csv("/data/jux/BBL/projects/jirsaraieStructuralIrrit/data/n144_TP2_JLF/n144_Irritability_20180322.csv", header=TRUE)
grumpy<-grumpy[ which(grumpy$bblid %in% cohort$bblid) , ]
grumpy<-grumpy[!(is.na(grumpy$ari_1)),]

#ALS-18#
ALS_SummaryScores<-grumpy[,c('bblid'), drop=FALSE]
als<-grumpy[,c(grep('als_[0-9]', names(grumpy), value=T))]
als<-als[,c(1:18)]
ALS_SummaryScores$als_avg<-rowMeans(als)
ALS_SummaryScores$als_naflag<-ifelse(complete.cases(als),0,1)
write.csv(ALS_SummaryScores, paste('/data/joy/BBL/studies/grmpy/n118DataFreeze/summaryScores/n118grmpyALSSummaryScores_', currentDate, '.csv', sep=''), row.names=F)

#MAP-SR#
MAPSR_SummaryScores<-grumpy[,c('bblid'), drop=FALSE]
mapsr<-grumpy[,c(grep('mapssr_[0-9]', names(grumpy), value=T))]
MAPSR_SummaryScores$mapsr_rawtot_sum<-rowSums(mapsr)
MAPSR_SummaryScores$mapsr_social_sum<-rowSums(mapsr[,c("mapssr_1","mapssr_2","mapssr_3")])
MAPSR_SummaryScores$mapsr_recvoc_sum<-rowSums(mapsr[,c("mapssr_4","mapssr_5","mapssr_6")])
MAPSR_SummaryScores$mapsr_motrelation_sum<-rowSums(mapsr[,c("mapssr_7","mapssr_8","mapssr_9")])
MAPSR_SummaryScores$mapsr_engage_sum<-rowSums(mapsr[,c("mapssr_10","mapssr_11","mapssr_12", "mapssr_13", "mapssr_14", "mapssr_15")])
MAPSR_SummaryScores$MAP_naflag<-ifelse(complete.cases(MAPSR_SummaryScores),0,1)
write.csv(MAPSR_SummaryScores, paste('/data/joy/BBL/studies/grmpy/n118DataFreeze/summaryScores/n118grmpyMAPSRSummaryScores_', currentDate, '.csv', sep=''), row.names=F)

#SWAN-child#
SWAN_SummaryScores<-grumpy[,c('bblid'), drop=FALSE]
swan<-grumpy[,c(grep('swan_[0-9]', names(grumpy), value=T))]
swan<-swan[,c(1:18)]
swan$swan_total1<-rowSums(swan[,c('swan_1','swan_2','swan_3','swan_4','swan_5','swan_6','swan_7','swan_8','swan_9')])
swan$swan_total2<-rowSums(swan[,c('swan_10','swan_11','swan_12','swan_13','swan_14','swan_15','swan_16','swan_17','swan_18')])
SWAN_SummaryScores$swan_naflag<-ifelse(complete.cases(swan),0,1) 
SWAN_SummaryScores$ADHD_Combined<-ifelse((swan$swan_total1 >= 6 & swan$swan_total2 >=6), 1,0)
SWAN_SummaryScores$ADHD_Inattentive<-ifelse((swan$swan_total1 >= 6 & swan$swan_total2 <6), 1,0)
SWAN_SummaryScores$ADHD_Hyperactive<-ifelse((swan$swan_total1 < 6 & swan$swan_total2 >=6), 1,0)
SWAN_SummaryScores$NoADHD<-ifelse((swan$swan_total1 < 6 & swan$swan_total2 < 6), 1,0)
write.csv(SWAN_SummaryScores, paste('/data/joy/BBL/studies/grmpy/n118DataFreeze/summaryScores/n118grmpySWANSummaryScores_', currentDate, '.csv', sep=''), row.names=F)

#SWAN-collateral- Data Missing#
#SWANcoll_SummaryScores<-grumpy[,c('bblid'), drop=FALSE]
#swancoll<-grumpy[,c(grep('swan_(.*)_c$', names(grumpy), value=T))]
#swancoll<-swancoll[,c(1:18)]
#swancoll$swan_total1<-rowSums(swancoll[,c('swan_1_c','swan_2_c','swan_3_c','swan_4_c','swan_5_c','swan_6_c','swan_7_c','swan_8_c','swan_9_c')])
#swancoll$swan_total2<-rowSums(swancoll[,c('swan_10_c','swan_11_c','swan_12_c','swan_13_c','swan_14_c','swan_15_c','swan_16_c','swan_17_c','swan_18_c')])
#SWANcoll_SummaryScores$swan_naflag<-ifelse(complete.cases(swancoll),0,1) #flags subjects that have NAs
#SWANcoll_SummaryScores$ADHD_Combined<-ifelse((swancoll$swan_total1 >= 6 & swancoll$swan_total2 >=6), 1,0)
#SWANcoll_SummaryScores$ADHD_Inattentive<-ifelse((swancoll$swan_total1 >= 6 & swancoll$swan_total2 <6), 1,0)
#SWANcoll_SummaryScores$ADHD_Hyperactive<-ifelse((swancoll$swan_total1 < 6 & swancoll$swan_total2 >=6), 1,0)
#SWANcoll_SummaryScores$NoADHD<-ifelse((swancoll$swan_total1 < 6 & swancoll$swan_total2 < 6), 1,0)
#write.csv(SWANcoll_SummaryScores, paste('/data/joy/BBL/studies/grmpy/n118DataFreeze/summaryScores/n103grmpySWANcollSummaryScores_', currentDate, '.csv', sep=''), #row.names=F)

#ACES#
ACES_SummaryScores<-grumpy[,c('bblid'), drop=FALSE]
aces<-grumpy[,c(grep('aces_[0-9]', names(grumpy), value=T))]
ACES_SummaryScores$aces_total<-rowSums(aces[,c('aces_1','aces_2','aces_3','aces_4','aces_5','aces_6','aces_7','aces_8','aces_9','aces_10')])
ACES_SummaryScores$aces_naflag<-ifelse(complete.cases(aces),0,1) 
write.csv(ACES_SummaryScores, paste("/data/joy/BBL/studies/grmpy/n118DataFreeze/summaryScores/n118grmpyACESSummaryScores_", currentDate, ".csv", sep=""), row.names=F)

#SCARED#
SCARED_SummaryScores<-grumpy[,c('bblid'), drop=FALSE]
scared<-grumpy[,c(grep('scared_[0-9]', names(grumpy), value=T))]
scared<-scared[,c('scared_1','scared_2','scared_3','scared_4','scared_5','scared_6','scared_7','scared_8','scared_9',
                  'scared_10','scared_11','scared_12','scared_13','scared_14','scared_15','scared_16','scared_17','scared_18',
                  'scared_19','scared_20','scared_21','scared_22','scared_23','scared_24','scared_25','scared_26','scared_27',
                  'scared_28','scared_29','scared_30','scared_31','scared_32','scared_33','scared_34','scared_35','scared_36',
                  'scared_37','scared_38','scared_39','scared_40','scared_41')]
SCARED_SummaryScores$scared_total<-rowSums(scared)
SCARED_SummaryScores$AnxietyDisorder<-ifelse(SCARED_SummaryScores$scared_total >=25, 1,0)
SCARED_SummaryScores$scared_naflag<-ifelse(complete.cases(scared),0,1) 
write.csv(SCARED_SummaryScores, paste("/data/joy/BBL/studies/grmpy/n118DataFreeze/summaryScores/n118grmpySCAREDSummaryScores_", currentDate, ".csv", sep=""), row.names=F)

#SCARED-collateral- missing data#
#SCAREDcoll_SummaryScores<-grumpy[,c('bblid'), drop=FALSE]
#scaredcoll<-grumpy[,c(grep('scared_(.*)_c$', names(grumpy), value=T))]
#scaredcoll<-scaredcoll[,c('scared_1_c','scared_2_c','scared_3_c','scared_4_c','scared_5_c','scared_6_c','scared_7_c','scared_8_c','scared_9_c',
#                          'scared_10_c','scared_11_c','scared_12_c','scared_13_c','scared_14_c','scared_15_c','scared_16_c','scared_17_c','scared_18_c',
#                          'scared_19_c','scared_20_c','scared_21_c','scared_22_c','scared_23_c','scared_24_c','scared_25_c','scared_26_c','scared_27_c',
#                          'scared_28_c','scared_29_c','scared_30_c','scared_31_c','scared_32_c','scared_33_c','scared_34_c','scared_35_c','scared_36_c',
#                          'scared_37_c','scared_38_c','scared_39_c','scared_40_c','scared_41_c')]
#SCAREDcoll_SummaryScores$scaredcoll_total<-rowSums(scaredcoll)
#SCAREDcoll_SummaryScores$AnxietyDisorder<-ifelse(SCAREDcoll_SummaryScores$scaredcoll_total >=25, 1,0)
#SCAREDcoll_SummaryScores$scaredcoll_naflag<-ifelse(complete.cases(scaredcoll),0,1) #flags subjects that have NAs
#write.csv(SCAREDcoll_SummaryScores, paste("/data/joy/BBL/studies/grmpy/n118DataFreeze/summaryScores/n103grmpySCAREDcollSummaryScores_", currentDate, ".csv", sep=""), row.names=F)

#RPAQ#
RPAQ_SummaryScores<-grumpy[,c('bblid'), drop=FALSE]
rpaq<-grumpy[,c(grep('rpaq_[0-9]', names(grumpy), value=T))]
RPAQ_SummaryScores$rpaq_proactivetotal<-rowSums(rpaq[,c('rpaq_2','rpaq_4','rpaq_6','rpaq_9','rpaq_10','rpaq_12','rpaq_15','rpaq_17','rpaq_18', 'rpaq_20','rpaq_21','rpaq_23')])
RPAQ_SummaryScores$rpaq_reactivetotal<-rowSums(rpaq[,c('rpaq_1','rpaq_3','rpaq_5','rpaq_7','rpaq_8','rpaq_11','rpaq_13','rpaq_14','rpaq_16','rpaq_19','rpaq_22')])
RPAQ_SummaryScores$rpaq_naflag<-ifelse(complete.cases(rpaq),0,1) 
write.csv(RPAQ_SummaryScores, paste("/data/joy/BBL/studies/grmpy/n118DataFreeze/summaryScores/n118grmpyRPAQSummaryScores_", currentDate, ".csv", sep=""), row.names=F)

#ARI#
ARI_SummaryScores<-grumpy[,c('bblid'), drop=FALSE]
ari<-grumpy[,c(grep('ari_[0-9]', colnames(grumpy)))]
ari<-ari[,c('ari_1','ari_2','ari_3','ari_4','ari_5','ari_6')]
ARI_SummaryScores$ari_avg<-rowMeans(ari)
ARI_SummaryScores$ari_total<-rowSums(ari)
ari$ari_1[ari$ari_1 == "2"] <- "1"
ari$ari_2[ari$ari_2 == "2"] <- "1"
ari$ari_3[ari$ari_3 == "2"] <- "1"
ari$ari_4[ari$ari_4 == "2"] <- "1"
ari$ari_5[ari$ari_5 == "2"] <- "1"
ari$ari_6[ari$ari_6 == "2"] <- "1"
ari[1:6] <- lapply(ari[1:6], as.numeric) 
#ARI_SummaryScores$ari_alternate<-rowSums(ari)
ARI_SummaryScores$ari_naflag<-ifelse(complete.cases(ari),0,1) 
write.csv(ARI_SummaryScores, paste('/data/joy/BBL/studies/grmpy/n118DataFreeze/summaryScores/n118grmpyARISummaryScores_', currentDate, '.csv', sep=''), row.names=F)

#ARI-collateral - Missing Data#
#ARIcoll_SummaryScores<-grumpy[,c('bblid'), drop=FALSE]
#aricoll<-grumpy[,c(grep('ari_(.*)_c$', colnames(grumpy)))]
#aricoll<-aricoll[,c('ari_1_c','ari_2_c','ari_3_c','ari_4_c','ari_5_c','ari_6_c')]
#ARIcoll_SummaryScores$ari_total<-rowSums(aricoll)
#ARIcoll_SummaryScores$ari_avg<-rowMeans(aricoll)
#ARIcoll_SummaryScores$ari_naflag<-ifelse(complete.cases(aricoll),0,1) 
#write.csv(ARIcoll_SummaryScores, paste('/data/joy/BBL/studies/grmpy/n118DataFreeze/summaryScores/n103grmpyARIcollSummaryScores_', currentDate, '.csv', sep=''), row.names=F)

#BDI#
BDI_SummaryScores<-grumpy[,c('bblid'), drop=FALSE]
bdi<-grumpy[,c(grep('bdi_[0-9]', colnames(grumpy)))]
bdi<-bdi[, !colnames(bdi) %in% c('bdi_19a')] 
BDI_SummaryScores$bdi_NAflag<-ifelse(complete.cases(bdi),0,1)
BDI_SummaryScores$bdi_total<-rowSums(bdi)
write.csv(BDI_SummaryScores, paste('/data/joy/BBL/studies/grmpy/n118DataFreeze/summaryScores/n118grmpyBDISummaryScores_', currentDate, '.csv', sep=''), row.names=F)

#BISBAS#
BISBAS_SummaryScores<-grumpy[,c('bblid'), drop=FALSE]
bisbas<-grumpy[,c(grep('bisbas_[0-9]', colnames(grumpy)))]
bis1<-bisbas[,c('bisbas_8','bisbas_13','bisbas_16','bisbas_19','bisbas_24')]
bis2<-bisbas[,c('bisbas_2','bisbas_22')]
bis1<-(4-bis1)+1 
bis3<-cbind(bis1,bis2)
BISBAS_SummaryScores$bistotal<-rowSums(bis3) 
bas_drive<-bisbas[,c('bisbas_3','bisbas_9','bisbas_12','bisbas_21')]
bas_drive<-(4-bas_drive)+1 
BISBAS_SummaryScores$basdrive_total<-rowSums(bas_drive) 
bas_fun<-bisbas[,c('bisbas_5','bisbas_10','bisbas_15','bisbas_20')]
bas_fun<-(4-bas_fun)+1 
bas_fun_sum<-(bas_fun)
BISBAS_SummaryScores$basfun_total<-rowSums(bas_fun_sum)
bas_reward<-bisbas[,c('bisbas_4','bisbas_7','bisbas_14','bisbas_18','bisbas_23')]
bas_reward<-(4-bas_reward)+1 
BISBAS_SummaryScores$basreward_total<-rowSums(bas_reward)
write.csv(BISBAS_SummaryScores, paste('/data/joy/BBL/studies/grmpy/n118DataFreeze/summaryScores/n118grmpyBISBASSummaryScores_', currentDate, '.csv', sep=''), row.names=F)

#GRIT#
GRIT_SummaryScores<-grumpy[,c('bblid'), drop=FALSE]
grit<-grumpy[,c(grep('grit_[0-9]', colnames(grumpy)))]
grittiness<-grit[,c('grit_2','grit_4','grit_5','grit_7','grit_8','grit_10')]
openness<-grit[,c('grit_1','grit_3','grit_6','grit_9','grit_11','grit_12')]
GRIT_SummaryScores$grit_grittiness<-rowMeans(grittiness)
GRIT_SummaryScores$grit_openness<-rowMeans(openness)
grit$NAflag<-ifelse(complete.cases(grit),0,1) 
GRIT_SummaryScores$grit_naflag<-grit[,c('NAflag')]
write.csv(GRIT_SummaryScores, paste('/data/joy/BBL/studies/grmpy/n118DataFreeze/summaryScores/n118grmpyGRITSummaryScores_', currentDate, '.csv', sep=''), row.names=F)

#HCL#
HCL_SummaryScores<-grumpy[,c('bblid'), drop=FALSE]
hcl<-grumpy[,c(grep('hcl16_3_[0-9]', names(grumpy), value=T))]
HCL_SummaryScores$hcl_total<-rowSums(hcl)
write.csv(HCL_SummaryScores, paste('/data/joy/BBL/studies/grmpy/n118DataFreeze/summaryScores/n118grmpyHCLSummaryScores_', currentDate, '.csv', sep=''), row.names=F)

#BSS#
BSS_SummaryScores<-grumpy[,c('bblid'), drop=FALSE]
bss<-grumpy[,c(grep('bss_[0-9]', colnames(grumpy)))]
BSS_SummaryScores$bss_mean<-rowMeans(bss)
bss$NAflag<-ifelse(complete.cases(bss),0,1) 
bss_exp<-bss[,c('bss_1','bss_5')]
bss_experience<-rowMeans(bss_exp)
BSS_SummaryScores$bss_experience<-bss_experience
bss_bore<-bss[,c('bss_2','bss_6')]
bss_boredom<-rowMeans(bss_bore)
BSS_SummaryScores$bss_boredom<-bss_boredom
bss_thrl<-bss[,c('bss_3','bss_7')]
bss_thrill<-rowMeans(bss_thrl)
BSS_SummaryScores$bss_thrill<-bss_thrill
bss_disinhib<-bss[,c('bss_4','bss_8')]
bss_disinhibition<-rowMeans(bss_disinhib)
BSS_SummaryScores$bss_disinhibition<-bss_disinhibition
BSS_SummaryScores$bss_naflag<-bss[,c('NAflag')]
write.csv(BSS_SummaryScores, paste('/data/joy/BBL/studies/grmpy/n118DataFreeze/summaryScores/n118grmpyBSSSummaryScores_', currentDate, '.csv', sep=''), row.names=F)

#RPASshort#
RPASSHORT_SummaryScores<-grumpy[,c('bblid'), drop=FALSE]
rpasshort<-grumpy[,c(grep('phys_anhed_[0-9]', colnames(grumpy)))]
rpasshort1<-rpasshort[,c('phys_anhed_5','phys_anhed_6','phys_anhed_8','phys_anhed_10')]
rpasshort2<-rpasshort[,c('phys_anhed_1','phys_anhed_2','phys_anhed_3','phys_anhed_4','phys_anhed_7','phys_anhed_9', "phys_anhed_11", "phys_anhed_12", "phys_anhed_13", "phys_anhed_14", "phys_anhed_15")]
rpasshort2<-(1-rpasshort2) 
rpasshort3<-cbind(rpasshort1,rpasshort2)
rpasshort3$NAflag<-ifelse(complete.cases(rpasshort3),0,1) 
RPASSHORT_SummaryScores$rpasshort_total<-rowSums(rpasshort3[,c(1:15)])
RPASSHORT_SummaryScores$rpasshort_naflag<-rpasshort3[,c('NAflag')]
write.csv(RPASSHORT_SummaryScores, paste('/data/joy/BBL/studies/grmpy/n118DataFreeze/summaryScores/n118grmpyRPASshortSummaryScores_', currentDate, '.csv', sep=''), row.names=F)

#RSASshort#
RSASSHORT_SummaryScores<-grumpy[,c('bblid'), drop=FALSE]
rsasshort<-grumpy[,c(grep('soc_anhed_[0-9]', colnames(grumpy)))]
rsasshort1<-rsasshort[,c('soc_anhed_1','soc_anhed_2','soc_anhed_3','soc_anhed_5','soc_anhed_6','soc_anhed_7','soc_anhed_8','soc_anhed_10','soc_anhed_15')]
rsasshort2<-rsasshort[,c('soc_anhed_4','soc_anhed_9','soc_anhed_11','soc_anhed_12','soc_anhed_13','soc_anhed_14')]
rsasshort2<-(1-rsasshort2) 
rsasshort3<-cbind(rsasshort1,rsasshort2)
rsasshort3$NAflag<-ifelse(complete.cases(rsasshort3),0,1) 
RSASSHORT_SummaryScores$rsasshort_total<-rowSums(rsasshort3[,c(1:15)])
RSASSHORT_SummaryScores$rsasshort_naflag<-rsasshort3[,c('NAflag')]
write.csv(RSASSHORT_SummaryScores, paste('/data/joy/BBL/studies/grmpy/n118DataFreeze/summaryScores/n118grmpyRSASshortSummaryScores_', currentDate, '.csv', sep=''), row.names=F)

###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################

#####################################################################
##### Reads in Demographic Information for Subjects of Interest #####
#####################################################################

demo<-read.csv("/home/rjirsaraie/GRMPYDataEntryInterv_DATA_2018-05-10_1920.csv")
demo[demo ==-9999] <- NA 
subs<-read.csv("/data/joy/BBL/projects/grmpyProcessing2017/structural/struct_pipeline/n118_Cohort_20170911.csv", header=FALSE)
demo<-demo[ which(demo$bblid %in% subs$V1) , ]
demo <- demo[c(1:2,7,8,10,13,25,26,27,28,29,36)]
write.csv(demo, paste('/data/joy/BBL/studies/grmpy/n118DataFreeze/summaryScores/n118Demographics_', currentDate, '.csv', sep=''), row.names=F)

###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################

####################################
##### Makes Master Spreadsheet #####
####################################

master <- merge(demo, ALS_SummaryScores, by=c('bblid'))
master <- merge(master, ARI_SummaryScores, by=c('bblid'))
master <- merge(master, BDI_SummaryScores, by=c('bblid'))
master <- merge(master, BISBAS_SummaryScores, by=c('bblid'))
master <- merge(master, BSS_SummaryScores, by=c('bblid'))
master <- merge(master, GRIT_SummaryScores, by=c('bblid'))
master <- merge(master, HCL_SummaryScores, by=c('bblid'))
master <- merge(master, MAPSR_SummaryScores, by=c('bblid'))
master <- merge(master, RPAQ_SummaryScores, by=c('bblid'))
master <- merge(master, RPASSHORT_SummaryScores, by=c('bblid'))
master <- merge(master, RSASSHORT_SummaryScores, by=c('bblid'))
master <- merge(master, SCARED_SummaryScores, by=c('bblid'))
master <- merge(master, STAITRAIT_SummaryScores, by=c('bblid'))
master <- merge(master, STAXI2CA_SummaryScores, by=c('bblid'))
master <- merge(master, SWAN_SummaryScores, by=c('bblid'))
master <- merge(master, ACES_SummaryScores, by=c('bblid'))

###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################



