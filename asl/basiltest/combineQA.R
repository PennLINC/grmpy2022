b1=read.csv('/data/jux/BBL/projects/grmpyProcessing/grmpyProcessing2017Scripts/asl/basiltest/grmpybasilquality.csv');b2=read.csv('/data/jux/BBL/projects/grmpyProcessing/grmpyProcessing2017Scripts/asl/basiltest/grmpycbfquality.csv')
b3=read.csv('/data/jux/BBL/projects/grmpyProcessing/grmpyProcessing2017Scripts/asl/basiltest/pnccbfquality.csv');  b4=read.csv('/data/jux/BBL/projects/grmpyProcessing/grmpyProcessing2017Scripts/asl/basiltest/pncbasilquality.csv'); 
nrow(b1);nrow(b2);nrow(b3);nrow(b4); 
c1=merge(b1,b2,by='bblid'); c2=merge(b3,b4,by='bblid')
dd=merge(c1,c2, by='bblid',all.Y=T)
 bb=read.csv('/data/jux/BBL/studies/grmpy/rawPsycha1/demographics_20180824.csv'); de=merge(dd,bb,by='bblid',all.x=T); 
comb=cbind(de$'bblid',de$'relMeanRMSMotion.x.x',de$'relMeanRMSMotion.x.y',de$'age_intake')
colnames(comb)=c('bblid','grmpymotion','pncmotion','age');write.csv(comb,file='/data/jux/BBL/projects/grmpyProcessing/grmpyProcessing2017Scripts/asl/basiltest/grmpncQA.csv',row.names=FALSE)
 sprintf('there are %i subjects in each group', nrow(comb))
