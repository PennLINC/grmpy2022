#!/usr/bin/env python

# concatenator for audit 
import pandas as pd
from pathlib import Path
import numpy as np
import subprocess
import os
import sys

csv_dir = sys.argv[1]
#1 *rest*singleband*fsLR_desc-qc_bold.csv
cntr = 0
for csv_path in Path(csv_dir).rglob('sub-*rest*singleband*fsLR_desc-qc_bold.csv'):
    cntr += 1
    sub_df = pd.read_csv(str(csv_path))
    columns = list(sub_df.columns)
    if cntr > 0:
        break

df = pd.DataFrame(np.nan, index=range(0,1), columns=columns, dtype="string")
print(df.columns)

for csv_path in Path(csv_dir).rglob('sub-*rest*singleband*fsLR_desc-qc_bold.csv'):
    sub_df = pd.read_csv(str(csv_path))
    df = pd.concat([df, sub_df])
df.dropna(how='all',inplace=True)
print("OUTPUT FILE", sys.argv[2])
print("OUTPUT", df.columns)
df.to_csv(sys.argv[2], index=False)

# THEN RUN THIS THROUGH THE SUMMARY REPORT SCRIPTS! 