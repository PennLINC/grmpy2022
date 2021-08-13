################
### LOAD DATA ###
#################

#microbiome volume (18 CT NMF components applied to microbiome volume images)
data.microbiome <- read.csv("/data/jux/BBL/studies/grmpy/microbiome/output/NMF/NMFcomponents/cmpWeightedAverageNumBases_18.csv", header=FALSE)

#############################
### PREPARE Microbiome DATA ###
#############################

#Remove path to get scan ID only
data.microbiome[] <- lapply(data.microbiome, function(x) gsub("/data/jux/BBL/studies/grmpy/microbiome/output/NMF/ctmooth/", "", x))
data.microbiome[] <- lapply(data.microbiome, function(x) gsub("_CTsmoothed2mm.nii.gz", "", x))

#Rename variables
colnames(data.microbiome) <- c("bblid","Nmf18C1","Nmf18C2","Nmf18C3","Nmf18C4","Nmf18C5","Nmf18C6","Nmf18C7","Nmf18C8","Nmf18C9","Nmf18C10","Nmf18C11","Nmf18C12","Nmf18C13","Nmf18C14","Nmf18C15","Nmf18C16","Nmf18C17","Nmf18C18")

#Make Jacobian variables numeric
data.microbiome<- data.frame(lapply(data.microbiome, function(x) as.numeric(as.character(x))))

### load data from Sage with 

demo=read.csv('/data/jux/BBL/studies/grmpy/microbiome/demographics/microbiomedemographics.csv')
newdata=merge(demo,data.microbiome, by = "bblid")

write.csv(newdata, file = "/data/jux/BBL/studies/grmpy/microbiome/demographics/microbiome_18CT.csv") #save for use 

