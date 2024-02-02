# -*- coding: utf-8 -*-

# -- Sheet --

# # **Intermediate Pandas**


import pandas as pd

penguins = pd.read_csv("penguins.csv")

#Preview first 5 rows
penguins.head()

#Preview last 5 rows
penguins.tail()

#rows, columns
penguins.shape

#Penguins info
penguins.info()

#Select columns
penguins["species"]

penguins.species.head()

penguins[["species", "island", "sex"]].head(7)

#iloc (integer-location based indexing for selection by position)
penguins.iloc[0]

penguins.iloc[ 0:5 , [0, 1, 2] ]

mini_penguins = penguins.iloc[ 0:5, 0:3] 
mini_penguins

#Filter DataFrame
penguins[ penguins["island"] == "Torgersen" ]

penguins[ penguins['bill_length_mm'] < 34 ]

#Filter more than 1 condition
and_penguins = penguins[ (penguins['island'] == 'Torgersen') & (penguins['bill_length_mm'] < 35) ]
or_penguins = penguins[ (penguins['island'] == 'Torgersen') | (penguins['bill_length_mm'] < 35) ]

#Filter with .query()
penguins.query('island == "Torgersen"') #"island == 'Torgersen'"

penguins.query('island == "Torgersen" & bill_length_mm < 35')

#Check missing values in each column
penguins.isna().sum()

#Filter missing values in column 'sex'
penguins[ penguins['sex'].isna() ]

#Drop missing values
clean_penguins = penguins.dropna()

clean_penguins

##Mean imputation
#Fill missing value
top5_penguins = penguins.head(5)

#Find mean
avg_value = top5_penguins['bill_length_mm'].mean()
print(avg_value)

#Fill missing value with avg_value
top5_penguins = top5_penguins['bill_length_mm'].fillna(value = avg_value)
top5_penguins

#Sort dataframe
penguins.dropna().sort_values('bill_length_mm', ascending = False).head(10)

#Sort multiple columns
penguins.dropna().sort_values(['island', 'bill_length_mm'])

#Unique values
penguins['species'].unique()

#Count unique values
penguins['species'].value_counts()

#Count more than one column
result = penguins[ ['island', 'species'] ].value_counts().reset_index()

result.columns = ['island', 'species', 'count']

result

#Summarize dataframe
penguins.describe(include = 'all')

penguins['bill_length_mm'].median()

#Group by + sum/mean
penguins.groupby("species")['bill_length_mm'].median()

#Group by aggregation
result = penguins.groupby(["island", "species"])['bill_length_mm'].agg(['min', 'mean', 'max']).reset_index()

result.to_csv('result.csv')

#If your code is long
penguins.groupby(["island", "species"])['bill_length_mm']\
    .agg(['min', 'mean', 'max'])\
    .reset_index()

#map values MALE: m, FEMALE: f
#penguins['sex'].head()

penguins['sex_new'] = penguins['sex'].map( {'MALE': 'm', 'FEMALE': 'f'} ).fillna('other')
penguins.head()

#Pandas style

penguins['bill_length_mm'].mean()

#Numpy style

import numpy as np

np.mean(penguins['bill_length_mm'])

#Other functions of numpy

print(np.sum(penguins['bill_length_mm']))
print(np.std(penguins['bill_length_mm']))

#Numpy where
score = pd.Series( [80, 55, 62, 95, 20] )
print(score)

grade = np.where(score >= 80, "Passed", "Failed")

grade

df = penguins.query("species == 'Adelie'")[['species', 'island', 'bill_length_mm']].dropna()

df['new_column'] = np.where(df['bill_length_mm'] > 40, True, False) #Boolean

df.head(10)

#Merge with pd.merge()
result = pd.merge(left, right, on = 'key')

##Plot graph in Pandas
#Histogram one column

penguins['body_mass_g'].plot(kind = 'hist');

#Histogram two columns

penguins[['body_mass_g', 'bill_length_mm']].plot(kind = 'hist', bins = 30);

penguins['bill_length_mm'].plot(kind = 'hist', bins = 30, color = 'gold');

#Bar plot (must aggregate data first)
penguins['species'].value_counts().plot(kind = 'bar', color = ['salmon', 'orange', 'gold']);

#Scatter plot (find the correlation of data)
penguins[['bill_length_mm', 'bill_depth_mm']]\
    .plot(x = 'bill_length_mm', y = 'bill_depth_mm', kind = 'scatter', color = 'gold');

#DataLore Visualization
penguins

