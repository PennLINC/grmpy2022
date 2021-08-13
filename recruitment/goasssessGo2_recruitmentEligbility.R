#GO1 itemwise data downloaded from galton:
#/home/analysis/redcap_archive/PNC_GO1_PNCCSGOASSESSSCREENE_DATA_2015-07-14_1309.csv

#GO1 summary data from:
#/home/analysis/redcap_data/201507//n1601_go1_datarel_073015.csv

# GO2 data downloaded from galton: 
#/home/kruparel/REDCAP/GO2/n555_go2_diagnosis_5_28_14.csv

###SET PATHS FOR DATA###
dataDir<-"/Users/sattertt/Documents/Magic Briefcase/ACTIVE_PROTOCOLS/GRMPY_BRAINS/goassessCapaDataForRecruitment/"
go1ItemName<-"n14513_GOASSESS_Screener_nontext_corrected_for_scala_20131021_redcap_pid272_fixed_20131101.csv"
go1SumName<-"n1601_go1_datarel_073015.csv"
go2Name<-"n555_go2_diagnosis_5_28_14.csv"

###LOAD DATA###
setwd(dataDir)
go1Item<-read.csv(go1ItemName, na.strings = ".")
go1Sum<-read.csv(go1SumName)
go2<-read.csv(go2Name) #5 duplicate BBLIDs in this file. . . . 

###subset & rename item data###
go1Item$bblid<-go1Item$PROBAND_BBLID
go1Item$DEP004[which(go1Item$DEP004==9)]<-NA
go1Item$IED001[which(go1Item$IED001==9)]<-NA
go1Item$MAN007[which(go1Item$MAN007==9)]<-NA
go1Item$ODD001[which(go1Item$ODD001==9)]<-NA
go1Item$ODD006[which(go1Item$ODD006==9)]<-NA
go1ItemSubset<-go1Item[,c("bblid","INTERVIEW_TYPE","DEP004","IED001","MAN007","ODD001","ODD006")]

go1ItemSubset$irritSum<-rowSums(go1ItemSubset[,3:7],na.rm=TRUE)
go1ItemSubset$irritBin<-0
go1ItemSubset$irritBin[go1ItemSubset$irritSum>0]<-1

###create TD and PS cols in summary data and subset###
go1Sum$ps<-0
go1Sum$ps[go1Sum$goassessDxpmr4=="4PS"]<-1
go1Sum$td<-0
go1Sum$td[go1Sum$goassessDxpmr4!="4PS" & go1Sum$goassessSmryPsychOverallRtg<4 & go1Sum$ltnExclude==0]<-1
go1SumSubset<-go1Sum[,c("bblid","scanid","ageAtGo1Scan","healthExclude","sex","race","ps","td")]  #want demo varaibles, PS

#subset Go2 to releveant cols
go2Subset<-go2[,c("bblid","go2_dx")]

#combine Go1 data sources
go1Comb<-merge(go1ItemSubset,go1SumSubset,by="bblid",all=FALSE)  #note that have more rows than 1601 because of collateral interview


#subset Go1 Data to irrit, then collapse to unique subjects across interview type, then add go2
go1Irrit<-go1Comb[which(go1Comb$irritBin==1),c("bblid","scanid","ageAtGo1Scan","healthExclude","sex","race","ps","td","irritBin")]
go1Irrit<-go1Irrit[!duplicated(go1Irrit),]
go1Irrit<-go1Irrit[-which(go1Irrit$td==1),]  #remove squeaky-clean TDs from irritable group
go1Irrit<-go1Irrit[-which(go1Irrit$healthExclude==1),]
#822 of the 1601!; 367 of these are PS
go1Go2Irrit<-merge(go1Irrit,go2Subset,by="bblid",all.x=TRUE)   
#around an even mix of CR (111) and TD (107), note that there are 2 duplicates here from Go2

#now TDs-- must be TD at Go1, and NOT screen positive for any irritable items
go1Td<-go1Comb[which(go1Comb$td==1 & go1Comb$irritBin==0),c("bblid","scanid","ageAtGo1Scan","sex","race","ps","td","irritBin")]  
go1Td<-go1Td[!duplicated(go1Td),]  #336
go1Go2Td<-merge(go1Td,go2Subset,by="bblid",all.x=TRUE)  #109 are TD per GO2

write.csv(go1Go2Td,"grmpyTdElig_20150909.csv",row.names=FALSE,quote=FALSE)
write.csv(go1Go2Irrit,"grmpyIrritElig_20150909.csv",row.names=FALSE,quote=FALSE)




