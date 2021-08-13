#############################################################
#### This script calls the GRMPY data processing scripts ####
#### and combines the results into one csv.              ####
###########################################################

## Find the correct date to use (aka use the most recent file)
rawPsycha1 <- list.files("/data/jux/BBL/studies/grmpy/rawPsycha1/")
rawPsycha1_demo <- regmatches(rawPsycha1, regexpr("demographics.*[0-9]", rawPsycha1))
rawPsycha1_demo_dates <- regmatches(rawPsycha1_demo, regexpr("[0-9].*[0-9]", rawPsycha1_demo))
rawPsycha1_demo_dates <- as.numeric(rawPsycha1_demo_dates)
currentDate <- rawPsycha1_demo_dates[which.max(rawPsycha1_demo_dates)]

## Create the data-frame to add all summary scores to ##
psycha1_allDataSummaryScores <- read.csv(paste("/data/jux/BBL/studies/grmpy/rawPsycha1/demographics_", currentDate, ".csv", sep = ""))
psycha1_allDataSummaryScores <- data.frame("bblid" = psycha1_allDataSummaryScores$bblid, "famid" = psycha1_allDataSummaryScores$famid)
## psycha1_allDataSummaryScores <-psycha1_allDataSummaryScores[ which(psycha1_allDataSummaryScores$bbl_protocol %in% "GRMPY") , ] #removes subjects not listed as GRMPY protcol

source("/data/jux/BBL/projects/grmpyProcessing/grmpyProcessing2017Scripts/summaryScoring/selfreport_scales_redcap.R")
psycha1_allDataSummaryScores <- merge(selfReportScoring, psycha1_allDataSummaryScores, "bblid", all.x = TRUE, all.y = TRUE)

source("/data/jux/BBL/projects/grmpyProcessing/grmpyProcessing2017Scripts/summaryScoring/demographics.R")
psycha1_allDataSummaryScores <- merge(Demo, psycha1_allDataSummaryScores, "bblid", all.x = TRUE, all.y = TRUE)

source("/data/jux/BBL/projects/grmpyProcessing/grmpyProcessing2017Scripts/summaryScoring/tracker_redcap_manualpull.R")
psycha1_allDataSummaryScores <- merge(scored_tracker_redcap_manualpull, psycha1_allDataSummaryScores, "bblid", all.x = TRUE, all.y = TRUE)

## Create the final CSV ##
write.csv(psycha1_allDataSummaryScores, paste('/data/jux/BBL/studies/grmpy/processedPsycha1/scored_data_', currentDate, '.csv', sep = ''))