# GRMPY Self-Report Scoring Code V4
# The csv for this scoring code is downloaded from the "State/Trait Scales #collection" project.
# Caluclates summary scores for the State and Trait Self-Report scales. 

#### STATE-TRAIT SCALES ####

# Get the inputs:
# 1. Path to raw data csv 
# 2. Path to output 

paths = commandArgs(trailingOnly = TRUE)
inputPath <- paths[1]
outputPath <- paths[2]


## Feed in the input data
grumpy<-read.csv(inputPath)

grumpy<-grumpy[ which(grumpy$bbl_protocol %in% "GRMPY") , ] #removes subjects not listed as GRMPY protcol
grumpy<-grumpy[ which(grumpy$statetrait_vcode %in% "V" | grumpy$statetrait_vcode %in% "U" | grumpy$statetrait_vcode %in% "F") , ] #removes data not listed as "U" unproctored valid or "V" valid data or "F" for flagged
grumpy <- grumpy[ which(grumpy$admin_proband %in% "p"),] 
grumpy[grumpy ==-9999] <- NA #replaces -9999 with NAs
grumpy<-grumpy[order(grumpy$bblid),]

#ALS-18#
ALS_SummaryScores<-grumpy[,c('bblid'), drop=FALSE]
als<-grumpy[,c(grep('als_[0-9]', names(grumpy), value=T))]
als<-als[,c(1:18)]
ALS_SummaryScores$als_score_avg<-rowMeans(als)

#MAP-SR#
MAPSR_SummaryScores<-grumpy[,c('bblid'), drop=FALSE]
mapsr<-grumpy[,c(grep('mapssr_[0-9]', names(grumpy), value=T))]
MAPSR_SummaryScores$mapsr_rawtot_sum<-rowSums(mapsr)
MAPSR_SummaryScores$mapsr_social_sum<-rowSums(mapsr[,c("mapssr_1","mapssr_2","mapssr_3")])
MAPSR_SummaryScores$mapsr_recvoc_sum<-rowSums(mapsr[,c("mapssr_4","mapssr_5","mapssr_6")])
MAPSR_SummaryScores$mapsr_motrelation_sum<-rowSums(mapsr[,c("mapssr_7","mapssr_8","mapssr_9")])
MAPSR_SummaryScores$mapsr_engage_sum<-rowSums(mapsr[,c("mapssr_10","mapssr_11","mapssr_12", "mapssr_13", "mapssr_14", "mapssr_15")])

#SWAN-child#
SWAN_SummaryScores<-grumpy[,c('bblid'), drop=FALSE]
swan<-grumpy[,c(grep('swan_[0-9]', names(grumpy), value=T))]
swan<-swan[,c(1:18)]
swan$swan_total1<-rowSums(swan[,c('swan_1','swan_2','swan_3','swan_4','swan_5','swan_6','swan_7','swan_8','swan_9')])
swan$swan_total2<-rowSums(swan[,c('swan_10','swan_11','swan_12','swan_13','swan_14','swan_15','swan_16','swan_17','swan_18')])
SWAN_SummaryScores$eswanADHD_score_combined<-ifelse((swan$swan_total1 >= 6 & swan$swan_total2 >=6), 1,0)
SWAN_SummaryScores$eswanADHD_score_inattentive<-ifelse((swan$swan_total1 >= 6 & swan$swan_total2 <6), 1,0)
SWAN_SummaryScores$eswanADHD_score_hyperactive<-ifelse((swan$swan_total1 < 6 & swan$swan_total2 >=6), 1,0)
SWAN_SummaryScores$eswanADHD_score_noADHD<-ifelse((swan$swan_total1 < 6 & swan$swan_total2 < 6), 1,0)

#SWAN-collateral#
SWANcoll_SummaryScores<-grumpy[,c('bblid'), drop=FALSE]
swancoll<-grumpy[,c(grep('swan_(.*)_c$', names(grumpy), value=T))]
swancoll<-swancoll[,c(1:18)]
swancoll$swan_total1<-rowSums(swancoll[,c('swan_1_c','swan_2_c','swan_3_c','swan_4_c','swan_5_c','swan_6_c','swan_7_c','swan_8_c','swan_9_c')])
swancoll$swan_total2<-rowSums(swancoll[,c('swan_10_c','swan_11_c','swan_12_c','swan_13_c','swan_14_c','swan_15_c','swan_16_c','swan_17_c','swan_18_c')])
SWANcoll_SummaryScores$eswanADHD_score_combined_c <-ifelse((swancoll$swan_total1 >= 6 & swancoll$swan_total2 >=6), 1,0)
SWANcoll_SummaryScores$eswanADHD_score_inattentive_c <-ifelse((swancoll$swan_total1 >= 6 & swancoll$swan_total2 <6), 1,0)
SWANcoll_SummaryScores$eswanADHD_score_hyperactive_c <-ifelse((swancoll$swan_total1 < 6 & swancoll$swan_total2 >=6), 1,0)
SWANcoll_SummaryScores$eswanADHD_score_noADHD_c <-ifelse((swancoll$swan_total1 < 6 & swancoll$swan_total2 < 6), 1,0)

#ACES#
ACES_SummaryScores<-grumpy[,c('bblid'), drop=FALSE]
aces<-grumpy[,c(grep('aces_[0-9]', names(grumpy), value=T))]
ACES_SummaryScores$aces_score_total<-rowSums(aces[,c('aces_1','aces_2','aces_3','aces_4','aces_5','aces_6','aces_7','aces_8','aces_9','aces_10')])

#SCARED#
SCARED_SummaryScores<-grumpy[,c('bblid'), drop=FALSE]
scared<-grumpy[,c(grep('scared_[0-9]', names(grumpy), value=T))]
scared<-scared[,c('scared_1','scared_2','scared_3','scared_4','scared_5','scared_6','scared_7','scared_8','scared_9',
                  'scared_10','scared_11','scared_12','scared_13','scared_14','scared_15','scared_16','scared_17','scared_18',
                  'scared_19','scared_20','scared_21','scared_22','scared_23','scared_24','scared_25','scared_26','scared_27',
                  'scared_28','scared_29','scared_30','scared_31','scared_32','scared_33','scared_34','scared_35','scared_36',
                  'scared_37','scared_38','scared_39','scared_40','scared_41')]
SCARED_SummaryScores$scared_score_total<-rowSums(scared)
SCARED_SummaryScores$scared_score_anxietyDisorder<-ifelse(SCARED_SummaryScores$scared_score_total >=25, 1,0)

#SCARED-collateral#
SCAREDcoll_SummaryScores<-grumpy[,c('bblid'), drop=FALSE]
scaredcoll<-grumpy[,c(grep('scared_(.*)_c$', names(grumpy), value=T))]
scaredcoll<-scaredcoll[,c('scared_1_c','scared_2_c','scared_3_c','scared_4_c','scared_5_c','scared_6_c','scared_7_c','scared_8_c','scared_9_c',
                          'scared_10_c','scared_11_c','scared_12_c','scared_13_c','scared_14_c','scared_15_c','scared_16_c','scared_17_c','scared_18_c',
                          'scared_19_c','scared_20_c','scared_21_c','scared_22_c','scared_23_c','scared_24_c','scared_25_c','scared_26_c','scared_27_c',
                          'scared_28_c','scared_29_c','scared_30_c','scared_31_c','scared_32_c','scared_33_c','scared_34_c','scared_35_c','scared_36_c',
                          'scared_37_c','scared_38_c','scared_39_c','scared_40_c','scared_41_c')]
SCAREDcoll_SummaryScores$scaredcoll_total<-rowSums(scaredcoll)
SCAREDcoll_SummaryScores$AnxietyDisorder<-ifelse(SCAREDcoll_SummaryScores$scaredcoll_total >=25, 1,0)

#RPAQ#
RPAQ_SummaryScores<-grumpy[,c('bblid'), drop=FALSE]
rpaq<-grumpy[,c(grep('rpaq_[0-9]', names(grumpy), value=T))]
RPAQ_SummaryScores$rpaq_score_proactiveTotal<-rowSums(rpaq[,c('rpaq_2','rpaq_4','rpaq_6','rpaq_9','rpaq_10','rpaq_12','rpaq_15','rpaq_17','rpaq_18', 'rpaq_20','rpaq_21','rpaq_23')])
RPAQ_SummaryScores$rpaq_score_reactiveTotal<-rowSums(rpaq[,c('rpaq_1','rpaq_3','rpaq_5','rpaq_7','rpaq_8','rpaq_11','rpaq_13','rpaq_14','rpaq_16','rpaq_19','rpaq_22')])

#ARI#
grumpyPro <- grumpy[which(grumpy$admin_proband=="p"),] #remove collaterals
ARI_SummaryScores <- grumpyPro[,c('bblid'), drop=FALSE]
ari<-grumpyPro[,c(grep('ari_[0-9]', colnames(grumpyPro)))]
ari<-ari[,c('ari_1','ari_2','ari_3','ari_4','ari_5','ari_6')]
ARI_SummaryScores$ari_score_avg<-rowMeans(ari)
ARI_SummaryScores$ari_score_total<-rowSums(ari)

#ARI-collateral#
grumpyColl <- grumpy[which(grumpy$admin_proband=="c"),] #remove probands
ARIcoll_SummaryScores<-grumpyColl[,c('bblid'), drop=FALSE]
aricoll<-grumpyColl[,c(grep('ari_(.*)_c$', colnames(grumpyColl)))]
aricoll<-aricoll[,c('ari_1_c','ari_2_c','ari_3_c','ari_4_c','ari_5_c','ari_6_c')]
ARIcoll_SummaryScores$ariColl_total<-rowSums(aricoll)
ARIcoll_SummaryScores$ariColl_avg<-rowMeans(aricoll)

#BDI#
BDI_SummaryScores<-grumpy[,c('bblid'), drop=FALSE]
bdi<-grumpy[,c(grep('bdi_[0-9]', colnames(grumpy)))]
bdi<-bdi[, !colnames(bdi) %in% c('bdi_19a')] #removes question 19a from BDI scoring
BDI_SummaryScores$bdi_score_total<-rowSums(bdi)

#BISBAS#
BISBAS_SummaryScores<-grumpy[,c('bblid'), drop=FALSE]
bisbas<-grumpy[,c(grep('bisbas_[0-9]', colnames(grumpy)))]
bis1<-bisbas[,c('bisbas_8','bisbas_13','bisbas_16','bisbas_19','bisbas_24')]
bis2<-bisbas[,c('bisbas_2','bisbas_22')]
bis1<-(4-bis1)+1 #reverse code scores in bis1 (not bis2) so that 4=1, 3=2, 2=3, 1=4
bis3<-cbind(bis1,bis2)
BISBAS_SummaryScores$bis_score_total<-rowSums(bis3) #sum scores after reverse coding
bas_drive<-bisbas[,c('bisbas_3','bisbas_9','bisbas_12','bisbas_21')]
bas_drive<-(4-bas_drive)+1 #reverse code scores in bas_drive
BISBAS_SummaryScores$bas_score_driveTotal<-rowSums(bas_drive) 
bas_fun<-bisbas[,c('bisbas_5','bisbas_10','bisbas_15','bisbas_20')]
bas_fun<-(4-bas_fun)+1 #reverse code scores in bas_fun
bas_fun_sum<-(bas_fun)
BISBAS_SummaryScores$bas_score_funTotal<-rowSums(bas_fun_sum)
bas_reward<-bisbas[,c('bisbas_4','bisbas_7','bisbas_14','bisbas_18','bisbas_23')]
bas_reward<-(4-bas_reward)+1 #reverse code scores in bas_reward
BISBAS_SummaryScores$bas_score_rewardTotal<-rowSums(bas_reward)

#GRIT#
GRIT_SummaryScores<-grumpy[,c('bblid'), drop=FALSE]
grit<-grumpy[,c(grep('grit_[0-9]', colnames(grumpy)))]
grittiness<-grit[,c('grit_2','grit_4','grit_5','grit_7','grit_8','grit_10')]
openness<-grit[,c('grit_1','grit_3','grit_6','grit_9','grit_11','grit_12')]
GRIT_SummaryScores$grit_score_grittiness<-rowMeans(grittiness)
GRIT_SummaryScores$grit_score_openness<-rowMeans(openness)

#HCL#
HCL_SummaryScores<-grumpy[,c('bblid'), drop=FALSE]
hcl<-grumpy[,c(grep('hcl16_3_[0-9]', names(grumpy), value=T))]
HCL_SummaryScores$hcl_score_total<-rowSums(hcl)

#BSS#
BSS_SummaryScores<-grumpy[,c('bblid'), drop=FALSE]
bss<-grumpy[,c(grep('bss_[0-9]', colnames(grumpy)))]
BSS_SummaryScores$bss_score_mean<-rowMeans(bss)
bss_exp<-bss[,c('bss_1','bss_5')]
bss_score_experience<-rowMeans(bss_exp)
BSS_SummaryScores$bss_score_experience<-bss_score_experience
bss_bore<-bss[,c('bss_2','bss_6')]
bss_score_boredom<-rowMeans(bss_bore)
BSS_SummaryScores$bss_score_boredom<-bss_score_boredom
bss_thrl<-bss[,c('bss_3','bss_7')]
bss_score_thrill<-rowMeans(bss_thrl)
BSS_SummaryScores$bss_score_thrill<-bss_score_thrill
bss_disinhib<-bss[,c('bss_4','bss_8')]
bss_score_disinhibition<-rowMeans(bss_disinhib)
BSS_SummaryScores$bss_score_disinhibition<-bss_score_disinhibition

#RPASshort#
RPASSHORT_SummaryScores<-grumpy[,c('bblid'), drop=FALSE]
rpasshort<-grumpy[,c(grep('phys_anhed_[0-9]', colnames(grumpy)))]
rpasshort1<-rpasshort[,c('phys_anhed_5','phys_anhed_6','phys_anhed_8','phys_anhed_10')]
rpasshort2<-rpasshort[,c('phys_anhed_1','phys_anhed_2','phys_anhed_3','phys_anhed_4','phys_anhed_7','phys_anhed_9', "phys_anhed_11", "phys_anhed_12", "phys_anhed_13", "phys_anhed_14", "phys_anhed_15")]
rpasshort2<-(1-rpasshort2) #reverse code items in rpasshort2
rpasshort3<-cbind(rpasshort1,rpasshort2)
RPASSHORT_SummaryScores$rpasShort_score_total<-rowSums(rpasshort3[,c(1:15)])

#RSASshort#
RSASSHORT_SummaryScores<-grumpy[,c('bblid'), drop=FALSE]
rsasshort<-grumpy[,c(grep('soc_anhed_[0-9]', colnames(grumpy)))]
rsasshort1<-rsasshort[,c('soc_anhed_1','soc_anhed_2','soc_anhed_3','soc_anhed_5','soc_anhed_6','soc_anhed_7','soc_anhed_8','soc_anhed_10','soc_anhed_15')]
rsasshort2<-rsasshort[,c('soc_anhed_4','soc_anhed_9','soc_anhed_11','soc_anhed_12','soc_anhed_13','soc_anhed_14')]
rsasshort2<-(1-rsasshort2) #reverse code items in rsasshort2
rsasshort3<-cbind(rsasshort1,rsasshort2)
RSASSHORT_SummaryScores$rsasShort_score_total<-rowSums(rsasshort3[,c(1:15)])

#ESWAN-DMDD-proband#
ESWAN_DMDD_SummaryScores<-grumpy[,c('bblid'), drop=FALSE]
eswan<-grumpy[,c(grep('eswan_dmdd_[0-9]', names(grumpy), value=T))]
ESWAN_DMDD_SummaryScores$eswanDMDD_score_homeOutburst<-rowSums(eswan[,c('eswan_dmdd_01a','eswan_dmdd_02a','eswan_dmdd_03a','eswan_dmdd_04a','eswan_dmdd_05a','eswan_dmdd_06a','eswan_dmdd_07a','eswan_dmdd_08a','eswan_dmdd_09a','eswan_dmdd_10a')])
ESWAN_DMDD_SummaryScores$eswanDMDD_score_friendOutburst<-rowSums(eswan[,c('eswan_dmdd_01b','eswan_dmdd_02b','eswan_dmdd_03b','eswan_dmdd_04b','eswan_dmdd_05b','eswan_dmdd_06b','eswan_dmdd_07b','eswan_dmdd_08b','eswan_dmdd_09b','eswan_dmdd_10b')])
ESWAN_DMDD_SummaryScores$eswanDMDD_score_schoolOutburst<-rowSums(eswan[,c('eswan_dmdd_01c','eswan_dmdd_02c','eswan_dmdd_03c','eswan_dmdd_04c','eswan_dmdd_05c','eswan_dmdd_06c','eswan_dmdd_07c','eswan_dmdd_08c','eswan_dmdd_09c','eswan_dmdd_10c')])
ESWAN_DMDD_SummaryScores$eswanDMDD_score_total <- rowSums(ESWAN_DMDD_SummaryScores[, c("eswanDMDD_score_homeOutburst","eswanDMDD_score_friendOutburst", "eswanDMDD_score_schoolOutburst")])

## PSQI Summary Scores ##
PSQI_SummaryScores <- grumpy[,c('bblid'), drop = FALSE]
psqi <- grumpy[,c('bblid'), drop = FALSE]
# Component 1:Subjective sleep quality #
PSQI_SummaryScores$psqi_score_component1 <- grumpy$psqi_6
# Component 2: Sleep latency #
surveys <- length(grumpy$bblid)
for (i in 1:surveys){
if (is.na(grumpy$psqi_2[i])){
  psqi$component2_1[i] = NA
} else if (!is.na(grumpy$psqi_2[i]) && grumpy$psqi_2[i] <= 15) {
  psqi$component2_1[i] = 0
} else if (!is.na(grumpy$psqi_2[i]) && grumpy$psqi_2[i] >= 16 && grumpy$psqi_2[i] <= 30) {
    psqi$component2_1[i] = 1
  } else if (!is.na(grumpy$psqi_2[i]) && grumpy$psqi_2[i] >= 31 && grumpy$psqi_2[i] <= 60) {
    psqi$component2_1[i] = 2
  } else if (!is.na(grumpy$psqi_2[i]) && grumpy$psqi_2[i] > 60){
  psqi$component2_1[i] = 3
}}

psqi$component2_2 <- grumpy$psqi_5a

# add part 1 and 2 of component 2
psqi$component2_3 = psqi$component2_1 + psqi$component2_2

# create component score
PSQI_SummaryScores$psqi_score_component2 = NA
for (i in 1:surveys){
if (!is.na(psqi$component2_3[i]) && psqi$component2_3[i] == 0){
  PSQI_SummaryScores$psqi_score_component2[i] = 0
} else if (!is.na(psqi$component2_3[i]) && (psqi$component2_3[i] == 1 || psqi$component2_3[i] == 2)){
  PSQI_SummaryScores$psqi_score_component2[i] = 1
} else if (!is.na(psqi$component2_3[i]) && (psqi$component2_3[i] == 3 || psqi$component2_3[i] == 4)){
  PSQI_SummaryScores$psqi_score_component2[i] = 2
} else if (!is.na(psqi$component2_3[i]) && (psqi$component2_3[i] == 5 || psqi$component2_3[i] == 6)){
  PSQI_SummaryScores$psqi_score_component2[i] = 3
}}

# Component 3: Sleep duration #
PSQI_SummaryScores$psqi_score_component3 = NA
for (i in 1:surveys){
if (!is.na(grumpy$psqi_4[i]) && grumpy$psqi_4[i] > 7){
  PSQI_SummaryScores$psqi_score_component3[i] = 0
} else if (!is.na(grumpy$psqi_4[i]) && (grumpy$psqi_4[i] >= 6 && grumpy$psqi_4[i] <= 7)) {
  PSQI_SummaryScores$psqi_score_component3[i] = 1
} else if (!is.na(grumpy$psqi_4[i]) && (grumpy$psqi_4[i] >= 4 && grumpy$psqi_4[i] <= 5)) {
  PSQI_SummaryScores$psqi_score_component3[i] = 2
} else if (!is.na(grumpy$psqi_4[i]) && (grumpy$psqi_4[i] < 5)) {
  PSQI_SummaryScores$psqi_score_component3[i] = 3
}}

# Component 4: Habitual sleep efficiency #
psqi$component4_1 = grumpy$psqi_4 # number of hours slept

# Manipulate Questions 1 and 3 into POSIXlt format - v2 
psqi$plainTimes_1 <- as.POSIXlt(format(strptime(substr(as.POSIXct(sprintf("%04.0f",grumpy$psqi_1 ), 
                                                       format="%H%M"), 12, 16), '%H:%M'), '%I:%M %p'),format = '%H:%M')
psqi$plainTimes_3 <- as.POSIXlt(format(strptime(substr(as.POSIXct(sprintf("%04.0f",grumpy$psqi_3 ), 
                                                       format="%H%M"), 12, 16), '%H:%M'), '%I:%M %p'),format = "%H:%M")


for (i in 1:surveys){
  if ((!is.na(psqi$plainTimes_1[i])) && (!is.na(psqi$plainTimes_3[i])) && (psqi$plainTimes_1[i] < psqi$plainTimes_3[i])){
    psqi$component4_2[i] = as.double(psqi$plainTimes_3[i] -  psqi$plainTimes_1[i]) #number of hours spent in bed
  }
  else if ((!is.na(psqi$plainTimes_1[i])) && (!is.na(psqi$plainTimes_3[i])) && (psqi$plainTimes_1[i] > psqi$plainTimes_3[i])){
    psqi$component4_2[i] = as.double((as.POSIXlt("12:00", format = "%H:%M") -  psqi$plainTimes_1[i])) + (as.double(psqi$plainTimes_3[i] - as.POSIXlt("00:00", format = "%H:%M"))) #number of hours spent in bed
  } 
  else {
    psqi$component4_2[i] = NA
  }
}
psqi$component4_3 = abs(psqi$component4_1 / psqi$component4_2) * 100 # Habitual sleep efficiency
PSQI_SummaryScores$psqi_score_component4 = NA
for (i in 1:surveys){
if (!is.na(psqi$component4_3[i]) && (psqi$component4_3[i] > 85.0)) {
  PSQI_SummaryScores$psqi_score_component4[i] = 0      
} else if (!is.na(psqi$component4_3[i]) && (psqi$component4_3[i] <= 84.0 && psqi$component4_3[i] >= 75.0)) {
  PSQI_SummaryScores$psqi_score_component4[i] = 1
} else if (!is.na(psqi$component4_3[i]) && (psqi$component4_3[i] <= 74.0 && psqi$component4_3[i] >= 65.0)) {
  PSQI_SummaryScores$psqi_score_component4[i] = 2
} else if (!is.na(psqi$component4_3[i]) && (psqi$component4_3[i] < 65.0)) {
  PSQI_SummaryScores$psqi_score_component4[i] = 3
}}

# Component 5: Sleep disturbances #
# add questions 5b-j
psqi$component5_2 = (grumpy$psqi_5b + grumpy$psqi_5c + grumpy$psqi_5d + grumpy$psqi_5e + grumpy$psqi_5f + grumpy$psqi_5g + grumpy$psqi_5h + grumpy$psqi_5i + grumpy$psqi_5othera )

# create component score
PSQI_SummaryScores$psqi_score_component5 = NA
for (i in 1:surveys) {
if (!is.na(psqi$component5_2[i]) && psqi$component5_2[i] == 0) {
  PSQI_SummaryScores$psqi_score_component5[i] = 0
} else if (!is.na(psqi$component5_2[i]) && psqi$component5_2[i] >= 1 && psqi$component5_2[i] <= 9) {
  PSQI_SummaryScores$psqi_score_component5[i] = 1
} else if (!is.na(psqi$component5_2[i]) && psqi$component5_2[i] >=10 && psqi$component5_2[i] <=18) {
  PSQI_SummaryScores$psqi_score_component5[i] = 2
} else if (!is.na(psqi$component5_2[i]) && psqi$component5_2[i] >= 19 && psqi$component5_2[i] <= 27) {
  PSQI_SummaryScores$psqi_score_component5[i] = 3
}}

# Component 6: Use of sleeping medication #
PSQI_SummaryScores$psqi_score_component6 = grumpy$psqi_7

# Component 7: Daytime dysfunction #
psqi$component7_3 = grumpy$psqi_8 + grumpy$psqi_9
PSQI_SummaryScores$psqi_score_component7 = NA
for (i in 1:surveys) {
  if (!is.na(psqi$component7_3[i]) && psqi$component7_3[i] == 0) {
    PSQI_SummaryScores$psqi_score_component7[i] = 0
  } else if (!is.na(psqi$component7_3[i]) && psqi$component7_3[i] >= 1 && psqi$component7_3[i] <= 2) {
    PSQI_SummaryScores$psqi_score_component7[i] = 1
  } else if (!is.na(psqi$component7_3[i]) && psqi$component7_3[i] >=3 && psqi$component7_3[i] <=4) {
    PSQI_SummaryScores$psqi_score_component7[i] = 2
  } else if (!is.na(psqi$component7_3[i]) && psqi$component7_3[i] >= 5 && psqi$component7_3[i] <= 6) {
    PSQI_SummaryScores$psqi_score_component7[i] = 3
  }}

## Global PSQI Score ##
PSQI_SummaryScores$psqi_score_global = (PSQI_SummaryScores$psqi_score_component1 + PSQI_SummaryScores$psqi_score_component2 + PSQI_SummaryScores$psqi_score_component3 + PSQI_SummaryScores$psqi_score_component4 + PSQI_SummaryScores$psqi_score_component5 + PSQI_SummaryScores$psqi_score_component6 + PSQI_SummaryScores$psqi_score_component7)

## BEST ##
bestSummaryScores <- grumpy[,c('bblid'), drop = FALSE]
bestSummaryScores$best_score_subscaleA = (grumpy$best_ms_1 + grumpy$best_ms_2 + grumpy$best_ms_3 + grumpy$best_ms_4 + grumpy$best_ms_5 + grumpy$best_ms_6 + grumpy$best_ms_7 + grumpy$best_ms_8)
bestSummaryScores$best_score_subscaleB = (grumpy$best_ms_9 + grumpy$best_ms_10 + grumpy$best_ms_11 + grumpy$best_ms_12)
bestSummaryScores$best_score_finalNoComponentC = (bestSummaryScores$best_score_subscaleA + bestSummaryScores$best_score_subscaleB)
# *Note that subscale C: Positive Behaviors is not administered and therefore the correction factor of 15 is not included here.

# Merge all summary scores and put into a csv #
SR <- Reduce(function(x,y)  merge(x, y, by = 'bblid', all.x=TRUE,all.y=TRUE), list(ALS_SummaryScores,SWAN_SummaryScores,ACES_SummaryScores, SCARED_SummaryScores, RPAQ_SummaryScores, ARI_SummaryScores, BDI_SummaryScores, BISBAS_SummaryScores,GRIT_SummaryScores, HCL_SummaryScores, BSS_SummaryScores, RPASSHORT_SummaryScores, RSASSHORT_SummaryScores, ESWAN_DMDD_SummaryScores, PSQI_SummaryScores, bestSummaryScores))
write.csv(SR, outputPath, row.names=FALSE)

