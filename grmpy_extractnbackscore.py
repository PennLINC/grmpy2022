#Zizu 03/10/20
import xml.etree.ElementTree as ET
import numpy as np
import pandas as pd

root = ET.parse('grympytemplate.xml').getroot() #read template xxml file 
scorelabel=root.getchildren()[5].getchildren() #the stimuli scores is in index 5 


bb=pd.read_csv('Example_logfiles_grmpy/126389-frac2B_1.00.log',skiprows=6,sep='\t',header=None) #read logfile for a particular subjects
bb.columns=['Subject','Trial','EventType','Code','Time','TTime','Uncertainty0','Duration','Uncertainty1',
       'ReqTime','ReqDur','StimType','PairIndex']

back0=[] #0back
back1=[] # 1back
back2=[] #2back
for i in range(0,len(scorelabel)):
    if scorelabel[i].get('category') == '0BACK':
        back0.append([scorelabel[i].get('expected'),scorelabel[i].get('index')])
    elif scorelabel[i].get('category') == '1BACK':
        back1.append([scorelabel[i].get('expected'),scorelabel[i].get('index')])
    elif scorelabel[i].get('category') == '2BACK':
        back2.append([scorelabel[i].get('expected'),scorelabel[i].get('index')])
  
# each list consists of both results with NR means No result and Macth means correct result as it is on xml 
# how to comppute final score? maye be (number of  Match/( number of NR + number of Match))!!        
# you combine all the output in one file may be  in json 
scoresummary={'0BACK':back0,'1BACK':back1,'2BACK':back2}
c=list(scoresummary.items())

allback=[]
templateback0=c[0][1]
templateback1=c[1][1]
templateback2=c[2][1]

for i in range(0,len(templateback0)):
    a1=bb[bb['Trial'] == np.int(templateback0[i][1])]
    aa=a1['TTime'].to_list()
    if len(aa) > 2 :
        response=aa[1]/10
    else : 
        response=0
    allback.append([c[0][0],templateback0[i][1],templateback0[i][0],response])
    
for i in range(0,len(templateback1)):
    a1=bb[bb['Trial'] == np.int(templateback1[i][1])]
    aa=a1['TTime'].to_list()
    if len(aa) > 2 :
        response=aa[1]/10
    else : 
        response=0
    allback.append([c[1][0],templateback1[i][1],templateback1[i][0],response])

for i in range(0,len(templateback2)):
    a1=bb[bb['Trial'] == np.int(templateback2[i][1])]
    aa=a1['TTime'].to_list()
    if len(aa) > 2 :
        response=aa[1]/10
    else : 
        response=0
    allback.append([c[2][0],templateback2[i][1],templateback2[i][0],response])

# output
dfallback=pd.DataFrame(allback)
dfallback.columns=['task','Index','Results','ResponseTime']
