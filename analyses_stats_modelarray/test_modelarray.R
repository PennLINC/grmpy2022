# if Rmd: search to see how to set up args and command to call .Rmd!

# rm(list=ls())

list.of.packages <- c("devtools")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

library(devtools)
# install ModelArray:
branch_name_modelarray <- "enh/subj_specific_masks"    # +++++++++++++++ TODO: change this after merging the branch into main!!!
devtools::install_github("PennLINC/ModelArray", ref = branch_name_modelarray,
                         upgrade = "never",  # not to upgrade package dependencies
                         force = TRUE)     # force to install or not
library(ModelArray)

### inputs #####
args = commandArgs(trailingOnly=TRUE)

num.voxels <- as.integer(args[1])  # if ==0, set as full set
nsubj <- as.integer(args[2])   # number of subjects, e.g. 215
num.cores <- as.integer(args[3])   # number of CPUs to use
folder.main <- as.character(args[4]) # "/cbica/projects/GRMPY/project/curation/testing/stats_ModelArray"
filename_output_body <- as.character(args[5])  # output filename (without extension), e.g. paste0("GRMPY_meanCBF_n",toString(nsubj))

message(paste0("number of voxels to analyze = ", toString(num.voxels)))
message(paste0("number of subjects = ", toString(nsubj)))
message(paste0("number of cores = ", toString(num.cores)))
message(paste0("main folder = ", folder.main))
message(paste0("output .h5 filename = ", filename_output_body, ".h5"))

# +++++++++++++++++++ CHANGE THESE INPUTS IF NEEDED: ++++++++++++++++++++++++++++++++++
#formula <- CBF ~ age + sex
formula <- CBF ~ s(age) + sex
full.outputs <- TRUE
#analysis_name <- "lm_fullOutputs"    # the name for the statistical results dataframe to be saved into .h5 file
analysis_name <- "gam_fullOutputs"
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


fn.h5.orig <- file.path(folder.main, 
                        paste0("GRMPY_meanCBF_n",toString(nsubj),"_indmask_orig.h5"))
# fn.h5.output <- file.path(folder.main, 
#                         paste0("GRMPY_meanCBF_n",toString(nsubj),".h5"))
fn.h5.output <- file.path(folder.main,
                          paste0(filename_output_body,".h5"))
fn.csv <- file.path(folder.main,
                    paste0("GRMPY_convoxel_meanCBF_n",toString(nsubj),"_indmask.csv"))

# sanity check:
if (file.exists(fn.h5.orig) == FALSE) {
  stop(paste0("input .h5 file does not exist: "), fn.h5.orig)
}
if (file.exists(fn.csv) == FALSE) {
  stop(paste0("input .csv file does not exist: "), fn.csv)
}

# generate fn.output:
if (fn.h5.orig != fn.h5.output) {
  file.copy(from=fn.h5.orig, to=fn.h5.output, overwrite = TRUE, copy.mode = TRUE, copy.date = TRUE)   # , recursive = TRUE
}



### set up for ModelArray #####
phenotypes <- read.csv(fn.csv)
#head(phenotypes)

message("formula:")
formula

modelarray <- ModelArray(fn.h5.output, scalar_types = c("CBF"))


# list of voxels to run:
if (num.voxels == 0) {  # requesting all
  element.subset <- NULL
  num.voxels <- numElementsTotal(modelarray = modelarray, scalar_name="CBF")  # total number of voxels
} else {
  element.subset <- 1:num.voxels
}


### run ModelArray ######
# mylm <- ModelArray.lm(formula, data = modelarray, phenotypes = phenotypes, scalar = "CBF",
#                       element.subset = element.subset, full.outputs = full.outputs,
#                       correct.p.value.terms = "fdr",
#                       correct.p.value.model = "fdr",
#                       pbar = TRUE, n_cores = num.cores)
# message("statistical results:")
# head(mylm)

mygam <- ModelArray.gam(formula, data = modelarray, phenotypes = phenotypes, scalar="CBF",
                        element.subset = element.subset, full.outputs = full.outputs,
                        pbar = TRUE, n_cores = num.cores)
message("statistical results:")
head(mygam)

### save results #####
#writeResults(fn.h5.output, mylm, analysis_name = analysis_name, overwrite = TRUE)
writeResults(fn.h5.output, mygam, analysis_name = analysis_name, overwrite = TRUE)

# if you want to view the saved results in .h5:
rhdf5::h5ls(fn.h5.output)

modelarray_new <- ModelArray(fn.h5.output, scalar_types = c("CBF"), analysis_names = analysis_name)
message("after saving to .h5:")
modelarray_new@results[[analysis_name]]
